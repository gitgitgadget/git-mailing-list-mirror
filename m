Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3DD1FECB3
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 16:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736352013; cv=none; b=AbLUnmaeD4aKBFPnLmNAewuy8UnIybbf2mFfB+vf9qoeHKdIkSqJoc+sW+Ms2C8zyb9Q2s6JYSIPpOHtYc5OWAIfzxa1PJPFNq6uihPnyHPmwxQB6AuT83C0Zc7hlHm66wYcjxLDFf0M2yj1sM1PfQsIlY5pZHWSoTSJdWUXezc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736352013; c=relaxed/simple;
	bh=wphC88Whd9QzSQIyXXR5sj7vKdklWRV/sn8R1aKGRwU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=TBGzQlNXBlkwzs6XfIu2mnBhlwhfXAwzaajO0jZlh2AqmfjLHxr/7E8tg3+pcyagzQNWX2dcE+WsjSV9H9PZDir4c1wav1a6tNXIRUQUKMIwr4XGkD9QL3HrBNxy2d+rpsT12CLZNBvNrBD7I02xWp4JJ0x6Kfl6KxyTYT7PoCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJOOtJ68; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJOOtJ68"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385e87b25f0so692358f8f.0
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 08:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736352007; x=1736956807; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=azLy+ks6ALGTcCwRbfAwkWGaR5liZYva672VKsbTBa8=;
        b=dJOOtJ680oEoZO5qfnVF1Ddgt8HMsc7uAZUNZpFNSu9vDc1E7ArzDQr9EqQsVFrBYI
         u8U0x+QMEHWk3S0vtTkklDwhhlxKJdtTeAGSVEzDI8qxNDrk+QVZt1a4UHHA+eV/ygJa
         yuOuf6F6Qu3o/iDU2NQFJxjagw2MalExMXt9/NDAX9K9LoR2QsNRoi63kHLJk6B5Y/+L
         9WOTwOo/PtgRnpuaLVQ5ODmylJ9jtb1CqVCh1W+7alpWzlOnsE4/YHJQorE5Chrm0gDc
         Cj/LsFHzr0P3rp55kX5Wo+kVqLZs1X2xEVc/BOa9BeWiYqaU2Ohu7TYMhd1tkmZD+Vdp
         91GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736352007; x=1736956807;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=azLy+ks6ALGTcCwRbfAwkWGaR5liZYva672VKsbTBa8=;
        b=KvAzsujBF8GEbJ47djorI1DOIQiq5bpeSIYvBGxaotNmEZ2u4S+zELNO9dVlsVP8HF
         QwhRUYQlXVfCQjBW2srsNFZa9y9HO+Wnxdx9LLLL3XAFwEtDA7sYQ5dqq6r17bAfppsh
         KJ9hQnjbytEPvheUMU7IRyc40GQbNNdhRQ7ejdis50zi4fQPxFXMSHrtt786WGFpJIQt
         8Bs6AY47r1ECedJj3zH7i8BQjX1OdeRpDbo68ZvvGQZUM65so3F47kh7lUfHLYz2cbR1
         QdQkinK5rHCK6HtpaGItezMqcLNBNrr2WV/sP/agCXBhxTlxUDY9fnWzJghoZhCMbftL
         aPJA==
X-Gm-Message-State: AOJu0YyHY9VUkMJZvWR7ilaSXq7pzw0JRVsday7a+zTW7ugVOqJLPwSh
	g2xcFVZfAenIC0panqS8MZZwdl5dfZdtnqG8y7n2mGbM45vJKcWl5Ao6Tw==
X-Gm-Gg: ASbGncvPZWr5KvJtRScdXysY0GT4f10gmbWdp+j9q3iD+Q5B/9bDaGloIFkGC7h9Jc4
	dPpdKNIPvfrV7VlUAv0m6UJX3sg74OL6WWjJ9OWOoCEx5eS8SV4kTRLpP2h0j6a1QXwSJwvBf9D
	AV3TN+XtQ/R0D5dJQtnCbqOjrmCSy9K1UoHsW+bqhLPlfFUTe2UrMFnBCamh6W6TcXSvTDEL9ZC
	PesAXdiOLCi3bNmz88or/JPzBKOuRhPfndezTj4OSWyDFEXvL2mduIcmw==
X-Google-Smtp-Source: AGHT+IFUd+Qi0GIFlDT0XMkJ8X5/SaRA6obuKZHjb6QRe4JUAsSD5lGz1ygwv+H9VDYnAuz6Gzb6mQ==
X-Received: by 2002:a05:6000:1faf:b0:385:e8e7:d09a with SMTP id ffacd0b85a97d-38a85e1f0afmr3688566f8f.2.1736352007359;
        Wed, 08 Jan 2025 08:00:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8472casm54067945f8f.45.2025.01.08.08.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 08:00:06 -0800 (PST)
Message-Id: <pull.1848.git.1736352005578.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 08 Jan 2025 16:00:05 +0000
Subject: [PATCH] t-reftable-basics: allow for `malloc` to be `#define`d
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As indicated by the `#undef malloc` line in `reftable/basics.h`, it is
quite common to use allocators other than the default one by defining
`malloc` constants and friends.

This pattern is used e.g. in Git for Windows, which uses the powerful
and performant `mimalloc` allocator.

Furthermore, in `reftable/basics.c` this `#undef malloc` is
_specifically_ disabled by virtue of defining the
`REFTABLE_ALLOW_BANNED_ALLOCATORS` constant before including
`reftable/basic.h`, to ensure that such a custom allocator is also used
in the reftable code.

However, in 8db127d43f5b (reftable: avoid leaks on realloc error,
2024-12-28) and in 2cca185e8517 (reftable: fix allocation count on
realloc error, 2024-12-28), `reftable_set_alloc()` function calls were
introduced that pass `malloc`, `realloc` and `free` function pointers as
parameters _after_ `reftable/basics.h` ensured that they were no longer
`#define`d. This would override the custom allocator and re-set it to
the default allocator provided by, say, libc or MSVCRT.

This causes problems because those calls happen after the initial
allocator has already been used to initialize an array, which is
subsequently resized using the overridden default `realloc()` allocator.

You cannot mix and match allocators like that, which leads to a
`STATUS_HEAP_CORRUPTION` (C0000374) on Windows, and when running this
unit test through shell and/or `prove` (which only support 7-bit status
codes), it surfaces as exit code 127.

It is actually unnecessary to use those function pointers to
`malloc`/`realloc`/`free`, though: The `reftable` code goes out of its
way to fall back to the initial allocator when passing `NULL` parameters
instead. So let's do that instead of causing heap corruptions.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    t-reftable-basics: allow for malloc to be #defined
    
    This is a fix for one of the many issues that force me to delay Git for
    Windows v2.48.0-rc2 until I can increase my confidence via thorough
    testing.
    
    The patch is based on rs/reftable-realloc-errors. Sadly, the patch fails
    the PR build
    [https://github.com/gitgitgadget/git/actions/runs/12672507500/job/35316720255],
    but then the base branch fails in the same way
    [https://github.com/gitgitgadget/git/actions/runs/12533205564/job/34952668803].

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1848%2Fdscho%2Freftable-tests-should-allow-malloc-to-be-defined-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1848/dscho/reftable-tests-should-allow-malloc-to-be-defined-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1848

 t/unit-tests/t-reftable-basics.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/unit-tests/t-reftable-basics.c b/t/unit-tests/t-reftable-basics.c
index 990dc1a2445..1d640b280f9 100644
--- a/t/unit-tests/t-reftable-basics.c
+++ b/t/unit-tests/t-reftable-basics.c
@@ -157,13 +157,13 @@ int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
 
 		old_alloc = alloc;
 		old_arr = arr;
-		reftable_set_alloc(malloc, realloc_stub, free);
+		reftable_set_alloc(NULL, realloc_stub, NULL);
 		check(REFTABLE_ALLOC_GROW(arr, old_alloc + 1, alloc));
 		check(arr == old_arr);
 		check_uint(alloc, ==, old_alloc);
 
 		old_alloc = alloc;
-		reftable_set_alloc(malloc, realloc, free);
+		reftable_set_alloc(NULL, NULL, NULL);
 		check(!REFTABLE_ALLOC_GROW(arr, old_alloc + 1, alloc));
 		check(arr != NULL);
 		check_uint(alloc, >, old_alloc);
@@ -188,11 +188,11 @@ int cmd_main(int argc UNUSED, const char *argv[] UNUSED)
 		arr[alloc - 1] = 42;
 
 		old_alloc = alloc;
-		reftable_set_alloc(malloc, realloc_stub, free);
+		reftable_set_alloc(NULL, realloc_stub, NULL);
 		REFTABLE_ALLOC_GROW_OR_NULL(arr, old_alloc + 1, alloc);
 		check(arr == NULL);
 		check_uint(alloc, ==, 0);
-		reftable_set_alloc(malloc, realloc, free);
+		reftable_set_alloc(NULL, NULL, NULL);
 
 		reftable_free(arr);
 	}

base-commit: 1e781209284eb5952e153339f45bf0c1555e78bb
-- 
gitgitgadget
