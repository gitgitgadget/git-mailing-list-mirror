Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850EFC38BF9
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 23:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317F52082F
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 23:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJui+42R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgBXXGl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 18:06:41 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:32811 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgBXXGl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 18:06:41 -0500
Received: by mail-wr1-f44.google.com with SMTP id u6so12468817wrt.0
        for <git@vger.kernel.org>; Mon, 24 Feb 2020 15:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=zcxBYz8YQ+yH7WAnjelR1U2lD6DAat6f3zWLrlbd85s=;
        b=XJui+42RmMOi3oxROWQX8w/3g+GFRXjSMHxAjIm0aNAll/WJ/vGxu9a2ZAyMq9Qfa7
         uh7Vz4CG7NnnHiJPslS+B4PTP9gwhIqneL2xFpeD58ONh6beg1tNGPash/GhnuOFML4O
         xZtDx3muLN3iOis2DNpn+DHQ8GZeCAP2SeduxEF/fvHLRQ3rm+Fx94n+p/9EeEPbf/hq
         ayTWK5COUW/qinb+dsy+2vGv5PIZ3LxbeYhUT2c3NSis2qhutt5qb1INQzDG+6B94voU
         E1kKh2KTOdnb4WlJYv3azvO8JN6aGg4Qa+srf0B1yiaJzQ5as3ell6CJNgNoaEzPSbSr
         XXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=zcxBYz8YQ+yH7WAnjelR1U2lD6DAat6f3zWLrlbd85s=;
        b=jWFA4i5HZkIixgWbCwWg0hm2eau/WU8KRRw0pqtcz5YagiOtfRDNI8ezPU3FjZIrB3
         a1cUAdVF+d0b3VcOxDTAFFCsxK0nuQpMCfkRYYdUDnvlnIHQdlMenhXsrokC+nbRJF+9
         39C+6nReRCUoRPa5nYNS5UiLMrZllDZlcEUajTryqHnp6UnWNPV3q5eNXUwB3tkhRfAi
         3heNwGPq75EdLYyGPII2iWXdWVjtcVVS8Ot4sheuUs/mIndeeTvPU2Z1f/10avKgDmBR
         4SvKleKlsthf82S3gEGuoIt5tnPL1iA3jbNNCN2eCwv0US1CrWQFsoPO2dwEZeDBsLsN
         SXeQ==
X-Gm-Message-State: APjAAAWAkM/WWp5ijmg8KI/KoTwklNmP4vzZsQASEKdOK0ex5K/LKFXi
        1D7XiXPHCwX0w5/Q//FMKED87hR6
X-Google-Smtp-Source: APXvYqx6vOeH4syzuuqBBAxI+cxvb+IL8rdw4ELmOBzTftHj+iJg1zqa3BVquVrXQFilqhS1IvvCNA==
X-Received: by 2002:adf:f401:: with SMTP id g1mr67710418wro.129.1582585596528;
        Mon, 24 Feb 2020 15:06:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q14sm21277455wrj.81.2020.02.24.15.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 15:06:36 -0800 (PST)
Message-Id: <pull.695.v3.git.git.1582585595108.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.v2.git.git.1580851963616.gitgitgadget@gmail.com>
References: <pull.695.v2.git.git.1580851963616.gitgitgadget@gmail.com>
From:   "Markus Klein via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Feb 2020 23:06:34 +0000
Subject: [PATCH v3] clone: use submodule.recurse option for automatically
 clone submodules
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Markus Klein <masmiseim@gmx.de>, Markus Klein <masmiseim@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Markus Klein <masmiseim@gmx.de>

Simplify cloning repositories with submodules when the option
submodule.recurse is set by the user. This makes it transparent to the
user if submodules are used. The user doesn’t have to know if he has to add
an extra parameter to get the full project including the used submodules.
This makes clone behave identical to other commands like fetch, pull,
checkout, ... which include the submodules automatically if this option is
set.

It is implemented analog to the pull command by using an own config
function instead of using just the default config. In contrast to the pull
command, the submodule.recurse state is saved in addition as an array of
strings as it can take an optionally pathspec argument which describes
which submodules should be recursively initialized and cloned. To
recursively initialize and clone all submodules a pathspec of "." has to
be used.
The regression test is simplified compared to the test for "git clone
--recursive" as the general functionality is already checked there.

Signed-off-by: Markus Klein <masmiseim@gmx.de>
---
    Add the usage of the submodules.recurse parameter on clone
    
    This adds the usage of the submodule.recurse parameter on clone
    
    Changes since v1:
    
     * Fixed the commit author to match the Signed-off-by line
    
    Changes since v2:
    
     * Added additional regression tests for checking the
       --no-recurse-submodules parameter
     * fixed not working --no-recurse-submodules parameter when
       submodule.recurse option is set
     * fixed invalid setting of “true” to the pathspec

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-695%2FMasmiseim36%2Fdev%2FCloneWithSubmodule-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-695/Masmiseim36/dev/CloneWithSubmodule-v3
Pull-Request: https://github.com/git/git/pull/695

Range-diff vs v2:

 1:  c75835268a2 ! 1:  f71ca264885 clone: use submodules.recurse option for automatically clone submodules
     @@ -1,9 +1,9 @@
      Author: Markus Klein <masmiseim@gmx.de>
      
     -    clone: use submodules.recurse option for automatically clone submodules
     +    clone: use submodule.recurse option for automatically clone submodules
      
          Simplify cloning repositories with submodules when the option
     -    submodules.recurse is set by the user. This makes it transparent to the
     +    submodule.recurse is set by the user. This makes it transparent to the
          user if submodules are used. The user doesn’t have to know if he has to add
          an extra parameter to get the full project including the used submodules.
          This makes clone behave identical to other commands like fetch, pull,
     @@ -12,16 +12,14 @@
      
          It is implemented analog to the pull command by using an own config
          function instead of using just the default config. In contrast to the pull
     -    command, the submodule.recurse state is saved as an array of strings as it
     -    can take an optionally pathspec argument which describes which submodules
     -    should be recursively initialized and cloned. To recursively initialize and
     -    clone all submodules a pathspec of "." has to be used.
     +    command, the submodule.recurse state is saved in addition as an array of
     +    strings as it can take an optionally pathspec argument which describes
     +    which submodules should be recursively initialized and cloned. To
     +    recursively initialize and clone all submodules a pathspec of "." has to
     +    be used.
          The regression test is simplified compared to the test for "git clone
          --recursive" as the general functionality is already checked there.
      
     -    Changes since v1:
     -    * Fixed the commit author to match the Signed-off-by line
     -
          Signed-off-by: Markus Klein <masmiseim@gmx.de>
      
       diff --git a/builtin/clone.c b/builtin/clone.c
     @@ -36,17 +34,156 @@
       #include "branch.h"
       #include "remote.h"
       #include "run-command.h"
     +@@
     + 	NULL
     + };
     + 
     ++struct option_submodules
     ++{
     ++	struct string_list option;
     ++	int status;
     ++};
     ++
     + static int option_no_checkout, option_bare, option_mirror, option_single_branch = -1;
     + static int option_local = -1, option_no_hardlinks, option_shared;
     + static int option_no_tags;
     +@@
     + static struct string_list option_optional_reference = STRING_LIST_INIT_NODUP;
     + static int option_dissociate;
     + static int max_jobs = -1;
     +-static struct string_list option_recurse_submodules = STRING_LIST_INIT_NODUP;
     ++static struct option_submodules option_recurse_submodules = {STRING_LIST_INIT_NODUP, RECURSE_SUBMODULES_DEFAULT};
     + static struct list_objects_filter_options filter_options;
     + static struct string_list server_options = STRING_LIST_INIT_NODUP;
     + static int option_remote_submodules;
     +@@
     + static int recurse_submodules_cb(const struct option *opt,
     + 				 const char *arg, int unset)
     + {
     +-	if (unset)
     +-		string_list_clear((struct string_list *)opt->value, 0);
     +-	else if (arg)
     +-		string_list_append((struct string_list *)opt->value, arg);
     +-	else
     +-		string_list_append((struct string_list *)opt->value,
     +-				   (const char *)opt->defval);
     ++	struct option_submodules *list = (struct option_submodules *)(opt->value);
     ++
     ++	if (unset) {
     ++		string_list_clear(&list->option, 0);
     ++		list->status = RECURSE_SUBMODULES_OFF;
     ++	}
     ++	else if (arg) {
     ++		string_list_append(&list->option, arg);
     ++		list->status = RECURSE_SUBMODULES_ON_DEMAND;
     ++	}
     ++	else {
     ++		string_list_append(&list->option, (const char *)opt->defval);
     ++		list->status = RECURSE_SUBMODULES_ON;
     ++	}
     + 
     + 	return 0;
     + }
     +@@
     + static struct option builtin_clone_options[] = {
     + 	OPT__VERBOSITY(&option_verbosity),
     + 	OPT_BOOL(0, "progress", &option_progress,
     +-		 N_("force progress reporting")),
     ++		N_("force progress reporting")),
     + 	OPT_BOOL('n', "no-checkout", &option_no_checkout,
     +-		 N_("don't create a checkout")),
     ++		N_("don't create a checkout")),
     + 	OPT_BOOL(0, "bare", &option_bare, N_("create a bare repository")),
     + 	OPT_HIDDEN_BOOL(0, "naked", &option_bare,
     + 			N_("create a bare repository")),
     +@@
     + 	OPT_BOOL('l', "local", &option_local,
     + 		N_("to clone from a local repository")),
     + 	OPT_BOOL(0, "no-hardlinks", &option_no_hardlinks,
     +-		    N_("don't use local hardlinks, always copy")),
     ++			N_("don't use local hardlinks, always copy")),
     + 	OPT_BOOL('s', "shared", &option_shared,
     +-		    N_("setup as shared repository")),
     ++			N_("setup as shared repository")),
     + 	OPT_ALIAS(0, "recursive", "recurse-submodules"),
     + 	{ OPTION_CALLBACK, 0, "recurse-submodules", &option_recurse_submodules,
     + 	  N_("pathspec"), N_("initialize submodules in the clone"),
     + 	  PARSE_OPT_OPTARG, recurse_submodules_cb, (intptr_t)"." },
     + 	OPT_INTEGER('j', "jobs", &max_jobs,
     +-		    N_("number of submodules cloned in parallel")),
     ++			N_("number of submodules cloned in parallel")),
     + 	OPT_STRING(0, "template", &option_template, N_("template-directory"),
     +-		   N_("directory from which templates will be used")),
     ++			N_("directory from which templates will be used")),
     + 	OPT_STRING_LIST(0, "reference", &option_required_reference, N_("repo"),
     + 			N_("reference repository")),
     + 	OPT_STRING_LIST(0, "reference-if-able", &option_optional_reference,
     + 			N_("repo"), N_("reference repository")),
     + 	OPT_BOOL(0, "dissociate", &option_dissociate,
     +-		 N_("use --reference only while cloning")),
     ++			N_("use --reference only while cloning")),
     + 	OPT_STRING('o', "origin", &option_origin, N_("name"),
     +-		   N_("use <name> instead of 'origin' to track upstream")),
     ++			N_("use <name> instead of 'origin' to track upstream")),
     + 	OPT_STRING('b', "branch", &option_branch, N_("branch"),
     +-		   N_("checkout <branch> instead of the remote's HEAD")),
     ++			N_("checkout <branch> instead of the remote's HEAD")),
     + 	OPT_STRING('u', "upload-pack", &option_upload_pack, N_("path"),
     +-		   N_("path to git-upload-pack on the remote")),
     ++			N_("path to git-upload-pack on the remote")),
     + 	OPT_STRING(0, "depth", &option_depth, N_("depth"),
     +-		    N_("create a shallow clone of that depth")),
     ++			N_("create a shallow clone of that depth")),
     + 	OPT_STRING(0, "shallow-since", &option_since, N_("time"),
     +-		    N_("create a shallow clone since a specific time")),
     ++			N_("create a shallow clone since a specific time")),
     + 	OPT_STRING_LIST(0, "shallow-exclude", &option_not, N_("revision"),
     + 			N_("deepen history of shallow clone, excluding rev")),
     + 	OPT_BOOL(0, "single-branch", &option_single_branch,
     +-		    N_("clone only one branch, HEAD or --branch")),
     ++			N_("clone only one branch, HEAD or --branch")),
     + 	OPT_BOOL(0, "no-tags", &option_no_tags,
     +-		 N_("don't clone any tags, and make later fetches not to follow them")),
     ++			N_("don't clone any tags, and make later fetches not to follow them")),
     + 	OPT_BOOL(0, "shallow-submodules", &option_shallow_submodules,
     +-		    N_("any cloned submodules will be shallow")),
     ++			N_("any cloned submodules will be shallow")),
     + 	OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
     +-		   N_("separate git dir from working tree")),
     ++			N_("separate git dir from working tree")),
     + 	OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
     + 			N_("set config inside the new repository")),
     + 	OPT_STRING_LIST(0, "server-option", &server_options,
     +@@
     + 			TRANSPORT_FAMILY_IPV6),
     + 	OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
     + 	OPT_BOOL(0, "remote-submodules", &option_remote_submodules,
     +-		    N_("any cloned submodules will use their remote-tracking branch")),
     ++			N_("any cloned submodules will use their remote-tracking branch")),
     + 	OPT_BOOL(0, "sparse", &option_sparse_checkout,
     +-		    N_("initialize sparse-checkout file to include only files at root")),
     ++			N_("initialize sparse-checkout file to include only files at root")),
     + 	OPT_END()
     + };
     + 
     +@@
     + 	err |= run_hook_le(NULL, "post-checkout", oid_to_hex(&null_oid),
     + 			   oid_to_hex(&oid), "1", NULL);
     + 
     +-	if (!err && (option_recurse_submodules.nr > 0)) {
     ++	if (!err && (option_recurse_submodules.option.nr > 0)) {
     + 		struct argv_array args = ARGV_ARRAY_INIT;
     + 		argv_array_pushl(&args, "submodule", "update", "--require-init", "--recursive", NULL);
     + 
      @@
       	return !stat(path, &sb);
       }
       
     -+/**
     -+ * Read config variables.
     -+ */
      +static int git_clone_config(const char *var, const char *value, void *cb)
      +{
     -+	if (!strcmp(var, "submodule.recurse") && git_config_bool(var, value)) {
     -+		string_list_append(&option_recurse_submodules, "true");
     ++	if (!strcmp(var, "submodule.recurse")){
     ++		if (git_config_bool(var, value) && option_recurse_submodules.status != RECURSE_SUBMODULES_OFF)
     ++			string_list_append(&option_recurse_submodules.option, ".");
      +		return 0;
      +	}
      +	return git_default_config(var, value, cb);
     @@ -56,6 +193,30 @@
       {
       	int is_bundle = 0, is_local;
      @@
     + 			fprintf(stderr, _("Cloning into '%s'...\n"), dir);
     + 	}
     + 
     +-	if (option_recurse_submodules.nr > 0) {
     ++	if (option_recurse_submodules.option.nr > 0) {
     + 		struct string_list_item *item;
     + 		struct strbuf sb = STRBUF_INIT;
     + 
     + 		/* remove duplicates */
     +-		string_list_sort(&option_recurse_submodules);
     +-		string_list_remove_duplicates(&option_recurse_submodules, 0);
     ++		string_list_sort(&option_recurse_submodules.option);
     ++		string_list_remove_duplicates(&option_recurse_submodules.option, 0);
     + 
     + 		/*
     + 		 * NEEDSWORK: In a multi-working-tree world, this needs to be
     + 		 * set in the per-worktree config.
     + 		 */
     +-		for_each_string_list_item(item, &option_recurse_submodules) {
     ++		for_each_string_list_item(item, &option_recurse_submodules.option) {
     + 			strbuf_addf(&sb, "submodule.active=%s",
     + 				    item->string);
     + 			string_list_append(&option_config,
     +@@
       
       	write_config(&option_config);
       
     @@ -82,6 +243,25 @@
      +		EOF
      +		test_cmp expect actual
      +	)
     ++'
     ++
     ++test_expect_success 'use "git clone" with submodule.recurse=false and --recurse-submodules to checkout all submodules' '
     ++	git clone -c submodule.recurse=false --recurse-submodules super clone8 &&
     ++	(
     ++		git -C clone8 rev-parse --resolve-git-dir .git --resolve-git-dir nested1/nested2/nested3/submodule/.git >actual &&
     ++		cat >expect <<-EOF &&
     ++		.git
     ++		$(pwd)/clone8/.git/modules/nested1/modules/nested2/modules/nested3/modules/submodule
     ++		EOF
     ++		test_cmp expect actual
     ++	)
     ++'
     ++
     ++test_expect_success 'use "git clone" with submodule.recurse=true and --no-recurse-submodules to checkout no submodules' '
     ++	git clone -c submodule.recurse=true --no-recurse-submodules super clone9 &&
     ++	(
     ++		test_path_is_missing clone9/nested1/nested2/nested3/submodule
     ++	)
      +'
       
       test_expect_success 'command passed to foreach retains notion of stdin' '


 builtin/clone.c              | 89 +++++++++++++++++++++++-------------
 t/t7407-submodule-foreach.sh | 30 ++++++++++++
 2 files changed, 87 insertions(+), 32 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 0fc89ae2b9c..dd45b6bb6a0 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -26,6 +26,8 @@
 #include "dir-iterator.h"
 #include "iterator.h"
 #include "sigchain.h"
+#include "submodule-config.h"
+#include "submodule.h"
 #include "branch.h"
 #include "remote.h"
 #include "run-command.h"
@@ -46,6 +48,12 @@ static const char * const builtin_clone_usage[] = {
 	NULL
 };
 
+struct option_submodules
+{
+	struct string_list option;
+	int status;
+};
+
 static int option_no_checkout, option_bare, option_mirror, option_single_branch = -1;
 static int option_local = -1, option_no_hardlinks, option_shared;
 static int option_no_tags;
@@ -66,7 +74,7 @@ static struct string_list option_required_reference = STRING_LIST_INIT_NODUP;
 static struct string_list option_optional_reference = STRING_LIST_INIT_NODUP;
 static int option_dissociate;
 static int max_jobs = -1;
-static struct string_list option_recurse_submodules = STRING_LIST_INIT_NODUP;
+static struct option_submodules option_recurse_submodules = {STRING_LIST_INIT_NODUP, RECURSE_SUBMODULES_DEFAULT};
 static struct list_objects_filter_options filter_options;
 static struct string_list server_options = STRING_LIST_INIT_NODUP;
 static int option_remote_submodules;
@@ -74,13 +82,20 @@ static int option_remote_submodules;
 static int recurse_submodules_cb(const struct option *opt,
 				 const char *arg, int unset)
 {
-	if (unset)
-		string_list_clear((struct string_list *)opt->value, 0);
-	else if (arg)
-		string_list_append((struct string_list *)opt->value, arg);
-	else
-		string_list_append((struct string_list *)opt->value,
-				   (const char *)opt->defval);
+	struct option_submodules *list = (struct option_submodules *)(opt->value);
+
+	if (unset) {
+		string_list_clear(&list->option, 0);
+		list->status = RECURSE_SUBMODULES_OFF;
+	}
+	else if (arg) {
+		string_list_append(&list->option, arg);
+		list->status = RECURSE_SUBMODULES_ON_DEMAND;
+	}
+	else {
+		string_list_append(&list->option, (const char *)opt->defval);
+		list->status = RECURSE_SUBMODULES_ON;
+	}
 
 	return 0;
 }
@@ -88,9 +103,9 @@ static int recurse_submodules_cb(const struct option *opt,
 static struct option builtin_clone_options[] = {
 	OPT__VERBOSITY(&option_verbosity),
 	OPT_BOOL(0, "progress", &option_progress,
-		 N_("force progress reporting")),
+		N_("force progress reporting")),
 	OPT_BOOL('n', "no-checkout", &option_no_checkout,
-		 N_("don't create a checkout")),
+		N_("don't create a checkout")),
 	OPT_BOOL(0, "bare", &option_bare, N_("create a bare repository")),
 	OPT_HIDDEN_BOOL(0, "naked", &option_bare,
 			N_("create a bare repository")),
@@ -99,43 +114,43 @@ static struct option builtin_clone_options[] = {
 	OPT_BOOL('l', "local", &option_local,
 		N_("to clone from a local repository")),
 	OPT_BOOL(0, "no-hardlinks", &option_no_hardlinks,
-		    N_("don't use local hardlinks, always copy")),
+			N_("don't use local hardlinks, always copy")),
 	OPT_BOOL('s', "shared", &option_shared,
-		    N_("setup as shared repository")),
+			N_("setup as shared repository")),
 	OPT_ALIAS(0, "recursive", "recurse-submodules"),
 	{ OPTION_CALLBACK, 0, "recurse-submodules", &option_recurse_submodules,
 	  N_("pathspec"), N_("initialize submodules in the clone"),
 	  PARSE_OPT_OPTARG, recurse_submodules_cb, (intptr_t)"." },
 	OPT_INTEGER('j', "jobs", &max_jobs,
-		    N_("number of submodules cloned in parallel")),
+			N_("number of submodules cloned in parallel")),
 	OPT_STRING(0, "template", &option_template, N_("template-directory"),
-		   N_("directory from which templates will be used")),
+			N_("directory from which templates will be used")),
 	OPT_STRING_LIST(0, "reference", &option_required_reference, N_("repo"),
 			N_("reference repository")),
 	OPT_STRING_LIST(0, "reference-if-able", &option_optional_reference,
 			N_("repo"), N_("reference repository")),
 	OPT_BOOL(0, "dissociate", &option_dissociate,
-		 N_("use --reference only while cloning")),
+			N_("use --reference only while cloning")),
 	OPT_STRING('o', "origin", &option_origin, N_("name"),
-		   N_("use <name> instead of 'origin' to track upstream")),
+			N_("use <name> instead of 'origin' to track upstream")),
 	OPT_STRING('b', "branch", &option_branch, N_("branch"),
-		   N_("checkout <branch> instead of the remote's HEAD")),
+			N_("checkout <branch> instead of the remote's HEAD")),
 	OPT_STRING('u', "upload-pack", &option_upload_pack, N_("path"),
-		   N_("path to git-upload-pack on the remote")),
+			N_("path to git-upload-pack on the remote")),
 	OPT_STRING(0, "depth", &option_depth, N_("depth"),
-		    N_("create a shallow clone of that depth")),
+			N_("create a shallow clone of that depth")),
 	OPT_STRING(0, "shallow-since", &option_since, N_("time"),
-		    N_("create a shallow clone since a specific time")),
+			N_("create a shallow clone since a specific time")),
 	OPT_STRING_LIST(0, "shallow-exclude", &option_not, N_("revision"),
 			N_("deepen history of shallow clone, excluding rev")),
 	OPT_BOOL(0, "single-branch", &option_single_branch,
-		    N_("clone only one branch, HEAD or --branch")),
+			N_("clone only one branch, HEAD or --branch")),
 	OPT_BOOL(0, "no-tags", &option_no_tags,
-		 N_("don't clone any tags, and make later fetches not to follow them")),
+			N_("don't clone any tags, and make later fetches not to follow them")),
 	OPT_BOOL(0, "shallow-submodules", &option_shallow_submodules,
-		    N_("any cloned submodules will be shallow")),
+			N_("any cloned submodules will be shallow")),
 	OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
-		   N_("separate git dir from working tree")),
+			N_("separate git dir from working tree")),
 	OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
 			N_("set config inside the new repository")),
 	OPT_STRING_LIST(0, "server-option", &server_options,
@@ -146,9 +161,9 @@ static struct option builtin_clone_options[] = {
 			TRANSPORT_FAMILY_IPV6),
 	OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
 	OPT_BOOL(0, "remote-submodules", &option_remote_submodules,
-		    N_("any cloned submodules will use their remote-tracking branch")),
+			N_("any cloned submodules will use their remote-tracking branch")),
 	OPT_BOOL(0, "sparse", &option_sparse_checkout,
-		    N_("initialize sparse-checkout file to include only files at root")),
+			N_("initialize sparse-checkout file to include only files at root")),
 	OPT_END()
 };
 
@@ -811,7 +826,7 @@ static int checkout(int submodule_progress)
 	err |= run_hook_le(NULL, "post-checkout", oid_to_hex(&null_oid),
 			   oid_to_hex(&oid), "1", NULL);
 
-	if (!err && (option_recurse_submodules.nr > 0)) {
+	if (!err && (option_recurse_submodules.option.nr > 0)) {
 		struct argv_array args = ARGV_ARRAY_INIT;
 		argv_array_pushl(&args, "submodule", "update", "--require-init", "--recursive", NULL);
 
@@ -929,6 +944,16 @@ static int path_exists(const char *path)
 	return !stat(path, &sb);
 }
 
+static int git_clone_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "submodule.recurse")){
+		if (git_config_bool(var, value) && option_recurse_submodules.status != RECURSE_SUBMODULES_OFF)
+			string_list_append(&option_recurse_submodules.option, ".");
+		return 0;
+	}
+	return git_default_config(var, value, cb);
+}
+
 int cmd_clone(int argc, const char **argv, const char *prefix)
 {
 	int is_bundle = 0, is_local;
@@ -1060,19 +1085,19 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			fprintf(stderr, _("Cloning into '%s'...\n"), dir);
 	}
 
-	if (option_recurse_submodules.nr > 0) {
+	if (option_recurse_submodules.option.nr > 0) {
 		struct string_list_item *item;
 		struct strbuf sb = STRBUF_INIT;
 
 		/* remove duplicates */
-		string_list_sort(&option_recurse_submodules);
-		string_list_remove_duplicates(&option_recurse_submodules, 0);
+		string_list_sort(&option_recurse_submodules.option);
+		string_list_remove_duplicates(&option_recurse_submodules.option, 0);
 
 		/*
 		 * NEEDSWORK: In a multi-working-tree world, this needs to be
 		 * set in the per-worktree config.
 		 */
-		for_each_string_list_item(item, &option_recurse_submodules) {
+		for_each_string_list_item(item, &option_recurse_submodules.option) {
 			strbuf_addf(&sb, "submodule.active=%s",
 				    item->string);
 			string_list_append(&option_config,
@@ -1103,7 +1128,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	write_config(&option_config);
 
-	git_config(git_default_config, NULL);
+	git_config(git_clone_config, NULL);
 
 	if (option_bare) {
 		if (option_mirror)
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 6b2aa917e11..e6667d8e9b0 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -383,6 +383,36 @@ test_expect_success 'use "update --recursive nested1" to checkout all submodules
 		git rev-parse --resolve-git-dir nested1/nested2/nested3/submodule/.git
 	)
 '
+test_expect_success 'use "git clone" with submodule.recurse=true to checkout all submodules' '
+	git clone -c submodule.recurse=true super clone7 &&
+	(
+		git -C clone7 rev-parse --resolve-git-dir .git --resolve-git-dir nested1/nested2/nested3/submodule/.git >actual &&
+		cat >expect <<-EOF &&
+		.git
+		$(pwd)/clone7/.git/modules/nested1/modules/nested2/modules/nested3/modules/submodule
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'use "git clone" with submodule.recurse=false and --recurse-submodules to checkout all submodules' '
+	git clone -c submodule.recurse=false --recurse-submodules super clone8 &&
+	(
+		git -C clone8 rev-parse --resolve-git-dir .git --resolve-git-dir nested1/nested2/nested3/submodule/.git >actual &&
+		cat >expect <<-EOF &&
+		.git
+		$(pwd)/clone8/.git/modules/nested1/modules/nested2/modules/nested3/modules/submodule
+		EOF
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'use "git clone" with submodule.recurse=true and --no-recurse-submodules to checkout no submodules' '
+	git clone -c submodule.recurse=true --no-recurse-submodules super clone9 &&
+	(
+		test_path_is_missing clone9/nested1/nested2/nested3/submodule
+	)
+'
 
 test_expect_success 'command passed to foreach retains notion of stdin' '
 	(

base-commit: d0654dc308b0ba76dd8ed7bbb33c8d8f7aacd783
-- 
gitgitgadget
