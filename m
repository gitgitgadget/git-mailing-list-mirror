Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7A0C433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 20:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiJTUUy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 16:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiJTUUs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 16:20:48 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE0D1F0439
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 13:20:47 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bp11so957989wrb.9
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 13:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbNIbJt4seS/lviG3MQ8OZqWiqRLSxNNEzvoHb/B5ro=;
        b=efXAI+3bOJL/iWANjU5uhATmJKn707jzBOEzLGiZ4zKfK8sm2puv1/i/ez5kgg4SQc
         PFNHWUNYPvGH3ahTSQgdZuEWbtZbsoVZIVnumIFLDAlOKWRnFiW+JWy0/OShMW7JbmSR
         xumFd+KE5X7vwfTgh5/Qbtq3pKog4ReQ3BjJAWp1g8j+KO06CkMyT6lo/DuC6rsjXzK0
         oZS4oDMROvKXXt58VkqiH1mHu7A+PG2s2KU0UzZ0Uh/7man3y9wHc2vGob0tLML1fFvW
         GeZg97iXVyy5kc7F50M68VuZdVwDZKgLZSn4l2VPEfh+V4203KnCYBZMMRyHX0CQ4nOB
         SkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbNIbJt4seS/lviG3MQ8OZqWiqRLSxNNEzvoHb/B5ro=;
        b=wQ0DpWpaFzuvWSS2EUz0PQOoT9LTqG7MMRuLcVRHmdxyrTWIJMrG1mLi/E7AAieB5O
         rIOTHlLTvyJWlGuIu5phGzJrxkqfVuZo6B1xzeHJWAx+zwFWO4rgECP5/Q6YeJhNcolx
         1Nb7PyfluxXGc62MNlBYM5GEFqFMgP9gL91LH4gS3yQq8nkR1QhWnIlR/yYvmDy/bu/W
         tB76M3368Q2lB/+j8CxQXmtVXlhZoE+YvF0Z7hALAfVIxcJ2TtfMnTo4BQTQs8sIYJ8H
         ChDyftMx34LdjEOg0rxBllRoXN4wBB/715pTyCv9rTb30Bw53KeBdDLCsMEouKh6vIHj
         aRZw==
X-Gm-Message-State: ACrzQf3OMwaGAQHpXIiU1133C7gqTR3i7XJqOOL3H8X7O4H7EsZW58XQ
        cfvY/NaHQQBcBrn+RZFe6Q9nGIlXKb8=
X-Google-Smtp-Source: AMsMyM5KQpMpEpXn6LiSVEjnMgBTSDxR1kwfIPvJ8ggUUnyuqQJVOMj+mP/y+JN75QRT1zPS/U+5Wg==
X-Received: by 2002:a5d:6dab:0:b0:231:3a49:3079 with SMTP id u11-20020a5d6dab000000b002313a493079mr9680440wrs.148.1666297245336;
        Thu, 20 Oct 2022 13:20:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c5-20020a05600c0a4500b003bdd2add8fcsm785075wmq.24.2022.10.20.13.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 13:20:44 -0700 (PDT)
Message-Id: <a4056e200eda9958efe77801b39bdebfdc1497a2.1666297239.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1321.v2.git.git.1666297238.gitgitgadget@gmail.com>
References: <pull.1321.git.git.1661806456.gitgitgadget@gmail.com>
        <pull.1321.v2.git.git.1666297238.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Oct 2022 20:20:34 +0000
Subject: [PATCH v2 3/7] submodule--helper clone: create named branch
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

When submodule branching is enabled (i.e. "submodule.propagateBranches =
true"), submodules are expected to have the same set of branches as the
superproject. To support this behavior in newly cloned submodules, teach
"git submodule--helper clone" to:

- clone with the "--detach" flag (so that the submodule doesn't create a
  branch corresponding to the remote's HEAD)
- create a branch when using the --branch and --branch-oid flags

The --branch and --branch-oid flags are only allowed when submodule
branching is enabled, otherwise the named branch might conflict with the
branch from the submodule remote's HEAD.

These flags will be used by `git submodule update` in a later commit.
"git submodule add" (which also invokes "git submodule--helper clone")
should also do something similar when submodule branching is enabled,
but this is left for a later series.

Arguably, "--detach" should also be the default for
"submodule.propagateBranches=false" since it doesn't make sense to
create a submodule branch when the submodule is always expected to be in
detached HEAD. But, to be conservative, this commit does not change the
behavior of "submodule.propagateBranches=false".

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 0b4acb442b2..1ce3458a29c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1503,6 +1503,8 @@ struct module_clone_data {
 	const char *name;
 	const char *url;
 	const char *depth;
+	const char *branch;
+	const char *branch_oid;
 	struct list_objects_filter_options *filter_options;
 	unsigned int quiet: 1;
 	unsigned int progress: 1;
@@ -1692,6 +1694,8 @@ static int clone_submodule(const struct module_clone_data *clone_data,
 			strvec_push(&cp.args, clone_data->single_branch ?
 				    "--single-branch" :
 				    "--no-single-branch");
+		if (the_repository->settings.submodule_propagate_branches)
+			strvec_push(&cp.args, "--detach");
 
 		strvec_push(&cp.args, "--");
 		strvec_push(&cp.args, clone_data->url);
@@ -1704,6 +1708,21 @@ static int clone_submodule(const struct module_clone_data *clone_data,
 		if(run_command(&cp))
 			die(_("clone of '%s' into submodule path '%s' failed"),
 			    clone_data->url, clone_data_path);
+
+		if (clone_data->branch) {
+			struct child_process branch_cp = CHILD_PROCESS_INIT;
+
+			branch_cp.git_cmd = 1;
+			prepare_other_repo_env(&branch_cp.env, sm_gitdir);
+
+			strvec_pushl(&branch_cp.args, "branch",
+				     clone_data->branch, clone_data->branch_oid,
+				     NULL);
+
+			if (run_command(&branch_cp))
+				die(_("could not create branch '%s' in submodule path '%s'"),
+				    clone_data->branch, clone_data_path);
+		}
 	} else {
 		char *path;
 
@@ -1778,6 +1797,12 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 			   N_("disallow cloning into non-empty directory")),
 		OPT_BOOL(0, "single-branch", &clone_data.single_branch,
 			 N_("clone only one branch, HEAD or --branch")),
+		OPT_STRING(0, "branch", &clone_data.branch,
+			   N_("string"),
+			   N_("name of branch to be created")),
+		OPT_STRING(0, "branch-oid", &clone_data.branch_oid,
+			   N_("object-id"),
+			   N_("commit id for new branch")),
 		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
 		OPT_END()
 	};
@@ -1785,12 +1810,14 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		N_("git submodule--helper clone [--prefix=<path>] [--quiet] "
 		   "[--reference <repository>] [--name <name>] [--depth <depth>] "
 		   "[--single-branch] [--filter <filter-spec>] "
+		   "[--branch <branch> --branch-oid <oid>]"
 		   "--url <url> --path <path>"),
 		NULL
 	};
 
 	argc = parse_options(argc, argv, prefix, module_clone_options,
 			     git_submodule_helper_usage, 0);
+	prepare_repo_settings(the_repository);
 
 	clone_data.dissociate = !!dissociate;
 	clone_data.quiet = !!quiet;
@@ -1798,9 +1825,13 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	clone_data.require_init = !!require_init;
 	clone_data.filter_options = &filter_options;
 
-	if (argc || !clone_data.url || !clone_data.path || !*(clone_data.path))
+	if (argc || !clone_data.url || !clone_data.path || !*(clone_data.path)
+	    || (!!clone_data.branch != !!clone_data.branch_oid))
 		usage_with_options(git_submodule_helper_usage,
 				   module_clone_options);
+	if ((clone_data.branch &&
+	     !the_repository->settings.submodule_propagate_branches))
+		BUG("--branch is only expected with submodule.propagateBranches");
 
 	clone_submodule(&clone_data, &reference);
 	list_objects_filter_release(&filter_options);
-- 
gitgitgadget

