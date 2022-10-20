Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698CBC433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 20:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiJTUUu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 16:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJTUUr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 16:20:47 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2B41F0438
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 13:20:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i9so1157481wrv.5
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 13:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QpniONDadL29AE82dKO6yOtA6u25QaY32iuzyD4GJw=;
        b=gdf5JsPWQAe2q40D5LosQfkOjNMruKIb7axop/1PutrLaB4xkka+Tw7P9Sl3fuqzu6
         jII2VLNut8FGFrUAghEv/WaUblMpaONR7L8G67OijfhN3n7CG/kigBimO93QCGPvaj+G
         VrcUKdNpuhDkJWIqEnQIJXnaeIoTDEWKOx+64iISKlh101soSOn0dv0sQy2Qo/+aNLY9
         yjYg0r0MpPx8kD8APSKdGGyeJDzGUq448tJXPU3N5mFkvfFHRhuLSKSXTd7AjTQp1AiE
         5sDj05UAygCV1Iv7056obKM7tBvjZmaOk3R5EPAIoNPRw3tGLu1lRIOekl7rIP8do1Ml
         xzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/QpniONDadL29AE82dKO6yOtA6u25QaY32iuzyD4GJw=;
        b=g0PgQjT6zs2s7c6TALG5vn22CmmU9Hjk8AvyoAgYtQXx9YUHZa7IB22UgvxVNwThPg
         NTIib/EnLvMYg65v+BWeaKhyxTy0e+Ny9jJ122/ecMatEulVG5An/iQHWklsL1ztEeli
         Of6/Tmc24cOSYBMzcW0aziguyPlWu4jmKr55rbsvkbkSglndl175ehVLzQaeT4INwIeG
         4UvtwPyZfc7HrSvZo9ZnmT7cVVj5qYwCospDJJtnAySBlUhj4YtHhuS1RrN5oXbeDmK5
         QjA+r4oM53aJ0A/YcKYlPoSv5Yv91BS4EQanDux1sC4jdTbEa139a9OMW0dy/Dv98yjt
         8d/A==
X-Gm-Message-State: ACrzQf21Sr83SnTcfgY+2yeAgER+3sgBgOuG8IbsUZzS149Nuf/Bwv4I
        MxnRe2Wt47oopyCORZB6+kaBduM6PB4=
X-Google-Smtp-Source: AMsMyM7G3u1FjUmFF8N+nFqNahzuPszh815w0olcbEm4pr+UupHlfM0CoDDfZn8cROLzh4ZrOiD+mg==
X-Received: by 2002:a05:6000:1f04:b0:22e:5e0b:e1fb with SMTP id bv4-20020a0560001f0400b0022e5e0be1fbmr9413467wrb.222.1666297243094;
        Thu, 20 Oct 2022 13:20:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o5-20020a5d62c5000000b00228cbac7a25sm17549319wrv.64.2022.10.20.13.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 13:20:41 -0700 (PDT)
Message-Id: <432bc7cb3a42cf39d0033701c2cc677c9109b3dd.1666297239.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1321.v2.git.git.1666297238.gitgitgadget@gmail.com>
References: <pull.1321.git.git.1661806456.gitgitgadget@gmail.com>
        <pull.1321.v2.git.git.1666297238.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Oct 2022 20:20:32 +0000
Subject: [PATCH v2 1/7] clone: teach --detach option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Teach "git clone" the "--detach" option, which leaves the cloned repo in
detached HEAD (like "git checkout --detach"). In addition, if the clone
is not bare, do not create the local branch pointed to by the remote's
HEAD symref (bare clones always copy all remote branches directly to
local branches, so the branch is still created in the bare case).

This is especially useful in the "submodule.propagateBranches" workflow,
where local submodule branches are named after the superproject's
branches, so it makes no sense to create a local branch named after the
submodule's remote's branch.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 Documentation/git-clone.txt |  8 +++++++-
 builtin/clone.c             | 12 +++++++++---
 t/t5601-clone.sh            | 22 ++++++++++++++++++++++
 3 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index d6434d262d6..6a4e5d31b46 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 	  [--depth <depth>] [--[no-]single-branch] [--no-tags]
 	  [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
 	  [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--[no-]reject-shallow]
-	  [--filter=<filter> [--also-filter-submodules]] [--] <repository>
+	  [--filter=<filter> [--also-filter-submodules] [--detach]] [--] <repository>
 	  [<directory>]
 
 DESCRIPTION
@@ -210,6 +210,12 @@ objects from the source repository into a pack in the cloned repository.
 	`--branch` can also take tags and detaches the HEAD at that commit
 	in the resulting repository.
 
+--detach::
+	If the cloned repository's HEAD points to a branch, point the newly
+	created HEAD to the branch's commit instead of the branch itself.
+	Additionally, in a non-bare repository, the corresponding local branch
+	will not be created.
+
 -u <upload-pack>::
 --upload-pack <upload-pack>::
 	When given, and the repository to clone from is accessed
diff --git a/builtin/clone.c b/builtin/clone.c
index 547d6464b3c..e624d3f49a2 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -78,6 +78,7 @@ static int option_filter_submodules = -1;    /* unspecified */
 static int config_filter_submodules = -1;    /* unspecified */
 static struct string_list server_options = STRING_LIST_INIT_NODUP;
 static int option_remote_submodules;
+static int option_detach;
 static const char *bundle_uri;
 
 static int recurse_submodules_cb(const struct option *opt,
@@ -162,6 +163,8 @@ static struct option builtin_clone_options[] = {
 		    N_("any cloned submodules will use their remote-tracking branch")),
 	OPT_BOOL(0, "sparse", &option_sparse_checkout,
 		    N_("initialize sparse-checkout file to include only files at root")),
+	OPT_BOOL(0, "detach", &option_detach,
+		 N_("detach HEAD and don't create a local branch")),
 	OPT_STRING(0, "bundle-uri", &bundle_uri,
 		   N_("uri"), N_("a URI for downloading bundles before fetching from origin remote")),
 	OPT_END()
@@ -613,10 +616,12 @@ static void update_remote_refs(const struct ref *refs,
 }
 
 static void update_head(const struct ref *our, const struct ref *remote,
-			const char *unborn, const char *msg)
+			const char *unborn, int should_detach,
+			const char *msg)
 {
 	const char *head;
-	if (our && skip_prefix(our->name, "refs/heads/", &head)) {
+	if (our && !should_detach &&
+	    skip_prefix(our->name, "refs/heads/", &head)) {
 		/* Local default branch link */
 		if (create_symref("HEAD", our->name, NULL) < 0)
 			die(_("unable to update HEAD"));
@@ -1357,7 +1362,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			   branch_top.buf, reflog_msg.buf, transport,
 			   !is_local);
 
-	update_head(our_head_points_at, remote_head, unborn_head, reflog_msg.buf);
+	update_head(our_head_points_at, remote_head, unborn_head,
+		    option_detach, reflog_msg.buf);
 
 	/*
 	 * We want to show progress for recursive submodule clones iff
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 45f0803ed4d..418cfd54717 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -333,6 +333,28 @@ test_expect_success 'clone checking out a tag' '
 	test_cmp fetch.expected fetch.actual
 '
 
+test_expect_success '--detach detaches and does not create branch' '
+	test_when_finished "rm -fr dst" &&
+	git clone --detach src dst &&
+	(
+		cd dst &&
+		test_must_fail git rev-parse main &&
+		test_must_fail git symbolic-ref HEAD &&
+		test_cmp_rev HEAD refs/remotes/origin/HEAD
+	)
+'
+
+test_expect_success '--detach with --bare detaches but creates branch' '
+	test_when_finished "rm -fr dst" &&
+	git clone --bare --detach src dst &&
+	(
+		cd dst &&
+		git rev-parse main &&
+		test_must_fail git symbolic-ref HEAD &&
+		test_cmp_rev HEAD refs/heads/main
+	)
+'
+
 test_expect_success 'set up ssh wrapper' '
 	cp "$GIT_BUILD_DIR/t/helper/test-fake-ssh$X" \
 		"$TRASH_DIRECTORY/ssh$X" &&
-- 
gitgitgadget

