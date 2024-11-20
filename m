Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2390170A1A
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 10:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732097872; cv=none; b=rb7QzgV00f2wJ8/XB5x0mha2LNhFsYzDEWanBqC52s50K/Pi7PCUGD1IEartK4rFxl01mrpgtsAhY2WI58w74zU8lQXCvlNX71/oCFfoi6xE3xQvHl2AQaVDQDNrN0NBB7KldtzdBfAxFwABN7jYlBk3udJWhsU645i6GtOPnq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732097872; c=relaxed/simple;
	bh=FLYW0m1SsyRe6RY85kKM3juikVil3ZQjOl03wLGdkGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K6Yu89cr0yDObHCTsg6Adprdbxd86T5wQJuPogGlRqayV/lqZRLKwgFb9m7NUdSPmyq4+mbQsFmYlLYYE5hIsauhblxwafAlh92oAhePURLMwd1dA6qUUdGolbvUiiySZnHMGwDVp49KMQG96yr911iVUpCG/j27d0ElyajNh8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCvPEQaV; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCvPEQaV"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53d9ff92b14so2288638e87.1
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 02:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732097869; x=1732702669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wl7kqxO7iClWs9RKfTjXT4Ga2lHTgDSACqpbwkruQPs=;
        b=cCvPEQaV3Mp0hbQZTxPnKCh1tpWRyPyJwv7gupqao2gmIEfCe68j5xOWAezIrES4Ie
         KRlkoRST8iKvILFItVieTBXQCcHZqYSFQo6z57cHruyDaeh2wYB3ey7ELRDUuNNnTPFS
         woPjGZvMfn7ovJ5nH44OeARYD/lEmNwaIRFGiXN7kq7/c9lCk1ZPNDguT2kKpj7TceQQ
         vPSxMVax0xQ5c4p4JCZnvSr3QqnZKvwvUphYH03cdwRo9XKZc4bsC1pd60MyerPZ+un6
         r3nG+1z/VheqX4lVCu+P0QwG6PWG4zfGzRAN0Uycrse5l6OySs99SjSdIspbhHBoynTy
         grFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732097869; x=1732702669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wl7kqxO7iClWs9RKfTjXT4Ga2lHTgDSACqpbwkruQPs=;
        b=GRRcj+x+m1n1yuzoKCgVaC804eiqEs2itugxkUJAULhkbZ5wLhT2CHsnhyPBCh3hFV
         xYuJNPGtPtvktAvbRnJZcA3eivuaS/1MFC42ppEVbHEDjkteVODuA9oO+0Ittl20kDch
         NwqrMslQNhNYXVbFSs7MP5zsXtxKdWEzWUcy3AeNfdCpClT75BDWrbx3JK6wQ9OP4n0Q
         ROn6keqQeiC9X4vEONgF877IcVJO7qNRdL1gddDk1+Wrjkv0bwMHRFl0xtl4gZIE+pDk
         fnfMLj+Z6rluANKuEll8NQOTKMPQi81RhOiqzZMc978EyEqRzvkfBsdgRGm46kWEWtnE
         7Feg==
X-Gm-Message-State: AOJu0YzPPg7RLE8/8NT/A0sE9119up++koOTzEk5bEMYNNOpGIsWlau+
	3MJ1+iBXnRTFVLFtUNmTEvvA2In6TO2Gnehd6j+MVpD5pTr960m6AlLATyeWizY=
X-Google-Smtp-Source: AGHT+IEptnLXqs39wec/9W8aGp/em/2NSIj26frlQB5RBJb0o5eWzl6OWI35m4l/Dx/sEuqIPDgMqg==
X-Received: by 2002:a05:651c:4118:b0:2ff:8e69:78f0 with SMTP id 38308e7fff4ca-2ff8e697b90mr6933431fa.2.1732097868534;
        Wed, 20 Nov 2024 02:17:48 -0800 (PST)
Received: from localhost.localdomain ([88.215.146.26])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff69967c10sm14304701fa.53.2024.11.20.02.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 02:17:48 -0800 (PST)
From: Matthew Bystrin <dev.mbstr@gmail.com>
To: git@vger.kernel.org
Cc: Lessley Dennington <lessleydennington@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	idriss fekir <mcsm224@gmail.com>,
	Joey Salazar <jgsal@protonmail.com>
Subject: [PATCH] git: fix paginate handling for commands with DELAY_PAGER_CONFIG
Date: Wed, 20 Nov 2024 13:17:40 +0300
Message-ID: <20241120101741.8225-1-dev.mbstr@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling commands using editor in terminal with `--paginate` option will
break things. For example `git --paginate config --edit`. Add extra
check to ignore paginate flag in case command have DELAY_PAGER_CONFIG
set.

Relates: cd878a206e8c (t7006: add tests for how git config paginates)
Signed-off-by: Matthew Bystrin <dev.mbstr@gmail.com>
---
Hi!

Some time ago I've sent RFC patch [1], which was not quite ready, and I didn't
receive any feedback. Now I'm sending a more complete version of it. Fixing
mentioned behaviour of `note` command can be done in separate patch series.

Link: https://lore.kernel.org/git/20241104140536.4970-1-dev.mbstr@gmail.com/

 git.c            | 5 +++--
 t/t7006-pager.sh | 4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/git.c b/git.c
index c2c1b8e22c..2b3b049f4a 100644
--- a/git.c
+++ b/git.c
@@ -464,11 +464,12 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct
 	}
 	assert(!prefix || *prefix);
 	precompose_argv_prefix(argc, argv, NULL);
-	if (use_pager == -1 && run_setup &&
-		!(p->option & DELAY_PAGER_CONFIG))
+	if (use_pager == -1 && run_setup && !(p->option & DELAY_PAGER_CONFIG))
 		use_pager = check_pager_config(p->cmd);
 	if (use_pager == -1 && p->option & USE_PAGER)
 		use_pager = 1;
+	if (use_pager == 1 && (p->option & DELAY_PAGER_CONFIG))
+		use_pager = 0;
 	if (run_setup && startup_info->have_repository)
 		/* get_git_dir() may set up repo, avoid that */
 		trace_repo_setup();
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index a0296d6ca4..218c5093d3 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -188,11 +188,11 @@ test_expect_success TTY 'git tag -a ignores pager.tag' '
 	test_path_is_missing paginated.out
 '
 
-test_expect_success TTY 'git tag -a respects --paginate' '
+test_expect_success TTY 'git tag -a do not respects --paginate' '
 	test_when_finished "git tag -d newtag" &&
 	rm -f paginated.out &&
 	test_terminal git --paginate tag -am message newtag &&
-	test_path_is_file paginated.out
+	test_path_is_missing paginated.out
 '
 
 test_expect_success TTY 'git tag as alias ignores pager.tag with -a' '
-- 
2.43.0

