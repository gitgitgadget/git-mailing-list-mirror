Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C6125394B
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518166; cv=none; b=qnp0bZCivH7uli4q/Pnyz++MgWiEE2aLMgawVnHl7NoT9+GMKdpsu/esrNaVy1RPRiiZEewFnOcnyUJ3gY0F9PZaEMFPkzp4gDwonQ59PzJZX58QpQvJAsK5Nks4z95YJO7V3MPQdPOyGhjZuRMWojLnTBblj5EMisl5etoldHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518166; c=relaxed/simple;
	bh=8NVtk+DaTt0LatKdM/DUhsHRKEmOGHWTer2IgNQ87ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SvMLGDZBRDAmcGkz6vg/XD6kfNNo0jGh7MWHrH/bNvXF3f9RdwjtCzTUgdpxabMgKpdtg3PspBJTtQTAZcYw6vo5UFHAYwPJazvuB8FsfhuWiVYQCj+GoFc4l9cBsFfN9F1YezwaR+Gd41UgW3jPTWSvI7RWX1AYQa2nVmvn3kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxW1/7/b; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxW1/7/b"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3e34dbc38easo3226935f8f.1
        for <git@vger.kernel.org>; Wed, 10 Sep 2025 08:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757518163; x=1758122963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NBdWhFa4ENtHo2COmUEcw8xCYjtPkrLHt4HP9hsXbVs=;
        b=JxW1/7/bFnH+A7Dfa2NyKzZtZ8HHQZ8OKSTqG21jWN8QenBUF87KKPXLpHuLDrOWsV
         bE50L2vatqMKz56FyNwgzj7oa80NFDAZMQTCDlPNkHiROZTqn0nIyPON46on4X7YriwU
         OXyjYWK40fm+JE6m54vyXUy6EXWKGRmvdXbERNrTzDyQ4fHlXlUtaTK+fAEuImb5mNDP
         tX/kAmzheNygGmlFFeDQ9Cf61hGzhTQdXS7dzhG/UL5WDKGunwBRDVmZvit1F5nb+/V6
         us0vwxPpqfCvjTLIVncUJR3G+GzlIOJp+kXZLX0hFpnJHbJmwHWzoN8p14SHc2mL51Vu
         /ylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757518163; x=1758122963;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NBdWhFa4ENtHo2COmUEcw8xCYjtPkrLHt4HP9hsXbVs=;
        b=nBsspQwBinBsoLILp4CORkj7lNcvBNAnW2iKby8urEKbhpvuW6ROaLYPjm00i9LdsC
         LrOANrRLRXKk8pn8IxlbmH3cxccEq72Gl7iPJxqs1D1sPTqWtCCbiFodWrEx6vRARyln
         FkE8VACcYfMOoRZ+qM9yLmtE14NCrHtiXMl3dTkK03aUrxvherJ3k4cWC4H336YjG/8c
         uc6Evpd9Ft9qPQwVosRgrzgIBfK1VcGHguoZYXH6UOyKUfAup3lvlxpyfvSgGihTHAyA
         3uBQDvVONcwS1qVurVehaSISFzBNNZBJEq5chI5SDQ4uPdqBez8FGFLYWSyCfGbb2CP5
         jjEA==
X-Gm-Message-State: AOJu0YwUpCe3wfdRlnM0gMkdwn38C5DAmXGVHK+DuUe47+5DlwwgpxcS
	vC/xhEhoX8VwqnbQ1+FGh0e5gDcWZ7dJKwTcwvDPkXFJsTpegqRo/LRS74KjSw==
X-Gm-Gg: ASbGncvFs9c0mRdSGh74invXwclmoOwzNElNVcuMhOcagmSdH8Urb400ipsDLIj6OA2
	/T0VnaxMzQTBJ1rCWazFKy9Zblk2yBni2Lx6MyUwSjHqAsEdVN/TqCaLn9nU4zFhd1V7f2++GDq
	3RKy2tm1h3Dznk9GkcpSVmYBwQh7bW/3bPJnjGNHrrdhCx4LpLV1dX4t3HFFCicuM42RN74JfdO
	F73SVE8w1d7NGVRhl19ndysA5/4/RRA181cKvdb9I0jF9xThqfu+Z28CViymDXrQaR4FwNmQkiE
	0vCepvmWvjHSEey/J9W56i+Pc2ih+GyI/UpvxXjtEye+5yoY/Ta28csOBesa/cIyu1g+d8l3m89
	yohHECvIePY1KBGKk1CJYJiT4gn6c6Lu78SNb2yfFJGAzNFvajwkQPyY=
X-Google-Smtp-Source: AGHT+IGbqRRkph5eVNFYTu7UCbbzKpfbOT4z9kgVUloYFWBbvVw4t1amNYyOrhxh8qHn6LlMmV9WbA==
X-Received: by 2002:a5d:64c3:0:b0:3d0:3eae:576d with SMTP id ffacd0b85a97d-3e642f8f76fmr11140545f8f.22.1757518162691;
        Wed, 10 Sep 2025 08:29:22 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75223f188sm7137107f8f.48.2025.09.10.08.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 08:29:22 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wing Huang <huangsen365@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 1/4] breaking-changes: switch default branch to main
Date: Wed, 10 Sep 2025 16:29:00 +0100
Message-ID: <441bc5f9bcbf70f401fd9df01c441cda23d4f5ca.1757518141.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1757518141.git.phillip.wood@dunelm.org.uk>
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk> <cover.1757518141.git.phillip.wood@dunelm.org.uk>
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
2020-12-11) "git-init.adoc" has advertised that the default name
of the initial branch may change in the future. The name "main"
is chosen to match the default used by the big Git forge web sites.

The advice printed when init.defaultBranch is not set is updated
to say that the default will change to "main" in Git 3.0. Building
with WITH_BREAKING_CHANGES enabled removes the advice and changes
the default branch name to "main". The code in guess_remote_head()
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
 Documentation/BreakingChanges.adoc |  6 ++++++
 Documentation/git-init.adoc        | 12 +++++++++---
 advice.c                           |  2 ++
 advice.h                           |  2 ++
 ci/run-build-and-tests.sh          |  1 -
 refs.c                             | 15 +++++++++++----
 t/t0001-init.sh                    | 18 +++++++++++++++++-
 t/test-lib.sh                      | 11 +++++++----
 8 files changed, 54 insertions(+), 13 deletions(-)

diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
index f8d2eba061c..f4e11c88655 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -165,6 +165,12 @@ A prerequisite for this change is that the ecosystem is ready to support the
 "reftable" format. Most importantly, alternative implementations of Git like
 JGit, libgit2 and Gitoxide need to support it.
 
+* In new repositories, the default branch name will be `main`. We have been
+  warning that the default name will change since 675704c74dd (init:
+  provide useful advice about init.defaultBranch, 2020-12-11).  The new name
+  matches the default branch name used in new repositories by many of the
+  big Git forges.
+
 === Removals
 
 * Support for grafting commits has long been superseded by git-replace(1).
diff --git a/Documentation/git-init.adoc b/Documentation/git-init.adoc
index a0dffba665f..bab99b9b477 100644
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
+`main`.
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
index 4ff55cf24f6..149a8d1cec1 100644
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
@@ -639,8 +641,9 @@ static const char default_branch_name_advice[] = N_(
 "\n"
 "\tgit branch -m <name>\n"
 );
+#endif /* WITH_BREAKING_CHANGES */
 
-char *repo_default_branch_name(struct repository *r, int quiet)
+char *repo_default_branch_name(struct repository *r, MAYBE_UNUSED int quiet)
 {
 	const char *config_key = "init.defaultbranch";
 	const char *config_display_key = "init.defaultBranch";
@@ -649,14 +652,18 @@ char *repo_default_branch_name(struct repository *r, int quiet)
 
 	if (env && *env)
 		ret = xstrdup(env);
-	else if (repo_config_get_string(r, config_key, &ret) < 0)
+	if (!ret && repo_config_get_string(r, config_key, &ret) < 0)
 		die(_("could not retrieve `%s`"), config_display_key);
 
 	if (!ret) {
+#ifdef WITH_BREAKING_CHANGES
+		ret = xstrdup("main");
+#else
 		ret = xstrdup("master");
 		if (!quiet)
 			advise_if_enabled(ADVICE_DEFAULT_BRANCH_NAME,
 					  _(default_branch_name_advice), ret);
+#endif /* WITH_BREAKING_CHANGES */
 	}
 
 	full_ref = xstrfmt("refs/heads/%s", ret);
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index f593c536874..df0040b9ace 100755
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
@@ -883,6 +883,22 @@ test_expect_success 'advice on unconfigured init.defaultBranch disabled' '
 	test_grep ! "hint: " err
 '
 
+test_expect_success 'default branch name' '
+	if test_have_prereq WITH_BREAKING_CHANGES
+	then
+		expect=main
+	else
+		expect=master
+	fi &&
+	echo "refs/heads/$expect" >expect &&
+	(
+		sane_unset GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME &&
+		git init default-initial-branch-name
+	) &&
+	git -C default-initial-branch-name symbolic-ref HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'overridden default main branch name (env)' '
 	test_config_global init.defaultBranch nmb &&
 	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=env git init main-branch-env &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 621cd31ae1d..b191954c3c4 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -127,10 +127,13 @@ then
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
+fi
 
 ################################################################
 # It appears that people try to run tests without building...
-- 
2.49.0.897.gfad3eb7d210

