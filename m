Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723BFC38A02
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 20:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiJ1UPM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 16:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJ1UPE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 16:15:04 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB643056B
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 13:15:02 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id g12so7957645wrs.10
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 13:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zk9/n3/N//VgzIqPESF7GvZyvogEh/1TnpqyiDw4ZZA=;
        b=aiVMifbY5EMVGRKYGlbB4DpXDnjaezBT04tRkmrq5kHg35eXQk3azeOnHMJLI4bRw6
         N1+1zwN8s+v8ITrSAGG3iyjSxUxN/NslTwl0bkezQoqI9Y9qNCu1Lv7S6tE8PUGFW30Q
         x0zMcXAdyTosqSZYYugVRu8HJEP2f58KA1UbuzOg6V29FTAHsqiMN8gTgp5H38ZG/aVl
         HgPEPhMFyl0JHw6+hcqKTWm9wbPwwwWFxJLrPdBbb0QFu5sv7slVIJdFEkkKeAEoIN+R
         YZWik0sLQpMLrOpYK7ofZtlKj7Kk/ZRRLDPHpai6K55bx2U57jROBlXsxx9tcO+65O8A
         IXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zk9/n3/N//VgzIqPESF7GvZyvogEh/1TnpqyiDw4ZZA=;
        b=N3vJsqox/6rhi1750jTaju19U74hr/wtfelPE18RECPI6nWB7lZTfgAixAAzYrJz1N
         OICSetVvNnP0r2otjHwatWHfEioDjZjD6oSXjoBOcgKUPEQ6nJtLKoCAnhMWPt5j1mln
         PXuGPbcljTLfLSjYRfMGMq3WAAsGL4tzNYByT5I+/SzLBU3EDVJP1OF1ZdnlfoELsWDI
         yhESOJHqM0nmaDUURtg02yiePWWc4TFD0W0w/bYzD9ki/+2rgA11c1RrZipc6DTNfdyt
         Zh1URBfpLGctmo3zHoG1bOkTyuu0kbiZWyneHVnfiT6hu+1hcK9/HzXMP2jrxvVrGDWN
         +KbA==
X-Gm-Message-State: ACrzQf0DSjDsQfo3NzGUUHL+OIqEfVPC3MQ3c3Yvw5cwIZK/jN2O08mX
        3CpHVwks03aX+mdngc8UNfCLSGDA60k=
X-Google-Smtp-Source: AMsMyM46MHFM7o0WzZk+YEMsjEiEZd9n5V0iAXqraJBWcnBHcUUxtM8YRnlCDN6C2VvFlZLViQOrHA==
X-Received: by 2002:adf:e405:0:b0:236:6e0d:6ed2 with SMTP id g5-20020adfe405000000b002366e0d6ed2mr610762wrm.338.1666988100951;
        Fri, 28 Oct 2022 13:15:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n16-20020a1c7210000000b003c6deb5c1edsm5121617wmc.45.2022.10.28.13.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 13:15:00 -0700 (PDT)
Message-Id: <5a24d7e9255de407e343ce8bd60edb63293505bb.1666988096.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1321.v3.git.git.1666988096.gitgitgadget@gmail.com>
References: <pull.1321.v2.git.git.1666297238.gitgitgadget@gmail.com>
        <pull.1321.v3.git.git.1666988096.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 28 Oct 2022 20:14:51 +0000
Subject: [PATCH v3 3/8] submodule--helper clone: create named branch
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

This functionality will be tested in a later commit where "git submodule
update" uses it to create and check out the correct branch when
submodule branching is enabled. "git submodule add" (which also invokes
"git submodule--helper clone") should also do something similar when
submodule branching is enabled, but this is left for a later series.

Arguably, "--detach" should also be the default for
"submodule.propagateBranches=false" since it doesn't make sense to
create a submodule branch when the submodule is always expected to be in
detached HEAD. But, to be conservative, this commit does not change the
behavior of "submodule.propagateBranches=false".

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 0b4acb442b2..c974206cad4 100644
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
@@ -1802,6 +1829,12 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_submodule_helper_usage,
 				   module_clone_options);
 
+	if (!!clone_data.branch != !!clone_data.branch_oid)
+		BUG("--branch and --branch-oid must be set/unset together");
+	if ((clone_data.branch &&
+	     !the_repository->settings.submodule_propagate_branches))
+		BUG("--branch is only expected with submodule.propagateBranches");
+
 	clone_submodule(&clone_data, &reference);
 	list_objects_filter_release(&filter_options);
 	string_list_clear(&reference, 1);
-- 
gitgitgadget

