Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFD8DDDC
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721724631; cv=none; b=B0kzGXbx2YjOnP+9/7z+mAn1xo/U3aWbKO9/Vv75cggPaerv6Go544G469Szxc6WNI2mXXZ3RXDfuVb7ZcX7QWGToUVtANgP80c44x23PpJ8Cj1YTFApHCbYvaQceEhsLii4nkJ6i8Q+bClM7LHz0VASofDauhVK0CCaCpNqjWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721724631; c=relaxed/simple;
	bh=UX3MbQgXMOTuuQF9FuaMTgiumAWVQU3waewm4P5Qzrk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+B6IVPNrJhABdK8bxdAOWsc7Pe+xpbuytJ6nKLYCRFrzylRSm+mWllwICKo6hRyE7Zko/HNdoV/tXajm8Q/fXBm6DaNVosJoT6+wE8LAY5drfEzSSjpBKyk109qPPPuXwMOnXJR5cg0oJxGbMc0gNP4aSFwX6IHPvTl6+BzIaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcsWGQuv; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcsWGQuv"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eeec60a324so67616841fa.2
        for <git@vger.kernel.org>; Tue, 23 Jul 2024 01:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721724628; x=1722329428; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1AXNLXg39nL0JkXdM8prAq1WXceRgpvHbA0/dBKsH98=;
        b=dcsWGQuv31LsjGlzLM8P9Zh/iGWJi7JcUmpNbz0458YJ/XN/Nu8as2C11pmFt5FR9Y
         A+PY5aE3yvLAPoPsozIZJdWiECgcuLpsBKsIJ7KilrvQHoiAtTSrRydSPYLO66HV778v
         MzKAuFgDXJdv3wpu/4LlO4SctONLp29blpX/yjHcxCiQWZdcu8Ck2neVeLl0gqzCPzgF
         ecqWaguPKvLVO5W3NHl0WA73bWulDm6wakGdaZ3p4DpcAONWSPwwvpcCHhoFLQ0tRG+Q
         /0qvZUKkzrPZZIAHIsKJhDscS7jE09TFKhZNbw6Ia/1/2lA7T984tLKokanulEE4VU2J
         p5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721724628; x=1722329428;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1AXNLXg39nL0JkXdM8prAq1WXceRgpvHbA0/dBKsH98=;
        b=QUaZ17OprQbVbWjV1f2ukgQTY8s/WV8tyklb2171DxJE5OZ2zm5FYZLTsgoe48oJq2
         Iqknt1nfmUubXvEOQ95+0+8GhSyh8hOjLxyg9/28TR8qgO4y7RWIWnx53SWsLffT5uAX
         ifhoplSvC3gUv3k3rp0OlQfhYTTHpczaF+4usThOW/INdqqh+SzAnnH+yUWV86K/lD0b
         VhNGn3TuQXDoK623UW7km7JIhgBOi1lpkohDxAWvlNgeDonEK3TLFaC31C5OWCJpDLGq
         H5zGiS7EILcQEHrsfZXV3tJnLIvGtkfhUfaCvmtfhRVgWpYhN26mN5d4HpqOwFJXRts+
         xdFQ==
X-Gm-Message-State: AOJu0YzvWYK6+RDuRFepzC3tlMtQ+oRLK/ch7ey9uWrJwPHLJEShdUiG
	jF61dl5xDrKhvEIPNhYwwZLOBk0txOY1spdgIjso4mTeV9gvIUKSCWazzXjBwt3pPNZJhKl+8Fb
	ccwcoqiilkkqNzOjeyHQdBm6Yb9A=
X-Google-Smtp-Source: AGHT+IGBjKs0ogbv5+pGwjHNltJzcGMAFac9YktfT90reL23sByBFSRdcNR2DKEyHpaVNkLK2JXMhtOTKcGLoQUBdzU=
X-Received: by 2002:a05:651c:1a2c:b0:2ef:2b65:1d03 with SMTP id
 38308e7fff4ca-2ef2b651e57mr68655911fa.49.1721724627627; Tue, 23 Jul 2024
 01:50:27 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jul 2024 08:50:25 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqo76p54ib.fsf@gitster.g>
References: <20240722225302.124356-1-tomasn@posteo.net> <xmqqy15t824l.fsf@gitster.g>
 <xmqqo76p54ib.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Jul 2024 08:50:25 +0000
Message-ID: <CAOLa=ZSJHz4RXvmmJi=KdDYCQ-3=q0p1KW1WgZAeotSQ+A_UJQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] doc: remove dangling closing parenthesis
To: Junio C Hamano <gitster@pobox.com>, Tomas Nordin <tomasn@posteo.net>
Cc: git@vger.kernel.org, charvi077@gmail.com
Content-Type: multipart/mixed; boundary="000000000000d4c91b061de640b5"

--000000000000d4c91b061de640b5
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Wonderful.  Thanks.
>>
>> Will queue.
>
> Spoke too early.  We need a matching change to in-code help,
> otherwise t0450 would break.
>
> Here is what I have, which hopefully needs no more fix-ups.
>
> Thanks.
>

Can confirm that your patch below fixes t0450.

> ----- >8 --------- >8 -----
> Subject: [PATCH] doc: remove dangling closing parenthesis
>
> The second line of the synopsis, starting with [--dry-run] has a
> dangling closing paren in the second optional group. Probably added by
> mistake, so remove it.
>
> Signed-off-by: Tomas Nordin <tomasn@posteo.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/git-commit.txt | 2 +-
>  builtin/commit.c             | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index 89ecfc63a8..c822113c11 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -9,7 +9,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git commit' [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]
> -	   [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>)]
> +	   [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>]
>  	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
>  	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
>  	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 6e1484446b..7f9dd45d05 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -41,7 +41,7 @@
>
>  static const char * const builtin_commit_usage[] = {
>  	N_("git commit [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]\n"
> -	   "           [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>)]\n"
> +	   "           [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>]\n"
>  	   "           [-F <file> | -m <msg>] [--reset-author] [--allow-empty]\n"
>  	   "           [--allow-empty-message] [--no-verify] [-e] [--author=<author>]\n"
>  	   "           [--date=<date>] [--cleanup=<mode>] [--[no-]status]\n"
> --
> 2.46.0-rc1-52-gda884b23f2

Looks good! Thanks.

--000000000000d4c91b061de640b5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a9d17ba13d62b02c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hZmJ0QVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNm9QQy8wUUh5NXB1OW5ybzRxK2grbWt6ZmlrRkx2aApNVUpmaE53UWZs
YWU3bW9TVDVtYzhKZjlFS1FUdDdpS01BcDBPajBlaHM2N1JxM0xyQ1haZXl3eGEwU2NvbVZWCktX
bWszVjA2YzhES1Q4WUt1VHV4ZXZqVUZqZWptbjJZMTc1L0RSYmwrSFd0eVdaK3YxOFF5M2V0ZlZp
K2NKUnUKOHh5Lzd4SWJ3M2VtS1RlcVBOWUVsSHNHZlkrMWJZVmhXdjdKK3lYWHUvK2tHbGE5N1dV
N3p0aG16RjBjWEEycQp1QWUxQ3Y2R1Q0WEZ1K0N3NEp6dFlhZUFwRzBzbXRrMEhCKzJQekN6RlhY
S1FRZnpFSGFMOVNvNEFIRmR1dC9UCmRJVkFWTU5MSk91NEhrL2lQQktPUWhnWmQycTJaWmptc1JQ
UWZ2ZzgzNHJiTkxmWUFtbzNSMXU5SzVnNUpWbXAKWitOajk2WUNHbzdMdktzVHVMVTBjajJ6UENE
VFpHN1RKSGw1TjhBVTMvS2tVaGRTTmt5VWdBYzlPYVlzV21MdQpWbUpVd1NJVW85T3V2dUhSSlRn
MVpjUHdmbEFNSnA1cDVISlRBVWI4QXp3VjNYdWdSbkdITGxobmJyZTg2RzVPCm1xaTh4NWFPM2Fj
dExpYW4vSWgrY1FJdzdoTGp5Mi9iV1N0d0ZOZz0KPU53R08KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d4c91b061de640b5--
