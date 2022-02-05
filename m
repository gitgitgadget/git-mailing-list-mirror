Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EB2C433F5
	for <git@archiver.kernel.org>; Sat,  5 Feb 2022 05:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbiBEFAz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Feb 2022 00:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiBEFAz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Feb 2022 00:00:55 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC1CC061346
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 21:00:53 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s73-20020a25aa4f000000b0061d764d3c13so1183353ybi.1
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 21:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NcsmlEZdGtd3XlC8SwkpwhPNhzoWeWsqwFHMRiQBBkE=;
        b=aziLlCCRMfNpciSXGB7K/dO/Y0G1fFpxAb/6CkWwryv/exMgOLUEHzXT/+LeCeoh1J
         QCaQ87GWc9LTt8KzMnYX9TbNc74hhMljpJJDbQgssLK2G+6iK/7Z507bboUQAKihjbPl
         G84VzojacD/bfsRfS6P4hxe036m+9YaZTunQlT3J4PXl8DEw/0dxZL2ASj7DDRGjxl0j
         HYYMwTqAxk9rMkXsvaOTHCF4Wl1vAsxsdN6omssXGlbx1Cad7QBynb6IR3kxLK3/VQHm
         S9TJL0W2u3nE5a7Pf+5lp9gNNSIzo5E5jMKkqkOQX+3FOQs+BijlF3ws4LTWouuSqfKc
         CDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NcsmlEZdGtd3XlC8SwkpwhPNhzoWeWsqwFHMRiQBBkE=;
        b=te4rEbfzojwl3TLPMuWwqBZpuRRmzx6muSrxWlfo0dcc2JYahY4SyPMj8I4iA+yQUK
         0RXXzelPUnWr7yrcBs/dtE4OoK2hNSmwD0WnIdJ0eilFxs2psnn9INXdjNMLGwLHp74R
         1bmByCKBMni6oIDxU4IPI06zrfBRCxaUQgcSM6/kWuvnREjR1n7nq+GNoxY9HJZPwirn
         u4qYv4Uv9+FvSVL0S4n5xZvB9X5qnXWa8bodGIyrlV1d1YPgDa3gDf+4Ha44irOkBdrH
         qOdp6v/1kqIagVSazd8moveqp7hNte/PtM0T546XAv+7fVC3ZJljVppO4IZEDcmVYoc0
         jWSQ==
X-Gm-Message-State: AOAM5312ND+3/Ulh/9dzMtdRkqum43Nsc8/d4AvQXNmi9x9PYgw6KcFb
        6j1sgd9uBfPEAEXAZQA8EJ+AHaKnEHFFKaeIXdD0mpnrCe1uxnKmFmDQvcJPotk80Ed4g2R7XH1
        5SrBaH1pNnRdUTb0vMgHW25CjAEMlBIrdHhUA3w8wq5YBgsqSf3Fx8fQb2N7GFq4=
X-Google-Smtp-Source: ABdhPJyi/pdWaSPAaKgcKf665dLiQzKxKvPjh4x7YeOpsDLQ0Z1AOFGal5oyUH1n5IoyKRRD6QMLdNxVleWeLA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:8562:eb15:bb84:ce64])
 (user=steadmon job=sendgmr) by 2002:a05:690c:30e:: with SMTP id
 bg14mr2270775ywb.52.1644037252259; Fri, 04 Feb 2022 21:00:52 -0800 (PST)
Date:   Fri,  4 Feb 2022 21:00:49 -0800
In-Reply-To: <50ebf7bd39adf34fa4ada27cd433d81b5381abe5.1642735881.git.steadmon@google.com>
Message-Id: <690d2316ad518ea4551821b2b3aa652996858475.1644034886.git.steadmon@google.com>
Mime-Version: 1.0
References: <50ebf7bd39adf34fa4ada27cd433d81b5381abe5.1642735881.git.steadmon@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v3] clone, submodule: pass partial clone filters to submodules
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When cloning a repo with a --filter and with --recurse-submodules
enabled, the partial clone filter only applies to the top-level repo.
This can lead to unexpected bandwidth and disk usage for projects which
include large submodules. For example, a user might wish to make a
partial clone of Gerrit and would run:
`git clone --recurse-submodules --filter=blob:5k https://gerrit.googlesource.com/gerrit`.
However, only the superproject would be a partial clone; all the
submodules would have all blobs downloaded regardless of their size.
With this change, the same filter can also be applied to submodules,
meaning the expected bandwidth and disk savings apply consistently.

To avoid changing default behavior, add a new clone flag,
`--also-filter-submodules`. When this is set along with `--filter` and
`--recurse-submodules`, the filter spec is passed along to git-submodule
and git-submodule--helper, such that submodule clones also have the
filter applied.

This applies the same filter to the superproject and all submodules.
Users who need to customize the filter per-submodule would need to clone
with `--no-recurse-submodules` and then manually initialize each
submodule with the proper filter.

Applying filters to submodules should be safe thanks to Jonathan Tan's
recent work [1, 2, 3] eliminating the use of alternates as a method of
accessing submodule objects, so any submodule object access now triggers
a lazy fetch from the submodule's promisor remote if the accessed object
is missing. This patch is a reworked version of [4], which was created
prior to Jonathan Tan's work.

[1]: 8721e2e (Merge branch 'jt/partial-clone-submodule-1', 2021-07-16)
[2]: 11e5d0a (Merge branch 'jt/grep-wo-submodule-odb-as-alternate',
	2021-09-20)
[3]: 162a13b (Merge branch 'jt/no-abuse-alternate-odb-for-submodules',
	2021-10-25)
[4]: https://lore.kernel.org/git/52bf9d45b8e2b72ff32aa773f2415bf7b2b86da2.1563322192.git.steadmon@google.com/

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
Changes since V2:
* Used a more reliable method for testing that a repository is a partial
  clone. Checking the remote.*.promisor field should work regardless of
  which hash algorithm (and therefore repository format) is used.

Changes since V1:
* Fixed a shell-quoting issue in git-submodule.sh
* Added a new clone flag (--also-filter-submodules) and config
  (clone.filterSubmodules) so that the default behavior remains the
  same, but users who want this option generally can set-and-forget it
  in their global config.

Range-diff against v2:
1:  8678e721c2 ! 1:  690d2316ad clone, submodule: pass partial clone filters to submodules
    @@ t/t5617-clone-submodules-remote.sh: test_expect_success 'clone with --single-bra
     +	git clone --recurse-submodules \
     +		--filter blob:none --also-filter-submodules \
     +		"file://$pwd/srv.bare" super_clone &&
    -+	test_cmp_config -C super_clone 1 core.repositoryformatversion &&
    ++	test_cmp_config -C super_clone true remote.origin.promisor &&
     +	test_cmp_config -C super_clone blob:none remote.origin.partialclonefilter &&
    -+	test_cmp_config -C super_clone/sub 1 core.repositoryformatversion &&
    ++	test_cmp_config -C super_clone/sub true remote.origin.promisor &&
     +	test_cmp_config -C super_clone/sub blob:none remote.origin.partialclonefilter
     +'
     +
    @@ t/t5617-clone-submodules-remote.sh: test_expect_success 'clone with --single-bra
     +	test_config_global clone.filterSubmodules true &&
     +	git clone --recurse-submodules --filter blob:none \
     +		"file://$pwd/srv.bare" super_clone2 &&
    -+	test_cmp_config -C super_clone2 1 core.repositoryformatversion &&
    ++	test_cmp_config -C super_clone2 true remote.origin.promisor &&
     +	test_cmp_config -C super_clone2 blob:none remote.origin.partialclonefilter &&
    -+	test_cmp_config -C super_clone2/sub 1 core.repositoryformatversion &&
    ++	test_cmp_config -C super_clone2/sub true remote.origin.promisor &&
     +	test_cmp_config -C super_clone2/sub blob:none remote.origin.partialclonefilter
     +'
     +
    @@ t/t5617-clone-submodules-remote.sh: test_expect_success 'clone with --single-bra
     +	git clone --recurse-submodules --filter blob:none \
     +		--no-also-filter-submodules \
     +		"file://$pwd/srv.bare" super_clone3 &&
    -+	test_cmp_config -C super_clone3 1 core.repositoryformatversion &&
    ++	test_cmp_config -C super_clone3 true remote.origin.promisor &&
     +	test_cmp_config -C super_clone3 blob:none remote.origin.partialclonefilter &&
    -+	test_cmp_config -C super_clone3/sub 0 core.repositoryformatversion
    ++	test_cmp_config -C super_clone3/sub false --default false remote.origin.promisor
     +'
     +
      test_done

 Documentation/config/clone.txt     |  5 ++++
 Documentation/git-clone.txt        |  7 ++++-
 Documentation/git-submodule.txt    |  6 ++++-
 builtin/clone.c                    | 36 ++++++++++++++++++++++++--
 builtin/submodule--helper.c        | 30 +++++++++++++++++++---
 git-submodule.sh                   | 17 ++++++++++++-
 t/t5617-clone-submodules-remote.sh | 41 ++++++++++++++++++++++++++++++
 t/t7814-grep-recurse-submodules.sh | 41 ++++++++++++++++++++++++++++++
 8 files changed, 175 insertions(+), 8 deletions(-)

diff --git a/Documentation/config/clone.txt b/Documentation/config/clone.txt
index 7bcfbd18a5..26f4fb137a 100644
--- a/Documentation/config/clone.txt
+++ b/Documentation/config/clone.txt
@@ -6,3 +6,8 @@ clone.defaultRemoteName::
 clone.rejectShallow::
 	Reject to clone a repository if it is a shallow one, can be overridden by
 	passing option `--reject-shallow` in command line. See linkgit:git-clone[1]
+
+clone.filterSubmodules::
+	If a partial clone filter is provided (see `--filter` in
+	linkgit:git-rev-list[1]) and `--recurse-submodules` is used, also apply
+	the filter to submodules.
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 984d194934..632bd1348e 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 	  [--depth <depth>] [--[no-]single-branch] [--no-tags]
 	  [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
 	  [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--[no-]reject-shallow]
-	  [--filter=<filter>] [--] <repository>
+	  [--filter=<filter> [--also-filter-submodules]] [--] <repository>
 	  [<directory>]
 
 DESCRIPTION
@@ -182,6 +182,11 @@ objects from the source repository into a pack in the cloned repository.
 	at least `<size>`. For more details on filter specifications, see
 	the `--filter` option in linkgit:git-rev-list[1].
 
+--also-filter-submodules::
+	Also apply the partial clone filter to any submodules in the repository.
+	Requires `--filter` and `--recurse-submodules`. This can be turned on by
+	default by setting the `clone.filterSubmodules` config option.
+
 --mirror::
 	Set up a mirror of the source repository.  This implies `--bare`.
 	Compared to `--bare`, `--mirror` not only maps local branches of the
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 7e5f995f77..4d3ab6b9f9 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -133,7 +133,7 @@ If you really want to remove a submodule from the repository and commit
 that use linkgit:git-rm[1] instead. See linkgit:gitsubmodules[7] for removal
 options.
 
-update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--depth <depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--] [<path>...]::
+update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--depth <depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--filter <filter spec>] [--] [<path>...]::
 +
 --
 Update the registered submodules to match what the superproject
@@ -177,6 +177,10 @@ submodule with the `--init` option.
 
 If `--recursive` is specified, this command will recurse into the
 registered submodules, and update any nested submodules within.
+
+If `--filter <filter spec>` is specified, the given partial clone filter will be
+applied to the submodule. See linkgit:git-rev-list[1] for details on filter
+specifications.
 --
 set-branch (-b|--branch) <branch> [--] <path>::
 set-branch (-d|--default) [--] <path>::
diff --git a/builtin/clone.c b/builtin/clone.c
index 727e16e0ae..fb605e4c8d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -71,6 +71,8 @@ static int option_dissociate;
 static int max_jobs = -1;
 static struct string_list option_recurse_submodules = STRING_LIST_INIT_NODUP;
 static struct list_objects_filter_options filter_options;
+static int option_filter_submodules = -1;    /* unspecified */
+static int config_filter_submodules = -1;    /* unspecified */
 static struct string_list server_options = STRING_LIST_INIT_NODUP;
 static int option_remote_submodules;
 
@@ -150,6 +152,8 @@ static struct option builtin_clone_options[] = {
 	OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
 			TRANSPORT_FAMILY_IPV6),
 	OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
+	OPT_BOOL(0, "also-filter-submodules", &option_filter_submodules,
+		    N_("apply partial clone filters to submodules")),
 	OPT_BOOL(0, "remote-submodules", &option_remote_submodules,
 		    N_("any cloned submodules will use their remote-tracking branch")),
 	OPT_BOOL(0, "sparse", &option_sparse_checkout,
@@ -650,7 +654,7 @@ static int git_sparse_checkout_init(const char *repo)
 	return result;
 }
 
-static int checkout(int submodule_progress)
+static int checkout(int submodule_progress, int filter_submodules)
 {
 	struct object_id oid;
 	char *head;
@@ -729,6 +733,10 @@ static int checkout(int submodule_progress)
 			strvec_push(&args, "--no-fetch");
 		}
 
+		if (filter_submodules && filter_options.choice)
+			strvec_pushf(&args, "--filter=%s",
+				     expand_list_objects_filter_spec(&filter_options));
+
 		if (option_single_branch >= 0)
 			strvec_push(&args, option_single_branch ?
 					       "--single-branch" :
@@ -749,6 +757,8 @@ static int git_clone_config(const char *k, const char *v, void *cb)
 	}
 	if (!strcmp(k, "clone.rejectshallow"))
 		config_reject_shallow = git_config_bool(k, v);
+	if (!strcmp(k, "clone.filtersubmodules"))
+		config_filter_submodules = git_config_bool(k, v);
 
 	return git_default_config(k, v, cb);
 }
@@ -871,6 +881,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	struct remote *remote;
 	int err = 0, complete_refs_before_fetch = 1;
 	int submodule_progress;
+	int filter_submodules = 0;
 
 	struct transport_ls_refs_options transport_ls_refs_options =
 		TRANSPORT_LS_REFS_OPTIONS_INIT;
@@ -1066,6 +1077,27 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_reject_shallow != -1)
 		reject_shallow = option_reject_shallow;
 
+	/*
+	 * If option_filter_submodules is specified from CLI option,
+	 * ignore config_filter_submodules from git_clone_config.
+	 */
+	if (config_filter_submodules != -1)
+		filter_submodules = config_filter_submodules;
+	if (option_filter_submodules != -1)
+		filter_submodules = option_filter_submodules;
+
+	/*
+	 * Exit if the user seems to be doing something silly with submodule
+	 * filter flags (but not with filter configs, as those should be
+	 * set-and-forget).
+	 */
+	if (option_filter_submodules > 0 && !filter_options.choice)
+		die(_("the option '%s' requires '%s'"),
+		    "--also-filter-submodules", "--filter");
+	if (option_filter_submodules > 0 && !option_recurse_submodules.nr)
+		die(_("the option '%s' requires '%s'"),
+		    "--also-filter-submodules", "--recurse-submodules");
+
 	/*
 	 * apply the remote name provided by --origin only after this second
 	 * call to git_config, to ensure it overrides all config-based values.
@@ -1299,7 +1331,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	}
 
 	junk_mode = JUNK_LEAVE_REPO;
-	err = checkout(submodule_progress);
+	err = checkout(submodule_progress, filter_submodules);
 
 	free(remote_name);
 	strbuf_release(&reflog_msg);
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c5d3fc3817..11552970f2 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -20,6 +20,7 @@
 #include "diff.h"
 #include "object-store.h"
 #include "advice.h"
+#include "list-objects-filter-options.h"
 
 #define OPT_QUIET (1 << 0)
 #define OPT_CACHED (1 << 1)
@@ -1630,6 +1631,7 @@ struct module_clone_data {
 	const char *name;
 	const char *url;
 	const char *depth;
+	struct list_objects_filter_options *filter_options;
 	struct string_list reference;
 	unsigned int quiet: 1;
 	unsigned int progress: 1;
@@ -1796,6 +1798,10 @@ static int clone_submodule(struct module_clone_data *clone_data)
 			strvec_push(&cp.args, "--dissociate");
 		if (sm_gitdir && *sm_gitdir)
 			strvec_pushl(&cp.args, "--separate-git-dir", sm_gitdir, NULL);
+		if (clone_data->filter_options && clone_data->filter_options->choice)
+			strvec_pushf(&cp.args, "--filter=%s",
+				     expand_list_objects_filter_spec(
+					     clone_data->filter_options));
 		if (clone_data->single_branch >= 0)
 			strvec_push(&cp.args, clone_data->single_branch ?
 				    "--single-branch" :
@@ -1852,6 +1858,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 {
 	int dissociate = 0, quiet = 0, progress = 0, require_init = 0;
 	struct module_clone_data clone_data = MODULE_CLONE_DATA_INIT;
+	struct list_objects_filter_options filter_options;
 
 	struct option module_clone_options[] = {
 		OPT_STRING(0, "prefix", &clone_data.prefix,
@@ -1881,17 +1888,19 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 			   N_("disallow cloning into non-empty directory")),
 		OPT_BOOL(0, "single-branch", &clone_data.single_branch,
 			 N_("clone only one branch, HEAD or --branch")),
+		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
 		OPT_END()
 	};
 
 	const char *const git_submodule_helper_usage[] = {
 		N_("git submodule--helper clone [--prefix=<path>] [--quiet] "
 		   "[--reference <repository>] [--name <name>] [--depth <depth>] "
-		   "[--single-branch] "
+		   "[--single-branch] [--filter <filter-spec>]"
 		   "--url <url> --path <path>"),
 		NULL
 	};
 
+	memset(&filter_options, 0, sizeof(filter_options));
 	argc = parse_options(argc, argv, prefix, module_clone_options,
 			     git_submodule_helper_usage, 0);
 
@@ -1899,12 +1908,14 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	clone_data.quiet = !!quiet;
 	clone_data.progress = !!progress;
 	clone_data.require_init = !!require_init;
+	clone_data.filter_options = &filter_options;
 
 	if (argc || !clone_data.url || !clone_data.path || !*(clone_data.path))
 		usage_with_options(git_submodule_helper_usage,
 				   module_clone_options);
 
 	clone_submodule(&clone_data);
+	list_objects_filter_release(&filter_options);
 	return 0;
 }
 
@@ -1994,6 +2005,7 @@ struct submodule_update_clone {
 	const char *recursive_prefix;
 	const char *prefix;
 	int single_branch;
+	struct list_objects_filter_options *filter_options;
 
 	/* to be consumed by git-submodule.sh */
 	struct update_clone_data *update_clone;
@@ -2154,6 +2166,9 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 		strvec_pushl(&child->args, "--prefix", suc->prefix, NULL);
 	if (suc->recommend_shallow && sub->recommend_shallow == 1)
 		strvec_push(&child->args, "--depth=1");
+	if (suc->filter_options && suc->filter_options->choice)
+		strvec_pushf(&child->args, "--filter=%s",
+			     expand_list_objects_filter_spec(suc->filter_options));
 	if (suc->require_init)
 		strvec_push(&child->args, "--require-init");
 	strvec_pushl(&child->args, "--path", sub->path, NULL);
@@ -2498,6 +2513,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	const char *update = NULL;
 	struct pathspec pathspec;
 	struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
+	struct list_objects_filter_options filter_options;
+	int ret;
 
 	struct option module_update_clone_options[] = {
 		OPT_STRING(0, "prefix", &prefix,
@@ -2528,6 +2545,7 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 			   N_("disallow cloning into non-empty directory")),
 		OPT_BOOL(0, "single-branch", &suc.single_branch,
 			 N_("clone only one branch, HEAD or --branch")),
+		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
 		OPT_END()
 	};
 
@@ -2540,20 +2558,26 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	update_clone_config_from_gitmodules(&suc.max_jobs);
 	git_config(git_update_clone_config, &suc.max_jobs);
 
+	memset(&filter_options, 0, sizeof(filter_options));
 	argc = parse_options(argc, argv, prefix, module_update_clone_options,
 			     git_submodule_helper_usage, 0);
+	suc.filter_options = &filter_options;
 
 	if (update)
 		if (parse_submodule_update_strategy(update, &suc.update) < 0)
 			die(_("bad value for update parameter"));
 
-	if (module_list_compute(argc, argv, prefix, &pathspec, &suc.list) < 0)
+	if (module_list_compute(argc, argv, prefix, &pathspec, &suc.list) < 0) {
+		list_objects_filter_release(&filter_options);
 		return 1;
+	}
 
 	if (pathspec.nr)
 		suc.warn_if_uninitialized = 1;
 
-	return update_submodules(&suc);
+	ret = update_submodules(&suc);
+	list_objects_filter_release(&filter_options);
+	return ret;
 }
 
 static int run_update_procedure(int argc, const char **argv, const char *prefix)
diff --git a/git-submodule.sh b/git-submodule.sh
index 652861aa66..87772ac891 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -10,7 +10,7 @@ USAGE="[--quiet] [--cached]
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] deinit [-f|--force] (--all| [--] <path>...)
-   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--[no-]single-branch] [--] [<path>...]
+   or: $dashless [--quiet] update [--init [--filter=<filter-spec>]] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--[no-]single-branch] [--] [<path>...]
    or: $dashless [--quiet] set-branch (--default|--branch <branch>) [--] <path>
    or: $dashless [--quiet] set-url [--] <path> <newurl>
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
@@ -49,6 +49,7 @@ dissociate=
 single_branch=
 jobs=
 recommend_shallow=
+filter=
 
 die_if_unmatched ()
 {
@@ -347,6 +348,14 @@ cmd_update()
 		--no-single-branch)
 			single_branch="--no-single-branch"
 			;;
+		--filter)
+			case "$2" in '') usage ;; esac
+			filter="--filter=$2"
+			shift
+			;;
+		--filter=*)
+			filter="$1"
+			;;
 		--)
 			shift
 			break
@@ -361,6 +370,11 @@ cmd_update()
 		shift
 	done
 
+	if test -n "$filter" && test "$init" != "1"
+	then
+		usage
+	fi
+
 	if test -n "$init"
 	then
 		cmd_init "--" "$@" || return
@@ -379,6 +393,7 @@ cmd_update()
 		$single_branch \
 		$recommend_shallow \
 		$jobs \
+		$filter \
 		-- \
 		"$@" || echo "#unmatched" $?
 	} | {
diff --git a/t/t5617-clone-submodules-remote.sh b/t/t5617-clone-submodules-remote.sh
index e2dbb4eaba..ca8f80083a 100755
--- a/t/t5617-clone-submodules-remote.sh
+++ b/t/t5617-clone-submodules-remote.sh
@@ -28,6 +28,13 @@ test_expect_success 'setup' '
 	)
 '
 
+# bare clone giving "srv.bare" for use as our server.
+test_expect_success 'setup bare clone for server' '
+	git clone --bare "file://$(pwd)/." srv.bare &&
+	git -C srv.bare config --local uploadpack.allowfilter 1 &&
+	git -C srv.bare config --local uploadpack.allowanysha1inwant 1
+'
+
 test_expect_success 'clone with --no-remote-submodules' '
 	test_when_finished "rm -rf super_clone" &&
 	git clone --recurse-submodules --no-remote-submodules "file://$pwd/." super_clone &&
@@ -65,4 +72,38 @@ test_expect_success 'clone with --single-branch' '
 	)
 '
 
+# do basic partial clone from "srv.bare"
+# confirm partial clone was registered in the local config for super and sub.
+test_expect_success 'clone with --filter' '
+	git clone --recurse-submodules \
+		--filter blob:none --also-filter-submodules \
+		"file://$pwd/srv.bare" super_clone &&
+	test_cmp_config -C super_clone true remote.origin.promisor &&
+	test_cmp_config -C super_clone blob:none remote.origin.partialclonefilter &&
+	test_cmp_config -C super_clone/sub true remote.origin.promisor &&
+	test_cmp_config -C super_clone/sub blob:none remote.origin.partialclonefilter
+'
+
+# check that clone.filterSubmodules works (--also-filter-submodules can be
+# omitted)
+test_expect_success 'filters applied with clone.filterSubmodules' '
+	test_config_global clone.filterSubmodules true &&
+	git clone --recurse-submodules --filter blob:none \
+		"file://$pwd/srv.bare" super_clone2 &&
+	test_cmp_config -C super_clone2 true remote.origin.promisor &&
+	test_cmp_config -C super_clone2 blob:none remote.origin.partialclonefilter &&
+	test_cmp_config -C super_clone2/sub true remote.origin.promisor &&
+	test_cmp_config -C super_clone2/sub blob:none remote.origin.partialclonefilter
+'
+
+test_expect_success '--no-also-filter-submodules overrides clone.filterSubmodules=true' '
+	test_config_global clone.filterSubmodules true &&
+	git clone --recurse-submodules --filter blob:none \
+		--no-also-filter-submodules \
+		"file://$pwd/srv.bare" super_clone3 &&
+	test_cmp_config -C super_clone3 true remote.origin.promisor &&
+	test_cmp_config -C super_clone3 blob:none remote.origin.partialclonefilter &&
+	test_cmp_config -C super_clone3/sub false --default false remote.origin.promisor
+'
+
 test_done
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 058e5d0c96..48ab7a05c4 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -544,4 +544,45 @@ test_expect_failure 'grep saves textconv cache in the appropriate repository' '
 	test_path_is_file "$sub_textconv_cache"
 '
 
+test_expect_success 'grep partially-cloned submodule' '
+	# Set up clean superproject and submodule for partial cloning.
+	git init super &&
+	git init super/sub &&
+	(
+		cd super &&
+		test_commit --no-tag "Add file in superproject" \
+			super-file "Some content for super-file" &&
+		test_commit -C sub --no-tag "Add file in submodule" \
+			sub-file "Some content for sub-file" &&
+		git submodule add ./sub &&
+		git commit -m "Add other as submodule sub" &&
+		test_tick &&
+		test_commit -C sub --no-tag --append "Update file in submodule" \
+			sub-file "Some more content for sub-file" &&
+		git add sub &&
+		git commit -m "Update submodule" &&
+		test_tick &&
+		git config --local uploadpack.allowfilter 1 &&
+		git config --local uploadpack.allowanysha1inwant 1 &&
+		git -C sub config --local uploadpack.allowfilter 1 &&
+		git -C sub config --local uploadpack.allowanysha1inwant 1
+	) &&
+	# Clone the superproject & submodule, then make sure we can lazy-fetch submodule objects.
+	git clone --filter=blob:none --also-filter-submodules \
+		--recurse-submodules "file://$(pwd)/super" partial &&
+	(
+		cd partial &&
+		cat >expect <<-\EOF &&
+		HEAD^:sub/sub-file:Some content for sub-file
+		HEAD^:super-file:Some content for super-file
+		EOF
+
+		GIT_TRACE2_EVENT="$(pwd)/trace2.log" git grep -e content \
+			--recurse-submodules HEAD^ >actual &&
+		test_cmp expect actual &&
+		# Verify that we actually fetched data from the promisor remote:
+		grep \"category\":\"promisor\",\"key\":\"fetch_count\",\"value\":\"1\" trace2.log >/dev/null
+	)
+'
+
 test_done

base-commit: b56bd95bbc8f716cb8cbb5fdc18b9b0f00323c6a
-- 
2.35.0.263.gb82422642f-goog

