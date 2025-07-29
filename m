Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381D52236F2
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 16:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753806029; cv=none; b=J/pAJtzO2h0EjaCXR6zsJ6ZEPYP9esEtTUlux4UYelekwQYhMGJ2bk3pvc9ytYWdNaQkklIdhO67Yvm+uSStuDie4gsSOaqC9DPnCQph6hEX47sgeKrCQgkChpijSfFuvvlfycEOkYfcg+TLfXCXodJ7C+SXGxYgIAe4tN6Fjd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753806029; c=relaxed/simple;
	bh=EgY2a0PuPYTt6buF8YltDIkBzdQKSqJBdEdiEV+KuDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fP/rYb6LWrgWDoJxPyWjKOox190IvcGox/7x4vVl3XkoesiMISPl73IJJ6gRsZJUa+Uu1rmdI/2Z+Mk2d1qGZrKqbLOHq7lZto85LX4HrA4kyQ/E3B3iSGRO6qzoxDpjHNKcTtekwtCMWz/qDtd+809kSUCekdhhWGM4HIoDAGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLgrgDva; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLgrgDva"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-31ed9a17f1fso2188919a91.1
        for <git@vger.kernel.org>; Tue, 29 Jul 2025 09:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753806027; x=1754410827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6U45aA5Ccc3R+iApCQWJzkDgk7MUhEejGL+x46224w=;
        b=nLgrgDvakjGG7Fg8ZYpH07AxHiaVlwuTSAqC16J68Jy07FHXWAqZ2b3UwPOIc0Q+tU
         Pz3Uec9sNWwQOwvn1x1j7MIaB+LaNOURW+wUePC6kxsz7wCsxyHUm6Ek7TYN25xqBMxh
         nmLryKHzAr+Mo30XC8yt/47T1iHpqK3Aum/6zLUKw2SFS3GvSdRbHIZnhTMA5TDXpR3Z
         BBsWL+gt2BeO6kZYI1O9qHuYXbbM+mDVCxXzgYchICXssbi2dNGQjwgutRYPgCFbHw9g
         W9aZNhVs32GxwBVbrLI62V3kFhFTGZcIUOrkmhGm2+YvhhByIhdz66mkiPc1C9Nvz5Kv
         3zbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753806027; x=1754410827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6U45aA5Ccc3R+iApCQWJzkDgk7MUhEejGL+x46224w=;
        b=auR8IYlVz/CXQDHTdW/QsABnNj1vrYRiIstXimloSK+hOAe6Q9SxpGw1lh9XtL5Lkk
         pymNfqxDX+mjCTQ0WakAR6Qih+rHMoBEOkaZK+T4Muj6NwaO+RszBtv8dtDUXPGsUJpV
         9iNHBbmoSpoSafPCw+uCQu5ckKXvDxwkfiA0wDDlxHewO/hlwTQOfg4hj/PHAWxcUOH3
         gl3pg4h6aaivVS7nsfafVuEpW3sR3jhmVDqyQCJ3++lxks7c/bq/30fzkGjYfoScHSz1
         oO6VMBSRJDSCndqBEKvq9v/nFDRQoeEU1O9WScpUreGP0HwF22NuxiclmoSjw1JwcV11
         BB0g==
X-Gm-Message-State: AOJu0YwApBTYviN+XN3mGNiyYGSgly5I52Y0lj7AL71b4f+6w75hcNmq
	F6l5cPFpQsrVJEnSH+BUFDW8NEE/+xOM4nXnehpaWzD+rRO/JUrBgJH5NbEWYjL1
X-Gm-Gg: ASbGncsewyg3bmKc43MLjgboCPN5XR5zPQlWDgJisvWEvUAesL7UIkfruZvZwFhznJR
	2twUQ5FOe/bgKFjORtjApkSYjToKjkgr6XdVKGrkqAehHAojhovG0EO6jhb+8SPpEYgy+QPLoj1
	08njeD5C0sHarph0nhBnnL7lzXCuy1UQk/TNfJHRcIh9e3A9X3LTz2E86SnABCEhWBUric/1hmR
	55iwH8UyIpKbXytI+cINksAi50G+47NFNcXcUueqlr1AnKWP3M2jCb9U0wNSVvEdZdXKCf/RaHg
	awlRBNxsAIqAPgz+lXqXtLKfqzFXjFpWv0jvNzE0L7XZxQm3c/RYP14rtkYiP86fhCS1MWobzdp
	Oi6QzI86AaAkkQReAE3m4Xbtn9jYSnG34rBnyb0BRZram
X-Google-Smtp-Source: AGHT+IH7rkV9LzQhtWrKxmVF5A/kHMJ6gKQzTkHXXpcmwV5GV6uJJR3ziTYtJSYq0Dx91ID3S0newg==
X-Received: by 2002:a17:90b:2ecf:b0:312:26d9:d5a7 with SMTP id 98e67ed59e1d1-31f5de2d561mr101733a91.20.1753806027208;
        Tue, 29 Jul 2025 09:20:27 -0700 (PDT)
Received: from thinku.tailbd49c4.ts.net ([103.37.201.225])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f2efd8b36sm1400032a91.1.2025.07.29.09.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 09:20:26 -0700 (PDT)
From: Ayush Chandekar <ayu.chandekar@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	shyamthakkar001@gmail.com,
	Ayush Chandekar <ayu.chandekar@gmail.com>
Subject: [GSOC PATCH 2/2] builtin/fmt-merge-msg: stop depending on 'the_repository'
Date: Tue, 29 Jul 2025 21:49:35 +0530
Message-ID: <04d6f682a6b2257e14682e809a2fd01ccfcf0d08.1753804956.git.ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1753804956.git.ayu.chandekar@gmail.com>
References: <cover.1753804956.git.ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor builtin/fmt-merge-msg.c to remove the dependancy on the global
'the_repository'. Replace all the occurrences of 'the_repository' with
'repo', where 'repo' is a pointer to 'struct repository' passed to the
function 'cmd_fmt_merge_msg()' and thus remove the definition '#define
USE_THE_REPOSITORY_VARIABLE'. Also, add a test to make sure that "git
fmt-merge-msg -h" can be called outside a repository.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
---
 builtin/fmt-merge-msg.c | 7 +++----
 t/t1517-outside-repo.sh | 7 +++++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index fed8163825..848498b8e6 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "config.h"
 #include "fmt-merge-msg.h"
@@ -13,7 +12,7 @@ static const char * const fmt_merge_msg_usage[] = {
 int cmd_fmt_merge_msg(int argc,
 		      const char **argv,
 		      const char *prefix,
-		      struct repository *repo UNUSED)
+		      struct repository *repo)
 {
 	char *inpath = NULL;
 	const char *message = NULL;
@@ -53,13 +52,13 @@ int cmd_fmt_merge_msg(int argc,
 	int ret;
 	struct fmt_merge_msg_opts opts;
 
-	git_config(fmt_merge_msg_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, fmt_merge_msg_usage,
 			     0);
 	if (argc > 0)
 		usage_with_options(fmt_merge_msg_usage, options);
+	repo_config(repo, fmt_merge_msg_config, NULL);
 
-	adjust_shortlog_len(the_repository, &shortlog_len);
+	adjust_shortlog_len(repo, &shortlog_len);
 
 	if (inpath && strcmp(inpath, "-")) {
 		in = fopen(inpath, "r");
diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 8f59b867f2..4b4e645860 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -121,4 +121,11 @@ test_expect_success 'prune does not crash with -h' '
 	test_grep "[Uu]sage: git prune " usage
 '
 
+test_expect_success 'fmt-merge-msg does not crash with -h' '
+	test_expect_code 129 git fmt-merge-msg -h >usage &&
+	test_grep "[Uu]sage: git fmt-merge-msg " usage &&
+	test_expect_code 129 nongit git fmt-merge-msg -h >usage &&
+	test_grep "[Uu]sage: git fmt-merge-msg " usage
+'
+
 test_done
-- 
2.49.0

