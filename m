Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CAA364CB
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 07:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707551385; cv=none; b=lEIpraRjOaBSqPOjfxGF0nry+a7wacHNpVYl12AFPOfQ5ZnukrR2W4z03eUYxINhEq1kzqoQ1Q4JqPKfTyszOVQ16bdD1yg8sO7eZAYKLZSd8l1rgfhNXRRIFeTpHKodGaahpSGxOzAF97EqaL3c4FOJ4+3nGFdp3kU5698OS5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707551385; c=relaxed/simple;
	bh=OcWoIrdfqnbAP4Dyx+2dfcsMl1BB3hJUGi/pdIDlBpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HA9RKASCdTSRVMXl7ZRHqviZMqOlVLpQ2sNBm+Q/f5udjzTZ4U30fzLtM3gftTxmH+6BgfIy87cMBvLTKPH538tfdr6pq4/F5U91OgQ6mnOHdMr96gvIfKzQbmzpCES0lC4SZZWfvL1gtaxnAZ1qIVF7OF8r4iNmFtuLtg80Jf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=liO/+EBv; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liO/+EBv"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-210c535a19bso921195fac.1
        for <git@vger.kernel.org>; Fri, 09 Feb 2024 23:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707551382; x=1708156182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOVccWn4ksV3bOdOHAHRKM/finSVRBjPOZ5rCQ9mkP8=;
        b=liO/+EBvi7pmpCm7kTSIklg+cdA/OJE4wu7Ef9Ki98ILX0SFzb+N4s+JVMOl7aUGSa
         JpNWvoQiuFmCrGOww94sm9+ZFfY9j/Ht4OxEcpN7Lxg9XY6Lc0xSbk9erTfWvDeuv7OI
         PoVBxdv2nBgy6p6k9C2VX6/l2sDUruDHzs1vitbp60H3G8M4K7NrhVe0mia5ADFft0YC
         WLCgWKMO9jzuBKc/rXWVV6gcjdQgTZMdsxTtwKNVS82jrJX3YtDp+8EvjckJ4XOsts0X
         VpKXT1voCqe2C5qWjKy7yEibtPKxfYNj2uioCh59qougnm1WHdRTE7ZZLxH8eAg6CslF
         WXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707551382; x=1708156182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOVccWn4ksV3bOdOHAHRKM/finSVRBjPOZ5rCQ9mkP8=;
        b=pM1eklY/3oBfObeoJkVLWNgX74Op0yjxJk1c1hGLYceJmMO5qJLTwUAA3j+kyZuqJU
         ZA89TLYaHkGcIqG9cnLkcGEuPYmverun7IvKO+PuYmyJYAYDxwAfTutDBvCDF8X7LneB
         zg9OacakHOYN/sI9n5kDONiT90fUAvg9jmrumroPGKFe8SslVqhB8NDM6vIJRv11+DDy
         CjCoSNK3Xp+zGD2Kssq4mOR0oc88mWyv+O0BDmDXMrsOIK4kSAyaGzSW15n/j5n2CGgd
         OKxiBbBywL6dV2JcrakuIL/EqS8ZzUmv/tv0Q0g/DjLhQXQFanQmYg/RDAMoPVLtgaYl
         mrRg==
X-Gm-Message-State: AOJu0YycZhboP0X7CWM6nV+4WUzKmyvbdgmSXvUpPXms0UzpyZQV9LgA
	oBTV6aZQ+p2yIuEeYfjW+ywLGUg/C/GpUtwNJgu3MC6lP03RxP+MiR9m4Cc9/oA=
X-Google-Smtp-Source: AGHT+IFjP2FDKyQe4duRXzksz9shZyznMyQ4vzZXohzfYHVy9kF06YZBzhgI0sVFCrXSSY+WfltYDA==
X-Received: by 2002:a05:6870:71d2:b0:219:6c31:7b4d with SMTP id p18-20020a05687071d200b002196c317b4dmr1622002oag.40.1707551381891;
        Fri, 09 Feb 2024 23:49:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUi2xoCwXRNGr5W9Q0NLWgXG2HUBQZg/rC0W7COaftFBDJvqMvvKq04/iB6s3AaNqzJidw1Rmq7N0Ix8ZUCPK1VfAxv36bdQo9R2VYMemi/sOPtz8f2THZeIDFy1PN/Y35gg/BDF/RW9PytnqWy27VjzBu32puoqLW0tGCr6Gry
Received: from localhost.localdomain (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id v19-20020a056870955300b00219fd9e3194sm310028oal.7.2024.02.09.23.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 23:49:41 -0800 (PST)
From: Brian Lyles <brianmlyles@gmail.com>
To: git@vger.kernel.org
Cc: Brian Lyles <brianmlyles@gmail.com>,
	newren@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	gitster@pobox.com
Subject: [PATCH v2 7/8] cherry-pick: enforce `--keep-redundant-commits` incompatibility
Date: Sat, 10 Feb 2024 01:43:55 -0600
Message-ID: <20240210074859.552497-8-brianmlyles@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240119060721.3734775-2-brianmlyles@gmail.com>
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When `--keep-redundant-commits` was added in  b27cfb0d8d
(git-cherry-pick: Add keep-redundant-commits option, 2012-04-20), it was
not marked as incompatible with the various operations needed to
continue or exit a cherry-pick (`--continue`, `--skip`, `--abort`, and
`--quit`).

Enforce this incompatibility via `verify_opt_compatible` like we do for
the other various options.

Signed-off-by: Brian Lyles <brianmlyles@gmail.com>
---

This commit was not present in v1 either. It addresses an existing issue
that I noticed after Phillip pointed out the same deficiency for my new
`--empty` option introduced in the ultimate commit in this series.

[1]: https://lore.kernel.org/git/CAHPHrSf+joHe6ikErHLgWrk-_qjSROS-dXCHagxWGDAF=2deDg@mail.gmail.com/

 builtin/revert.c                            |  1 +
 t/t3515-cherry-pick-incompatible-options.sh | 34 +++++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100755 t/t3515-cherry-pick-incompatible-options.sh

diff --git a/builtin/revert.c b/builtin/revert.c
index d83977e36e..48c426f277 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -163,6 +163,7 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 				"--ff", opts->allow_ff,
 				"--rerere-autoupdate", opts->allow_rerere_auto == RERERE_AUTOUPDATE,
 				"--no-rerere-autoupdate", opts->allow_rerere_auto == RERERE_NOAUTOUPDATE,
+				"--keep-redundant-commits", opts->keep_redundant_commits,
 				NULL);
 	}
 
diff --git a/t/t3515-cherry-pick-incompatible-options.sh b/t/t3515-cherry-pick-incompatible-options.sh
new file mode 100755
index 0000000000..6100ab64fd
--- /dev/null
+++ b/t/t3515-cherry-pick-incompatible-options.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+
+test_description='test if cherry-pick detects and aborts on incompatible options'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	echo first > file1 &&
+	git add file1 &&
+	test_tick &&
+	git commit -m "first" &&
+
+	echo second > file1 &&
+	git add file1 &&
+	test_tick &&
+	git commit -m "second"
+'
+
+test_expect_success '--keep-redundant-commits is incompatible with operations' '
+	test_must_fail git cherry-pick HEAD 2>output &&
+	test_grep "The previous cherry-pick is now empty" output &&
+	test_must_fail git cherry-pick --keep-redundant-commits --continue 2>output &&
+	test_grep "fatal: cherry-pick: --keep-redundant-commits cannot be used with --continue" output &&
+	test_must_fail git cherry-pick --keep-redundant-commits --skip 2>output &&
+	test_grep "fatal: cherry-pick: --keep-redundant-commits cannot be used with --skip" output &&
+	test_must_fail git cherry-pick --keep-redundant-commits --abort 2>output &&
+	test_grep "fatal: cherry-pick: --keep-redundant-commits cannot be used with --abort" output &&
+	test_must_fail git cherry-pick --keep-redundant-commits --quit 2>output &&
+	test_grep "fatal: cherry-pick: --keep-redundant-commits cannot be used with --quit" output &&
+	git cherry-pick --abort
+'
+
+test_done
-- 
2.43.0

