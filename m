Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016DFC433F5
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 20:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF65861151
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 20:34:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhJNUgo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 16:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbhJNUgm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 16:36:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C34EC061755
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 13:34:37 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i83-20020a252256000000b005b67a878f56so2028090ybi.17
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 13:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EKLa1BbpT8qQs7NTfceOdKmh57l3JvJT2UwkBs9U6sc=;
        b=Nx2mS3oo7/BgBqRL2ctdJLBYLoSWx4Gb60LGl8KmypFntp6YKTy8QjzbGn4b6gbQvM
         s/Ikl5f6ndm6bT/LVFPozd8E8V0gMmULcsnMsC8g790B+B7LFtnG0LtLe/a+Ti9NTgx+
         aCQk1TVv+U+I5R/tTQBT0BQ9fgLoZmQ9+uByREHHTCkR+uLf87zSYK+yvSpVrBfiXk9X
         HbOo5HqNw4rYJUCI+c0FX72e1hO3KQ2Jet/hBo9MrplnBZi89dbm5RSNxQIOquUrl4wB
         QXn5kyPAlmIvJNhYjcDrTuUu6l3lqD1EpVS+eHf/H2M38icHps0F3qRkuya+uqtaOzLS
         H0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EKLa1BbpT8qQs7NTfceOdKmh57l3JvJT2UwkBs9U6sc=;
        b=jAMxiros8ybVb0Z27tJbxqIId56KsUATz9/GbcHsyVuBl/EDiQfafNHhyZtb32Hp3Q
         GayxdgDMvgsT5/sIQjEK+lJMxJww1qqU8oou3WZQ5skgy1oUyockhltPBlk/tSOPvezH
         Iq+iRaDsoYcQBAfTUR51n2859EiB2Vf+mTSeQZEV9Q8kspE4ersEdvl5Qc9HVjJAXoP0
         2ymJVJxhTLYvl1a0hERAoNznNOCScbMQjgYsoInOhfk4FpbXp30OopxanwfTX0hpof3n
         vDRsQcRiuZgOUN4l606UJ/iz1jt8uGC1LCjnXKBg5M+QCOPem00jTxCnrkPDph9G1HuL
         s78g==
X-Gm-Message-State: AOAM532zN3/sP28nVo5bvH4KusxRa6seiqi64KDebXlErisfAiCszk86
        IGFJNiPXeNDnm3u+HTCM+zvVg33a9nhNehFXuSUZ9UGHBXSyvRVe4LcDJoeia8yqBifvK/Fyjv1
        07suC/yZuosDq0du0f0xTkRGtic6eBxgBr7itnOqb8CMwm8Y/6xP2fvOY2WFsgO4XGYK7rHOF9g
        ==
X-Google-Smtp-Source: ABdhPJzkzXZUDPJxCQS2tD4OBolppLOWLwJr/qP5zAnC9rAuw/xoZk+2EInRv4HZ5pBodz+kfBYhU+LJIstQKLJHmfo=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:e9ae:673a:ec5:a064])
 (user=emilyshaffer job=sendgmr) by 2002:a25:c6c9:: with SMTP id
 k192mr9314127ybf.409.1634243676631; Thu, 14 Oct 2021 13:34:36 -0700 (PDT)
Date:   Thu, 14 Oct 2021 13:34:14 -0700
In-Reply-To: <20211014203416.2802639-1-emilyshaffer@google.com>
Message-Id: <20211014203416.2802639-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20211014203416.2802639-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v4 2/4] introduce submodule.superprojectGitDir record
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach submodules a reference to their superproject's gitdir. This allows
us to A) know that we're running from a submodule, and B) have a
shortcut to the superproject's vitals, for example, configs.

By using a relative path instead of an absolute path, we can move the
superproject directory around on the filesystem without breaking the
submodule's cache. And by using the path from gitdir to gitdir, we can
move the submodule within the superproject's tree structure without
breaking the submodule's cache, too.

Since this hint value is only introduced during new submodule creation
via `git submodule add`, though, there is more work to do to allow the
record to be created at other times.

If the new config is present, we can do some optional value-added
behavior, like letting "git status" print additional info about the
submodule's status in relation to its superproject, or like letting the
superproject and submodule share an additional config file separate from
either one's local config.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/submodule.txt | 12 +++++++++++
 builtin/submodule--helper.c        |  4 ++++
 t/t7400-submodule-basic.sh         | 32 ++++++++++++++++++++----------
 3 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
index ee454f8126..c10aeb7fdc 100644
--- a/Documentation/config/submodule.txt
+++ b/Documentation/config/submodule.txt
@@ -91,3 +91,15 @@ submodule.alternateErrorStrategy::
 	`ignore`, `info`, `die`. Default is `die`. Note that if set to `ignore`
 	or `info`, and if there is an error with the computed alternate, the
 	clone proceeds as if no alternate was specified.
+
+submodule.superprojectGitDir::
+	The relative path from the submodule's gitdir to its superproject's
+	gitdir. When Git is run in a repository, it usually makes no difference
+	whether this repository is standalone or a submodule, but if this
+	configuration variable is present, additional behavior may be possible,
+	such as "git status" printing additional information about this
+	submodule's status with respect to its superproject. This config should
+	only be present in projects which are submodules, but is not guaranteed
+	to be present in every submodule, so only optional value-added behavior
+	should be linked to it. It is set automatically during
+	submodule creation.
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d574d650af..338dcbd364 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1838,6 +1838,10 @@ static int clone_submodule(struct module_clone_data *clone_data)
 		git_config_set_in_file(p, "submodule.alternateErrorStrategy",
 				       error_strategy);
 
+	git_config_set_in_file(p, "submodule.superprojectGitdir",
+			       relative_path(absolute_path(get_git_dir()),
+					     sm_gitdir, &sb));
+
 	free(sm_alternate);
 	free(error_strategy);
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index d69a5c0032..3d146491df 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -109,12 +109,24 @@ submodurl=$(pwd -P)
 
 inspect() {
 	sub_dir=$1 &&
+	super_dir=$2 &&
 
 	git -C "$sub_dir" for-each-ref --format='%(refname)' 'refs/heads/*' >heads &&
 	{ git -C "$sub_dir" symbolic-ref HEAD || :; } >head &&
 	git -C "$sub_dir" rev-parse HEAD >head-sha1 &&
 	git -C "$sub_dir" update-index --refresh &&
 	git -C "$sub_dir" diff-files --exit-code &&
+
+	# Ensure that submodule.superprojectGitDir contains the path from the
+	# submodule's gitdir to the superproject's gitdir.
+
+	super_abs_gitdir=$(git -C "$super_dir" rev-parse --absolute-git-dir) &&
+	sub_abs_gitdir=$(git -C "$sub_dir" rev-parse --absolute-git-dir) &&
+
+	[ "$(git -C "$sub_dir" config --get submodule.superprojectGitDir)" = \
+	  "$(test-tool path-utils relative_path "$super_abs_gitdir" \
+						"$sub_abs_gitdir")" ] &&
+
 	git -C "$sub_dir" clean -n -d -x >untracked
 }
 
@@ -138,7 +150,7 @@ test_expect_success 'submodule add' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/submod &&
+	inspect addtest/submod addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -240,7 +252,7 @@ test_expect_success 'submodule add --branch' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/submod-branch &&
+	inspect addtest/submod-branch addtest &&
 	test_cmp expect-heads heads &&
 	test_cmp expect-head head &&
 	test_must_be_empty untracked
@@ -256,7 +268,7 @@ test_expect_success 'submodule add with ./ in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/dotsubmod/frotz &&
+	inspect addtest/dotsubmod/frotz addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -272,7 +284,7 @@ test_expect_success 'submodule add with /././ in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/dotslashdotsubmod/frotz &&
+	inspect addtest/dotslashdotsubmod/frotz addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -288,7 +300,7 @@ test_expect_success 'submodule add with // in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/slashslashsubmod/frotz &&
+	inspect addtest/slashslashsubmod/frotz addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -304,7 +316,7 @@ test_expect_success 'submodule add with /.. in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod &&
+	inspect addtest/realsubmod addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -320,7 +332,7 @@ test_expect_success 'submodule add with ./, /.. and // in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod2 &&
+	inspect addtest/realsubmod2 addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -351,7 +363,7 @@ test_expect_success 'submodule add in subdirectory' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod3 &&
+	inspect addtest/realsubmod3 addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -492,7 +504,7 @@ test_expect_success 'update should work when path is an empty dir' '
 	git submodule update -q >update.out &&
 	test_must_be_empty update.out &&
 
-	inspect init &&
+	inspect init . &&
 	test_cmp expect head-sha1
 '
 
@@ -551,7 +563,7 @@ test_expect_success 'update should checkout rev1' '
 	echo "$rev1" >expect &&
 
 	git submodule update init &&
-	inspect init &&
+	inspect init . &&
 
 	test_cmp expect head-sha1
 '
-- 
2.33.0.1079.g6e70778dc9-goog

