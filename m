Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EF727E05A
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 15:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308316; cv=none; b=JKFKQqnDBAyBXIeATA8i1U1FX4fjGb83x2ceNyCCz/mNx1ChmuvAYyOUIelG8dIFKqTaWeB7j/a03ovkNmxY89Xy8uYtCag2WzGaCrP7nP7XB8ZaLQWFVz5iO+icYpAypxA9VUS1rievPy51TwTEEFk8s/niTZct5J+q9Snh1UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308316; c=relaxed/simple;
	bh=SGOBeEbkHJe20jeLUVQaYt3RzrHx+UY6holVQS1oZ5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJc669+k+HZ85LJZpchw2Alb+COWUgm8o2TAq8r3QLfp3xzMESIpr+fkCuQ6RgtdqQ/dpDGjTwRXA6Dz3R1QjrjKOgOnFpMBEtvN2OAamwdAM35uov5Rtt+vEid9Z3SRdDZX8kwB1cwC+zZHoApBIkTIn/oJV9a/Kd2X2S5zLGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jS2d2/q3; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jS2d2/q3"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3c51f0158d8so5503658f8f.1
        for <git@vger.kernel.org>; Wed, 27 Aug 2025 08:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756308313; x=1756913113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2GO2IK/nA4Xp9VeK4AtZ+D+KX6Zqi7Px0Pq9P/5ba0w=;
        b=jS2d2/q3voGkwahYlSQeFMcjC1JFkjiUbEBDH0h7zEITrKbnfqTSMOvxCuMpEAlCS0
         RKqO2GWO1NqpNCAEBg7JRPc6xeNh8stZzEIituL6AAyb10ypI4m4IvJk2v6WdhnpwNkG
         dn5FM3vzVh5lpif1n3Cx0MZMdf2tG/slVzehZwaswLUdZehHXcUtohfplHicVRO2MG3T
         QNM0EBnV2l1LmnOoniNTxYFouhfCSdbHiZ+rOW4DRfa5dvvF9gjvqOgolb0TAi0JLq1R
         4c1ffaHhzKi+BVsoxggZB7IZL8kNy6g5riYM13TtR0KaWF2x20br0CQprYucWQJ2yz3s
         4QFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756308313; x=1756913113;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2GO2IK/nA4Xp9VeK4AtZ+D+KX6Zqi7Px0Pq9P/5ba0w=;
        b=G9u13wYSbQAylZFle1MKi0JlfD299nvDJTXt2i946tVvbyBBmCrhvh7egkSrxxaZNA
         xxkIHnxckoU4dhb7c8aiwCasrjkRKTr4fg6wrOsoKU5zFb6i0kpGON9U6C/lZPLUU26j
         gHEPwubr1KPO+xH52709s9nwwcxRrihZY3HtwR/kKkqPgZq2U9ge/OcDW0/OP3yO1e+q
         kHmr4i/MY0u9ONv8KwvHjPe2RchcsKg1dbzyHog1dAcT2bSTgIXtJZtB/BpKUHToc/6C
         AXhmoRi6aHLy7XX7P1j74TDkE9m5/3AtcA++BInx/hjpdj281SiFgpHLEnPz7cI435on
         dQuA==
X-Gm-Message-State: AOJu0YxhPympMmWoV3NAbPDvK7VKF8Xt5W1skQtw/aBB+QYmPSmpzxGB
	KlhhwTWFRpoeH6AGSxpoE5eQhJzDrVcNOzfDCZpufC30VuoBMoxaSkDoDOqanw==
X-Gm-Gg: ASbGncsWdhUv2nYmxAtH87f7h5RW6m6uW0agB4r+eMlSdfXPlSOfBIdEhUODItCrypo
	afeH817lDokodQ7vNiYrE66vx4vxFrNj8zaQgy+kG3HEdZu0fqBbUh1r3x3xYUaT2UkYbBM25UN
	D57eTUPyztL17bDfp6Xw/SQXUzFGbQHoALgpmzmn27ptscYb3PcEyy6iSYonXy7Y1WyQFImkeYr
	ouK+NS4zZl8RfR/5UiO9BDGvAAys24X3Vf1/zneZNFWMbt55M5rMm7EfjenKwKR/gWuS5kp/+zl
	A9PneU7H4lfenCrifWpJvxU9kz7/bhUvHzyVOXjwqJTSi5rgAfIJkO9dECdoLfJ4rWK1E/vV7Dw
	XTFKer9nceJ0WBXRWsFkx7pheVBFdygIio/NUlid8zGQd/A==
X-Google-Smtp-Source: AGHT+IG+DpNtfxRwtglpQFhS90x3esrJvHWdr8/E4Dww+wl9jpGoNKM1cEqLj3xBY5r6PG8xg1sGfA==
X-Received: by 2002:a05:6000:40ce:b0:3b7:899c:e867 with SMTP id ffacd0b85a97d-3c5dcefd9aemr16709580f8f.59.1756308312515;
        Wed, 27 Aug 2025 08:25:12 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b73627bc4sm17894305e9.9.2025.08.27.08.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:25:12 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wing Huang <huangsen365@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH 6/6] breaking-changes: switch default branch to main
Date: Wed, 27 Aug 2025 16:24:50 +0100
Message-ID: <487d1a33130cb2fafadcf98da00a332a7408a0e8.1756308283.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Since 1296cbe4b46 (init: document `init.defaultBranch` better,
2020-12-11) "git-init.adoc" has advertized that the default name
of the initial branch may change in the future. The name "main"
is chosen to match the default used by the big git forge web sites.

The advice printed when init.defaultBranch is not set is
updated to say that the default will change to "main" in Git
3.0. Building with WITH_BREAKING_CHANGES enabled removes the advice,
changes the default branch name is "main" and removes support for
GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME. The code in guess_remote_head()
that looks for "refs/heads/master" is left unchanged as that is only
called when the remote server does not support the symref capability
in the v0 protocol or the symref extension to the ls-refs list in the
v2 protocol. Such an old server is more likely to be using "master"
as the default branch name.

With the exception of the "git-init.adoc" the documentation is left
unchanged. I had hoped to parameterize the name of the default branch
by using an asciidoc attribute. Unfortunately attribute expansion
is inhibited by backticks and we use backticks to mark up ref names
so that idea does not work. As the changes to git-init.adoc show
inserting ifdef's around each instance of the branch name "master"
is cumbersome and makes the documentation sources harder to read.

Apart from "git-init.adoc" there are some other files where "master" is
used as the name of the initial branch rather than as an example of a
branch name such as "user-manual.adoc" and "gitcore-tutorial.adoc". The
name appears a lot in those so updating it with ifdef's is not really
practical. We can update that document in the 3.0 release cycle. The
other documentation where master is used as an example branch name
can be gradually converted over time.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/BreakingChanges.adoc |  5 +++++
 Documentation/git-init.adoc        | 12 +++++++++---
 advice.c                           |  2 ++
 advice.h                           |  2 ++
 ci/run-build-and-tests.sh          |  1 -
 refs.c                             | 16 +++++++++++++---
 t/t0001-init.sh                    |  9 +++++----
 t/test-lib.sh                      | 15 +++++++++++----
 8 files changed, 47 insertions(+), 15 deletions(-)

diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
index f8d2eba061c..93922299321 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -165,6 +165,11 @@ A prerequisite for this change is that the ecosystem is ready to support the
 "reftable" format. Most importantly, alternative implementations of Git like
 JGit, libgit2 and Gitoxide need to support it.
 
+* The default branch name will be `main`. We have been warning that the default
+  name will change since 675704c74dd (init: provide useful advice about
+  init.defaultBranch, 2020-12-11). The new name matches the default branch name
+  used by many of the big git forges.
+
 === Removals
 
 * Support for grafting commits has long been superseded by git-replace(1).
diff --git a/Documentation/git-init.adoc b/Documentation/git-init.adoc
index a0dffba665f..39d4db6bccb 100644
--- a/Documentation/git-init.adoc
+++ b/Documentation/git-init.adoc
@@ -77,9 +77,15 @@ If this is a reinitialization, the repository will be moved to the specified pat
 `-b <branch-name>`::
 `--initial-branch=<branch-name>`::
 Use _<branch-name>_ for the initial branch in the newly created
-repository.  If not specified, fall back to the default name (currently
-`master`, but this is subject to change in the future; the name can be
-customized via the `init.defaultBranch` configuration variable).
+repository.  If not specified, fall back to the default name
+ifndef::with-breaking-changes[]
+(currently `master`, but this will change to `main` when Git 3.0 is released).
+endif::with-breaking-changes[]
+ifdef::with-breaking-changes[]
+(`main`).
+endif::with-breaking-changes[]
+The default name can be customized via the `init.defaultBranch` configuration
+variable.
 
 `--shared[=(false|true|umask|group|all|world|everybody|<perm>)]`::
 
diff --git a/advice.c b/advice.c
index e5f0ff84491..48c49ee4145 100644
--- a/advice.c
+++ b/advice.c
@@ -51,7 +51,9 @@ static struct {
 	[ADVICE_AM_WORK_DIR] 				= { "amWorkDir" },
 	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName" },
 	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge" },
+#ifndef WITH_BREAKING_CHANGES
 	[ADVICE_DEFAULT_BRANCH_NAME]			= { "defaultBranchName" },
+#endif /* WITH_BREAKING_CHANGES */
 	[ADVICE_DETACHED_HEAD]				= { "detachedHead" },
 	[ADVICE_DIVERGING]				= { "diverging" },
 	[ADVICE_FETCH_SET_HEAD_WARN]			= { "fetchRemoteHEADWarn" },
diff --git a/advice.h b/advice.h
index 727dcecf4a3..fc1dc872049 100644
--- a/advice.h
+++ b/advice.h
@@ -18,7 +18,9 @@ enum advice_type {
 	ADVICE_AM_WORK_DIR,
 	ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
 	ADVICE_COMMIT_BEFORE_MERGE,
+#ifndef WITH_BREAKING_CHANGES
 	ADVICE_DEFAULT_BRANCH_NAME,
+#endif /* WITH_BREAKING_CHANGES */
 	ADVICE_DETACHED_HEAD,
 	ADVICE_DIVERGING,
 	ADVICE_FETCH_SET_HEAD_WARN,
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 01823fd0f14..a21834043f3 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -9,7 +9,6 @@ run_tests=t
 
 case "$jobname" in
 linux-breaking-changes)
-	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 	export WITH_BREAKING_CHANGES=YesPlease
 	;;
 linux-TEST-vars)
diff --git a/refs.c b/refs.c
index 4ff55cf24f6..e73f63ff6b8 100644
--- a/refs.c
+++ b/refs.c
@@ -627,10 +627,12 @@ void expand_ref_prefix(struct strvec *prefixes, const char *prefix)
 		strvec_pushf(prefixes, *p, len, prefix);
 }
 
+#ifndef WITH_BREAKING_CHANGES
 static const char default_branch_name_advice[] = N_(
 "Using '%s' as the name for the initial branch. This default branch name\n"
-"is subject to change. To configure the initial branch name to use in all\n"
-"of your new repositories, which will suppress this warning, call:\n"
+"will change to \"main\" in Git 3.0. To configure the initial branch name\n"
+"to use in all of your new repositories, which will suppress this warning,\n"
+"call:\n"
 "\n"
 "\tgit config --global init.defaultBranch <name>\n"
 "\n"
@@ -639,24 +641,32 @@ static const char default_branch_name_advice[] = N_(
 "\n"
 "\tgit branch -m <name>\n"
 );
+#endif /* WITH_BREAKING_CHANGES */
 
 char *repo_default_branch_name(struct repository *r, int quiet)
 {
 	const char *config_key = "init.defaultbranch";
 	const char *config_display_key = "init.defaultBranch";
 	char *ret = NULL, *full_ref;
+#ifndef WITH_BREAKING_CHANGES
 	const char *env = getenv("GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME");
 
 	if (env && *env)
 		ret = xstrdup(env);
-	else if (repo_config_get_string(r, config_key, &ret) < 0)
+#endif /* WITH_BREAKING_CHANGES */
+	if (!ret && repo_config_get_string(r, config_key, &ret) < 0)
 		die(_("could not retrieve `%s`"), config_display_key);
 
 	if (!ret) {
+#ifdef WITH_BREAKING_CHANGES
+		ret = xstrdup("main");
+		(void) quiet; /* Silence -Wunused-parameter */
+#else
 		ret = xstrdup("master");
 		if (!quiet)
 			advise_if_enabled(ADVICE_DEFAULT_BRANCH_NAME,
 					  _(default_branch_name_advice), ret);
+#endif /* WITH_BREAKING_CHANGES */
 	}
 
 	full_ref = xstrfmt("refs/heads/%s", ret);
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index f593c536874..7223a98773d 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -868,7 +868,7 @@ test_expect_success 'overridden default initial branch name (config)' '
 	grep nmb actual
 '
 
-test_expect_success 'advice on unconfigured init.defaultBranch' '
+test_expect_success !WITH_BREAKING_CHANGES 'advice on unconfigured init.defaultBranch' '
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= git -c color.advice=always \
 		init unconfigured-default-branch-name 2>err &&
 	test_decode_color <err >decoded &&
@@ -883,16 +883,17 @@ test_expect_success 'advice on unconfigured init.defaultBranch disabled' '
 	test_grep ! "hint: " err
 '
 
-test_expect_success 'overridden default main branch name (env)' '
+test_expect_success !WITH_BREAKING_CHANGES 'overridden default main branch name (env)' '
 	test_config_global init.defaultBranch nmb &&
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=env git init main-branch-env &&
 	git -C main-branch-env symbolic-ref HEAD >actual &&
 	grep env actual
 '
 
 test_expect_success 'invalid default branch name' '
-	test_must_fail env GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME="with space" \
-		git init initial-branch-invalid 2>err &&
+	test_must_fail env GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
+		git -c init.defaultBranch="with space" \
+			init initial-branch-invalid 2>err &&
 	test_grep "invalid branch name" err
 '
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 621cd31ae1d..ec6b8ebcabb 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -127,10 +127,17 @@ then
 	export GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS
 fi
 
-# Explicitly set the default branch name for testing, to avoid the
-# transitory "git init" warning under --verbose.
-: ${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME:=master}
-export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+if test -z "$WITH_BREAKING_CHANGES"
+then
+	# Explicitly set the default branch name for testing, to avoid the
+	# transitory "git init" warning under --verbose.
+	: ${GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME:=master}
+	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+else
+	# Unset the default branch name that is set in many test scripts
+	# before sourcing this file.
+	unset GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+fi
 
 ################################################################
 # It appears that people try to run tests without building...
-- 
2.49.0.897.gfad3eb7d210

