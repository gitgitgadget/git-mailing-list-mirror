Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2F0C636D4
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 18:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjBMSWl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 13:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjBMSW0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 13:22:26 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26108206B2
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 10:22:14 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id pj9-20020a17090b4f4900b00232cca91108so5011319pjb.7
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 10:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1676312533;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ggoJOO2GA5Q5f8At6jIma7siMSH6HvKvh/4fysEYNoM=;
        b=Emcr6FeD2p7kr2bH9TEdXi4kRMyHWcpTKAr8r9dpa9rxtRBMWZageiRRDAogDq4and
         1EibYRPz0hGCbnIagjOxqRt5DuD1V9rcoW5SXEp6bb+t7Qg6fr4gAlGynbtQ2BWDfgiJ
         yUquvKsUpN1z8mzhD9WRlODC932HNSjHxqhoWwtjU+pCNJeAytvrpETES+JWUVdcEmsL
         m4hPC9t33czy7nSmOhPW5hd4kUvx2lvlLMh5IA3XZED0Trovk+cjfzp0OLuH9Hf0wkhl
         5IsJ1XXFejKpJhCtZPnYiUBcyyF7ZoasROEPjpFYhULejQQh5LReMC9qz5jFH23w1E+b
         mZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676312533;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ggoJOO2GA5Q5f8At6jIma7siMSH6HvKvh/4fysEYNoM=;
        b=Y1QXbUg+XsWvmAHTK/GCEHp/OS7FZfLl8zQis7raZu/P6LHYglI4z9awLKxbDCZYrn
         bTMKdlE/yx30JJX0az5F6vXif92Hwo1nl0MRA2O3S9XRIZMzwQ+Rg1OGgy5wFWKmLtZi
         yJgQ5RQZ/gsQha82/B/IQLAjzS1qQulgt0arEdV4fZpmmaCP4jJJUD1Pv4LOOVmyoo08
         dGATGnLs/mdR2U3n8EqrmuWlD7Gne9HSDBQFYvIP3wKam45bi2pZpWG6n8k7+jZCw3dY
         Dwn4Rcn90le+IBDu3TkVABAVr/8trBcf4vGAPEE/bwqQ8eKR5/8AW8TEOrO9aCm7CRMI
         eZ7A==
X-Gm-Message-State: AO0yUKWFsyVnQ21E329sNCilGKBPgvCwe3SYTHP+eGFdhJXJ/w2PTVBC
        z6dVSW2CxeSDNOpZ+GxAEOzr1ErnHJcCxw+yxnToHfCCInRaN7ecevSoBLPIeWI5HYPALTvLEFs
        7PpYYmjJEvSFi9jLc4+wUwZEvWJ0loqYNd2/YrNO2ICj55Hd8sXVqPT+8P1xcSLgg/w==
X-Google-Smtp-Source: AK7set/RY9vFz/r8wB0N/V/CdPkGxzMExke4C24D01Dhz6JdlIQ6Tt71AyaonzAnfRlQFpz8arM6e/MXpfgCP5s=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a62:4ed7:0:b0:5a8:b6e2:a3fe with SMTP id
 c206-20020a624ed7000000b005a8b6e2a3femr983368pfb.41.1676312533521; Mon, 13
 Feb 2023 10:22:13 -0800 (PST)
Date:   Mon, 13 Feb 2023 18:21:34 +0000
In-Reply-To: <20230213182134.2173280-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230213182134.2173280-1-calvinwan@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230213182134.2173280-7-calvinwan@google.com>
Subject: [RFC PATCH 6/6] add: reject nested repositories
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Josh Steadmon <steadmon@google.com>,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Josh Steadmon <steadmon@google.com>

As noted in 532139940c (add: warn when adding an embedded repository,
2017-06-14), adding embedded repositories results in subpar experience
compared to submodules, due to the lack of a corresponding .gitmodules
entry, which means later clones of the top-level repository cannot
locate the embedded repo. We expect that this situation is usually
unintentional, which is why 532139940c added a warning message and
advice when users attempt to add an embedded repo.

At $dayjob, we have found that even this advice is insufficient to stop
users from committing unclonable embedded repos in shared projects.
This causes toil for the owners of the top-level project repository as
they must clean up the resulting gitlinks. Additionally, these mistakes
are often made by partners outside of $dayjob, which means that a simple
organization-wide change to the default Git config would be insufficient
to prevent these mistakes.

Due to this experience, we believe that Git's default behavior should be
changed to disallow adding embedded repositories. This commit changes
the existing warning into a fatal error while preserving the
`--no-warn-embedded-repo` flag as a way to bypass this check.

Signed-off-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 Documentation/git-add.txt          |  7 ++++---
 builtin/add.c                      | 28 ++++++++++++++++++++--------
 t/t7400-submodule-basic.sh         |  4 ++--
 t/t7412-submodule-absorbgitdirs.sh |  2 +-
 t/t7414-submodule-mistakes.sh      | 21 ++++++++++-----------
 t/t7450-bad-git-dotfiles.sh        |  2 +-
 6 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index a030d33c6e..b7fb95b061 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -177,10 +177,11 @@ for "git add --no-all <pathspec>...", i.e. ignored removed files.
 	tree or not.
 
 --no-warn-embedded-repo::
-	By default, `git add` will warn when adding an embedded
+	By default, `git add` will error out when adding an embedded
 	repository to the index without using `git submodule add` to
-	create an entry in `.gitmodules`. This option will suppress the
-	warning (e.g., if you are manually performing operations on
+	create an entry in `.gitmodules`. This option will allow the
+	embedded repository to be added and suppress the error.
+	(e.g., if you are manually performing operations on
 	submodules).
 
 --renormalize::
diff --git a/builtin/add.c b/builtin/add.c
index 76277df326..795d9251b9 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -421,36 +421,45 @@ static const char embedded_advice[] = N_(
 "\n"
 "	git rm --cached %s\n"
 "\n"
-"See \"git help submodule\" for more information."
+"See \"git help submodule\" for more information.\n"
+"\n"
+"If you cannot use submodules, you may bypass this check with:\n"
+"\n"
+"	git add --no-warn-embedded-repo %s\n"
 );
 
-static void check_embedded_repo(const char *path)
+static int check_embedded_repo(const char *path)
 {
+	int ret = 0;
 	struct strbuf name = STRBUF_INIT;
 	static int adviced_on_embedded_repo = 0;
 
 	if (!warn_on_embedded_repo)
-		return;
+		goto cleanup;
 	if (!ends_with(path, "/"))
-		return;
+		goto cleanup;
+
+	ret = 1;
 
 	/* Drop trailing slash for aesthetics */
 	strbuf_addstr(&name, path);
 	strbuf_strip_suffix(&name, "/");
 
-	warning(_("adding embedded git repository: %s"), name.buf);
+	error(_("cannot add embedded git repository: %s"), name.buf);
 	if (!adviced_on_embedded_repo &&
 	    advice_enabled(ADVICE_ADD_EMBEDDED_REPO)) {
-		advise(embedded_advice, name.buf, name.buf);
+		advise(embedded_advice, name.buf, name.buf, name.buf);
 		adviced_on_embedded_repo = 1;
 	}
 
+cleanup:
 	strbuf_release(&name);
+	return ret;
 }
 
 static int add_files(struct dir_struct *dir, int flags)
 {
-	int i, exit_status = 0;
+	int i, exit_status = 0, embedded_repo = 0;
 	struct string_list matched_sparse_paths = STRING_LIST_INIT_NODUP;
 
 	if (dir->ignored_nr) {
@@ -476,10 +485,13 @@ static int add_files(struct dir_struct *dir, int flags)
 				die(_("adding files failed"));
 			exit_status = 1;
 		} else {
-			check_embedded_repo(dir->entries[i]->name);
+			embedded_repo |= check_embedded_repo(dir->entries[i]->name);
 		}
 	}
 
+	if (embedded_repo)
+		die(_("refusing to add embedded git repositories"));
+
 	if (matched_sparse_paths.nr) {
 		advise_on_updating_sparse_paths(&matched_sparse_paths);
 		exit_status = 1;
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index eae6a46ef3..e0bcecba6e 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -118,7 +118,7 @@ test_expect_success 'setup - repository in init subdirectory' '
 test_expect_success 'setup - commit with gitlink' '
 	echo a >a &&
 	echo z >z &&
-	git add a init z &&
+	git add --no-warn-embedded-repo a init z &&
 	git commit -m "super commit 1"
 '
 
@@ -771,7 +771,7 @@ test_expect_success 'set up for relative path tests' '
 			git init &&
 			test_commit foo
 		) &&
-		git add sub &&
+		git add --no-warn-embedded-repo sub &&
 		git config -f .gitmodules submodule.sub.path sub &&
 		git config -f .gitmodules submodule.sub.url ../subrepo &&
 		cp .git/config pristine-.git-config &&
diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
index 2859695c6d..365953b558 100755
--- a/t/t7412-submodule-absorbgitdirs.sh
+++ b/t/t7412-submodule-absorbgitdirs.sh
@@ -100,7 +100,7 @@ test_expect_success 'absorb the git dir in a nested submodule' '
 test_expect_success 'setup a gitlink with missing .gitmodules entry' '
 	git init sub2 &&
 	test_commit -C sub2 first &&
-	git add sub2 &&
+	git add --no-warn-embedded-repo sub2 &&
 	git commit -m superproject
 '
 
diff --git a/t/t7414-submodule-mistakes.sh b/t/t7414-submodule-mistakes.sh
index 101afff30f..dbdcbe909d 100755
--- a/t/t7414-submodule-mistakes.sh
+++ b/t/t7414-submodule-mistakes.sh
@@ -10,31 +10,30 @@ test_expect_success 'create embedded repository' '
 	test_commit -C embed one
 '
 
-test_expect_success 'git-add on embedded repository warns' '
-	test_when_finished "git rm --cached -f embed" &&
-	git add embed 2>stderr &&
-	test_i18ngrep warning stderr
+test_expect_success 'git-add on embedded repository dies' '
+	test_must_fail git add embed 2>stderr &&
+	test_i18ngrep fatal stderr
 '
 
-test_expect_success '--no-warn-embedded-repo suppresses warning' '
+test_expect_success '--no-warn-embedded-repo suppresses error message' '
 	test_when_finished "git rm --cached -f embed" &&
 	git add --no-warn-embedded-repo embed 2>stderr &&
-	test_i18ngrep ! warning stderr
+	test_i18ngrep ! fatal stderr
 '
 
-test_expect_success 'no warning when updating entry' '
+test_expect_success 'no error message when updating entry' '
 	test_when_finished "git rm --cached -f embed" &&
-	git add embed &&
+	git add --no-warn-embedded-repo embed &&
 	git -C embed commit --allow-empty -m two &&
 	git add embed 2>stderr &&
-	test_i18ngrep ! warning stderr
+	test_i18ngrep ! fatal stderr
 '
 
-test_expect_success 'submodule add does not warn' '
+test_expect_success 'submodule add does not issue error message' '
 	test_when_finished "git rm -rf submodule .gitmodules" &&
 	git -c protocol.file.allow=always \
 		submodule add ./embed submodule 2>stderr &&
-	test_i18ngrep ! warning stderr
+	test_i18ngrep ! fatal stderr
 '
 
 test_done
diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
index ba1f569bcb..6fbcf36ae9 100755
--- a/t/t7450-bad-git-dotfiles.sh
+++ b/t/t7450-bad-git-dotfiles.sh
@@ -307,7 +307,7 @@ test_expect_success 'git dirs of sibling submodules must not be nested' '
 		EOF
 		git clone . thing1 &&
 		git clone . thing2 &&
-		git add .gitmodules thing1 thing2 &&
+		git add --no-warn-embedded-repo .gitmodules thing1 thing2 &&
 		test_tick &&
 		git commit -m nested
 	) &&
-- 
2.39.1.581.gbfd45094c4-goog

