Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2691B1401
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 08:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718700289; cv=none; b=kmfupzMQDJUb2aV0d+DYz6n2zOhIFn9FVzeHFBGYHkw2uSo7nh2w1wA43T+Tj+hdwcHvz1+gAFh2JVMM4ANU+yhdLOKS1QBLWczUKPTUheoUIdVb9gdDlFQkOSmqdV9P1TZseJ3Sx6cfBTQEoqNT69BwhKkmC29uTbsojQpklQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718700289; c=relaxed/simple;
	bh=EAYBfI9KeWd97pEb8NGf8ar9arL5lqPavcWReL6JVK0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kpzLFbkK/5U1jEKdDpUJgekif0joxLoqS5P000VJlMA7YKZo2xbJu4YKLsnpizaxBD4FmKHunycUPD4FKfnsl/B28ExPwCG8xDI+TBVfTd9p8uNWKtop+66xdHEktgcK4YRF/0NA0oeiDlV+92bzl9FOA5dnJmsWRBQtzwaNrUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KurcQDhB; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KurcQDhB"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-24c9f6338a4so2584263fac.1
        for <git@vger.kernel.org>; Tue, 18 Jun 2024 01:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718700287; x=1719305087; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OrXKFsVl/ZAlYUWcudV6MMn6oNB+6FoZBVxMctmVmRg=;
        b=KurcQDhBcQDKbRyS7ZygXhp8c7v/Cf9yiDJvI0gmsOL2gwQfkrdSAiVLyyhUWNRncE
         kPhHsLCLQPNkaQh5WCihAdREZOuP8qfeY64R//dNiZGZA0j2p0pkJ5zF3lSQWLc38vbe
         YPGQYh7TSSPmiOrV86SH8HF/jpoK6ZhPyWGOWA5UEerlQ2A7BV1srvfezpjsKzMtuoPi
         QzK6BiMwm1n2dFwSNesVq2u0x7GjmYVIzjZ9v3kEN4KkDduIARinVa5RyPK+/mI6FKxb
         6TMQLE5Csm+8rPfiR99ilOXAqzd65RTL/qIDchFq5bWh83agOQQHONyerbnlKjAjY8ym
         RbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718700287; x=1719305087;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OrXKFsVl/ZAlYUWcudV6MMn6oNB+6FoZBVxMctmVmRg=;
        b=E58XIsV74U6hE6D932ya3mXiFDpTOFCc2M6+Zot34Y4wRZVyzJ8hHFqo2uczba6c2i
         hyTTPveiG4C0AXZay7laxzGCc/YhYJNFQlA6z5Hbg2bJkz68hINQIL1rkYPNZzlt7e0n
         8WpwksfvMDNwe+KnJsYrFKxgkoGso7/fBhC2BMuSG+lMam85fLzLruPilAWodkP1U7JQ
         tYnKu24zB+YrbwE0oi0mJOXa8n6milTGdrSsm+Arypd4qWFRDcdKIBjf2NfQDx/uz7VJ
         Ty4eqZWv02n4AKfWxpAKd1Tp+S7E3BsEvZV95luFCGGXVxW18AN/IhS1kYkU4dEUvgA1
         BtwA==
X-Forwarded-Encrypted: i=1; AJvYcCVRh6jMlwexGRXBHPur1icHoEMiMrcZX3+HQhIXvinfOUvzfJECnay7hP+VvyaCg+K5ZbtqUEXNccnmNrYW6LGoG8Nu
X-Gm-Message-State: AOJu0YwEgclMOgiP2AFDQhbvPgcQtc//5RSBTzeG9YqEyE7Cw2abxKyP
	x5QYd2GALSbRA/Ovq54QSBsYPg6VjBVp/arvxT4NwzwYRwKxrtLgn6Yfx9oS8px0HscwqKS3cI/
	Vj3cPPWMi7RddOr1pA9W19s9WGZs=
X-Google-Smtp-Source: AGHT+IG2rWDJ/LDYLAbFvTOFxbhtf/vHn2wcSBMTc0Oo9ORUw9OPfV60f6lakqM23/fezsGR/ag97dFaVEo1wTV0DcE=
X-Received: by 2002:a05:6870:8a10:b0:254:9a96:96a4 with SMTP id
 586e51a60fabf-25842c13734mr13413339fac.49.1718700287239; Tue, 18 Jun 2024
 01:44:47 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 18 Jun 2024 04:44:46 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZnFCu7kDjjoNr9dr@ArchLinux>
References: <ZnFCu7kDjjoNr9dr@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 18 Jun 2024 04:44:46 -0400
Message-ID: <CAOLa=ZT=B=7Ec7Ui6JmOCFC7gh+G0D=GGGO0MzL_HBcGW9pbOQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] builtin/refs: add verify subcommand
To: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: multipart/mixed; boundary="00000000000018c6fd061b261816"

--00000000000018c6fd061b261816
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

> Introduce a new subcommand "verify" in git-refs(1) to allow the user to
> check the reference database consistency.
>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  Documentation/git-refs.txt | 13 +++++++++++
>  builtin/refs.c             | 45 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
>
> diff --git a/Documentation/git-refs.txt b/Documentation/git-refs.txt
> index 5b99e04385..16b518ecce 100644
> --- a/Documentation/git-refs.txt
> +++ b/Documentation/git-refs.txt
> @@ -10,6 +10,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git refs migrate' --ref-format=<format> [--dry-run]
> +'git refs verify' [--strict] [--verbose]
>
>  DESCRIPTION
>  -----------
> @@ -22,6 +23,9 @@ COMMANDS
>  migrate::
>  	Migrate ref store between different formats.
>
> +verify::
> +	Verify reference database consistency.
> +
>  OPTIONS
>  -------
>
> @@ -39,6 +43,15 @@ include::ref-storage-format.txt[]
>  	can be used to double check that the migration works as expected before
>  	performing the actual migration.
>
> +The following options are specific to 'git refs verify':
> +
> +--strict::
> +	Enable more strict checking, every WARN severity for the `Fsck Messages`
> +	be seen as ERROR.
> +

Nit: It would be nice to redirect users to the fsck documentation to
understand severity levels.

[snip]

--00000000000018c6fd061b261816
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ccfe9dd1b7b1e28d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aeFNQMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meUUwQy80eUlVSURQbFVUL0dveFZoMkJ6RWs3SXVVNApoUjZMVllLV3hi
em5xc2kyc1Jsc1VWWXprVUl5TnhSOC9UNHNkeDFBKzJJdWNhSVZienJiU1pQYjE3SXlYZVppCnZi
MWlBeno3Vng2VWpya0FlRHlMb0Q4SzRJaHp4citrSGFZUjRnY1YzL0dBSlNxZ01DWW1ObXhiTFFO
RlFIL3gKcW9IMnZCYVJhWDJmbnNMMGJ2WVMrOTh2eWhkeSt5VENjOWxHNnhLYXVpMU9US2xFME5o
c2dJVyszUGN0bWtlYwp0ZGlpQWkxK2hIK0NBTnZCUkhzZHFTTFMxZFdDQ0Z0cDlSQmtXYk9DOTFh
TEJmQ0lDdGJDNjBwaEJ3bVVRVEoxCnFYd1dJdXFicy9MdlZET1AvcVNOSnZBZmJneDhwdXM0REVU
Y0w1ZWVLVHJPSG9vSEJ1Z2VpdmVRaGd1c0FnSUEKaTVEc2JJaENHdTZoNlFpYkRUaTdhS0lqSnFz
Z1Q2NGtMWm5PWFBaQXJBVkU4WWV6VG54aWFqbG1qeWlKbWx4Swo2NFZsVXgyZzlZdldhZGc5SE1h
bmpJL0lCL0haWW56WFovL01TUS9SN2YreDlhc04ydG5SN0NIZzhPaVdlb0FkCkw5WFp1OXJBSnNy
eEptUnVPTmhjRUFMbFNEemNjQzFIQ1pHZlhjRT0KPVh6dlAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000018c6fd061b261816--
