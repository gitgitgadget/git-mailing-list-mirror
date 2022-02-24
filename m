Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F36DC433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 06:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiBXGr4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 01:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiBXGrz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 01:47:55 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F9B113DBF
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 22:47:26 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id y5so1043369pfe.4
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 22:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xyYbiA8/Bb9wR0nwylYK4j8mDjr3B2+xdQa5Gkbgooc=;
        b=oeePXq4elwo2hRMyhPerXPq0EWomw0LsXeB2S0ibYRQaeNICrHgVBAVjSCZ9JAv/Xl
         Ows4OGalptL9rwthkSOsxywTiQnEwwe/kUJ8CdT2BpEi6NwIyYu6bkPvQAuwZn0j5Fp7
         lmMRm7azo49hQcW4+8NSHvU9ei2njRLQF0lmRCi91Q06y4OJh3XuUFTk/pDQ9gbmnQGg
         0AabWEkKCwX1CaPl8d+7a0709l1N0WOAY3xqyscjhEzaWXEdCGY3YRyaYtSL26mL5k6G
         yqH1a7bvSzcP0V+4fihNd22opfOZ0UN4BFmK2y8Sjs0k7mrLghU/xcL5N4kirjSHLp+f
         x/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xyYbiA8/Bb9wR0nwylYK4j8mDjr3B2+xdQa5Gkbgooc=;
        b=2Yhpm6r9UEQsZK1S1KgKbU+l3xoIMPdnmKckGxS3TCZl5/vIv+WTt9/JdwGBkN8/zy
         1GtnqXk7L4Cj8KpCi/S6N+wOSld9Cv2RpQXNiOs+RmzKNH0FNYHB/2HbfCDeqjnGNowi
         2zd0Y0IApZV1iM+Y1ZXcwWoCXp6RzJKtzQ9z9V/Ctk0vTV9ec2kUcilx/mrDGj3yNV2a
         EEllNQXifH+XFXZynA9lZCsMG3k1pKc4Swht33Y8JXueh9Wywjv/LI3ih5q+2SX2flZe
         5+8bvfdEP27PEggCaELDIhCEjdY2uNGDqt6ZQpkBPs5Hyn/QthY7UuP5uUj8K3EfgvS0
         FqaQ==
X-Gm-Message-State: AOAM532YPgU0cmSNKACubnUUcsQp/5Jch5jUc0Y1G/ehT2zhqY02/N58
        SdWtytcj8OglRi1B4yAPwSygH/O+NfB01Q==
X-Google-Smtp-Source: ABdhPJw4hqEN9fF/jlgdSn9VbnfxyQPgw3/k7vWxy/75ygVWsj0Aim7qlHAxTx9MgYxzCL+UcyQ/fg==
X-Received: by 2002:aa7:9429:0:b0:4e1:5814:79b3 with SMTP id y9-20020aa79429000000b004e1581479b3mr1449781pfo.82.1645685245761;
        Wed, 23 Feb 2022 22:47:25 -0800 (PST)
Received: from xavier.lan ([2001:470:b:114::cc1])
        by smtp.gmail.com with ESMTPSA id q26sm1425401pgt.67.2022.02.23.22.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 22:47:25 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com,
        pclouds@gmail.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v2] switch: mention the --detach option when dying due to lack of a branch
Date:   Wed, 23 Feb 2022 23:47:10 -0700
Message-Id: <20220224064710.2252637-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Users who are accustomed to doing `git checkout <tag>` assume that
`git switch <tag>` will do the same thing. Inform them of the --detach
option so they aren't left wondering why `git switch` doesn't work but
`git checkout` does.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
v2:
- Rephrase advice
- Print advice after error message
- Create a new config variable to suppress the advice
- Add tests
---
 Documentation/config/advice.txt |  3 +++
 advice.c                        |  1 +
 advice.h                        |  1 +
 builtin/checkout.c              | 30 +++++++++++++++++++-----------
 t/t2060-switch.sh               | 11 +++++++++++
 5 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
index adee26fbbb..c40eb09cb7 100644
--- a/Documentation/config/advice.txt
+++ b/Documentation/config/advice.txt
@@ -85,6 +85,9 @@ advice.*::
 		linkgit:git-switch[1] or linkgit:git-checkout[1]
 		to move to the detach HEAD state, to instruct how to
 		create a local branch after the fact.
+	suggestDetachingHead::
+		Advice shown when linkgit:git-switch[1] refuses to detach HEAD
+		without the explicit `--detach` option.
 	checkoutAmbiguousRemoteBranchName::
 		Advice shown when the argument to
 		linkgit:git-checkout[1] and linkgit:git-switch[1]
diff --git a/advice.c b/advice.c
index e00d30254c..2e1fd48304 100644
--- a/advice.c
+++ b/advice.c
@@ -42,6 +42,7 @@ static struct {
 	[ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME] 	= { "checkoutAmbiguousRemoteBranchName", 1 },
 	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge", 1 },
 	[ADVICE_DETACHED_HEAD]				= { "detachedHead", 1 },
+	[ADVICE_SUGGEST_DETACHING_HEAD]			= { "suggestDetachingHead", 1 },
 	[ADVICE_FETCH_SHOW_FORCED_UPDATES]		= { "fetchShowForcedUpdates", 1 },
 	[ADVICE_GRAFT_FILE_DEPRECATED]			= { "graftFileDeprecated", 1 },
 	[ADVICE_IGNORED_HOOK]				= { "ignoredHook", 1 },
diff --git a/advice.h b/advice.h
index a7521d6087..a3957123a1 100644
--- a/advice.h
+++ b/advice.h
@@ -20,6 +20,7 @@ struct string_list;
 	ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
 	ADVICE_COMMIT_BEFORE_MERGE,
 	ADVICE_DETACHED_HEAD,
+	ADVICE_SUGGEST_DETACHING_HEAD,
 	ADVICE_FETCH_SHOW_FORCED_UPDATES,
 	ADVICE_GRAFT_FILE_DEPRECATED,
 	ADVICE_IGNORED_HOOK,
diff --git a/builtin/checkout.c b/builtin/checkout.c
index d9b31bbb6d..9244827ca0 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1397,23 +1397,31 @@ static void die_expecting_a_branch(const struct branch_info *branch_info)
 {
 	struct object_id oid;
 	char *to_free;
+	int code;
 
 	if (dwim_ref(branch_info->name, strlen(branch_info->name), &oid, &to_free, 0) == 1) {
 		const char *ref = to_free;
 
 		if (skip_prefix(ref, "refs/tags/", &ref))
-			die(_("a branch is expected, got tag '%s'"), ref);
-		if (skip_prefix(ref, "refs/remotes/", &ref))
-			die(_("a branch is expected, got remote branch '%s'"), ref);
-		die(_("a branch is expected, got '%s'"), ref);
+			code = die_message(_("a branch is expected, got tag '%s'"), ref);
+		else if (skip_prefix(ref, "refs/remotes/", &ref))
+			code = die_message(_("a branch is expected, got remote branch '%s'"), ref);
+		else
+			code = die_message(_("a branch is expected, got '%s'"), ref);
 	}
-	if (branch_info->commit)
-		die(_("a branch is expected, got commit '%s'"), branch_info->name);
-	/*
-	 * This case should never happen because we already die() on
-	 * non-commit, but just in case.
-	 */
-	die(_("a branch is expected, got '%s'"), branch_info->name);
+	else if (branch_info->commit)
+		code = die_message(_("a branch is expected, got commit '%s'"), branch_info->name);
+	else
+		/*
+		 * This case should never happen because we already die() on
+		 * non-commit, but just in case.
+		 */
+		code = die_message(_("a branch is expected, got '%s'"), branch_info->name);
+
+	if (advice_enabled(ADVICE_SUGGEST_DETACHING_HEAD))
+		advise(_("If you want to detach HEAD at the commit, try again with the --detach option."));
+
+	exit(code);
 }
 
 static void die_if_some_operation_in_progress(void)
diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
index ebb961be29..f54691bac9 100755
--- a/t/t2060-switch.sh
+++ b/t/t2060-switch.sh
@@ -32,6 +32,17 @@ test_expect_success 'switch and detach' '
 	test_must_fail git symbolic-ref HEAD
 '
 
+test_expect_success 'suggestion to detach' '
+	test_must_fail git switch main^{commit} 2>stderr &&
+	test_i18ngrep "try again with the --detach option" stderr
+'
+
+test_expect_success 'suggestion to detach is suppressed with advice.suggestDetachingHead=false' '
+	test_config advice.suggestDetachingHead false &&
+	test_must_fail git switch main^{commit} 2>stderr &&
+	test_i18ngrep ! "try again with the --detach option" stderr
+'
+
 test_expect_success 'switch and detach current branch' '
 	test_when_finished git switch main &&
 	git switch main &&
-- 
2.35.1

