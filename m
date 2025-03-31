Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6824F214227
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 15:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743436294; cv=none; b=htA+UTWJIT72A1zsuyfCRl2d2m14M+PSmP/PCX3PPR94tSEuU44YSqGxr9ahH1lFDfzNhk2NPJmj6jyc27stHxyWkLsmpQLSoYNNEiVAxOmwb4wi9LKIW3+YwWXMTVDzLBXr58TmPvRJghLNEdINh/dJkBaCstzyTl+m5TEpTX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743436294; c=relaxed/simple;
	bh=2e7Fmrgi9w888kvnkw1mQ7NK+Dqk5n1X0aBoJiIAnns=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WBfEKYfHPDE2L5hdYSGcQlUJzgv7lpOmb1FlHYr5gEhdHsM0JywBWKC7NV2A0kAfvaAyyZGn8pt/fxPj7fUqhNHv5hztmJHV4tIL8uF+UQsqo+VG3vm/uXYqez0IwUgBUUoStOBf5v3mJgAJ7+Kz4c3fw9zchuyUSWBoCHwwRjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHJVvkF6; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHJVvkF6"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso43486485e9.2
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 08:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743436290; x=1744041090; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzmSmZ57MV4r6wpQeyXj8ka6HvD+XlngCNgdKlo5+s0=;
        b=EHJVvkF6NEkFqL5GAm52cjpyXWgzU+122aRuGTmcN8RAJI4jT5lXGciUhk86yhxOvU
         T8W6kSpsZcF2xrHCyQRyOei26yDLcArn2BtW7Npcl4tQzMsPBhPrGXrzjKdIMjR1QCMb
         p04f69t8UoBGphmvmWDECvvJ6dDhpKNNeMt3FKx1foE2JacUOP0h/rspmF+vPoBMydGX
         v0pGx092f8Rr/KgbMi6H8vsm7b6UXoC53AbKggorvlz2+KY5tAklJGUegLJ2ocMIbCWA
         s09EgLPMEwQ95+7m/ov45fkLrv8To8BPaMHCc7ja0BQKA7EvsZTYzMznXDCC/uLojlno
         lhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743436290; x=1744041090;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NzmSmZ57MV4r6wpQeyXj8ka6HvD+XlngCNgdKlo5+s0=;
        b=NAdFFKrH/pfni/XOU3PKA2NUpD+i6d/a062SS/Hb4Z2/ox2GkUzSBZIM/5zFQUfEj2
         frcnxDzhul3YH1bvnZPT4kmEYbrFqMRBasB6rIoG0yA9TCV3xMQkJThVH6mqNBErDEEc
         4wRoDQl5SwmvqidKmwBzASgYs5GL/i9KhhvPWKFGUqcmn8pl6PPPT/ZLkz+fmZu/1Qh7
         I1jpfd3TpXY2Dd34sgnOqsU6ruzh8xJatY25iXD5YnF1Sk0ki7qckTuIjBWjvFh+25bn
         HEj2hm8Lj/xP6wHumwvJ3hwlzU/sQwGtDvvZsMjdOpmd9LFSOhVmmCFm/qirZuMT4R3M
         xxpw==
X-Gm-Message-State: AOJu0Yx5L4W4Sx97Wd88Pbf+YWOEkj1ytSd+XUjmpsm9zscEEu/YEJ6M
	k+qNl+I/kzUqPPmJKir/2gwZgP8fc7l8NPWOyzw828RvScVaG/3/A+rGzw==
X-Gm-Gg: ASbGnct2y+yH3haC6/NAWM3O0+ZejUW+Hj5+YGIK9jGxBqCPxC3T9SKthy5Wqcj4C2q
	aXYnF00dNmR+I5uhgg8AVTwLzsZmGfoH9c41PC8lrxb3FriO6NN8pzGOo7nl8vwQsmlMH0kVfjN
	6y02W2/dTtIaCheMbrl6RjU229Q88dKz7Wyg7+BuzO77eVkdNcNJwaTozv1D6bGSiIEm2oCMWjB
	1wfEJ4P78jewPi4QzKt+s3WRtUbkJSkQ2UFgMPstWSOcszLZmodtKyAC30MC8l1CehgVETTvg90
	XPtKpZOvP7NNeTZStWJJo/qoN/InU+NXl3a911S+V4AK4A==
X-Google-Smtp-Source: AGHT+IGElaQm2TymrfZydSIN1uBZNuxHnh544kqG7qeN19mt/+iNslk8FB58eOiGBqIkmx2KTPY47w==
X-Received: by 2002:a05:600c:83c4:b0:43c:ec28:d31b with SMTP id 5b1f17b1804b1-43db62283d1mr119877565e9.10.1743436289927;
        Mon, 31 Mar 2025 08:51:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d830f59d0sm167980445e9.28.2025.03.31.08.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 08:51:29 -0700 (PDT)
Message-Id: <3abcfe6faf0759592d04d191c7cd4cdf93127965.1743436280.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1898.git.1743436279.gitgitgadget@gmail.com>
References: <pull.1898.git.1743436279.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 31 Mar 2025 15:51:19 +0000
Subject: [PATCH 8/8] builtin/{merge,rebase,revert}: remove
 GIT_TEST_MERGE_ALGORITHM
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

This environment variable existed to allow the testsuite to reuse all
the merge-related tests in the testsuite while easily flipping between
the 'recursive' and the 'ort' backends.  Now that we have removed
merge-recursive and remapped 'recursive' to mean 'ort', we don't need
this scaffolding anymore.  Remove it from these three builtins.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c  | 14 +-------------
 builtin/rebase.c |  5 -----
 builtin/revert.c |  2 --
 3 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index c0bbdab7104..9efd585842f 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -170,7 +170,7 @@ static struct strategy *get_strategy(const char *name)
 	struct strategy *ret;
 	static struct cmdnames main_cmds = {0}, other_cmds = {0};
 	static int loaded;
-	char *default_strategy = getenv("GIT_TEST_MERGE_ALGORITHM");
+	char *default_strategy = NULL;
 
 	if (!name)
 		return NULL;
@@ -1311,12 +1311,6 @@ int cmd_merge(int argc,
 	if (branch)
 		skip_prefix(branch, "refs/heads/", &branch);
 
-	if (!pull_twohead) {
-		char *default_strategy = getenv("GIT_TEST_MERGE_ALGORITHM");
-		if (default_strategy && !strcmp(default_strategy, "ort"))
-			pull_twohead = xstrdup("ort");
-	}
-
 	init_diff_ui_defaults();
 	git_config(git_merge_config, NULL);
 
@@ -1517,12 +1511,6 @@ int cmd_merge(int argc,
 			fast_forward = FF_NO;
 	}
 
-	if (!use_strategies && !pull_twohead &&
-	    remoteheads && !remoteheads->next) {
-		char *default_strategy = getenv("GIT_TEST_MERGE_ALGORITHM");
-		if (default_strategy)
-			append_strategy(get_strategy(default_strategy));
-	}
 	if (!use_strategies) {
 		if (!remoteheads)
 			; /* already up-to-date */
diff --git a/builtin/rebase.c b/builtin/rebase.c
index d4715ed35d7..e83193ac73e 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1575,11 +1575,6 @@ int cmd_rebase(int argc,
 			    options.default_backend);
 	}
 
-	if (options.type == REBASE_MERGE &&
-	    !options.strategy &&
-	    getenv("GIT_TEST_MERGE_ALGORITHM"))
-		options.strategy = xstrdup(getenv("GIT_TEST_MERGE_ALGORITHM"));
-
 	switch (options.type) {
 	case REBASE_MERGE:
 		options.state_dir = merge_dir();
diff --git a/builtin/revert.c b/builtin/revert.c
index aca6c293cdf..2654f769a88 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -252,8 +252,6 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 		free(opts->strategy);
 		opts->strategy = xstrdup_or_null(strategy);
 	}
-	if (!opts->strategy && getenv("GIT_TEST_MERGE_ALGORITHM"))
-		opts->strategy = xstrdup(getenv("GIT_TEST_MERGE_ALGORITHM"));
 	free(options);
 
 	if (cmd == 'q') {
-- 
gitgitgadget
