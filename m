Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6DE48A2BF
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 09:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790587234; cv=pass; b=hhuIvvIPgqar45fDbvYladMOfglg03vRVL4ClFZi97C+y/c0bkG7fDPwEW5xMpxiRZeZn/747v+8tu5iQc4G8PuCf/N845R4L6rfQtcvWiw55GOJXdu+rzi/Gq2+jxPT0Ii+EBK0cExhROiKWTX/0NXv1uqZkFskM0roheVxfgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790587234; c=relaxed/simple;
	bh=FsNwSqERe9ugHbcxhzzxjvjBqSt1cPInZ/2VQbTXR+w=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=LTfLE1AZQEMCeSXwCZBUuRCJBJHPrt+Vrw52dd1nf9HWeLMRNxiHM3w3VEABvUPtlNrnZB6HyTRgKK06/KuEdiw+FdJ4jACz07sw7v4oLr5YX+H+gd7q3+xv5GmqgTtrsfGR5Nl8p38IXaaslrXlYsK1KLA3w5DPcLx2uLPp3A4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9hVERQj; arc=pass smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9hVERQj"
Received: by mail-vs2-f12.google.com with SMTP id ada2fe7eead31-786c3d55c99so666859137.0
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 02:20:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790587232; cv=none;
        d=google.com; s=arc-20260327;
        b=O3KFgCHM+3xhO6/Yzr+oZ8404PPmZ/Nv/8fwkqa1DOq4SF9KqOayq7RCqeWggtUw2y
         CZy1jqd35vlo+o914TVgRJxELIlh+DU/R+GzUCE42gc0DDoRCutlGnLkMfe3frIdC4r/
         htUpTG4fFsCSTrJvQhmRX97gCQihMMKm+yafpe2wsK7CAa2VZ1cTp88Gcc9czv3D0OhT
         iJNihSEaHn3PrCv/yEGxS512OgdsP+ZZxG7fjG8oNRgorRRzzGDjs8W3eEnAO0UkKYN9
         2fLrGVtlYQaGvuQR+X7ceEfoKRmgoUythLAsqJQYtETCCPpxH59x+GhuGg9NC+6DNP84
         YXZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=OnEBvHNjWC4MotEyRa6nRRh6NiOtVXAjssFJla47fJ4=;
        fh=pUzyQpobkTja20cRhoXexLPx5E05/KXRXAzrJ11IUKU=;
        b=MvK9E2kWFnVzricgBZBYpVe67W/UY5FsnPpFX0wcT9wMS0uUs4u++e0RsS+yZDlpGC
         XRCaqSc1XJa8AFy2PlE0nMrO3A0zALLChKD53rcvCsNMCga1q5ubCsyXg4JBBr5dj742
         oQ9pm8YluePai1kUaYYrICEeYkRcqDVbWOpzylwJzTMUJLR+PjFJJkIgNZ4YHgi3HKwI
         NLnfyke8e4gooRcVASQ6DlBbfF+I8xRM3FPag9dDUOtlVZ1OLsTmcBCOjURpLBckxhx9
         gOR6dI77h8KBoa/ezGryDkJIfxazoYLIM4vCmQz9+lJ3Xr//nkdNDrC0vpcwn6lgTTSg
         Q6Qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790587232; x=1791192032; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OnEBvHNjWC4MotEyRa6nRRh6NiOtVXAjssFJla47fJ4=;
        b=b9hVERQjkC6U/J6yv3tjnMxJqmc+QPwxexOLIUkx/VMQGKdIRf+SKF/c46XKQziVXr
         eqIdvH8DBpZgGrVSxvtpu2xfzCDYP/Tx5DyQhMog2pE23hLA07wZNnOdydNVUuTGePMv
         h8dUtI7G6tbWiGcIQRMJofTA3Uf08eoT2WRVHpO0NkLQrTeihDO/2sjoREoBKeth2Xb5
         s3wsSGCkjiPmHk2DrNvIlSoLDWcUHMeR7R5uJKCLIr8aYh+OVSFQEd7uZraHeajZpdb9
         28U4eC7fwqZhqTJO3lpWvRW+NqXvTEH6SQPju4uAFMaXDC/8VgsDxelOBUhcIuBX0r9Z
         juQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790587232; x=1791192032;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OnEBvHNjWC4MotEyRa6nRRh6NiOtVXAjssFJla47fJ4=;
        b=t6A4bwZTI6g29NJClmVrvSWvdiUjeOKOEAZmbYvry9jK4oxy1a+ND7dXM8pX10oEet
         niCLN3onxU0ZUFIFsD0PQk/ljsVIiRtmYNmqiOYpN3x6MX3NIOK+TXnuRqq9KkF9o75w
         988VFjCddtNKNx+pdJS1kSXnLEE/IzG8IWr0gerpMxFUoQ+CDSBiO8xtR7mJnDm4DUaU
         9Afx7KsY36nQhNewmvt0CMYn8MZGzoS73peIh2sT+ctfG7UgYl7wBLCXRwFTSJtSB9jx
         hELbFqShml0bkhhfJXWRdwVwCtrvcl7Cuu/ikVldQZ47PoRTe46Qu8xI4uQKBXoOhH1z
         TE8A==
X-Forwarded-Encrypted: i=1; AKwUvBwY8BTs5upuwa1q9NacAHh64olrz2A5EJUA3mNpphzTfFRBrRfkGvGyjTFr3Lf4oManms8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3iGf7JyZJWyVMmdYMZeQSwamfkqxvj60KxrWoP8MkDx6G/FrA
	wnZednK+HBxnfMc72TtzmgO46wM/qI5Y54611Fkeqa4eK4sF0nIz5LqqO7/VQ2cZiXhLxQUzuFE
	9x53dgfd23Q2P4tliTRD77OtMeKT+tP8iUA==
X-Gm-Gg: AYBFou3YgY1MvjtpHBA0B2K7cY38+nmyEQEHaVWCRpk2GvdqSwPHap4f82WpwLrTDAy
	kc+XNYJOPxWi5io3TDnYdJHiaQUANubyo6fU4kvHiLBvtmAmX4E8S9HDxFh87QHBemb81aVbIhl
	V60hmbF1eiuTwYU867105cUESLMHBwL9fNDi8/+v/6SjLXFp3O5BmA8URhihGEpP0lPT4oiALK9
	UOkKFUP7j5pdET1QGkK64gWb6sZQDDGUosquU6CAujskXoN4p0Hs/tX64VRNXtFXtR5j1FRfBn9
	q5tcc0FIGIA8UA/FApcrH5pMbpgKaaS10WpLNry5o2FYh5KwXfsu/paoN495wxFJZ7LoUByRQR/
	5uFMBVYNhVTTx1jetHJD0JjuwnpETUbpJGVCTey/D7DGt
X-Received: by 2002:a05:6102:3e90:b0:7a1:f2b4:dae1 with SMTP id
 ada2fe7eead31-7af1e9e74dfmr3625356137.14.1790587231716; Mon, 28 Sep 2026
 02:20:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 05:20:30 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Sep 2026 05:20:30 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260924-pks-create-repository-stateless-v1-0-11499557cf31@pks.im>
References: <20260924-pks-create-repository-stateless-v1-0-11499557cf31@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 28 Sep 2026 05:20:30 -0400
X-Gm-Features: AclHuK9h6gvAo-wjItPoiNozEVWOYD2a8evR5ORD5TZfHBylkVDwE1OLk-caDoU
Message-ID: <CAOLa=ZSX0e25wK5qQwznXN9rVM+WHn8631pkTEN9Zm-BrXfEsg@mail.gmail.com>
Subject: Re: [PATCH 0/7] setup: enforce repo passed to `create_repository()`
 has no state
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000e2e2bb065c879376"

--000000000000e2e2bb065c879376
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> when creating a new repository via `create_repository()` we pass in a
> repository. This repository is acting as an in/out parameter: the caller
> expects that it will be fully configured after the call, but the
> function itself also uses some information from the passed-in repository
> to figure out how exactly we want to create it.
>
> This interface is quite confusing, as it's not obvious at all what
> configuration of the repository is relevant. We have thus over a couple
> of patch series reduced the use of the parameter as in/out parameter. So
> now, the only piece of info that is still being propagated via the repo
> is "core.sharedRepository".
>
> This patch series cleans up that last remaining part so that the repo
> becomes purely an out-parameter. To ensure that this is the case we also
> start to `repo_clear()` it as a first step.
>
> Besides simplifying the interface, the intent is also to go further into
> the direction of unifying repository initialization in a follow-up patch
> series.
>
> The series is built on top of 0f8e75abeb (Revert "Merge branch
> 'en/no-amend-during-conflicts'", 2026-09-23) with
> ps/odb-alternates-at-creation at d1019ac894 (odb/source: remove the
> ability to write alternates, 2026-09-10) merged into it.
>
> Thanks!
>
> Patrick
>

The series was a good read and I didn't see anything that needed
changes. Thanks

> ---
> Patrick Steinhardt (7):
>       path: drop useless `safe_create_leading_directories_1()`
>       path: introduce `safe_create_leading_directories_no_share_const()`
>       builtin/init: refactor messy creation of leading directories
>       builtin/init: move handling of "core.sharedRepository" into "setup.c"
>       builtin/clone: don't apply "core.sharedRepository" to leading dirs
>       repository: adapt `repo_clear()` to fully reset the repository
>       setup: enforce that passed-in repo does not carry relevant state
>
>  builtin/clone.c        |  4 ++--
>  builtin/init-db.c      | 15 ++-------------
>  path.c                 | 13 ++++++-------
>  path.h                 |  1 +
>  repository.c           | 37 ++++++++++++++++++-------------------
>  repository.h           |  2 +-
>  setup.c                |  6 ++++++
>  t/t1301-shared-repo.sh | 42 ++++++++++++++++++++++++++++++++++++++++++
>  8 files changed, 78 insertions(+), 42 deletions(-)
>
>
> ---
> base-commit: 6b6fe25b12e5324f2fdaf8c73816b9d2207e9404
> change-id: 20260916-pks-create-repository-stateless-f0ca03cca689

--000000000000e2e2bb065c879376
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d75c4f599ca9f7c5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xNk1WMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNnVTQy85bVErZndPaXV1QW1UamJsYVp1SG1FbnZiMgpqeDBtbnVXeTgx
L1lLa2FGSHpaa2FSdGltS3FDekRqNW5IUDhFRkgwWk9oZWxiNFJBVFFNcUlRNFliTXRQS1N6CjhD
SW9QMUFKSDJoM1MvVnIwMmN5VWh0ZnI1blo4dTRxa1BnWVE0aWZnWHFYNEU3YXhXK1NJVG1TRXNm
bDNvWksKMnF6Z2E1MVIvSlZZSkV3VVg4QTRSVUVDVXNJV0QrL3U1S1Zhd1RPTEcyc1RQbk9jaHgx
NFBrWUtmWjM4ZTQ3UwpFVW1SbXQ4TmVkTzVUYU5OUWkrYVhURWFpc2lyeG5MeUlkdHZaU2tSRmhs
Q2VZQXRNOERzd29QWWJtQkU0YW5OClhIbG54aW1vbFVhb25lRUVCZkJ4eXplQ3M0RlFDem1POWN4
YUNiVE9QVHlwQUpHYjkrWmdvcDJXM1VGR3BvWG4KWFlsQTR2ZHdhZ3pSTHpKMUJFclpDVEJUS2Z4
VlczNzBSSmx0RkZVYUtzeDcxcXpBZHY1ZGNRclpZQ01ZVENHZwp6U3lQYUYwT2t3U1JuNURxcmph
NkZLZ3NsMHF2MUJCV3huMlMrU3pHRHRRaDRxcDJOMFVUdU41S09KbG00cHZHCnhCM2lKN3R5N29U
SktCU0wwZkV2V2hwUUd2R2JCa011M3lqZXcrcz0KPXZDb0QKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e2e2bb065c879376--
