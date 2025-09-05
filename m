Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B730222836C
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 19:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757100382; cv=none; b=Z9kYcVdfzNTe7QPeJyqkflSubxT2JJ0PQ70PsRu1cdausi/wjbHGCjqc+A+704ZkpDu4EYiR7fbNKmR45P6PMP4qNiX6r1g70ncHRhMUE4S3vIEfHcVPeKTwbiHL/GdWQfbyP6ZdluDxGGs5F8QCoN1BIXEhQtL9yS7SgPPp8xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757100382; c=relaxed/simple;
	bh=ueXQFzkHsE7PMfcyfqdQC2/oPyv2RiAO5Fr13yOCoJQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ci6oMm1cWHD4vn7phQL2x2euybHIjilSBszHgNRXONQNbtuJa9wDVRKGQpUFuXQwYrord3HFi7Zq7eSrAE9nkRJjoqRLkG7tbOOKecoUceXlO/G01W11YWCQB83WRN9jcAZO8fv8rCwVN+nWWZKw+MX7RojiPWA31fd0YqD5FGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9hy94Yt; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9hy94Yt"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24af8cd99ddso32231905ad.0
        for <git@vger.kernel.org>; Fri, 05 Sep 2025 12:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757100380; x=1757705180; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qm/VvxEFtfHBf4wg558m+psoosH6pV3dwgZ5RkgZ9vQ=;
        b=E9hy94Yt4ZejYyIdspNRDcvySCU3c1PoAY4I+ucocogdhGB3dDf2Y3acnPxfMDQuMu
         omqS0naPWL1mSRO2oR8H7JHYIWKpEx5MOt0aPIOkmPrNorUvcHLKeI8CN1OCHMgREXY+
         mBg3Tjs4JYQqDvt0VTrS5Y+Y82TftWblZl4Fzq0xKM634kIWTI3+SN6aUUjN0OSeDrwi
         0he7TekALL8m2GzF0VoZahDCYNB9aUOukg59Ih8FQ42EGDFNjESAnyrzahTByHfLmFHn
         zSpl19/oWzS6JITl7VUm+3L1bb9jKN0JxuNu106l139A5MQGEOhVM84EVLVuDG+EV6ip
         IGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757100380; x=1757705180;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qm/VvxEFtfHBf4wg558m+psoosH6pV3dwgZ5RkgZ9vQ=;
        b=nkOeSrg5AapPO1cDwDMgb5ziQ3RqJbo2cOkvWPgpFK8n3gVghwoW60t3XWl6RN696R
         pnFf6QNjSSTuT+kD9z9hC87y2n7Y8DZM3YyfJZb91YgWPza0eVUPsAu8zSUYHfg3CTtx
         jjPgEknVKLNzqGaOkNaI4aO+BOC1JfN3Rf9UFFu9UlXD+Jh/RLs6SgFEb/dqfJKUrp3o
         nXfjdmlfRP1MHc3mjNh2QxdKcwq9aVDnLE6EkHMnw0KR6gWg2XkRbE0fJhPmM75ZXjkz
         dMTqmuIGxXGhNAwI91HdIWSBxUD8TEIiy/59XjFwfmLXEDFeXu3lzG86i3RaiLZqOqn1
         zuRQ==
X-Gm-Message-State: AOJu0YwqCwPdouMZz+gf1EXvt7a+cwlkQjL2mUFFPXm2fBPNZgIsy6jp
	2Jb/iP4PIa+z0Rpsml9fN59IghqUiM0YtIrwHNG3ezRhNM/0ek7k0Sztie7BZg==
X-Gm-Gg: ASbGncu/Ff6WifngxVPQ5KEz0SCzBoiXnkdJ03B/mAwPRGEusxaX2tPliIX3t/9vAFm
	HXLyv7x1lWLgkEWHqwTXerwEtKMSpOHBK8WerCUjdH3kB8LW13nLoaZ45LQTSpQKQNnowLSDMve
	mjqMWWO8UhTHog3YiHgTWJ0YhPEBISZhYRt3ppk4MRhxIP7t/idzs7hI31rRU/36niLLYYY0wWg
	uAT4xluSgqCZtd4WPdeNlGMdjzUxaYqsTspyEYKJ98EdnNcGA5hdi0F2cAvTJwd/9U8sBuQuumr
	ezhdAKJSRUkZSxLjjrI27GX3Di4BkOFVUApilEUipunBY/SuG0dP4HohmJsKxYrMlXfmSFRibZp
	ikvy9iy7Lb4Cfw+aj3Iew5TUdR1Y1UsWo5MQ9
X-Google-Smtp-Source: AGHT+IHz5OLsrl/F+ekCcCWGr+JaFaxEseb2l4wK1ytca2is6gPeOHaeJqXxfOkWLTSfS1KX3cWjmA==
X-Received: by 2002:a17:902:f78f:b0:24b:153f:7722 with SMTP id d9443c01a7336-24b153f792amr179163255ad.43.1757100379420;
        Fri, 05 Sep 2025 12:26:19 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.243.166])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cb01df2c0sm62965945ad.86.2025.09.05.12.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 12:26:18 -0700 (PDT)
Message-Id: <pull.1965.v3.git.1757100378.gitgitgadget@gmail.com>
In-Reply-To: <pull.1965.v2.git.1756589007.gitgitgadget@gmail.com>
References: <pull.1965.v2.git.1756589007.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 05 Sep 2025 19:26:12 +0000
Subject: [PATCH v3 0/6] midx-write: fix segfault and do several cleanups
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
Cc: gitster@pobox.com,
    me@ttaylorr.com,
    Patrick Steinhardt <ps@pks.im>,
    Derrick Stolee <stolee@gmail.com>

I was motivated to start looking closely at midx-write.c due to multiple
users reporting Git crashes in their background maintenance, specifically
during git multi-pack-index repack calls. I was eventually able to reproduce
it in git multi-pack-index expire as well.

Patch 1 is the only change we need to fix this bug. It includes a test case
that will fail under --stress with SANITIZE=address. It requires creating
many packfiles (50 was not enough, but 100 is enough). As far as I can tell,
this bug has existed since Git 2.47.0 in October 2024, but I started hearing
reports of this from users in July 2025 (and took a while to get a
dump/repro).

The remaining patches are cleanups based on my careful rereading of
midx-write.c. There are some issues about error handling that needed some
cleanup as well as a removal of the DISABLE_SIGN_COMPARE_WARNINGS macro.


Updates in V3
=============

 * Use test_grep over grep.
 * Translate an error message.
 * Clarify a commit message.


Updates in V2
=============

 * A stale comment to an unsubmitted version of the test is removed.
 * More cases needing open_pack_index() are patched.
 * Typos fixed.
 * A new patch assumes error and sets result to zero only on the few
   successful paths.

Thanks, -Stolee

Derrick Stolee (6):
  midx-write: only load initialized packs
  midx-write: put failing response value back
  midx-write: use cleanup when incremental midx fails
  midx-write: use uint32_t for preferred_pack_idx
  midx-write: reenable signed comparison errors
  midx-write: simplify error cases

 midx-write.c                | 134 +++++++++++++++++-------------------
 t/t5319-multi-pack-index.sh |  22 +++++-
 2 files changed, 86 insertions(+), 70 deletions(-)


base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1965%2Fderrickstolee%2Fmidx-write-cleanup-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1965/derrickstolee/midx-write-cleanup-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1965

Range-diff vs v2:

 1:  e02a444315 = 1:  e02a444315 midx-write: only load initialized packs
 2:  a1dd3ed874 ! 2:  1e5f43a417 midx-write: put failing response value back
     @@ t/t5319-multi-pack-index.sh: test_expect_success 'load reverse index when missin
      +		git cat-file --batch-check="%(objectsize:disk)" <tip &&
      +
      +		test_must_fail git multi-pack-index write 2>err &&
     -+		grep "could not load pack" err
     ++		test_grep "could not load pack" err
       	)
       '
       
 3:  c4f75cca09 = 3:  414ae51024 midx-write: use cleanup when incremental midx fails
 4:  2290e27ded ! 4:  b113b3f012 midx-write: use uint32_t for preferred_pack_idx
     @@ Commit message
          For now, replace the use of -1 with a 'NO_PREFERRED_PACK' macro and an
          equality check. The macro stores the max value of a uint32_t, so we
          cannot store a preferred pack that appears last in a list of 2^32 total
     -    packs, but that's expected to be unreasonable already. This improves the
     -    range from 2^31 already.
     +    packs, but that's expected to be unreasonable already. Furthermore, with
     +    this change we end up extending the range from 2^31 possible packs to
     +    2^32-1.
      
          There are some careful things to worry about with initializing the
          preferred pack in the struct and using that value when searching for a
 5:  35302f5228 ! 5:  7c68f2535c midx-write: reenable signed comparison errors
     @@ midx-write.c: static int write_midx_internal(struct repository *r, const char *o
       	 */
       
      +	if (ctx.num_multi_pack_indexes_before == UINT32_MAX)
     -+		die("too many multi-pack-indexes");
     ++		die(_("too many multi-pack-indexes"));
      +
       	CALLOC_ARRAY(keep_hashes, ctx.num_multi_pack_indexes_before + 1);
       
 6:  7be25cf534 = 6:  224be4ee5c midx-write: simplify error cases

-- 
gitgitgadget
