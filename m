Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19314847B
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 11:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743767221; cv=none; b=pex069L+XVmCNVvgBT5MtlPeY1BMAQc0426c2iO6MeUpTX1Mu1kmngGRq6ft0Ti7O39+8MBurVNFuDU7z/iZgIgnmupKG6vWCmjzR/iETwcTywgMOeTqaO5feltT2KpzHlFrM/tTq3rotGB3PLQ4KEdzGqMKrkKlWD4ehdEobeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743767221; c=relaxed/simple;
	bh=5KYqJAG4ki7Sn6NBXPuhHy8M6nndjvJBSS/w6lj0m2g=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HaShVbscBNocYF3lUgsnxDBGg3UhwXwpQUaCNQOjrxU/jKcYqOf0luuM1/WrZdJx9rpJvcxSqBcVFTqLCGn7CcLRrcxlPG7nFDbGED7psF+MqAHr9levdy2kvDrur1C9M0F9IyyVdcCDfk1vUOiiayuvgjXMcxXfH5SvBeAdTTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksW+z7WX; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksW+z7WX"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-86d5e42c924so1667906241.3
        for <git@vger.kernel.org>; Fri, 04 Apr 2025 04:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743767219; x=1744372019; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ur48Hk74o4vekW7ONGr/5QnQ85Ug8zhaKv+EW3+QRUU=;
        b=ksW+z7WXKCLk9VBpAYZyjpoZG/co+S154dLPdr86bwumO5r8k6U+MX5hT8dp5BLW4w
         dX3c6ELSPX6coRZBKuuC0lF9bjluJirb14PGzNpUJ0nx9i2Vk4SPYj+MromN/IUyE+LX
         qunsnCBeTCCDBORip98ImgUU6bfoh8S0MpoyRwhNi0rtlg/Lgc88Js0RyKMcWhEnvZDh
         qfdnevmMrd0bEulgohynauPAm3Olb9WzlFGA8YgtKd1E3Ib0ul1CIjjROL8pKhzBldya
         WyGeZOkuwGSREwccYVHG0EPdzyUJ1g/wJDdTfv8lKhabYIN4Ji8fBVgz1k1pcUR9FegJ
         fu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743767219; x=1744372019;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ur48Hk74o4vekW7ONGr/5QnQ85Ug8zhaKv+EW3+QRUU=;
        b=C8OB/LvWJ9/Cz+JAAGcSHaFzKKBVyJygEMZxJFfJ+dTNPlhRFVldC+eFzF/+YLGOik
         yKbQ7mXah3kZNVXvsgqOW8kjCHswia2o0AdZLKskI6OLdKbWbuzJ9CS/bPZy2+1FOlMf
         IXDEH3cFK45tbGrjQYEIFIJXR37wE5L0vQ29uDNgG9PIOEEeGg7mx+oVztbqHam8qfZr
         gaq2RGilq69XmNCHr85Mf7QdnZxUZHbj8nHTfmLlAKCKX3VQ6m91P/z5n/GWJawpFHE1
         +tweb6unWVYgknjcZkN2R2D/V5PYw3ulp8q4FcicGtzQaRGKscFKI0A33fYb3s2SNnK8
         psfg==
X-Forwarded-Encrypted: i=1; AJvYcCWUp5XPO/XS4OOarB/9nuUbccHWAxjrdsCxT0ZdYIdtrMFp8gzKJ5DPPxzKGzJqXGPTET4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGdhlE1zlFHoDCyhE/boT5ZQXjhPGGFjI3G92mwQv2Yv+M6Yt9
	oL6Akoin/rQ9Vfh/Dlqj+gMXahnx/9rymBGjrqQXMWECN2brCHKiWd8NYArz5Be65HFo0FOQw7E
	aUj0Vr3VcgEe/aKc5YncJMPZZ7ZE=
X-Gm-Gg: ASbGncuROIbJZ3Fu2c08cjzOU8BSWryw4FW7n3dGlh/sP2zHp9ZVTx6u1r4om09v9t8
	om6suUiriCvyhztugIaGhrMlgsMIXHOv1f83V9Vx5oizxd9N5hci+Zpn605euZNTOLgwDIcWryF
	aYzP6WSBFE8IpEA6Anb+mHUQp5lqEtUpx16GbKtueDnaJzEaNJ9OUP3yO5I/cFqHlvWosoBg4=
X-Google-Smtp-Source: AGHT+IG4lCG+CXJFnyOyxU8qAL4pyfhVXzfDB1Tdwver6LgKHIg1n8a6BTyT9QBJ15to4mgyNgVjorRdG47VzITl/dE=
X-Received: by 2002:a05:6102:330e:b0:4c1:71b6:6c with SMTP id
 ada2fe7eead31-4c8568e389fmr1366096137.7.1743767218866; Fri, 04 Apr 2025
 04:46:58 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 4 Apr 2025 04:46:58 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 4 Apr 2025 04:46:58 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAPhwyn3McL-2rwjkexsDUWqxt0Kr4UsDVy_G=s1DmKhrw5BZ-A@mail.gmail.com>
References: <CAPhwyn3McL-2rwjkexsDUWqxt0Kr4UsDVy_G=s1DmKhrw5BZ-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 4 Apr 2025 04:46:58 -0700
X-Gm-Features: ATxdqUH8k1ZEVfIkn2TVII5A57C_1l89MFrHmcj_PbI4EblAk4Lt3UsASqgexkI
Message-ID: <CAOLa=ZQ4nTP7Ls=JsnQSbvpvw+OhjXqqoQxpsTKA0x-HxaDH5A@mail.gmail.com>
Subject: Re: [GSoC][Proposal RFC] Consolidate ref-related functionality into git-refs
To: Meet Soni <meetsoni3017@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, christian.couder@gmail.com, shejialuo@gmail.com, 
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000a6dcee0631f27126"

--000000000000a6dcee0631f27126
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Meet Soni <meetsoni3017@gmail.com> writes:

[snip]

> Command mapping and naming:
> ---------------------------
>
> I have taken reference for potential names for these subcommands from Pat=
rick=E2=80=99s
> suggestion (https://gitlab.com/gitlab-org/git/-/issues/330):
>
>   # Replaces git-show-ref(1) and git-for-each-ref(1).
>   $ git refs list
>
>   # Replaces `git show-ref --exists`.
>   $ git refs exist
>
>   # Replaces `git show-ref --verify <ref>`.
>   $ git refs show
>
>   # Replaces git-symbolic-ref(1) to show a ref.
>   $ git refs resolve
>
>   # Replaces git-pack-ref(1).
>   $ git refs pack
>
>   # Replaces git-update-ref(1).
>   $ git refs write
>
>   # Replaces git-check-ref-format(1).
>   $ git refs check-format
>

One other command that I noticed, which we didn't talk about it 'git
reflog'. I would think, it would be nice to also fit this as 'git refs
logs', but it doesn't have to be part of GSoC.

> Below is a list of the commands along with their associated subcommands/f=
lags
> that need to be considered for consolidation under this project:
>
> git show-ref -> git refs list
> Used to list references in a local repository.
> * abbrev
> * branches
> * tags
> * exists
> * verify
> * exclude-existing
> * dereference
> * head
> * hash
> * quiet
>
>
> git update-ref -> git refs update/write
> Used to update the object name stored in a ref safely.
> Subcommands:
> * [symref-]update
> * [symref-]create
> * [symref-]delete
> * [symref-]verify
> * option
> * start
> * prepare
> * commit
> * Abort
> Options/Flags:
> * --stdin
> * -m
> * -d
> * --no-deref
> * --create-reflog
>

One of the issues we had with 'git update-ref' was that it wasn't
initially built with symref compatibility with mind, which is why we
had to add 'symref-*' as new subcommands. This time, we can fix that and
reduce the surface of subcommands.

[snip]

I agree with Patricks comments already. Just wanted to comment on some
additional points. Thanks for the proposal.

- Karthik

--000000000000a6dcee0631f27126
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8c46f04fe02e6ea3_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mdnhyQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOEsyQy85c1ZaL0k3ZkVKcVdIY2g4c21PV1hQZGVtZApoZVdiS2Zid3k4
a1dETE1neXR6UmZ3YU14UGhxWjhudC9kelhCRk5UOVpoTTRwV0x1eEVhOFlDaE1NbkloemxrCjFY
QXdjTHdiSWJselFrMGJxeVVTS2hWZGwwOWFxUUZqU20rTnF3OW5Qb2hYeWp5RHlpcVk0TWMwYW5I
WW12U0QKNUhuZjc2TC85aklNZm5wbzEwU0oxV0Y2aDE4RDQ0TXA4clZqSGVDdWVZRVZhRWhBbmNu
cGpackR2ZjFyZ0ZUeQpvUmFaVDQxVW5sMkFXSFc4NnNsNVBpWFVKc2Y4cXJ0YmRSZTR3R2Y3RVZN
Z3VFYVQzZkg3b2R3T3RlVDhMUHRzClNITXZIblN1OTc3Tkd4TjRYVDNDQXNrMGpnWXNuL0djMThQ
SkpwRTJ0SGUzTkE2MzR5Z1pWckxVc2dla3ZTRFQKMkdlK2lDZGRkQVZpZ0tCMVNLamRiMUtnMjhS
Z3FXWkVlbHRyb2xtSWd0WDc2SmJFTnhuUkM5aFIySEF5VTRjQwpkRVNwQm1BOWprWnFsM1I3QXMr
d296cThJTlNUdUpzVzZCTEF3V2VBbnRXSzJwQ0dDMGhYZzR3OStEVm9FWllmCm0zQk1Wc2VhclpY
NDlCdVVZUWhlQ1lHejNtb3g2NUN2aW5odmZMcz0KPWJNQzIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a6dcee0631f27126--
