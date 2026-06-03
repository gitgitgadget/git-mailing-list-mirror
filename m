Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696C436A36E
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 09:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780477486; cv=none; b=phMnC6qQnDk6/DS8fCbrBLzIPu1ZsFV/UENwruGCq/n27dzmyANymWwL/HFHhpK8/30fv+1c7qweyEyhKzLHoIbQp+3phdSrpp9uVRAoTooSX05g+Kik2tzP57t2JCN+SAClyrA7PEtxmRrhTVyqRifsoNxl7qT83VFEj+kXDR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780477486; c=relaxed/simple;
	bh=vgg5sqUqQWK4sFcQ59bURRR4U98JI4COIQFGb+3v0pQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WioLyUu+CMkq41B5JBmPb534M3+1tQGYBiAKmD08ZQVFqKysFeAMCsZ2rUn1/GSpsKjz0NQvF8+EptF7T4nOP3MtApDCMDtTMTdelLseThDRNyVLQ1o8xM3QKqRKtRsp2PbOHVY6CEtRbZHEGOUZo758rpLzLcsvKZR+vMkWeWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRRqQLgj; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRRqQLgj"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-137dd523634so5495983c88.1
        for <git@vger.kernel.org>; Wed, 03 Jun 2026 02:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780477482; x=1781082282; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GoUvkERuNg73d0e0odce4XGBCn8M7ufK2b5mWLP8l60=;
        b=lRRqQLgjJ2t0zBZeR/wKX3onkaMwpgo8GNzTF3j4JGUvF7Jbm3cE8Ecn6n2QwJEWVe
         9ML87Pg/GWeW9ji6xxxGK7eGvDeKgMIn9gJGG/Y0UTzlKX6fCxO7ksyj8PHgtUeOsztE
         xRu3575npWW1nZG0uRguA2Exq1E3eZ2vvRzkh2h8ejCBp7NAhQ1dMIR0B5Nr2hbI0NvZ
         iawGLdhztBFwJF8L92Vqm9jnS8PO1Hr7qMLg2kNmeyuvgjdIwKYi8d9usByjnpoJCw88
         m7i7OUYU7lxLpZgFoxp/c+VMg2B33mfSaZsh74gqD7NCG/KP22OTXBY0ffP11hyyHL0n
         rKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780477482; x=1781082282;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GoUvkERuNg73d0e0odce4XGBCn8M7ufK2b5mWLP8l60=;
        b=DnjgRVNx5lZHDMduOmHVHui8gBvp4vgdOP4h2/ZcVX+W2TwYKOKR+KsEzKfpY15+CU
         FYpX6eXzML2iIU8ETdEdX10zMx+xlZNOduKnl6HKHGpJzg4+ZCC2kYswXKEG1CplmxLE
         DJ4TIaBBToGpcfQjAu00YXQ/gVMVjNVcFOQdM+LmS59KBrltTt+WZxbhKQO8cYGb4jPc
         CII5DXNPx5Sngzjomps0kcy28MKWrIR9swWpbx4/7ZC/vMxVKKvqhroJ4SBlnTGlj719
         pXxBGs+WVSLjDl2ZT0qe6KBMiAly1/Hz+/bOUrVhqQQJAKvSFfaiaFfzc4Ij5k9AV1LX
         yahA==
X-Gm-Message-State: AOJu0Yyc3+AUQLtnCaQeikFl+P293ZWp/BFLy/GkvpSDR80ruzA5XwpU
	YIKBEvD55Wab9SgeNBvDhSfBVCAmMALX02TWRCk00bLpEbA7cRGOY+Z1zatnaQ==
X-Gm-Gg: Acq92OH8P56lfT24T2NP/gz56VmHzJi6wA6CZO7gxTTQYE4/CvqdWhhA/NlKq0fITAT
	3gR2c5QZ7+qdm1nLyhiUsyWtaESau/Q2MXTEy+a2xMWkv+pgCxVIWCuv7GK1DWnpZZ2Yv9AHFPN
	GMihRI4xpbo8EgPTTQj5GpY7JgY3frnaiCr+CscQAGR/BkIPN8/Fs9IagWF6MvHa0SaxorwMCbh
	6bRq2z0bsWYpancggLgcs9Ri8zveysQIwhyekAIXjdnV6kEf6wrfgoSexmOCYuTSbmBZ5hzQhM5
	xIlKRUsaWCO6zsSuCUyj/urJxEILI6n8G1+WdeJQ2D/lARKN77JqoyVUyvQ6EkAj07KwU9km3hT
	LcmC9gBullceFo4N3WaAou/7d2g+6JWPY6oee9XLk2fcimNayRKD3dJqITwytTPaaUf4EHJtg1x
	Rjzncuhxd/8um9vIxBsnDpMLFFF/2Xut8ke/ZweA==
X-Received: by 2002:a05:7022:206:b0:137:ea00:3f5d with SMTP id a92af1059eb24-137f6b42772mr829329c88.17.1780477482049;
        Wed, 03 Jun 2026 02:04:42 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.228.214])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f5489d17sm1500666c88.1.2026.06.03.02.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 02:04:41 -0700 (PDT)
Message-Id: <pull.2285.v12.git.git.1780477479.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v11.git.git.1779449498.gitgitgadget@gmail.com>
References: <pull.2285.v11.git.git.1779449498.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 03 Jun 2026 09:04:33 +0000
Subject: [PATCH v12 0/6] branch: prune-merged
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

 * Reworked --forked from a standalone action into a --list-mode filter.
 * Switched --forked and --prune-merged to repeatable OPT_STRING_LIST
   options.
 * Dropped the bare-remote-name resolution for --forked, the argument is now
   a ref or a glob.

Harald Nordgren (6):
  branch: add --forked filter for --list mode
  branch: let delete_branches warn instead of error on bulk refusal
  branch: prepare delete_branches for a bulk caller
  branch: add --prune-merged <branch>
  branch: add branch.<name>.pruneMerged opt-out
  branch: add --dry-run for --prune-merged

 Documentation/config/branch.adoc |   7 +
 Documentation/git-branch.adoc    |  37 ++++
 builtin/branch.c                 | 317 +++++++++++++++++++++++++--
 ref-filter.c                     |  10 +-
 ref-filter.h                     |   2 +
 t/t3200-branch.sh                | 354 +++++++++++++++++++++++++++++++
 6 files changed, 701 insertions(+), 26 deletions(-)


base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2285%2FHaraldNordgren%2Ffetch-prune-local-branches-v12
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2285/HaraldNordgren/fetch-prune-local-branches-v12
Pull-Request: https://github.com/git/git/pull/2285

Range-diff vs v11:

 1:  b9fddd124a ! 1:  8834c424fb branch: add --forked <branch>
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    branch: add --forked <branch>
     +    branch: add --forked filter for --list mode
      
     -    List local branches whose configured upstream
     -    (branch.<name>.merge resolved against branch.<name>.remote)
     -    matches any of the given <branch> arguments.
     +    Add a --forked option to "git branch" list mode that keeps only
     +    branches whose configured upstream matches <branch>. The argument
     +    can be a ref (e.g. "origin/main", "master") or a shell-style
     +    glob (e.g. "origin/*"). The option can be repeated to widen the
     +    filter.
      
     -    Each <branch> is interpreted against the local repository, not
     -    against any specific remote:
     +    Because it is a filter on list mode, --forked composes with the
     +    existing list-mode filters, so
      
     -      * a literal upstream short name, e.g. "origin/main" or "master"
     -        for a branch whose upstream is local;
     -      * a wildmatch pattern, e.g. "origin/*";
     -      * a bare configured-remote name, e.g. "origin", which resolves
     -        to whatever refs/remotes/origin/HEAD points at, matching how
     -        "git checkout -b topic origin" picks a starting point.
     +        git branch --merged origin/main --forked 'origin/*'
      
     -    The literal-vs-wildcard distinction is settled at parse time so
     -    the per-branch matching loop calls wildmatch() only for genuine
     -    wildcards. Multiple <branch> arguments are unioned. Output is
     -    sorted by branch name.
     +    lists branches forked from origin that have already been
     +    integrated into origin/main, and --no-merged inverts the question.
      
          This is the building block for --prune-merged, which deletes the
          listed branches once they have landed on their upstream.
     @@ Commit message
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Documentation/git-branch.adoc ##
     -@@ Documentation/git-branch.adoc: git branch (-m|-M) [<old-branch>] <new-branch>
     - git branch (-c|-C) [<old-branch>] <new-branch>
     - git branch (-d|-D) [-r] <branch-name>...
     - git branch --edit-description [<branch-name>]
     -+git branch --forked <branch>...
     - 
     - DESCRIPTION
     - -----------
     +@@ Documentation/git-branch.adoc: git branch [--color[=<when>] | --no-color] [--show-current]
     + 	   [--merged [<commit>]] [--no-merged [<commit>]]
     + 	   [--contains [<commit>]] [--no-contains [<commit>]]
     + 	   [--points-at <object>] [--format=<format>]
     ++	   [(--forked <branch>)...]
     + 	   [(-r|--remotes) | (-a|--all)]
     + 	   [--list] [<pattern>...]
     + git branch [--track[=(direct|inherit)] | --no-track] [-f]
      @@ Documentation/git-branch.adoc: This option is only applicable in non-verbose mode.
       	Print the name of the current branch. In detached `HEAD` state,
       	nothing is printed.
       
     -+`--forked`::
     -+	List local branches whose configured upstream
     -+	(`branch.<name>.merge` resolved against `branch.<name>.remote`)
     -+	matches any of the given _<branch>_ arguments.
     -++
     -+Each _<branch>_ is interpreted against the local repository: a literal
     -+upstream like `origin/main` or a local branch like `master`, or a
     -+wildmatch pattern like `'origin/*'`.  A bare configured-remote name
     -+(e.g. `origin`) resolves to the target of `refs/remotes/<remote>/HEAD`,
     -+to match the way `git checkout -b topic origin` picks a starting
     -+point.  Multiple _<branch>_ arguments are unioned.
     ++`--forked <branch>`::
     ++	List only branches whose configured upstream matches
     ++	_<branch>_. The argument can be a ref (e.g. `origin/main`,
     ++	`master`) or a shell-style glob (e.g. `'origin/*'`). The
     ++	option can be repeated to widen the filter.
      +
       `-v`::
       `-vv`::
     @@ builtin/branch.c
      +#include "wildmatch.h"
       
       static const char * const builtin_branch_usage[] = {
     - 	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged]"),
     -@@ builtin/branch.c: static const char * const builtin_branch_usage[] = {
     - 	N_("git branch [<options>] (-c | -C) [<old-branch>] <new-branch>"),
     - 	N_("git branch [<options>] [-r | -a] [--points-at]"),
     - 	N_("git branch [<options>] [-r | -a] [--format]"),
     -+	N_("git branch [<options>] --forked <branch>..."),
     - 	NULL
     - };
     +-	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged]"),
     ++	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged] [(--forked <branch>)...]"),
     + 	N_("git branch [<options>] [-f] [--recurse-submodules] <branch-name> [<start-point>]"),
     + 	N_("git branch [<options>] [-l] [<pattern>...]"),
     + 	N_("git branch [<options>] [-r] (-d | -D) <branch-name>..."),
     +@@ builtin/branch.c: static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
     + 	return strbuf_detach(&fmt, NULL);
     + }
     + 
     ++static void filter_array_by_forked(struct ref_array *array,
     ++				   const struct string_list *upstreams);
     ++
     + static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sorting,
     +-			   struct ref_format *format, struct string_list *output)
     ++			   struct ref_format *format, struct string_list *output,
     ++			   const struct string_list *forked_upstreams)
     + {
     + 	int i;
     + 	struct ref_array array;
     +@@ builtin/branch.c: static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
     + 
     + 	filter_refs(&array, filter, filter->kind);
     + 
     ++	if (forked_upstreams->nr)
     ++		filter_array_by_forked(&array, forked_upstreams);
     ++
     + 	if (filter->verbose)
     + 		maxwidth = calc_maxwidth(&array, strlen(remote_prefix));
       
      @@ builtin/branch.c: static void copy_or_rename_branch(const char *oldname, const char *newname, int
       	free_worktrees(worktrees);
     @@ builtin/branch.c: static void copy_or_rename_branch(const char *oldname, const c
      +
      +static int parse_one_forked_arg(const char *arg, struct upstream_pattern *out)
      +{
     -+	struct ref_store *refs = get_main_ref_store(the_repository);
     -+	struct remote *remote;
      +	struct object_id oid;
      +	char *full_ref = NULL;
     -+	struct strbuf head_ref = STRBUF_INIT;
     -+	const char *resolved;
      +
      +	if (has_glob_specials(arg)) {
      +		out->name = xstrdup(arg);
     @@ builtin/branch.c: static void copy_or_rename_branch(const char *oldname, const c
      +		return 0;
      +	}
      +
     -+	remote = remote_get(arg);
     -+	if (remote && remote_is_configured(remote, 0)) {
     -+		strbuf_addf(&head_ref, "refs/remotes/%s/HEAD", remote->name);
     -+		resolved = refs_resolve_ref_unsafe(refs, head_ref.buf,
     -+						   RESOLVE_REF_NO_RECURSE,
     -+						   NULL, NULL);
     -+		if (resolved && starts_with(resolved, "refs/remotes/")) {
     -+			out->name = xstrdup(short_upstream_name(resolved));
     -+			out->is_wildcard = 0;
     -+			strbuf_release(&head_ref);
     -+			return 0;
     -+		}
     -+		strbuf_release(&head_ref);
     -+	}
     -+
      +	if (repo_dwim_ref(the_repository, arg, strlen(arg), &oid,
      +			  &full_ref, 0) == 1 &&
      +	    (starts_with(full_ref, "refs/heads/") ||
     @@ builtin/branch.c: static void copy_or_rename_branch(const char *oldname, const c
      +	return -1;
      +}
      +
     -+static void parse_forked_args(int argc, const char **argv,
     ++static void parse_forked_args(const struct string_list *args,
      +			      struct upstream_pattern **patterns_out,
      +			      size_t *nr_out)
      +{
      +	struct upstream_pattern *patterns;
     -+	int i;
     ++	size_t i;
      +
     -+	ALLOC_ARRAY(patterns, argc);
     -+	for (i = 0; i < argc; i++) {
     -+		if (parse_one_forked_arg(argv[i], &patterns[i]) < 0) {
     ++	ALLOC_ARRAY(patterns, args->nr);
     ++	for (i = 0; i < args->nr; i++) {
     ++		const char *arg = args->items[i].string;
     ++		if (parse_one_forked_arg(arg, &patterns[i]) < 0) {
      +			upstream_pattern_list_clear(patterns, i);
     -+			die(_("'%s' is not a valid branch or pattern"),
     -+			    argv[i]);
     ++			die(_("'%s' is not a valid branch or pattern"), arg);
      +		}
      +	}
      +	*patterns_out = patterns;
     -+	*nr_out = argc;
     ++	*nr_out = args->nr;
      +}
      +
      +static int upstream_matches(const char *short_upstream,
     @@ builtin/branch.c: static void copy_or_rename_branch(const char *oldname, const c
      +	return 0;
      +}
      +
     -+struct forked_cb {
     -+	const struct upstream_pattern *patterns;
     -+	size_t nr_patterns;
     -+	struct string_list *out;
     -+};
     -+
     -+static int collect_forked_branch(const struct reference *ref, void *cb_data)
     ++static int branch_upstream_matches(const char *full_refname,
     ++				   const struct upstream_pattern *patterns,
     ++				   size_t nr_patterns)
      +{
     -+	struct forked_cb *cb = cb_data;
     ++	const char *short_name;
      +	struct branch *branch;
      +	const char *upstream;
      +
     -+	if (ref->flags & REF_ISSYMREF)
     ++	if (!skip_prefix(full_refname, "refs/heads/", &short_name))
      +		return 0;
     -+	branch = branch_get(ref->name);
     ++	branch = branch_get(short_name);
      +	if (!branch)
      +		return 0;
      +	upstream = branch_get_upstream(branch, NULL);
      +	if (!upstream)
      +		return 0;
     -+	if (upstream_matches(short_upstream_name(upstream),
     -+			     cb->patterns, cb->nr_patterns))
     -+		string_list_append(cb->out, ref->name);
     -+	return 0;
     ++	return upstream_matches(short_upstream_name(upstream),
     ++				patterns, nr_patterns);
      +}
      +
     -+static int list_forked_branches(int argc, const char **argv)
     ++static void filter_array_by_forked(struct ref_array *array,
     ++				   const struct string_list *upstreams)
      +{
      +	struct upstream_pattern *patterns = NULL;
      +	size_t nr_patterns = 0;
     -+	struct string_list out = STRING_LIST_INIT_DUP;
     -+	struct string_list_item *item;
     -+	struct forked_cb cb;
     -+
     -+	if (!argc)
     -+		die(_("--forked requires at least one <branch>"));
     ++	int i, kept = 0;
      +
     -+	parse_forked_args(argc, argv, &patterns, &nr_patterns);
     -+	cb.patterns = patterns;
     -+	cb.nr_patterns = nr_patterns;
     -+	cb.out = &out;
     ++	parse_forked_args(upstreams, &patterns, &nr_patterns);
      +
     -+	refs_for_each_branch_ref(get_main_ref_store(the_repository),
     -+				 collect_forked_branch, &cb);
     -+
     -+	string_list_sort(&out);
     -+	for_each_string_list_item(item, &out)
     -+		puts(item->string);
     ++	for (i = 0; i < array->nr; i++) {
     ++		struct ref_array_item *item = array->items[i];
     ++		if (branch_upstream_matches(item->refname,
     ++					    patterns, nr_patterns))
     ++			array->items[kept++] = item;
     ++		else
     ++			free_ref_array_item(item);
     ++	}
     ++	array->nr = kept;
      +
      +	upstream_pattern_list_clear(patterns, nr_patterns);
     -+	string_list_clear(&out, 0);
     -+	return 0;
      +}
      +
       static GIT_PATH_FUNC(edit_description, "EDIT_DESCRIPTION")
     @@ builtin/branch.c: int cmd_branch(int argc,
       	/* possible actions */
       	int delete = 0, rename = 0, copy = 0, list = 0,
       	    unset_upstream = 0, show_current = 0, edit_description = 0;
     -+	int forked = 0;
     ++	struct string_list forked_upstreams = STRING_LIST_INIT_DUP;
       	const char *new_upstream = NULL;
       	int noncreate_actions = 0;
       	/* possible options */
     @@ builtin/branch.c: int cmd_branch(int argc,
       		OPT_BOOL(0, "create-reflog", &reflog, N_("create the branch's reflog")),
       		OPT_BOOL(0, "edit-description", &edit_description,
       			 N_("edit the description for the branch")),
     -+		OPT_BOOL(0, "forked", &forked,
     -+			N_("list local branches whose upstream matches the given <branch>...")),
     ++		OPT_STRING_LIST(0, "forked", &forked_upstreams, N_("branch"),
     ++			N_("list local branches whose upstream matches <branch> (repeatable)")),
       		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
       		OPT_MERGED(&filter, N_("print only branches that are merged")),
       		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
      @@ builtin/branch.c: int cmd_branch(int argc,
     - 			     0);
     - 
     - 	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
     --	    !show_current && !unset_upstream && argc == 0)
     -+	    !show_current && !unset_upstream && !forked && argc == 0)
       		list = 1;
       
       	if (filter.with_commit || filter.no_commit ||
     -@@ builtin/branch.c: int cmd_branch(int argc,
     +-	    filter.reachable_from || filter.unreachable_from || filter.points_at.nr)
     ++	    filter.reachable_from || filter.unreachable_from ||
     ++	    filter.points_at.nr || forked_upstreams.nr)
     + 		list = 1;
       
       	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
     - 			    !!show_current + !!list + !!edit_description +
     --			    !!unset_upstream;
     -+			    !!unset_upstream + !!forked;
     - 	if (noncreate_actions > 1)
     - 		usage_with_options(builtin_branch_usage, options);
     - 
      @@ builtin/branch.c: int cmd_branch(int argc,
     - 			die(_("branch name required"));
     - 		ret = delete_branches(argc, argv, delete > 1, filter.kind, quiet);
     - 		goto out;
     -+	} else if (forked) {
     -+		ret = list_forked_branches(argc, argv);
     -+		goto out;
     - 	} else if (show_current) {
     - 		print_current_branch_name();
     - 		ret = 0;
     + 		ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
     + 		ref_sorting_set_sort_flags_all(
     + 			sorting, REF_SORTING_DETACHED_HEAD_FIRST, 1);
     +-		print_ref_list(&filter, sorting, &format, &output);
     ++		print_ref_list(&filter, sorting, &format, &output,
     ++			       &forked_upstreams);
     + 		print_columns(&output, colopts, NULL);
     + 		string_list_clear(&output, 0);
     + 		ref_sorting_release(sorting);
     +@@ builtin/branch.c: int cmd_branch(int argc,
     + 
     + out:
     + 	string_list_clear(&sorting_options, 0);
     ++	string_list_clear(&forked_upstreams, 0);
     + 	return ret;
     + }
     +
     + ## ref-filter.c ##
     +@@ ref-filter.c: static int filter_one(const struct reference *ref, void *cb_data)
     + }
     + 
     + /*  Free memory allocated for a ref_array_item */
     +-static void free_array_item(struct ref_array_item *item)
     ++void free_ref_array_item(struct ref_array_item *item)
     + {
     + 	free((char *)item->symref);
     + 	if (item->value) {
     +@@ ref-filter.c: static int filter_and_format_one(const struct reference *ref, void *cb_data)
     + 
     + 	strbuf_release(&output);
     + 	strbuf_release(&err);
     +-	free_array_item(item);
     ++	free_ref_array_item(item);
     + 
     + 	/*
     + 	 * Increment the running count of refs that match the filter. If
     +@@ ref-filter.c: void ref_array_clear(struct ref_array *array)
     + 	int i;
     + 
     + 	for (i = 0; i < array->nr; i++)
     +-		free_array_item(array->items[i]);
     ++		free_ref_array_item(array->items[i]);
     + 	FREE_AND_NULL(array->items);
     + 	array->nr = array->alloc = 0;
     + 
     +@@ ref-filter.c: static void reach_filter(struct ref_array *array,
     + 		if (is_merged == include_reached)
     + 			array->items[array->nr++] = array->items[i];
     + 		else
     +-			free_array_item(item);
     ++			free_ref_array_item(item);
     + 	}
     + 
     + 	clear_commit_marks_many(old_nr, to_clear, ALL_REV_FLAGS);
     +@@ ref-filter.c: void pretty_print_ref(const char *name, const struct object_id *oid,
     + 
     + 	strbuf_release(&err);
     + 	strbuf_release(&output);
     +-	free_array_item(ref_item);
     ++	free_ref_array_item(ref_item);
     + }
     + 
     + static int parse_sorting_atom(const char *atom)
     +
     + ## ref-filter.h ##
     +@@ ref-filter.h: void filter_and_format_refs(struct ref_filter *filter, unsigned int type,
     + 			    struct ref_format *format);
     + /*  Clear all memory allocated to ref_array */
     + void ref_array_clear(struct ref_array *array);
     ++/*  Free a single item from a ref_array */
     ++void free_ref_array_item(struct ref_array_item *item);
     + /*  Used to verify if the given format is correct and to parse out the used atoms */
     + int verify_ref_format(struct ref_format *format);
     + /*  Sort the given ref_array as per the ref_sorting provided */
      
       ## t/t3200-branch.sh ##
      @@ t/t3200-branch.sh: test_expect_success 'errors if given a bad branch name' '
     @@ t/t3200-branch.sh: test_expect_success 'errors if given a bad branch name' '
      +	git -C forked branch --track local-trunk local-base
      +'
      +
     -+test_expect_success '--forked <upstream-tracking-branch> lists matching branches' '
     -+	git -C forked branch --forked origin/one >actual &&
     ++test_expect_success '--forked <upstream-tracking-branch> filters by upstream' '
     ++	git -C forked branch --forked origin/one --format="%(refname:short)" >actual &&
      +	echo local-one >expect &&
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success '--forked <glob> matches by wildmatch' '
     -+	git -C forked branch --forked "origin/*" >actual &&
     ++test_expect_success '--forked <glob> filters by wildmatch' '
     ++	git -C forked branch --forked "origin/*" --format="%(refname:short)" >actual &&
      +	cat >expect <<-\EOF &&
      +	local-one
      +	local-two
     @@ t/t3200-branch.sh: test_expect_success 'errors if given a bad branch name' '
      +'
      +
      +test_expect_success '--forked <local-branch> matches branches with local upstream' '
     -+	git -C forked branch --forked local-base >actual &&
     ++	git -C forked branch --forked local-base --format="%(refname:short)" >actual &&
      +	echo local-trunk >expect &&
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success '--forked <remote> resolves via refs/remotes/<remote>/HEAD' '
     -+	test_when_finished "git -C forked symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/main" &&
     -+	git -C forked symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/one &&
     -+	git -C forked branch --forked origin >actual &&
     -+	echo local-one >expect &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success '--forked unions multiple <branch> arguments' '
     -+	git -C forked branch --forked origin/one other/foreign >actual &&
     ++test_expect_success '--forked can be repeated to widen the filter' '
     ++	git -C forked branch --forked origin/one --forked other/foreign --format="%(refname:short)" >actual &&
      +	cat >expect <<-\EOF &&
      +	local-foreign
      +	local-one
     @@ t/t3200-branch.sh: test_expect_success 'errors if given a bad branch name' '
      +'
      +
      +test_expect_success '--forked combines literal and glob arguments' '
     -+	git -C forked branch --forked local-base "other/*" >actual &&
     ++	git -C forked branch --forked local-base --forked "other/*" --format="%(refname:short)" >actual &&
      +	cat >expect <<-\EOF &&
      +	local-foreign
      +	local-trunk
     @@ t/t3200-branch.sh: test_expect_success 'errors if given a bad branch name' '
      +'
      +
      +test_expect_success '--forked "*/*" covers every remote-tracking upstream' '
     -+	git -C forked branch --forked "*/*" >actual &&
     ++	git -C forked branch --forked "*/*" --format="%(refname:short)" >actual &&
      +	cat >expect <<-\EOF &&
      +	local-foreign
      +	local-one
     @@ t/t3200-branch.sh: test_expect_success 'errors if given a bad branch name' '
      +	test_cmp expect actual
      +'
      +
     ++test_expect_success '--forked composes with --no-merged' '
     ++	test_when_finished "git -C forked checkout detached" &&
     ++	git -C forked checkout local-one &&
     ++	test_commit -C forked local-only &&
     ++	git -C forked branch --forked "origin/*" --no-merged origin/one \
     ++		--format="%(refname:short)" >actual &&
     ++	echo local-one >expect &&
     ++	test_cmp expect actual
     ++'
     ++
      +test_expect_success '--forked rejects unknown branch/pattern' '
      +	test_must_fail git -C forked branch --forked nope 2>err &&
      +	test_grep "not a valid branch or pattern" err
      +'
      +
     -+test_expect_success '--forked requires at least one <branch>' '
     ++test_expect_success '--forked requires a value' '
      +	test_must_fail git -C forked branch --forked 2>err &&
     -+	test_grep "at least one <branch>" err
     ++	test_grep "requires a value" err
      +'
      +
       test_done
 2:  b666d09bf5 ! 2:  6c95e4e77c branch: let delete_branches warn instead of error on bulk refusal
     @@ Commit message
          so a bulk caller can report not-fully-merged branches as one-line
          warnings and continue, instead of erroring with the four-line "use
          'git branch -D'" advice that the standalone "git branch -d" path
     -    emits.  Default callers pass 0 and are unaffected.
     +    emits. Default callers pass 0 and are unaffected.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ builtin/branch.c: int cmd_branch(int argc,
      +		ret = delete_branches(argc, argv, delete > 1, filter.kind,
      +				      quiet, 0);
       		goto out;
     - 	} else if (forked) {
     - 		ret = list_forked_branches(argc, argv);
     + 	} else if (show_current) {
     + 		print_current_branch_name();
 3:  6e6580270e ! 3:  004a96f7a4 branch: prepare delete_branches for a bulk caller
     @@ Metadata
       ## Commit message ##
          branch: prepare delete_branches for a bulk caller
      
     -    Add no_head_fallback and dry_run flags to delete_branches() so a bulk
     -    caller (the upcoming --prune-merged) can ask strictly about
     -    merged-into-upstream without a silent fallback to HEAD, and rehearse
     -    deletions with the same "Would delete branch ..." wording as the live
     -    run.  Existing callers pass 0 for both and keep current behavior.
     +    Add no_head_fallback and dry_run flags to delete_branches() so a
     +    bulk caller (the upcoming --prune-merged) can ask strictly about
     +    merged-into-upstream without a silent fallback to HEAD, and
     +    rehearse deletions with the same "Would delete branch ..." wording
     +    as the live run. Existing callers pass 0 for both and keep current
     +    behavior.
      
          When no_head_fallback is set, head_rev stays NULL through to
          branch_merged(), whose "merged to X but not yet merged to HEAD"
     -    reminder otherwise compares against HEAD.  That reminder is only
     -    meaningful when the caller actually cares about HEAD; for the
     -    bulk caller every candidate is known to have an upstream and HEAD
     -    is irrelevant to the decision.  Guard the block on head_rev so the
     -    NULL case skips it instead of treating "NULL != reference_rev" as
     -    "diverges from HEAD" and emitting a spurious warning.
     +    reminder otherwise compares against HEAD. For the bulk caller
     +    every candidate is known to have an upstream, so HEAD is
     +    irrelevant. Guard the block on head_rev so the NULL case skips
     +    it instead of treating "NULL != reference_rev" as "diverges from
     +    HEAD" and emitting a spurious warning.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ builtin/branch.c: int cmd_branch(int argc,
      -				      quiet, 0);
      +				      quiet, 0, 0, 0);
       		goto out;
     - 	} else if (forked) {
     - 		ret = list_forked_branches(argc, argv);
     + 	} else if (show_current) {
     + 		print_current_branch_name();
 4:  e7e03c1338 ! 4:  cccfdb831c branch: add --prune-merged <branch>
     @@ Commit message
          upstream: the work has already landed on the upstream they track,
          so the local copy is no longer needed.
      
     -    Reachability is read from the local refs only -- nothing is
     -    fetched. Users who want fresh upstream refs run "git fetch" first;
     -    the deletion path stays a separate, idempotent step that also
     -    works offline.
     +    Reachability is read from local refs; nothing is fetched. Users
     +    who want fresh upstream refs run "git fetch" first.
      
          Three classes of branches are spared:
      
     @@ Commit message
            * any branch whose push destination equals its upstream
              (<branch>@{push} == <branch>@{upstream}). Such a branch
              cannot be distinguished from a freshly pulled trunk that
     -        just looks "fully merged" -- e.g. local "main" tracking and
     +        just looks "fully merged", e.g. local "main" tracking and
              pushing to "origin/main" right after a pull. Only branches
              that push somewhere other than their upstream (typically
              topics in a fork-based workflow) are treated as candidates.
     @@ Commit message
          mode and with the HEAD-fallback disabled: a branch that is not
          yet fully merged to its upstream is reported as a one-line warning
          and skipped, so a single un-mergeable topic does not abort the
     -    whole sweep, and there is no fallback to "merged into the
     -    currently checked out branch" -- we only act on upstream-merged
     -    status.
     +    whole sweep. We only act on upstream-merged status.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Documentation/git-branch.adoc ##
     -@@ Documentation/git-branch.adoc: git branch (-c|-C) [<old-branch>] <new-branch>
     +@@ Documentation/git-branch.adoc: git branch (-m|-M) [<old-branch>] <new-branch>
     + git branch (-c|-C) [<old-branch>] <new-branch>
       git branch (-d|-D) [-r] <branch-name>...
       git branch --edit-description [<branch-name>]
     - git branch --forked <branch>...
     -+git branch --prune-merged <branch>...
     ++git branch (--prune-merged <branch>)...
       
       DESCRIPTION
       -----------
     -@@ Documentation/git-branch.adoc: wildmatch pattern like `'origin/*'`.  A bare configured-remote name
     - to match the way `git checkout -b topic origin` picks a starting
     - point.  Multiple _<branch>_ arguments are unioned.
     +@@ Documentation/git-branch.adoc: This option is only applicable in non-verbose mode.
     + 	`master`) or a shell-style glob (e.g. `'origin/*'`). The
     + 	option can be repeated to widen the filter.
       
     -+`--prune-merged`::
     ++`--prune-merged <branch>`::
      +	Delete the local branches that `--forked` would list for the
     -+	same _<branch>_ arguments, but only those whose tip is
     -+	reachable from their configured upstream.  In other words,
     -+	the work on the branch has already landed on the upstream it
     -+	tracks, so the local copy is no longer needed.
     ++	same _<branch>_, but only those whose tip is reachable from
     ++	their configured upstream. In other words, the work on the
     ++	branch has already landed on the upstream it tracks, so the
     ++	local copy is no longer needed. May be given more than once to
     ++	union the matches; positional arguments are not accepted.
      ++
      +Reachability is checked against whatever the upstream refs say
     -+locally; nothing is fetched.  Run `git fetch` first if you want
     ++locally; nothing is fetched. Run `git fetch` first if you want
      +the upstream refs refreshed.
      ++
      +A branch is left alone if any of the following holds:
     @@ Documentation/git-branch.adoc: wildmatch pattern like `'origin/*'`.  A bare conf
       `--verbose`::
      
       ## builtin/branch.c ##
     -@@ builtin/branch.c: static int collect_forked_branch(const struct reference *ref, void *cb_data)
     +@@ builtin/branch.c: static const char * const builtin_branch_usage[] = {
     + 	N_("git branch [<options>] (-c | -C) [<old-branch>] <new-branch>"),
     + 	N_("git branch [<options>] [-r | -a] [--points-at]"),
     + 	N_("git branch [<options>] [-r | -a] [--format]"),
     ++	N_("git branch [<options>] (--prune-merged <branch>)..."),
     + 	NULL
     + };
     + 
     +@@ builtin/branch.c: static int upstream_matches(const char *short_upstream,
       	return 0;
       }
       
     --static int list_forked_branches(int argc, const char **argv)
     -+static void collect_forked_set(int argc, const char **argv,
     -+			       struct string_list *out)
     +-static int branch_upstream_matches(const char *full_refname,
     ++static int branch_upstream_matches(const char *short_branch_name,
     + 				   const struct upstream_pattern *patterns,
     + 				   size_t nr_patterns)
       {
     - 	struct upstream_pattern *patterns = NULL;
     - 	size_t nr_patterns = 0;
     --	struct string_list out = STRING_LIST_INIT_DUP;
     --	struct string_list_item *item;
     - 	struct forked_cb cb;
     +-	const char *short_name;
     +-	struct branch *branch;
     ++	struct branch *branch = branch_get(short_branch_name);
     + 	const char *upstream;
       
     --	if (!argc)
     --		die(_("--forked requires at least one <branch>"));
     --
     - 	parse_forked_args(argc, argv, &patterns, &nr_patterns);
     - 	cb.patterns = patterns;
     - 	cb.nr_patterns = nr_patterns;
     --	cb.out = &out;
     -+	cb.out = out;
     +-	if (!skip_prefix(full_refname, "refs/heads/", &short_name))
     +-		return 0;
     +-	branch = branch_get(short_name);
     + 	if (!branch)
     + 		return 0;
     + 	upstream = branch_get_upstream(branch, NULL);
     +@@ builtin/branch.c: static void filter_array_by_forked(struct ref_array *array,
       
     - 	refs_for_each_branch_ref(get_main_ref_store(the_repository),
     - 				 collect_forked_branch, &cb);
     + 	for (i = 0; i < array->nr; i++) {
     + 		struct ref_array_item *item = array->items[i];
     +-		if (branch_upstream_matches(item->refname,
     +-					    patterns, nr_patterns))
     ++		const char *short_name;
     ++		if (skip_prefix(item->refname, "refs/heads/", &short_name) &&
     ++		    branch_upstream_matches(short_name, patterns, nr_patterns))
     + 			array->items[kept++] = item;
     + 		else
     + 			free_ref_array_item(item);
     +@@ builtin/branch.c: static void filter_array_by_forked(struct ref_array *array,
     + 	upstream_pattern_list_clear(patterns, nr_patterns);
     + }
       
     --	string_list_sort(&out);
     -+	string_list_sort(out);
     ++struct forked_cb {
     ++	const struct upstream_pattern *patterns;
     ++	size_t nr_patterns;
     ++	struct string_list *out;
     ++};
      +
     -+	upstream_pattern_list_clear(patterns, nr_patterns);
     ++static int collect_forked_branch(const struct reference *ref, void *cb_data)
     ++{
     ++	struct forked_cb *cb = cb_data;
     ++
     ++	if (ref->flags & REF_ISSYMREF)
     ++		return 0;
     ++	if (branch_upstream_matches(ref->name, cb->patterns, cb->nr_patterns))
     ++		string_list_append(cb->out, ref->name);
     ++	return 0;
      +}
      +
     -+static int list_forked_branches(int argc, const char **argv)
     ++static void collect_forked_set(const struct string_list *upstreams,
     ++			       struct string_list *out)
      +{
     -+	struct string_list out = STRING_LIST_INIT_DUP;
     -+	struct string_list_item *item;
     ++	struct upstream_pattern *patterns = NULL;
     ++	size_t nr_patterns = 0;
     ++	struct forked_cb cb;
      +
     -+	if (!argc)
     -+		die(_("--forked requires at least one <branch>"));
     ++	parse_forked_args(upstreams, &patterns, &nr_patterns);
     ++	cb.patterns = patterns;
     ++	cb.nr_patterns = nr_patterns;
     ++	cb.out = out;
      +
     -+	collect_forked_set(argc, argv, &out);
     - 	for_each_string_list_item(item, &out)
     - 		puts(item->string);
     - 
     --	upstream_pattern_list_clear(patterns, nr_patterns);
     - 	string_list_clear(&out, 0);
     - 	return 0;
     - }
     - 
     -+static int prune_merged_branches(int argc, const char **argv, int quiet)
     ++	refs_for_each_branch_ref(get_main_ref_store(the_repository),
     ++				 collect_forked_branch, &cb);
     ++
     ++	string_list_sort(out);
     ++
     ++	upstream_pattern_list_clear(patterns, nr_patterns);
     ++}
     ++
     ++static int prune_merged_branches(const struct string_list *upstreams,
     ++				 int quiet)
      +{
      +	struct ref_store *refs = get_main_ref_store(the_repository);
      +	struct string_list candidates = STRING_LIST_INIT_DUP;
     @@ builtin/branch.c: static int collect_forked_branch(const struct reference *ref,
      +	struct string_list_item *item;
      +	int ret = 0;
      +
     -+	if (!argc)
     ++	if (!upstreams->nr)
      +		die(_("--prune-merged requires at least one <branch>"));
      +
     -+	collect_forked_set(argc, argv, &candidates);
     ++	collect_forked_set(upstreams, &candidates);
      +
      +	for_each_string_list_item(item, &candidates) {
      +		const char *short_name = item->string;
     @@ builtin/branch.c: static int collect_forked_branch(const struct reference *ref,
      @@ builtin/branch.c: int cmd_branch(int argc,
       	int delete = 0, rename = 0, copy = 0, list = 0,
       	    unset_upstream = 0, show_current = 0, edit_description = 0;
     - 	int forked = 0;
     -+	int prune_merged = 0;
     + 	struct string_list forked_upstreams = STRING_LIST_INIT_DUP;
     ++	struct string_list prune_merged_upstreams = STRING_LIST_INIT_DUP;
       	const char *new_upstream = NULL;
       	int noncreate_actions = 0;
       	/* possible options */
      @@ builtin/branch.c: int cmd_branch(int argc,
       			 N_("edit the description for the branch")),
     - 		OPT_BOOL(0, "forked", &forked,
     - 			N_("list local branches whose upstream matches the given <branch>...")),
     -+		OPT_BOOL(0, "prune-merged", &prune_merged,
     -+			N_("delete local branches whose upstream matches the given <branch>... and is merged")),
     + 		OPT_STRING_LIST(0, "forked", &forked_upstreams, N_("branch"),
     + 			N_("list local branches whose upstream matches <branch> (repeatable)")),
     ++		OPT_STRING_LIST(0, "prune-merged", &prune_merged_upstreams, N_("branch"),
     ++			N_("delete local branches whose upstream matches <branch> and is merged (repeatable)")),
       		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
       		OPT_MERGED(&filter, N_("print only branches that are merged")),
       		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
     @@ builtin/branch.c: int cmd_branch(int argc,
       			     0);
       
       	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
     --	    !show_current && !unset_upstream && !forked && argc == 0)
     -+	    !show_current && !unset_upstream && !forked && !prune_merged &&
     +-	    !show_current && !unset_upstream && argc == 0)
     ++	    !show_current && !unset_upstream && !prune_merged_upstreams.nr &&
      +	    argc == 0)
       		list = 1;
       
     @@ builtin/branch.c: int cmd_branch(int argc,
       
       	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
       			    !!show_current + !!list + !!edit_description +
     --			    !!unset_upstream + !!forked;
     -+			    !!unset_upstream + !!forked + !!prune_merged;
     +-			    !!unset_upstream;
     ++			    !!unset_upstream + !!prune_merged_upstreams.nr;
       	if (noncreate_actions > 1)
       		usage_with_options(builtin_branch_usage, options);
       
      @@ builtin/branch.c: int cmd_branch(int argc,
     - 	} else if (forked) {
     - 		ret = list_forked_branches(argc, argv);
     + 		ret = delete_branches(argc, argv, delete > 1, filter.kind,
     + 				      quiet, 0, 0, 0);
       		goto out;
     -+	} else if (prune_merged) {
     -+		ret = prune_merged_branches(argc, argv, quiet);
     ++	} else if (prune_merged_upstreams.nr) {
     ++		if (argc)
     ++			die(_("--prune-merged does not take positional arguments; "
     ++			      "repeat --prune-merged for each <branch>"));
     ++		ret = prune_merged_branches(&prune_merged_upstreams, quiet);
      +		goto out;
       	} else if (show_current) {
       		print_current_branch_name();
       		ret = 0;
     +@@ builtin/branch.c: int cmd_branch(int argc,
     + out:
     + 	string_list_clear(&sorting_options, 0);
     + 	string_list_clear(&forked_upstreams, 0);
     ++	string_list_clear(&prune_merged_upstreams, 0);
     + 	return ret;
     + }
      
       ## t/t3200-branch.sh ##
     -@@ t/t3200-branch.sh: test_expect_success '--forked requires at least one <branch>' '
     - 	test_grep "at least one <branch>" err
     +@@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
     + 	test_grep "requires a value" err
       '
       
      +test_expect_success '--prune-merged: setup' '
     @@ t/t3200-branch.sh: test_expect_success '--forked requires at least one <branch>'
      +	git -C pm-union branch --set-upstream-to=origin/main two &&
      +	git -C pm-union checkout --detach &&
      +
     -+	git -C pm-union branch --prune-merged origin/next origin/main &&
     ++	git -C pm-union branch --prune-merged origin/next --prune-merged origin/main &&
      +
      +	test_must_fail git -C pm-union rev-parse --verify refs/heads/one &&
      +	test_must_fail git -C pm-union rev-parse --verify refs/heads/two
     @@ t/t3200-branch.sh: test_expect_success '--forked requires at least one <branch>'
      +	test_must_fail git -C pm-push-diff rev-parse --verify refs/heads/topic
      +'
      +
     -+test_expect_success '--prune-merged requires at least one <branch>' '
     ++test_expect_success '--prune-merged requires a value' '
      +	test_must_fail git -C forked branch --prune-merged 2>err &&
     -+	test_grep "at least one <branch>" err
     ++	test_grep "requires a value" err
     ++'
     ++
     ++test_expect_success '--prune-merged rejects positional arguments' '
     ++	test_must_fail git -C forked branch --prune-merged origin/one other/foreign 2>err &&
     ++	test_grep "does not take positional arguments" err
      +'
      +
       test_done
 5:  75b6d2366a ! 5:  5f793f8d0d branch: add branch.<name>.pruneMerged opt-out
     @@ Documentation/git-branch.adoc: the upstream refs refreshed.
       warnings and skipped; pass them to `git branch -D` explicitly if
      
       ## builtin/branch.c ##
     -@@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv, int quiet)
     +@@ builtin/branch.c: static int prune_merged_branches(const struct string_list *upstreams,
       		struct branch *branch = branch_get(short_name);
       		const char *upstream, *push;
       		struct strbuf full = STRBUF_INIT;
     @@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv,
       
       		strbuf_addf(&full, "refs/heads/%s", short_name);
       		skip = !!branch_checked_out(full.buf);
     -@@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv, int quiet)
     +@@ builtin/branch.c: static int prune_merged_branches(const struct string_list *upstreams,
       		if (!push || !strcmp(push, upstream))
       			continue;
       
     @@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv,
       
      
       ## t/t3200-branch.sh ##
     -@@ t/t3200-branch.sh: test_expect_success '--prune-merged requires at least one <branch>' '
     - 	test_grep "at least one <branch>" err
     +@@ t/t3200-branch.sh: test_expect_success '--prune-merged rejects positional arguments' '
     + 	test_grep "does not take positional arguments" err
       '
       
      +test_expect_success '--prune-merged honours branch.<name>.pruneMerged=false' '
 6:  a1a42a6b19 ! 6:  1a0d5eab15 branch: add --dry-run for --prune-merged
     @@ Commit message
          branch: add --dry-run for --prune-merged
      
          With --dry-run, --prune-merged prints the local branches it would
     -    delete -- one "Would delete branch <name>" line per candidate --
     -    and exits without touching any ref.
     +    delete, one "Would delete branch <name>" line per candidate, and
     +    exits without touching any ref.
      
     -    This is the natural sanity check before letting a broad pattern
     -    like 'origin/*' run for real: the @{push}-vs-@{upstream} and
     -    unmerged filtering still applies, so the dry-run output is
     -    exactly the set that the live run would delete.
     +    The @{push}-vs-@{upstream} and unmerged filtering still applies,
     +    so the dry-run output is exactly the set that the live run would
     +    delete.
      
          --dry-run is only meaningful in combination with --prune-merged
          and is rejected otherwise.
     @@ Commit message
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Documentation/git-branch.adoc ##
     -@@ Documentation/git-branch.adoc: git branch (-c|-C) [<old-branch>] <new-branch>
     +@@ Documentation/git-branch.adoc: git branch (-m|-M) [<old-branch>] <new-branch>
     + git branch (-c|-C) [<old-branch>] <new-branch>
       git branch (-d|-D) [-r] <branch-name>...
       git branch --edit-description [<branch-name>]
     - git branch --forked <branch>...
     --git branch --prune-merged <branch>...
     -+git branch --prune-merged [--dry-run] <branch>...
     +-git branch (--prune-merged <branch>)...
     ++git branch [--dry-run] (--prune-merged <branch>)...
       
       DESCRIPTION
       -----------
     @@ Documentation/git-branch.adoc: Branches refused by the "fully merged" safety che
       `--verbose`::
      
       ## builtin/branch.c ##
     -@@ builtin/branch.c: static int list_forked_branches(int argc, const char **argv)
     - 	return 0;
     +@@ builtin/branch.c: static void collect_forked_set(const struct string_list *upstreams,
       }
       
     --static int prune_merged_branches(int argc, const char **argv, int quiet)
     -+static int prune_merged_branches(int argc, const char **argv, int quiet,
     -+				 int dry_run)
     + static int prune_merged_branches(const struct string_list *upstreams,
     +-				 int quiet)
     ++				 int quiet, int dry_run)
       {
       	struct ref_store *refs = get_main_ref_store(the_repository);
       	struct string_list candidates = STRING_LIST_INIT_DUP;
     -@@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv, int quiet)
     +@@ builtin/branch.c: static int prune_merged_branches(const struct string_list *upstreams,
       				      quiet,
       				      1, /* warn_only */
       				      1, /* no_head_fallback */
     @@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv,
       	string_list_clear(&candidates, 0);
      @@ builtin/branch.c: int cmd_branch(int argc,
       	    unset_upstream = 0, show_current = 0, edit_description = 0;
     - 	int forked = 0;
     - 	int prune_merged = 0;
     + 	struct string_list forked_upstreams = STRING_LIST_INIT_DUP;
     + 	struct string_list prune_merged_upstreams = STRING_LIST_INIT_DUP;
      +	int dry_run = 0;
       	const char *new_upstream = NULL;
       	int noncreate_actions = 0;
       	/* possible options */
      @@ builtin/branch.c: int cmd_branch(int argc,
     - 			N_("list local branches whose upstream matches the given <branch>...")),
     - 		OPT_BOOL(0, "prune-merged", &prune_merged,
     - 			N_("delete local branches whose upstream matches the given <branch>... and is merged")),
     + 			N_("list local branches whose upstream matches <branch> (repeatable)")),
     + 		OPT_STRING_LIST(0, "prune-merged", &prune_merged_upstreams, N_("branch"),
     + 			N_("delete local branches whose upstream matches <branch> and is merged (repeatable)")),
      +		OPT_BOOL(0, "dry-run", &dry_run,
      +			N_("with --prune-merged, only print which branches would be deleted")),
       		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
     @@ builtin/branch.c: int cmd_branch(int argc,
       	if (noncreate_actions > 1)
       		usage_with_options(builtin_branch_usage, options);
       
     -+	if (dry_run && !prune_merged)
     ++	if (dry_run && !prune_merged_upstreams.nr)
      +		die(_("--dry-run requires --prune-merged"));
      +
       	if (recurse_submodules_explicit) {
       		if (!submodule_propagate_branches)
       			die(_("branch with --recurse-submodules can only be used if submodule.propagateBranches is enabled"));
      @@ builtin/branch.c: int cmd_branch(int argc,
     - 		ret = list_forked_branches(argc, argv);
     - 		goto out;
     - 	} else if (prune_merged) {
     --		ret = prune_merged_branches(argc, argv, quiet);
     -+		ret = prune_merged_branches(argc, argv, quiet, dry_run);
     + 		if (argc)
     + 			die(_("--prune-merged does not take positional arguments; "
     + 			      "repeat --prune-merged for each <branch>"));
     +-		ret = prune_merged_branches(&prune_merged_upstreams, quiet);
     ++		ret = prune_merged_branches(&prune_merged_upstreams, quiet, dry_run);
       		goto out;
       	} else if (show_current) {
       		print_current_branch_name();
     @@ t/t3200-branch.sh: test_expect_success 'branch -d still deletes a pruneMerged=fa
      +	git -C pm-dry branch two two-commit &&
      +	git -C pm-dry branch --set-upstream-to=origin/next two &&
      +
     -+	git -C pm-dry branch --prune-merged --dry-run "origin/*" >actual &&
     ++	git -C pm-dry branch --dry-run --prune-merged "origin/*" >actual &&
      +	test_grep "Would delete branch one " actual &&
      +	test_grep "Would delete branch two " actual &&
      +
     @@ t/t3200-branch.sh: test_expect_success 'branch -d still deletes a pruneMerged=fa
      +	git -C pm-dry-mixed branch merged one-commit &&
      +	git -C pm-dry-mixed branch --set-upstream-to=origin/next merged &&
      +
     -+	git -C pm-dry-mixed branch --prune-merged --dry-run "origin/*" >out &&
     ++	git -C pm-dry-mixed branch --dry-run --prune-merged "origin/*" >out &&
      +	test_grep "Would delete branch merged" out &&
      +	test_grep ! "Would delete branch wip" out &&
      +	git -C pm-dry-mixed rev-parse --verify refs/heads/wip &&

-- 
gitgitgadget
