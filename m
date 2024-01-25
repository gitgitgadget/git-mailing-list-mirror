Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775B9433B6
	for <git@vger.kernel.org>; Thu, 25 Jan 2024 20:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706215987; cv=none; b=nIt0GZ7tb80NP1ZR/SV6ZgRlqlBY7YUhTjW4AYpFk3FZSX4jtGcZIGJJ5Ph0vt5RZQYwI6HuHebI5iiLwlLH7Bwv8HExP3Q2zTqOiyxBNHQe/+qIpUHJKFQpA5x3qt9h63urRrNZubBPJfI8h25x5A+j/XVClAky26Ifwoo98AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706215987; c=relaxed/simple;
	bh=8TljTEm5P7t2tuS/Ysv1XqLa5dGorSgiKBIbtzl76Bw=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CX3OyLzPemwN6kjF50JzXaC3tNl2f0ZGhr308kFW4PxRn6hClGFfCa4qOKOeFOFV+XbBMF/uU43Xkk33nvD9+n9RsUULZLa3BtBjkgSWPAHmYoTkJ7l4hCk8yscifjLRTyQdA1Ce7HAHxomSBEZuiE2FDM32bJPOfPSLOAm0EQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0S4fSa5; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0S4fSa5"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e800461baso85371215e9.3
        for <git@vger.kernel.org>; Thu, 25 Jan 2024 12:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706215983; x=1706820783; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFe766aODKoSFWZY7g4Y6ejLcPRGjlu7n9BZ03Atxbc=;
        b=l0S4fSa5si+xlL1adjzkf1lqkEhzcrom6dpTonpCe1dpeoibg8/0vlt7VvGRFZyNo1
         4J6UhO0C4dlAnyqw91J3r4Rl73vUN0bzmZr2eC1sJSES4cAy3WYgEAcuCTogT24L2zE1
         LKPXntdamlmP1Rq6bIfDaL6ADlgTXLvATrSSIVLnCQgWG2QYysHPN50SBRI+d5ZWOTy1
         BPuUtyV5B93RiI9myxGd4MJkV+6LD+J6EkMMkuToG2WdRggSmQ3vBxuNzO5ivhjPaFpq
         VxoNvyZLRf4SUl24yCNH/LolY7RwLLT3axOk+Jgpunk+4Npo4K83hQUcZz/myD3H3C4l
         U9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706215983; x=1706820783;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFe766aODKoSFWZY7g4Y6ejLcPRGjlu7n9BZ03Atxbc=;
        b=urYx1Lf5OzuKDSgn1fxmWUXcOdIoPjJ2v2TtCO18ZcPdlm1WYibO92T9+Mi43Ujikq
         7DGCVIBtIjGccAdwKXaRVAQxWYpt6s2hOOM/dEFCP9shjyKZQXGpO3qSCzlluE2fkZ6Q
         gZW/nLylUq5I6P4Jl2ena57cQ7r2xdfrvxbYV+0JDJ/Qv/6SKS1zDn28st1ygdrun8jd
         tEPteERwB5cp9wnfoL5fZ7jzIDtkwhxYq2xsvzTu499mtiIyE78etZZ0EfkGL5BFDn2u
         34TGJfB79XJTMgKRv5Ft3LEkUfhuSVUWBF8ONtiJxwtOs6NOXo4mfjkXpFYwE53tlTBU
         D2Yg==
X-Gm-Message-State: AOJu0Ywt/AZSGzhSXfzla8O2sLH2HDOZz9FjPx9SzO3vYmMJ680gzxYy
	yXcC/SOeVP3VA3+KRTMokNJlX0rX9gkXHdl6RxdcJXZnKA/5Fy0/9pi6FWY0
X-Google-Smtp-Source: AGHT+IGOJjiGJO2Ga1ulv22b8e/LztWhmm5vDFTnqCRHdykvz1T1HnIbnusFc9GtDW2LJY8fOTadXQ==
X-Received: by 2002:a05:600c:2244:b0:40e:b947:4be5 with SMTP id a4-20020a05600c224400b0040eb9474be5mr91018wmm.244.1706215983026;
        Thu, 25 Jan 2024 12:53:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fs18-20020a05600c3f9200b0040e7306f655sm3596925wmb.22.2024.01.25.12.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 12:53:01 -0800 (PST)
Message-ID: <074e0c7ab923777c66516ced18b4fd1dadf7677f.1706215884.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1658.git.git.1706215884.gitgitgadget@gmail.com>
References: <pull.1658.git.git.1706215884.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 25 Jan 2024 20:51:24 +0000
Subject: [PATCH 2/2] index-pack: --fsck-objects to take an optional argument
 for fsck msgs
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
Cc: John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

git-index-pack has a --strict mode that can take an optional argument to
provide a list of fsck issues to change their severity. --fsck-objects
does not have such a utility, which would be useful if one would like to
be more lenient or strict on data integrity in a repository.

Like --strict, Allow --fsck-objects to also take a list of fsck msgs to
change the severity.

This commit also removes the "For internal use only" note for
--fsck-objects, and documents the option. This won't often be used by
the normal end user, but it turns out it is useful for Git forges like
GitLab.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 Documentation/git-index-pack.txt | 10 ++++++++--
 builtin/index-pack.c             |  5 +++--
 t/t5300-pack-object.sh           | 29 ++++++++++++++++++++++++-----
 3 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 14f806d07d1..37709b13c88 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -96,8 +96,14 @@ default and "Indexing objects" when `--stdin` is specified.
 --check-self-contained-and-connected::
 	Die if the pack contains broken links. For internal use only.
 
---fsck-objects::
-	For internal use only.
+--fsck-objects[=<msg-ids>]::
+	Instructs index-pack to check for broken objects instead of broken
+	links. If `<msg-ids>` is passed, it should be  a comma-separated list of
+	`<msg-id>=<severity>` where `<msg-id>` and `<severity>` are used to
+	change the severity of `fsck` errors, eg: `--strict="missingEmail=ignore,badTagName=ignore"`.
+	See the entry for the `fsck.<msg-id>` configuration options in
+	`linkgit:git-fsck[1] for more information on the possible values of
+	`<msg-id>` and `<severity>`.
 +
 Die if the pack contains broken objects. If the pack contains a tree
 pointing to a .gitmodules blob that does not exist, prints the hash of
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 1e53ca23775..519162f5b91 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -24,7 +24,7 @@
 #include "setup.h"
 
 static const char index_pack_usage[] =
-"git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--[no-]rev-index] [--verify] [--strict[=<msg-ids>]] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
+"git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--[no-]rev-index] [--verify] [--strict[=<msg-ids>]] [--fsck-objects[=<msg-ids>]] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
 
 struct object_entry {
 	struct pack_idx_entry idx;
@@ -1785,8 +1785,9 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 			} else if (!strcmp(arg, "--check-self-contained-and-connected")) {
 				strict = 1;
 				check_self_contained_and_connected = 1;
-			} else if (!strcmp(arg, "--fsck-objects")) {
+			} else if (skip_to_optional_arg(arg, "--fsck-objects", &arg)) {
 				do_fsck_object = 1;
+				fsck_set_msg_types(&fsck_options, arg);
 			} else if (!strcmp(arg, "--verify")) {
 				verify = 1;
 			} else if (!strcmp(arg, "--verify-stat")) {
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 9563372ae27..916cf939beb 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -441,8 +441,7 @@ test_expect_success 'index-pack with --strict' '
 	)
 '
 
-test_expect_success 'index-pack with --strict downgrading fsck msgs' '
-	test_when_finished rm -rf strict &&
+test_expect_success 'setup for --strict and --fsck-objects downgrading fsck msgs' '
 	git init strict &&
 	(
 		cd strict &&
@@ -457,12 +456,32 @@ test_expect_success 'index-pack with --strict downgrading fsck msgs' '
 
 		EOF
 		git hash-object --literally -t commit -w --stdin <commit >commit_list &&
-		PACK=$(git pack-objects test <commit_list) &&
-		test_must_fail git index-pack --strict "test-$PACK.pack" &&
-		git index-pack --strict="missingEmail=ignore" "test-$PACK.pack"
+		git pack-objects test <commit_list >pack-name
 	)
 '
 
+test_with_bad_commit () {
+	must_fail_arg="$1" &&
+	must_pass_arg="$2" &&
+	(
+		cd strict &&
+		test_expect_fail git index-pack "$must_fail_arg" "test-$(cat pack-name).pack"
+		git index-pack "$must_pass_arg" "test-$(cat pack-name).pack"
+	)
+}
+
+test_expect_success 'index-pack with --strict downgrading fsck msgs' '
+	test_with_bad_commit --strict --strict="missingEmail=ignore"
+'
+
+test_expect_success 'index-pack with --fsck-objects downgrading fsck msgs' '
+	test_with_bad_commit --fsck-objects --fsck-objects="missingEmail=ignore"
+'
+
+test_expect_success 'cleanup for --strict and --fsck-objects downgrading fsck msgs' '
+	rm -rf strict
+'
+
 test_expect_success 'honor pack.packSizeLimit' '
 	git config pack.packSizeLimit 3m &&
 	packname_10=$(git pack-objects test-10 <obj-list) &&
-- 
gitgitgadget
