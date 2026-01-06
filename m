Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ECD1DC9B5
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 16:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767717022; cv=none; b=GDTFPMnErRw+xSqus0y8V+BFKnub35fUOLeXRfzvAgroabAHPC9wekb1cT54lSkDA5wG1YLm4bFkkljqxyP2eZfNKtQNdsPRHYe0qaPTDF//c+ZLXgjh9oB8thoTGp5gQf6O6wxanDix6p4nGP6eX8dnol5+aMcZKE6iWm5IJkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767717022; c=relaxed/simple;
	bh=fFlaicYbwe/oRi26qU5NvkigDfS5BM7ayRtCqh+Xs64=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ODTt+2Bab2/T73YGZDlwnudist4TuOA6pMRngFuR56sz6DqE2cRsDqWSEqtT1ulAOCviVtsTzkzCdgwaaSUCfH0JDyHcJfLApCzPAvaDZyb//e8DoMB0QkV515xtv0pv/30SMqPWmj7P+KcfO7Igka7NTtfrpALyYg06O9r+wjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RbgQuZQK; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbgQuZQK"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5deb0b2f685so2032880137.0
        for <git@vger.kernel.org>; Tue, 06 Jan 2026 08:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767717020; x=1768321820; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=gWRoRSF0i18K9W+N7AVhZCgWb8dwJ2WW0K+9eOwHIx0=;
        b=RbgQuZQKUogAFfjmv3rir691XR7yQoC4S/Madf1SHXqFbcmegCphD21p8AfCrgCvlt
         jCthe0JLiwMd9hBMuNOPSEMYbeuW5fF3jcty8OS0R7k5ZWM4y9AM3WEABGkxEX3NVjvs
         0MlgKlmzmtrVsjqOGlbG3/XO11TswsRS/ANbZAwv898tNC1OMH8SDybGImSOsc8A1w3m
         Xc5FXEFUoJKvhKBukWwVJNt7JEfyS/IVqb46gSQKeVLXQI28X8hd+KxgS4TfW3Wtu4vw
         l3KVmn/19t4uf2p1oKa6CtUKhvULktX7y+SeqwWmPriigLrSOlzlfJsi953bZhmz6ODg
         i0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767717020; x=1768321820;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gWRoRSF0i18K9W+N7AVhZCgWb8dwJ2WW0K+9eOwHIx0=;
        b=DAVGBJjEqG2x+pYet5HGhjAp82Fj4EtQ+Llem2TnmgAQw2TInIij6VwKUpukjiwjGT
         UszUjAtgLKzKUlkQD7oh6uHmty20uvL9t6Hg07sbiPrqcNSaxT6tPQFR9npiaYkHt5lc
         3zMTgQnct3FsxbyavncUNPiS8RCR7cw/XPpdLZVDtfUlkZ9/3Otqf1V5k0y+dfkcfS96
         wFCPxJ3ZFaTaz02EarLLhZ1HW0MpIKrWYW5k6sIXdDwo1bGgfL4FoSB/nISto12sa20h
         oeg+AOFPgomAUIpczm7Y9lEYYt3+ilmmFHbj4ujEYmLmQIqxXvkMHmAePr9GDfJB3pfv
         cPoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrjnx5N/lynd90Iw/93Qi0vHptHWgTwVDNm+1TBYa5FsyqIsmYWAJbHTZIEPBkwZw0mRg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9VXTzjYZywKhh6KBogDkRDGXQUG0UpjtzbMjw0/HsYmBSF5bI
	KMMUIiYEF6RUHS7TQse5rWwfMKEFCV69nMAngqvIpYFKHUPk4fmyqMY/fZpZJTDpj6VkrdMhIrs
	oDeUjJVSPSv2qki7ckNebUE0v3SHbiw8=
X-Gm-Gg: AY/fxX7paknVyGA1xo9LRLHNh/3SnOkG9qAU4uDso/YSq5lfq72ffTpx09yUhqyjjUB
	82iKJ+IkbOSHDUsrJsF/5K3PckCv3bqet8aP0ka8Y9CanviYrXdy750eEepCLv8khJsoZtOh/7I
	aM+M9yNRbjJQZueUSNu+dPM3/4tYe7C8bcn7w/1f0hJ/kow95wKzomSMOLciCaBZ04n0qxRYlkB
	D4VXUeBtdY6POKCuQh5PdPpdxFykug3IYFfjhxApE9/IJGGKohmsLPot8yl6wfmTpydxRajPIt3
	01aJiNpD2A70+OJSMxGCt3pMw19QFg==
X-Google-Smtp-Source: AGHT+IFQSzmKITA5H9aFOtSuRVZr74ivUsVtJ2Hn5gUp1yK8EZEdo98BynQGJRrLADoha991IFHl2mwzdlMBL5e7O64=
X-Received: by 2002:a05:6102:26c4:b0:5ea:65e1:a9a0 with SMTP id
 ada2fe7eead31-5ec75743d44mr1120018137.18.1767717018163; Tue, 06 Jan 2026
 08:30:18 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Jan 2026 08:30:16 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Jan 2026 08:30:16 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260106-odb-related-fixes-v3-0-7ac157207b20@pks.im>
References: <20251205-odb-related-fixes-v1-0-ef4250abb584@pks.im> <20260106-odb-related-fixes-v3-0-7ac157207b20@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 6 Jan 2026 08:30:16 -0800
X-Gm-Features: AQt7F2pdIlEQlA-R71GUC3AoXA1Jzt_gyYZw3wiuWnanTKppOfrBgmsjAI4whG8
Message-ID: <CAOLa=ZT8_vij=2TU3GNZSST0N8Oj1CmaOd0ZzBcp32N8Aze0WQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Some random object database related fixes
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: multipart/mixed; boundary="000000000000ee85300647bab0b0"

--000000000000ee85300647bab0b0
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this patch series fixes some small issues I've discovered while working
> on some other patch series. I've decided to split it out of these
> because I'm hitting the same issues in multiple series, and I don't want
> those to become dependent on one another.
>
> The patch series is built on top of f0ef5b6d9b with
> ps/object-source-management at ac65c70663 (odb: handle recreation of
> quarantine directories, 2025-11-19) merged into it.
>
> Changes in v3:
>   - Use `test_commit ()` so that we the same object at multiple tips.
>   - Slightly reword the commit message.
>   - Link to v2: https://lore.kernel.org/r/20251211-odb-related-fixes-v2-0-bdf875ce51fc@pks.im
>
> Changes in v2:
>   - Drop the first commit that regards geometric repacking with promisor
>     remotes. As it turns out my assertion was wrong: geometric repacks
>     do and have to consider promisors, but they will fail to handle
>     them. This is a bigger topic to fix though, so I'll rather want to
>     move this into a separate patch series.
>   - Tighten tests a bit for the commit-graph generation.
>   - Stop referring to a "subsequent" commit that doesn't exist.
>   - Link to v1: https://lore.kernel.org/r/20251205-odb-related-fixes-v1-0-ef4250abb584@pks.im
>
> Thanks!
>
> Patrick
>
> ---
> Patrick Steinhardt (2):
>       builtin/gc: fix condition for whether to write commit graphs
>       odb: properly close sources before freeing them
>
>  builtin/gc.c           |  8 +++++---
>  odb.c                  |  2 +-
>  t/t7900-maintenance.sh | 25 +++++++++++++++++++++++++
>  3 files changed, 31 insertions(+), 4 deletions(-)
>
> Range-diff versus v2:
>
> 1:  564b26fa6b ! 1:  3ef6ea3560 builtin/gc: fix condition for whether to write commit graphs
>     @@ Commit message
>          establish the proper border at which the auto-condition would be
>          fulfilled. As it turns out, there's another bug: if an object is at the
>          tip of any reference we don't mark it as seen. Consequently, if it is
>     -    reachable via any other reference, we'd count that object twice.
>     +    the tip of or reachable via another ref, we'd count that object multiple
>     +    times.
>
>          Fix both of these bugs so that we properly count objects without leaking
>          any memory.
>     @@ t/t7900-maintenance.sh: test_expect_success 'commit-graph auto condition' '
>      +	(
>      +		cd repo &&
>      +		git config set maintenance.auto false &&
>     -+		git commit --allow-empty -m initial &&
>     ++		test_commit initial &&
>      +		git switch --create feature &&
>     -+		git commit --allow-empty -m feature-1 &&
>     -+		git commit --allow-empty -m feature-2 &&
>     ++		test_commit feature-1 &&
>     ++		test_commit feature-2 &&
>      +		git switch - &&
>     -+		git commit --allow-empty -m main-1 &&
>     -+		git commit --allow-empty -m main-2 &&
>     ++		test_commit main-1 &&
>     ++		test_commit main-2 &&
>      +		git merge feature &&
>      +
>     -+		# We have 6 commit, none of which are covered by a commit
>     ++		# We have 6 commits, none of which are covered by a commit
>      +		# graph. So this must be the boundary at which we start to
>      +		# perform maintenance.
>      +		test_must_fail git -c maintenance.commit-graph.auto=7 \
> 2:  20bb4741eb = 2:  55cad3ea0f odb: properly close sources before freeing them
>
> ---
> base-commit: 2797238193944b52d12624a04a962f40b9bcad69
> change-id: 20251205-odb-related-fixes-5f48a0993ef7

The changes in this version looks good to me! :)

--000000000000ee85300647bab0b0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: de72b577ba3c5471_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sZE9KY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNTkrREFDZUsvZkNpQ1BIZHd0L3hKUmRxbWFZTTlPZApSVGIremFDbDBm
Y00xczF4OWpoRWFMSlRwWnhuVW9nK04rTGFNbTEzbDZneUF1cnpmcDF2c3Y0WlIxMVNQaWVZCjhE
SnFxWnkvQmNpbTAvbmhleXF2UnVXdTVnWS9UZ05RMUhaWVBkL3ZJdEdZNHdpSmtrY0tJeDI0QUdI
NkhuN20KRk1NRnhSZGI3c1hxcXM3bmk4M2VaK2N4MEQ3Wmc0bVh2UEZrcWdMR21ocmNwYnZ2YllE
YUMrY3UzUXhWSGR6cQo3SEJkNVB3T1FGcjVla0FHeEpnaFRiMUFQZktWRTZReTkxendDZjR2VDNz
T203SU5pUUxZbVJtY0lJTmhWQ21mCkhuQTBza0xSYzdoOEQ4MzZIdlVHc3FwV3dwYnVFQk5tSC92
bzFSK2dxanBUUUwweVVBdUZiZFh0SjFtU0JDRlkKYkYvcDBPV2xWRmlhc04wdkNsTnlxZ3htSXBG
eXU2dEpNai8xd3ZBbXNnTHFacHhzR2JiYjFReU1CUXVUY3FhQgp5TS9UckRkbFFlTUlWd0ltNG1t
VlBud0drSno1WE11b2k5UjQrSlR6cFpWZDQzVWdpeWk3UWlWYlBmZXh1cHFNCjBlK0ZWVGNhNytw
UnFvNXRhRVZTSGFaTnVsN0F5STNLYlJCR2FOWT0KPVUrdG0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ee85300647bab0b0--
