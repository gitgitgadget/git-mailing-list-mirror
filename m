Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E324733F8B9
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963908; cv=none; b=AnEsXXEtwX5PYOPxPAWO0H0M5Xn+4moepLLXPKU5+ufpO7Tr94SlmpB+TzpuhVMQKwIM4QqrzRBEpFaMxsYZLVR1JBBZ4Dp2fxqrXyd7clxAiXvwYVMjXDqTbrwR1NoAPPodZARdj0+SB9GQFCkQGIviFx/YKFj/H0GOq8jVGbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963908; c=relaxed/simple;
	bh=uU+tMqlFbaszAy6mjmYYimnVFy8iLbtVr0Zs4YyiVn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGKYxU7aP4Q577YTGIJxkP72yExU38wug+JEAhD7e5XinSPnWNa9UxYY4hyVFxFcXm3CnfgmykW2qBDawjR/vikk5dFDFn3ZRCN3I0wPkCK5ni627jvj8fYhYUrzQSEzDKOxmdZcySbD4kUHELnKNO5Vy8oRN6YkXCVpeyW9EPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcCCeIjR; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcCCeIjR"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b727f330dd2so166591366b.2
        for <git@vger.kernel.org>; Wed, 12 Nov 2025 08:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762963905; x=1763568705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cssP3PHGU3c1KRfXjHDlQ+qKNtk70OobE73Cj8bU6w=;
        b=WcCCeIjRenZ1vivaIBvHbD2kMdUVCH+u58TRsWlf/GBqGZhVykp8cPybw7FqiBjXom
         pVkyO+yM/PK7vIHOmlQ+WqfWY0NYuVz7qYJFO+4R1es+meSrNBv/UzvgtDH4abxRUrX8
         qL3YYy+DkrJ8hfBXEEUSpe7d9Xdgu2yeYHf668RZ43qXmWRWwFKju9SZGeCainNn78op
         xOrrXEd5Ovl/BYcxwQ1h2DSEwTJEq3aAGndAB2oJqiKVceWsFetJijbippLVtvqy3ACu
         cs3Kc1cOpTSKIx0wUoK/1qDqQySk8nBdsEq4vNDPHOeUMSWDRfXp/uTc0CPfXWYTcFOM
         28lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762963905; x=1763568705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8cssP3PHGU3c1KRfXjHDlQ+qKNtk70OobE73Cj8bU6w=;
        b=l/gPTDdAbjTg2O1ehqnSDzdn6JlwM1GHV3GyQVdo4wSd3VTe085bMqzjfvt6Jv76Rd
         qUh/1WsEQsuw/VgRkQWiHyiFLCuq/LuBZORrnxdDmlQ1L44tlMNz/cdsAujPZXB2BxnX
         wou6dmmySnRLdiOEFSsitnvssZxx6HbCOs6nfn+L2LmDemMPHHpcVLwqFF/svUeQBw+O
         OadaxK3lfkFdjdUTIzImnPfnFY/6YgN6N7oj0LHI8fTEZm+wGkjBmFV77ogZU2PIVSKW
         qyJsxJsBypcOkcQmx51BXNIOM8RHVQ2TicnsyEpvUtwP5+rvua83fp+wWmlLeton7sHL
         IIFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfl2Ln0Nerw0275LfUgmxTRVM8ADiYjN5Us4QiVEYM1PNq9PGCsBowQLYD61cCfSoRyaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE3m4hI97Y8HcAC5/d72iOh7wKHx229hUIbnm9M3dla3UXf9FZ
	jfdzEfPnDQRMLzrKvMbmKW2FmUIClPHL6okv4RbG/0e6JnATgN734VJIFvbZXTE1x8Ulx+Zv+rs
	KFbOkLEq7qHnEA5s3N5lR37uJZiQJEXM=
X-Gm-Gg: ASbGncvUodhRkmfcxkl54cGkRXQaJz6F+hviVNfNWyZODqnAieHzU3dHBgCnxIuKfd8
	gm10qWg+nxtOsZXRX0RE1AtPczdI+e0iaCvsiYV+2GCCFBL9dniEtH7pxYE55FCDeHpM8VxjTON
	Obze8NdSHUtFpsxKMyCGNzCE/ufsWB3VGRyTWQKP9ZPhEiKw7Gsm8PHmRnsIhNSu7ZDoD9XveaO
	rOLKcVorHPk/hR3V/P99CX9jb+fu0TFO9nKyN6hlTIXnwldXTFBwtUhSXpPRe8j4BNqBiJZ8ljd
	qk07cKeSzee8Gsz0Nc+dMks=
X-Google-Smtp-Source: AGHT+IFKHA00ZG3TMEB7kF9J2SebquPDjJJIyxcx9cduCwHnqGkbYOuWbXOTHEdhUggZelcKUSHMbNjKzwq1cuVUFYs=
X-Received: by 2002:a17:907:9506:b0:b73:44ee:eb24 with SMTP id
 a640c23a62f3a-b7344eeeb9dmr30681066b.43.1762963904898; Wed, 12 Nov 2025
 08:11:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
 <6be20c41-15a0-4732-bd12-4927a59a9f59@gmail.com> <aRIoleD6nP-kA4Xn@fruit.crustytoothpaste.net>
 <20251110201136.GB127132@coredump.intra.peff.net> <aRLdsu-MUgPPdIgX@pks.im> <f7a9bf6d-d723-437f-badd-517fbf47d945@gmail.com>
In-Reply-To: <f7a9bf6d-d723-437f-badd-517fbf47d945@gmail.com>
From: ZheNing Hu <adlternative@gmail.com>
Date: Thu, 13 Nov 2025 00:11:33 +0800
X-Gm-Features: AWmQ_bndjAFlDUbC0IK8SZcoy5-niwL_CAr3kDpTvbBhXEjS-Noj6wW3EeOuiuE
Message-ID: <CAOLTT8Q_ajnCdnbLSJM_VQLpsHQPNBr_qh6L-X4KFyRxaXcJdg@mail.gmail.com>
Subject: Re: [PATCH] commit: add --committer option
To: phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, 
	ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Phillip Wood <phillip.wood123@gmail.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=881=
1=E6=97=A5=E5=91=A8=E4=BA=8C 22:53=E5=86=99=E9=81=93=EF=BC=9A
>
> On 11/11/2025 06:54, Patrick Steinhardt wrote:
> > On Mon, Nov 10, 2025 at 03:11:36PM -0500, Jeff King wrote:
> >> On Mon, Nov 10, 2025 at 06:01:57PM +0000, brian m. carlson wrote:
> >>
> >>> On 2025-11-10 at 16:50:04, Phillip Wood wrote:
> >>>> On 09/11/2025 10:22, ZheNing Hu via GitGitGadget wrote:
> >>>>> From: ZheNing Hu <adlternative@gmail.com>
> >>>>>
> >>>>>       This patch introduces the --committer option to git-commit, p=
roviding:
> >>>>>        1. Consistency with the existing --author option
> >>>>>        2. A more convenient alternative to environment variables
> >>>>>        3. Better support for automated workflows and scripts
> >>>>>        4. Improved user experience when managing multiple identitie=
s
> >>>>
> >>>> What's the use case for the same person committing under different
> >>>> identities? We already have a config mechanism to set different iden=
tities
> >>>> for different repositories but I'm struggling to see why someone wou=
ld want
> >>>> to create commits under multiple identities in a single repository. =
For
> >>>> scripts it easy enough to set the relevant environment variables if =
a tool
> >>>> wants to create commits under its own identity.
> >>>
> >>> Someone who works on the same project under both their personal and
> >>> corporate identities.  For instance, me working on the Git project.
> >>>
> >>> Some open source projects also require a CLA and you have to use a
> >>> particular address to match the one that's listed on the CLA.  For
> >>> example, Google requires an address with a Google account, so in the
> >>> hypothetical state where I was going to contribute to one of their
> >>> projects, I'd need to use a different committer identity with my Gmai=
l
> >>> address.
> >>>
> >>> I've also kept business logs in Git when I had a small business and I
> >>> might well need to log approving a profit distribution (with my
> >>> corporate address) and log accepting a profit distribution (with my
> >>> personal address).  Those would need separate digital signatures from=
 my
> >>> two different email addresses.
> >>
> >> Is a "--committer" option the best solution there, though? I'd think
> >> you'd want to set user.* in the repo-level .git/config (or using a
> >> dir-specific include) would be less error-prone.
> >>
> >> That doesn't help for using two identities for the same repo, but in m=
y
> >> experience it is easier to use two separate repositories for that to
> >> match the organization of the work (even if you may sometimes fetch
> >> between them).
> >>
> >> I'm not totally opposed to the new flag, and in general I'd defer to
> >> people who say they find a new feature useful. I'm just having a hard
> >> time imagining a scenario where it's the best option.
>
> Yes, it strikes me as very inconvenient to have to specify "--committer"
> each time. I'd have though you'd either want to (i) set up an alias in
> which case you can start your alias with "-c user.name=3D..." or
> "!GIT_COMMITTER_NAME=3D...", or (ii) set GIT_COMMITTER_NAME in your shell=
.

Since modifying the committer is a low-frequency operation, there's
no real need to specifically configure an alias for it.

> > The reason why I find it useful is mostly scripted uses. Sure, you can
> > already set environment variables there. But from my experience,
> > environment variables tend to be a significantly worse API compared to
> > command line options:
> >
> >    - They are harder to discover in the manual page.
>
> They're documented in the COMMIT INFORMATION section of the "git commit"
> man page, admittedly that comes after the options and examples but
> overriding the committer is a fairly niche requirement.
>

Although it's niche or infrequent, when configuration errors do occur,
the current fix process is quite painful for users. Previously, countless
users have gone through great trouble seeking solutions because they
didn't know how to resolve incorrect user.name and email configurations,
which prevented them from pushing code to the company's servers.

This may also suggest that Git lacks simpler ways to fix their identity.
In fact, many users end up needing to use more complex tools like git
filter-repo to attempt fixing their commits, whereas git commit --committer
and --author could become a relatively simple and memorable fix method.

> >    - You don't have any "guarantees" that Git actually interprets them,
> >      as there won't be an error if you mistype the name.
>
> Playing devil's advocate even if you use "--committer" you still need to
> check the result to make sure there were no typo's in the committer info
> just as you would if you were setting GIT_COMMITTER_NAME.
>

GIT_COMMITTER_NAME and GIT_COMMITTER_EMAIL are split
into two parts. Sometimes I even forget whether GIT_COMMITTER_EMAIL
should be "<email.example.com>" or "email.example.com", whereas
--author or --committer provides a more compact and memorable
"user <email.example.com>" pair.

> >    - Cause and effect may be detached with environment variables, but
> >      with command line options that's never the case.
> >
> > So I myself would prefer using "--committer" over its accompanying
> > environment variable any point in time when I have a scripted use case
> > for it.
>
> I'm wary of cluttering the UI of one of our core porcelain command with
> options for use with scripting.
>
> Thanks
>
> Phillip

Thanks

ZheNing Hu
