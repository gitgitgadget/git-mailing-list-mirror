Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCC91649D8
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713975307; cv=none; b=q7Gjs/ht4A2IK9Fnm5jltUc5jtdN1AoL1Qe5g4kR7jW+6u2MDRm+UFijdP/r9hRBkFq1xImxaspfNhK21UctiK9/qN5tpJZ+zxcGIjwSMaHNLCccHRbzfx9q7DBrz3wcyCKaAlt1hz+gWFsTLvxc7OEWlJNLc8/OwvYzJ7p1m/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713975307; c=relaxed/simple;
	bh=qAQ5yJRbZA5IscjPswWFHwt55uOClEBcSH7RAanmdZ4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gR6kFYgoZYXBUGgC9wA29YhvyBaXiwTWkmkNt0qYjiVQgBZvOOokxZs1YacuRfgB6MURQYAmYA9JSf1liAPyUaskN/JVqKlCo/jOPlNmPL2upJHRI5QK6to0Jys8U9Ugx2Bmg7RgUAE5MEEYiAcGwVUUV8t66reJAWke7qHFt90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BsHuCFmg; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsHuCFmg"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41b086d6676so95955e9.1
        for <git@vger.kernel.org>; Wed, 24 Apr 2024 09:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713975302; x=1714580102; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18XEQDY7ZP5xgDGMSEof/IOcXza/QWRcAr1+3SxA+Bc=;
        b=BsHuCFmgJyhFiu+9nu/zWt/BCja4S4elUOisQebCDb97ZglNlKf9d3BjyFybtaqFIG
         hFE6tUKyyM6lzo5zqmxn9Dv2lpudSDTnCUXUHO6zReXSL319YPjVJlEs4qBdyCY7EoEa
         BUgbK3fJo5FCjacTmNXnUDE+qnAqt+bKuUAZpjF6hbxEUTGcY1GH5XzUIyoM8QA4RTkJ
         lqQosE7GcDIWe345j9PRpZvtjTjoREEfcYaMGrrEFHJfJLcXrCuIGy+dchgwmT1uwQGu
         40fSwDLRhBysCYVm82CTBNoNls57PmqsQJoyFfwjsap6LeR6uRMFcxxvRgpoyrz2y4nG
         YK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713975302; x=1714580102;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18XEQDY7ZP5xgDGMSEof/IOcXza/QWRcAr1+3SxA+Bc=;
        b=XX9Cby5CmVfK3tX/NEw2R4VxNm6Q4hPTQxC9QkgYaROye48xZlkAwhu6XOvO5vSc2n
         OmPtHd3J6/ZpeZP2yvu/WbDlcljgtzOFvXDFhbZJBL4mtuNEclhV7ysCKk85xzfD7Djr
         AfsUZk8cicC3zc6IWtI4dul9rSJp+i+LLoyIXHV48ZGGAMiyukYeCzy9/2ptX0ZcLGYq
         nDiNZlBILVWv0T4KKSdxkWzh2OOVq2gK5NwoSYsHJD0bwOU9XH1Q8uZDRJlnciHyT9Vm
         bXY+hDm+8wxoIgbxTFNJDx/Rnv+pe1sbGhgwric3088VPSqpPk3y4NMJzuB1LvtQofrl
         QWUw==
X-Gm-Message-State: AOJu0YwrVAY6hRjGBksFlItucJ/r3pQCcb7npruVi1Fw5slTXPMhiw2v
	EMjfWoJjEyB29z1ELghK+fJw1I+KpRLChfcPcNHsqcaC7Q1qnR8b86L6nw==
X-Google-Smtp-Source: AGHT+IEcI47RRWMrdyGtLn+TZuJ4vRRNwukQwJsPFAM70AB6W9h/k+2yiNll5Xg9sFbhz/nkHtRXOw==
X-Received: by 2002:a05:600c:1d06:b0:419:96:965 with SMTP id l6-20020a05600c1d0600b0041900960965mr2304770wms.37.1713975302376;
        Wed, 24 Apr 2024 09:15:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b00416b163e52bsm27893385wmq.14.2024.04.24.09.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 09:15:02 -0700 (PDT)
Message-Id: <39ee6386aab25f28d197a27010b2f80ccd45aab2.1713975300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1719.v3.git.1713975299.gitgitgadget@gmail.com>
References: <pull.1719.v2.git.1713444783.gitgitgadget@gmail.com>
	<pull.1719.v3.git.1713975299.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 24 Apr 2024 16:14:58 +0000
Subject: [PATCH v3 1/2] for-each-repo: optionally keep going on an error
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Patrick Steinhardt <ps@pks.im>,
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In https://github.com/microsoft/git/issues/623, it was reported that
the regularly scheduled maintenance stops if one repo in the middle of
the list was found to be missing.

This is undesirable, and points out a gap in the design of `git
for-each-repo`: We need a mode where that command does not stop on an
error, but continues to try running the specified command with the other
repositories.

Imitating the `--keep-going` option of GNU make, this commit teaches
`for-each-repo` the same trick: to continue with the operation on all
the remaining repositories in case there was a problem with one
repository, still setting the exit code to indicate an error occurred.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-for-each-repo.txt |  9 +++++++++
 builtin/for-each-repo.c             | 13 +++++++++++--
 t/t0068-for-each-repo.sh            | 16 ++++++++++++++++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-for-each-repo.txt b/Documentation/git-for-each-repo.txt
index 94bd19da263..abe3527aaca 100644
--- a/Documentation/git-for-each-repo.txt
+++ b/Documentation/git-for-each-repo.txt
@@ -42,6 +42,15 @@ These config values are loaded from system, global, and local Git config,
 as available. If `git for-each-repo` is run in a directory that is not a
 Git repository, then only the system and global config is used.
 
+--keep-going::
+	Continue with the remaining repositories if the command failed
+	on a repository. The exit code will still indicate that the
+	overall operation was not successful.
++
+Note that the exact exit code of the failing command is not passed
+through as the exit code of the `for-each-repo` command: If the command
+failed in any of the specified repositories, the overall exit code will
+be 1.
 
 SUBPROCESS BEHAVIOR
 -------------------
diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index 28186b30f54..c4fa41fda9f 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -32,6 +32,7 @@ static int run_command_on_repo(const char *path, int argc, const char ** argv)
 int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
 {
 	static const char *config_key = NULL;
+	int keep_going = 0;
 	int i, result = 0;
 	const struct string_list *values;
 	int err;
@@ -39,6 +40,8 @@ int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
 	const struct option options[] = {
 		OPT_STRING(0, "config", &config_key, N_("config"),
 			   N_("config key storing a list of repository paths")),
+		OPT_BOOL(0, "keep-going", &keep_going,
+			 N_("keep going even if command fails in a repository")),
 		OPT_END()
 	};
 
@@ -55,8 +58,14 @@ int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
 	else if (err)
 		return 0;
 
-	for (i = 0; !result && i < values->nr; i++)
-		result = run_command_on_repo(values->items[i].string, argc, argv);
+	for (i = 0; i < values->nr; i++) {
+		int ret = run_command_on_repo(values->items[i].string, argc, argv);
+		if (ret) {
+			if (!keep_going)
+					return ret;
+			result = 1;
+		}
+	}
 
 	return result;
 }
diff --git a/t/t0068-for-each-repo.sh b/t/t0068-for-each-repo.sh
index 4b90b74d5d5..95019e01ed3 100755
--- a/t/t0068-for-each-repo.sh
+++ b/t/t0068-for-each-repo.sh
@@ -59,4 +59,20 @@ test_expect_success 'error on NULL value for config keys' '
 	test_cmp expect actual
 '
 
+test_expect_success '--keep-going' '
+	git config keep.going non-existing &&
+	git config --add keep.going . &&
+
+	test_must_fail git for-each-repo --config=keep.going \
+		-- branch >out 2>err &&
+	test_grep "cannot change to .*non-existing" err &&
+	test_must_be_empty out &&
+
+	test_must_fail git for-each-repo --config=keep.going --keep-going \
+		-- branch >out 2>err &&
+	test_grep "cannot change to .*non-existing" err &&
+	git branch >expect &&
+	test_cmp expect out
+'
+
 test_done
-- 
gitgitgadget

