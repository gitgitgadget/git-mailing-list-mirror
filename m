Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EDB17582
	for <git@vger.kernel.org>; Sat, 18 May 2024 10:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716028374; cv=none; b=ZpNGrWYiZNcno3GwEP/wc2hzc//gZeqLHTvGdYvvyeLn5JRQkdVFyQYUsyKUqH0kocNwzmyGNjFTFCbYJS2ICCyiGAawHt5L/IM5Spv222YwBZmK8NO2YBw1nJUnpZWjcxYwTRAOvzEmjsxsigeP5QXO6d+71mffSXVvDxV8S8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716028374; c=relaxed/simple;
	bh=krL/leV3Ovj02P3yP96CT1EddKaYG8XjxJTxhV7OKDg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CfirYabOg3jWJx+L3lDj8oms+enIaooTOIcCGrNymqQgqVaZ7XfgHLa8DHJAlVTrsXGU01kF9I8mucs4+NyvJ7i+SY+dzpUe/ZG6S6vFobAL3RIHaIbgWxSYvmMPhd0enStKSVA13sYlTjKt7BAh80GQ6iNx/vBTsKsd2ReYaf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbvjPAZA; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbvjPAZA"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4202ca70270so11596595e9.3
        for <git@vger.kernel.org>; Sat, 18 May 2024 03:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716028370; x=1716633170; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuRrxw830UYQtha8Je88sNiet+O/9A2IyWr6XYPPhuA=;
        b=MbvjPAZAKdIoCqm4j82OwWy5fm85Flmly331DRRFuQonC+NIaAZaR5Pub5u/ZzBf6U
         3Ql+SF8Glhofk45fa+N/vuunww571Q4ixIBuCSnkpNxnbQOS9kLSODy6s4VsGIP64Y6k
         toSK987LX2Ahx8xTZNgSlPXYjmBj5Z8lz5i/BtB3B6I/aQLNllp80VTiNa1jEILQ6FYU
         lyAv/rKdzSFu5s0PqicFIB4c9IdxrQbgeajiDbGjIoNdiX3WMkIe8lMCIiUxxr2sxbU4
         HjM1sI79uA9VWufDvOTA0cyhHaJzF9HV3ye/4Rwq/qjDK8Ae8sIoVfeh3VUMrsAzUs2B
         l9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716028370; x=1716633170;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DuRrxw830UYQtha8Je88sNiet+O/9A2IyWr6XYPPhuA=;
        b=hI16CGfuj15v2hoIaIWMvfp0VmqXimVZLFyLj+uFMXklwtdUvTsv0z46Gk6G1KDuD3
         MD6UI+EugcMivVal1j3IyOXPXnVdtfCAKnftEjtEMZM9es0+juQQ3O/OXMh+/fy1duRB
         KH6aB3zp2oWZMxLNEMiQrY5npe/Mxmr5avcDjB3HN534Yc75PML4tevAHslCocITTye7
         b4sEukzZFY4nMGPg8Wrz+stE/ZFiAtWZvJgwETSRrX5boELHqnaXQAEs5T06raLFLE1/
         ZgZ1UGnngpsF5mcMCxgqn7qeaYy0VqIY929V+OjAMzOwMZpcgILgdeVVM0TreiReR1dO
         ccdA==
X-Gm-Message-State: AOJu0Yzc5cID1xCIUssq2sGvkbUFJi2GgVM1Cf7R8pP3rVWfcP+VaIU3
	8YBRjq5nvgJl5zQtClf21OFT1+4URaIFjdZ/kHJ/eDtdaqt9M8lGa5Cybg==
X-Google-Smtp-Source: AGHT+IFuWiG+fv117tlZjGm/MY4A72D3M3B75/OfEbtWjzO5hv0VgCjwvC9pRJAr4jpS/jTTORM9MQ==
X-Received: by 2002:a05:600c:4f04:b0:420:1508:f0ae with SMTP id 5b1f17b1804b1-4201508f2edmr178066725e9.10.1716028369627;
        Sat, 18 May 2024 03:32:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-420149b1c24sm229771495e9.41.2024.05.18.03.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 03:32:48 -0700 (PDT)
Message-Id: <pull.1732.v2.git.1716028366.gitgitgadget@gmail.com>
In-Reply-To: <pull.1732.git.1715987756.gitgitgadget@gmail.com>
References: <pull.1732.git.1715987756.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 18 May 2024 10:32:38 +0000
Subject: [PATCH v2 0/8] Various fixes for v2.45.1 and friends
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

There have been a couple of issues that were reported about v2.45.1, and in
addition I have noticed some myself:

 * a memory leak in the clone protection logic
 * a missed adjustment in the Makefile that leads to an incorrect templates
   path in v2.39.4, v2.40.2 and v2.41.1 (but not in v2.42.2, ..., v2.45.1)
 * an overzealous core.hooksPath check
 * that Git LFS clone problem where it exits with an error (even if the
   clone often succeeded...)

This patch series is based on maint-2.39 to allow for (relatively) easy
follow-up versions v2.39.5, ..., v2.45.2.

Changes since v1:

 * simplified adding the SHA-256s corresponding to Git LFS' hooks
 * the core.hooksPath test case now verifies that the config setting was
   configured correctly

Johannes Schindelin (8):
  hook: plug a new memory leak
  init: use the correct path of the templates directory again
  Revert "core.hooksPath: add some protection while cloning"
  tests: verify that `clone -c core.hooksPath=/dev/null` works again
  hook(clone protections): add escape hatch
  hooks(clone protections): special-case current Git LFS hooks
  hooks(clone protections): simplify templates hooks validation
  Revert "Add a helper function to compare file contents"

 Documentation/config/safe.txt |   6 ++
 Makefile                      |   2 +-
 builtin/init-db.c             |   7 +++
 cache.h                       |  14 -----
 config.c                      |  13 +----
 copy.c                        |  58 --------------------
 hook.c                        | 100 +++++++++++++++++++++++++++-------
 hook.h                        |  10 ++++
 setup.c                       |   1 +
 t/helper/test-path-utils.c    |  10 ----
 t/t0060-path-utils.sh         |  41 --------------
 t/t1350-config-hooks-path.sh  |   7 +++
 t/t1800-hook.sh               |  40 ++++++++++----
 t/t5601-clone.sh              |  19 +++++++
 14 files changed, 161 insertions(+), 167 deletions(-)


base-commit: 47b6d90e91835082010da926f6a844d4441c57a6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1732%2Fdscho%2Fvarious-fixes-for-v2.45.1-and-friends-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1732/dscho/various-fixes-for-v2.45.1-and-friends-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1732

Range-diff vs v1:

 1:  d4a003bf2ce = 1:  d4a003bf2ce hook: plug a new memory leak
 2:  961dfc35f42 = 2:  961dfc35f42 init: use the correct path of the templates directory again
 3:  57db89a1497 = 3:  57db89a1497 Revert "core.hooksPath: add some protection while cloning"
 4:  7d5ef6db2a9 ! 4:  cd14042b065 tests: verify that `clone -c core.hooksPath=/dev/null` works again
     @@ t/t1350-config-hooks-path.sh: test_expect_success 'git rev-parse --git-path hook
       '
       
      +test_expect_success 'core.hooksPath=/dev/null' '
     -+	git clone -c core.hooksPath=/dev/null . no-templates
     ++	git clone -c core.hooksPath=/dev/null . no-templates &&
     ++	value="$(git -C no-templates config --local core.hooksPath)" &&
     ++	# The Bash used by Git for Windows rewrites `/dev/null` to `nul`
     ++	{ test /dev/null = "$value" || test nul = "$value"; }
      +'
      +
       test_done
 5:  a4f5eeef667 = 5:  b841db8392e hook(clone protections): add escape hatch
 6:  98465797e72 ! 6:  5e5128bc232 hooks(clone protections): special-case current Git LFS hooks
     @@ Commit message
      
       ## hook.c ##
      @@ hook.c: static int is_hook_safe_during_clone(const char *name, const char *path, char *s
     - 	if (get_sha256_of_file_contents(path, sha256) < 0)
     - 		return 0;
       
     -+	/* Hard-code known-safe values for Git LFS v3.4.0..v3.5.1 */
     -+	if ((!strcmp("pre-push", name) &&
     -+	     !strcmp(sha256, "df5417b2daa3aa144c19681d1e997df7ebfe144fb7e3e05138bd80ae998008e4")) ||
     -+	    (!strcmp("post-checkout", name) &&
     -+	     !strcmp(sha256, "791471b4ff472aab844a4fceaa48bbb0a12193616f971e8e940625498b4938a6")) ||
     -+	    (!strcmp("post-commit", name) &&
     -+	     !strcmp(sha256, "21e961572bb3f43a5f2fbafc1cc764d86046cc2e5f0bbecebfe9684a0b73b664")) ||
     -+	    (!strcmp("post-merge", name) &&
     -+	     !strcmp(sha256, "75da0da66a803b4b030ad50801ba57062c6196105eb1d2251590d100edb9390b")))
     -+		return 1;
     -+
       	if (!safe_hook_sha256s_initialized) {
       		safe_hook_sha256s_initialized = 1;
     ++
     ++		/* Hard-code known-safe values for Git LFS v3.4.0..v3.5.1 */
     ++		/* pre-push */
     ++		strset_add(&safe_hook_sha256s, "df5417b2daa3aa144c19681d1e997df7ebfe144fb7e3e05138bd80ae998008e4");
     ++		/* post-checkout */
     ++		strset_add(&safe_hook_sha256s, "791471b4ff472aab844a4fceaa48bbb0a12193616f971e8e940625498b4938a6");
     ++		/* post-commit */
     ++		strset_add(&safe_hook_sha256s, "21e961572bb3f43a5f2fbafc1cc764d86046cc2e5f0bbecebfe9684a0b73b664");
     ++		/* post-merge */
     ++		strset_add(&safe_hook_sha256s, "75da0da66a803b4b030ad50801ba57062c6196105eb1d2251590d100edb9390b");
     ++
       		git_protected_config(safe_hook_cb, &safe_hook_sha256s);
     + 	}
     + 
      
       ## t/t1800-hook.sh ##
      @@ t/t1800-hook.sh: test_expect_success '`safe.hook.sha256` and clone protections' '
 7:  c487bd06be8 = 7:  bd6d72625f5 hooks(clone protections): simplify templates hooks validation
 8:  c45c33d8e3f = 8:  4b0a636d41a Revert "Add a helper function to compare file contents"

-- 
gitgitgadget
