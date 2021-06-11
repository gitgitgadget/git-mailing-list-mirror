Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFC7C48BD1
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 22:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EEC0613DF
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 22:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhFKW4u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 18:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhFKW4t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 18:56:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C737C0613A2
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 15:54:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j190-20020a253cc70000b029054c72781aa2so5014700yba.9
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 15:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3IxDtWA6ByJxnRZ+gtO9fxE4iYaPRZEZ1uXikqz+6rE=;
        b=wTC/IaplmPMxRhK3PYgxrTQcInlr048mnaJQ95vSia0RprwoMKnlXD2G3whP23gz4O
         8I+WJcANd4x169Pjv72MSzIzSvWGFgGjKs1eChJmsC50qt6enEWXBSVIj9jXjSspYw3V
         p9EYxFH4/+hmkAUXhIciNte3mS2UjECWwleiqpevIGcv3VhynYh/Lg4I5DwgT68LZX+I
         fZGL+QAOhUGD+YKSHZCRyg0rXHFVJJO3cQaqQ98oleD3u6uWAuvY4xAUk+MWcEUQwOy4
         mc+oPv77UvlH7reQc7vYZGFknP1gYsMFBOzyVbwqte4cocZpmBbGY9HKsvnrU2de5Z2i
         PlBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3IxDtWA6ByJxnRZ+gtO9fxE4iYaPRZEZ1uXikqz+6rE=;
        b=OrrjQlgSkUZMrR6Zabxhn2EijcSUVno/BFd0PoYlUP/u7PXhF61gmB4/VYC3wA8Sow
         AiIDUnwpBqbAFhWrRfgC07ctYVzvNTi1YYZUAo/KGIUapE+sO2f54CNijhyYmVK/vKR2
         8cdC+n9uxa5vUw6ZaGALANd/GpK5iq9N5xVxBhrQ/+SQkF2B4FvhyrYfb+vi+cofpk6B
         CAg49geKY/bALIhyg1xBatW0MfThbIWlHTJKEhGn/uhtVs4WC4P0mkO1dhkR+DC6oo/D
         dFlRwety2V7AP55ooreg34Ije8fpSUSjiInxTAzN9QHj0QdtkPgr9g+jxI61nQYO9ld5
         U1YA==
X-Gm-Message-State: AOAM531ePC0yyfW22NjcaLzXjfwaup3PUiGNbueRdohTebNlLUFumQxY
        prX78ex/8NNm1O6QaQBYZ/M8jAK3LD1EC7qdFIUpVlIT7DPVDvhzH3tMXGAqL3IndV3sFbsDvW6
        g56UzgaD0brGSPSRq7irTQfKrr/3uw2rzuKLwoLtR3elculFCUkIzrjMB/BEfynhknum8vtANnQ
        ==
X-Google-Smtp-Source: ABdhPJzHXC9yKVldY45hg05kwGnpEco68bcRe2DN0X7G0d5DKJTTYna2FFgIk7eXhpEKgYjzK/DAZXxgTo2Ea9PegKg=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:c894:862c:2364:ff78])
 (user=emilyshaffer job=sendgmr) by 2002:a25:31c3:: with SMTP id
 x186mr8036327ybx.382.1623452079246; Fri, 11 Jun 2021 15:54:39 -0700 (PDT)
Date:   Fri, 11 Jun 2021 15:54:26 -0700
In-Reply-To: <20210611225428.1208973-1-emilyshaffer@google.com>
Message-Id: <20210611225428.1208973-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210611225428.1208973-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [RFC PATCH 2/4] introduce submodule.superprojectGitDir cache
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach submodules a reference to their superproject's gitdir. This allows
us to A) know that we're running from a submodule, and B) have a
shortcut to the superproject's vitals, for example, configs.

By using a relative path instead of an absolute path, we can move the
superproject directory around on the filesystem without breaking the
submodule's cache.

Since this cached value is only introduced during new submodule creation
via `git submodule add`, though, there is more work to do to allow the
cache to be created at other times.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 builtin/submodule--helper.c |  4 ++++
 t/t7400-submodule-basic.sh  | 40 ++++++++++++++++++++-----------------
 2 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 9d505a6329..3d6fd54c9b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1909,6 +1909,10 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		git_config_set_in_file(p, "submodule.alternateErrorStrategy",
 					   error_strategy);
 
+	git_config_set_in_file(p, "submodule.superprojectGitdir",
+			       relative_path(absolute_path(get_git_dir()),
+					     path, &sb));
+
 	free(sm_alternate);
 	free(error_strategy);
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index f5dc051a6e..e45f42588f 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -108,14 +108,18 @@ test_expect_success 'setup - repository to add submodules to' '
 submodurl=$(pwd -P)
 
 inspect() {
-	dir=$1 &&
-
-	git -C "$dir" for-each-ref --format='%(refname)' 'refs/heads/*' >heads &&
-	{ git -C "$dir" symbolic-ref HEAD || :; } >head &&
-	git -C "$dir" rev-parse HEAD >head-sha1 &&
-	git -C "$dir" update-index --refresh &&
-	git -C "$dir" diff-files --exit-code &&
-	git -C "$dir" clean -n -d -x >untracked
+	sub_dir=$1 &&
+	super_dir=$2 &&
+
+	git -C "$sub_dir" for-each-ref --format='%(refname)' 'refs/heads/*' >heads &&
+	{ git -C "$sub_dir" symbolic-ref HEAD || :; } >head &&
+	git -C "$sub_dir" rev-parse HEAD >head-sha1 &&
+	git -C "$sub_dir" update-index --refresh &&
+	git -C "$sub_dir" diff-files --exit-code &&
+	cached_super_dir="$(git -C "$sub_dir" config --get submodule.superprojectGitDir)" &&
+	[ "$(git -C "$super_dir" rev-parse --absolute-git-dir)" \
+		-ef "$sub_dir/$cached_super_dir" ] &&
+	git -C "$sub_dir" clean -n -d -x >untracked
 }
 
 
@@ -139,7 +143,7 @@ test_expect_success 'submodule add' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/submod &&
+	inspect addtest/submod addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -230,7 +234,7 @@ test_expect_success 'submodule add --branch' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/submod-branch &&
+	inspect addtest/submod-branch addtest &&
 	test_cmp expect-heads heads &&
 	test_cmp expect-head head &&
 	test_must_be_empty untracked
@@ -246,7 +250,7 @@ test_expect_success 'submodule add with ./ in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/dotsubmod/frotz &&
+	inspect addtest/dotsubmod/frotz addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -262,7 +266,7 @@ test_expect_success 'submodule add with /././ in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/dotslashdotsubmod/frotz &&
+	inspect addtest/dotslashdotsubmod/frotz addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -278,7 +282,7 @@ test_expect_success 'submodule add with // in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/slashslashsubmod/frotz &&
+	inspect addtest/slashslashsubmod/frotz addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -294,7 +298,7 @@ test_expect_success 'submodule add with /.. in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod &&
+	inspect addtest/realsubmod addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -310,7 +314,7 @@ test_expect_success 'submodule add with ./, /.. and // in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod2 &&
+	inspect addtest/realsubmod2 addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -341,7 +345,7 @@ test_expect_success 'submodule add in subdirectory' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod3 &&
+	inspect addtest/realsubmod3 addtest &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -482,7 +486,7 @@ test_expect_success 'update should work when path is an empty dir' '
 	git submodule update -q >update.out &&
 	test_must_be_empty update.out &&
 
-	inspect init &&
+	inspect init . &&
 	test_cmp expect head-sha1
 '
 
@@ -541,7 +545,7 @@ test_expect_success 'update should checkout rev1' '
 	echo "$rev1" >expect &&
 
 	git submodule update init &&
-	inspect init &&
+	inspect init . &&
 
 	test_cmp expect head-sha1
 '
-- 
2.32.0.272.g935e593368-goog

