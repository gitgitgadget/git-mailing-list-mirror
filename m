Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002F313B5A4
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 08:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717662165; cv=none; b=dIVjD81BN2Byl8v1U22KjAiUi7j4ye2iGRwbScejcsLg+CHv9nNWATZ7vBkJVm62cni2VI8NoUgS2edbfzKR/zq0ioLri5bpwrdkAnrWrewiQp+N8tJADwXrHbPKDp5e+1dxeyzgS61cNgPaICjlW+hiwccpg6TUBwTI2QHWtRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717662165; c=relaxed/simple;
	bh=AxBwUQwdWt74yAb7GX9/xZ5TAIxa/Sxyyo6OVFni3s4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 Cc:Content-Type; b=Mb83nLETIyBVHHOiXxF8kom/NkgIkFsaS0dZk5qUzEZjxIWbwEFA3eSHweima2ClO66RY0HoDZPNZOyhSUXlk0ACCQbQJ9l/yfXWZ/1/kF2Ks8Q5ATiVge90pa4vGj04+ebnVN9O35dKDdT1wg0QVp2F13zFxaiUwtJFcDmo9jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CiWrb8ON; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiWrb8ON"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2544465c9e2so230932fac.2
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 01:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717662163; x=1718266963; darn=vger.kernel.org;
        h=cc:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AxBwUQwdWt74yAb7GX9/xZ5TAIxa/Sxyyo6OVFni3s4=;
        b=CiWrb8ONtsBaP52J3nFTvfV/ivOW64AUEhablRey6mTn2tVDErLTeN19gJmO9XV3bS
         NGMQAz9Ew03ySyWuyxQf+qRdJwYXJvMQmSY5A7gygY/joL20R7eIlBmby4GPzpPzIeO/
         xj94nYTWgplT/EkeoLuzirjnjIdmoRnFJGfOeBR+6Fmn6uHGIRr9yhzKXfMrDSm9RyQQ
         4/8o1kwxA9ZmA038w//X0xqQ8iWjhJyVSvl0NF4pS9xe0ypbGMzeOazLhHjAIrkSs+eB
         yzIoCDKUFrC4CEbyc21P/guZAO5x+qSWsy5z8ukAKMQVITvkj00KmL/ykJaZ/q2HwNOg
         jkjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717662163; x=1718266963;
        h=cc:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AxBwUQwdWt74yAb7GX9/xZ5TAIxa/Sxyyo6OVFni3s4=;
        b=nmPVcp4zsavsxkLyrWQ83bPFm0rtRs/MQjc/gV1s2NZOnW4havmrX8e7XINzoA6O0j
         YHMeagjbKnBupB3yjvoQBOtt+oBm4JxjsUzZ6e3gK5J0n+GWXavc8Rf7Gy5wf1K4S2y3
         htRPCut/0KCmeQDL9dlPlVGyr/lAx2sbD1MpZx+4veEJVnvaX8bGIm9J34kDkaJMJ75l
         9KWaRMYsVL/dM3/vZJy13BuTBAQHoH0OyKJlNTxTH1JAlYv3n4qvuxkkrd6fNFK7Bu3A
         3E2y0JwmmwA+SlpAPYtKHSgOSA16tG+/uMjqez4G5zf+hSKSbLGwcOTjPoR2xJtdf2i7
         7F1A==
X-Gm-Message-State: AOJu0YwHygXJd6gRXXtZHGUDuQwWFE1th0/hmY5Mc3condMsBVpbQAgw
	XWi0hC8uSFuUDRm1YV8mKckym9U3SSE3zC6sjI5i/WlBvJguZTnQMTNmUO9fn1nxX4ayYtg7PFQ
	5m7dDODX1viSs2O5ikdP6Al2aWCwdG7iJ
X-Received: by 2002:a05:6870:829f:b0:245:2ccf:becf with SMTP id
 586e51a60fabf-251228b01a2mt5854289fac.37.1717662162472; Thu, 06 Jun 2024
 01:22:42 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Jun 2024 01:22:41 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240605102958.716432-1-knayak@gitlab.com>
References: <https://lore.kernel.org/r/20240530120940.456817-1-knayak@gitlab.com>
 <20240605102958.716432-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 6 Jun 2024 01:22:41 -0700
Message-ID: <CAOLa=ZSkBj5V1sqW6pyraqMJOw4QUntFgo660NFoTKRTwrsvhA@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] update-ref: add symref support for --stdin
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im
Content-Type: multipart/mixed; boundary="0000000000000ae2cb061a34632a"

--0000000000000ae2cb061a34632a
Content-Type: text/plain; charset="UTF-8"

Karthik Nayak <karthik.188@gmail.com> writes:

> From: Karthik Nayak <karthik.188@gmail.com>
>
> The 'update-ref' command is used to update refs using transactions. The
> command allows users to also utilize a '--stdin' mode to provide a
> batch of sub-commands which can be processed in a transaction.
>
> Currently, the sub-commands involve {verify, delete, create, update}
> and they allow users to work with regular refs in the repository. To
> work with symrefs, users only have the option of using
> 'git-symbolic-ref', which doesn't provide transaction support to the
> users eventhough it uses the same behind the hood.
>
> Recently, we modified the reference backend to add symref support,
> following which, 'git-symbolic-ref' also uses the transaction backend.
> But, it doesn't expose this to the user. To allow users to work with
> symrefs via transaction, this series adds support for new sub-commands
> {symrer-verify, symref-delete, symref-create, symref-update} to the
> '--stdin' mode of update-ref. These complement the existing
> sub-commands.
>
> The patches 1, 2, & 6 fix small issues in the reference backends. The other
> patches 3, 4, 5, & 7 each add one of the new sub-commands.
>
> The series is based off master, with 'kn/ref-transaction-symref' merged
> in.
>
> There was some discussion [1] also about adding `old_target` support to
> the existing `update` command. I think its worthwhile to do this with
> some tests cleanup, will follow that up as a separate series.
>
> Changes since v3:
> * Changed the position of `old_target` and `flags` in `ref_transaction_delete`
> to make it a coherent.
> * Added tests for deletion of regular refs using 'symref-delete', this lead to
> adding a new commit to have specific errors for when a regular update contains
> `old_target`.
>
> [1]: https://lore.kernel.org/r/CAOLa=ZQW-cCV5BP_fCvuZimfkjwAzjEiqXYRPft1Wf9kAX=_bw@mail.gmail.com
>

Somehow I added the wrong link in the reply-to and this has come out as
a thread of its own. This is a follow up of v3:

https://lore.kernel.org/all/20240530120940.456817-1-knayak@gitlab.com/#t

[snip]

--0000000000000ae2cb061a34632a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5734c68a39d99e8e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEpCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aaGNjNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meFdwQy9kRGsvRDBNbnNoZEZhSVo0N2ttbnN2cll1UgpRZ2JKMWdHWEEr
WXFWdnNQNklNWnBERlExQ3pxanhFSjNKQ0dFNDlxS1hFN2tlZEs1WTE1bWdjS3liSWhKcVI5Cjcy
aVVVL1YycHpIY2hiL3BYem9lbFljTG84cGpTYVBpc0o5NWttUDJjUlFSeGhQb052VnRaY01mSG5r
bDJHdjcKREdGdFFoSGVjbldJVTFNRnYzZVp0Tlo2L0wyVU1PczNwa0NHK205Y1g3elo5NUVFUmlT
K0NOM0pIT2psK3NOVgpIM3dObEZqMDBpNm5PWUgxak81QTR3R1d4dmduT0VoVzNoa1pmdGgwWWJL
U3gwRXEvSks1a2NVYWZoUXczZFQwCnR3eVJKTUJJYll1dkdIOVRKcnhHTUxodlBsbkFSeWdUSmov
M2VmRUxQUmtnTUdkWE1vcFNxMEZjcDBvTEM3WHcKQ1dIMW4rNzNSNFVkNzVJMVMwckR0MnNwS3ln
alc2VVVXMUxOTW9HeDVGcHZpc2dRY0tWMStacUN5c1JaYnNxbQptSlZ6bEpqM0gweWtKRkZOWWpu
TEhhWHBBQTYzRld3TVpVZjRWUi9KSzNOS29vWkpzVXFZMk5NeVpZdVJyWExWCmNmdVFKYVRYcEta
Y1g1VjhqOXhpQWxnS1dQMjRieTM0Nzk2U0l3PT0KPUxyOSsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000ae2cb061a34632a--
