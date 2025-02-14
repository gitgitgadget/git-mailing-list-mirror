Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BC12139A1
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 09:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739523853; cv=none; b=Oybr1lTNsdvRzuitMmMBXEzPutAOHYv3PxHkXxFlSOn4shz6fVBbnaP/GCwq8ICS3yEsg/JvsNgtSOaPQk6R2kxUwHE6uMBsQK+WwdU7psktXw+2KuMFvaYpv/eT20PlhkJ6XeYRXx+fm1nerVh1x64rg49jHjo5eHpv2t8RJhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739523853; c=relaxed/simple;
	bh=1+em1ZaEGVsLT+sG8HdENqzetML8ejipvnyben8i8/4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bkb//CyK9MyZ8B5/do8oL+U1Mx9eGsjp7SR1kg0M7KwVK71ML/W56JHmhpD6bGOxcKB0fbRz5O7Ln8lZ1oGn6JR74ZisLQ+tRkQZGntdJp+HiiOo+I2UwMc+DJz78FlbreDF2MYIa03e6cQx6jmH8LNnkcM9Ned0B/l4BefzV9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0HOLaz6; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0HOLaz6"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-52088c0aaa3so278145e0c.3
        for <git@vger.kernel.org>; Fri, 14 Feb 2025 01:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739523851; x=1740128651; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=efQjm6U7l8bM7JFo8FRBAHlhekotb2BGKzmYByBaHVU=;
        b=F0HOLaz6tLe0pC4ph5PBKu0M3oJGkv9e+F8qwCu3R5IwFCbuiy5RyRDw0RCPZTlfzx
         wXak9MEqldpbvlEgu6pOpYxHbxcLupcjrO4pvQlvLgf/cpUilpu33OFrKC0PKPWDQAzf
         r8LSglUBCAC4+PocJVcd4tyhcWiRJxggHs6eCJZ+RrBOUP36HlGCTce44YysWdUZ2TTM
         dq7Mmlh3n6nsIRPurv2OJ4eBGhmXCZyj/+HE71k8P/213ndZFhLY9xOew/4M0TwZwsb1
         fJfKY5La/8MVk1rpmtIPbEjTpTHHlOEKeHG8Bk4qTy8Dl9DznehGiAnZ7LLrB5le34Wf
         svGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739523851; x=1740128651;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=efQjm6U7l8bM7JFo8FRBAHlhekotb2BGKzmYByBaHVU=;
        b=S76ZOuLBSBWwwg9XNlKKkcpX6c5347j592SM0iTU7DN/mzsGT7f9wXa8CUthIMXcl9
         aGyaj7+0THrY0r0nDaBJs61Og+QBW30A2gSvDDAMU2KyeLisCPbyVEmW29/QH0zb55dO
         lWXDwG2mAppncQDWPvnnKxCzZnCnZOq3KBsLg9R+ocEugb7UZSaNP8JnrdIH8KCniQnl
         RD3CxF3QWl28YrtxkQjyd1JtVBiU3hcO5AQBGqW4QII3i5PqFZooBcjNVhJPr/hG1S02
         lsKS3GnQVklOh21nS68jdq1exuWoHLNCm0ovQogjtZcSTQWBviiBq4oWyAd6GQpTj1O/
         AgMg==
X-Forwarded-Encrypted: i=1; AJvYcCWJeNVNVsLGw/41bl2gUEUeh/pNIehL9x9N5+OSfzkDixcnOa7HkCBmgwl7VgJX3x5U4+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIfPyY+I71gshvGTCY22OndY56LN7nadw+ulgqK+hQt883IivF
	0oLYY8OL4VDTzbNHbsl1pIrSSegLY9ONq6X25yOGQN3cGrg2vQjnQmbNsXvqahlB2gX8PHzcr+k
	VLNsA9C1QO7Vp5Ob7tQMJYZ+3guo=
X-Gm-Gg: ASbGnctTkuMiUwd41EfVZcL2/siyceWlD7SUNb0aJnge899tbwlXf/X+AFXrhHKo/1Z
	MHOy+Uxkai3CDHOoZZcvDyTxL9eTNUgQiolPiyypcfBnMPHgJzqZFFQgJdFDbS2rMbD2tfV8wrQ
	==
X-Google-Smtp-Source: AGHT+IHUT2zwCmouDtRh8eHHHBOjLHH/4mk0QH8YjPqe9MH7YuLvdbVDjEzoskFdNJ/5NbZxqbh/DrSFPPfpN4ZK0Gs=
X-Received: by 2002:a05:6122:1d8c:b0:520:60c2:3f3 with SMTP id
 71dfb90a1353d-52067b7c509mr8279720e0c.4.1739523850677; Fri, 14 Feb 2025
 01:04:10 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 14 Feb 2025 01:04:09 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z67LkxAFIAeaYr0U@ArchLinux>
References: <Z6RPJI10-2QkwyqH@ArchLinux> <Z67LkxAFIAeaYr0U@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 14 Feb 2025 01:04:09 -0800
X-Gm-Features: AWEUYZm3JaauJAn6wFH4oyvgwlBxwGYF63AiDiSGtalZwwrQBotm0CSvn4Pkwt4
Message-ID: <CAOLa=ZQFLTFNc5AnvDyAaLvY8__R+J9RHZ29TM8COhPxnQs8Zg@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] add more ref consistency checks
To: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: multipart/mixed; boundary="00000000000032cf81062e16752d"

--00000000000032cf81062e16752d
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

> Hi All:
>
> This patch enhances the following things:
>
> 1. [PATCH v4 4/8]: update the tests to verify that we don't report any
>    errors to the user in some cases. Also, suggested by Junio, make sure
>    that we check whether there is a trailing space after "# packed-refs
>    with:".
> 2. [PATCH v4 6/8]: instead of greedily calculating the name of the line,
>    lazily compute when there is any errors. And use the HERE docs to
>    improve the test script.
> 3. [PATCH v4 7/8]: instead of storing the states, we parse the file
>    again to check whether the file is sorted to avoid allocating too
>    much memory. And use the HERE docs to improve the test script.
> 4. [PATCH v4 8/8]: update the documentation to emphasis the default. And
>    add tests to exercise the code.
>

Nit: For someone coming in to review the 4th version directly it would
be really nice to see:

1. Summary of what the patch series is about.
2. Changes built over the last versions.

I know all this information is already spread out over the previous
versions, but would be nice to have it here (in every version rather).

> shejialuo (8):
>   t0602: use subshell to ensure working directory unchanged
>   builtin/refs: get worktrees without reading head information
>   packed-backend: check whether the "packed-refs" is regular file
>   packed-backend: add "packed-refs" header consistency check
>   packed-backend: check whether the refname contains NUL characters
>   packed-backend: add "packed-refs" entry consistency check
>   packed-backend: check whether the "packed-refs" is sorted
>   builtin/fsck: add `git refs verify` child process
>
>  Documentation/fsck-msgids.txt |   14 +
>  Documentation/git-fsck.txt    |    7 +-
>  builtin/fsck.c                |   33 +-
>  builtin/refs.c                |    2 +-
>  fsck.h                        |    4 +
>  refs/packed-backend.c         |  349 +++++++++-
>  t/t0602-reffiles-fsck.sh      | 1205 ++++++++++++++++++++-------------
>  worktree.c                    |    5 +
>  worktree.h                    |    6 +
>  9 files changed, 1140 insertions(+), 485 deletions(-)

[snip]

--00000000000032cf81062e16752d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e355fb6d9495cf37_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ldkJ3Z1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNWtWQy85UDFzNE4wY0JlZE8wODBJVDA5b2lCKzdlawpQb3YxMnpTSXZE
YVJWeG9kcFFWbUhKTXdqRTNpQ1lTSzg3ZG5iMUYrYXRNcnJnQkh2b3djSXBYYXVKdUd1d1plCng5
TElmNzQ0Qmg0SnFmWkJMOWxqakhtcmNEVkFkeGtnSTVrVWpCcHRkT2VacFdCMnBweUVCWHVlZjhU
eWpFL0oKdlprUkk5Y1YxQ25Tc2kyUWM1S1cxTys0UmFiRVJxNE9SQkZUNXpWWjlZMkxhdlpVTEc0
U2UrSmpqeS9qSTQyZgpteVVwWW5iTk96TUZmemg0bzFmK2FrdTMrYkhnbGlLSjhoZ0ZlQWswd0hP
ZHVpT3dBVDFIS1lTdnFFRDVlWHhzCkMybm5GS0tNdDR4SWd3dFFLZHZpVG9HWWhUNlR2a1E1enps
UGcvT29aSWNucSt2TWNXM0pKeXBCNGkyVjFvaWkKUGJuUG1SeHBBbWxDcEJLbVhONHpiVGRPVEZL
ZXNrTnpaUDZ3Y1UwU0ZwMTI4cklVeWd0cGllZ3BqMlNaejVWVQphYk01TDZBS2NDcmxGT3VwNDVi
YkdEcmVVQkx5VHB3amI3cjZVbG0rcUJQT2orSDhrV2xNcldXTExwMGs3Y2tVCnJtRW9pZWphWnFx
SHNuRFdzODJxN3gxRGxtdkdvd2FvWHkxT0ZPST0KPTRrdk0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000032cf81062e16752d--
