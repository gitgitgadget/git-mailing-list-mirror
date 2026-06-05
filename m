Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366F43FBEB9
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684560; cv=none; b=EkvKD1SFzMf14jME9HjbBzWxFep7SItevb+Z5X4Y2KyzzqX/bbYu5FIVCJhd3yslnS7lbc3Vp/evGuyr80kzU8xLQyKcDyDt3DbriDcj9v1FjbDwRyJP7j4Jsxx5er3P+6pl/8Oi2S2VG/gV3jbkxv9mOew4EMdOewKNRidqguM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684560; c=relaxed/simple;
	bh=7OVva4XwB3AQwtL1UZhqfHxLOtLCESu+4LNGZwG1gK0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JdhI9qOfj9Dh63gKkBsE5ADErwkRnGm42pvRYVOGVi9PowM4s/BKDomgqNPa7268x2CVpvH/IvXjJJ3Qs7PfemK0ehEA4pHRzsxSzo9uibEch+2Uk+8g5m6s85yVc3go1TkhPX8mv1ahjGfld/4So7WvRERGtsiXsK8c7KAQhLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itCft7js; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itCft7js"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-137dd5161feso4634719c88.1
        for <git@vger.kernel.org>; Fri, 05 Jun 2026 11:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780684555; x=1781289355; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vl8DRL3Xi2wqbKU6/PR4VFRbJjhn0lnu93XF/obsveE=;
        b=itCft7js4XckFMrp3nHn/AXUPbgcxI3gi6aaEBDq1hSOxrGUncCcQoYs1L31NuEn1a
         vHDpEX/yG42DX3w/GO551hb4RkneDZ/TBmUVX8L/hy/87xya75gEFIYKz6E55MXlu2lC
         P4mHnG0HnCMnnrrDwoBaKD5wW5jIoNuDR3SMfXR78+B3s0CyrlGQifMTbWeIroVZJbsD
         LYadiq2ffv7rUz7/P6EceYyYb0W3GOKtzbfK7mNTAjcEAfv0Yfee/KTpuqpK9tOdjvsW
         UJNfRWcKWh4pKiSVYh3QMR+1wsjF5MpLt5+duo2VTh6jlHmU9KzUaIHZEHYzppswea+a
         scYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780684555; x=1781289355;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vl8DRL3Xi2wqbKU6/PR4VFRbJjhn0lnu93XF/obsveE=;
        b=A4PU2TkSxv4C4X30GuIi0h0NBsRLGSazPJ2AZnIVI/OhzhVThK+4usGN4YR5qUqG0/
         fd+fpNfnYA2GbjczsbjqEfLefk/vhyrL8m7ZTHRlR5ZmKHQkg5mFtHc/JE5kmDUfPE9W
         TKgQmF2oFmO09gpqEJMgo6R/pwTpDLaS6LUBd2AvfI8jtZWQ9xLeltjJsQcUYeckrTx8
         x6UmX/ejf1A4fAk2zr+4jq7SpN5va/KgtFqMeojxo6Jms3SiBtudTwgjI2XO77Dl31Ow
         CGjrcyslf7qWHFgKfs7noxjHdlnKvz5n05BcbvBBfSVBGqFu9HpKrdjqtV957scH9r+y
         sL9Q==
X-Gm-Message-State: AOJu0YwJ8TiePKUdW52t8WLx4wUE5YjBjqqsRQHwIjdqdLsKu+/AfDeF
	xm+IqondAsvs5i7Bi2aKFptGiwHVlXB1CzubDulMcIXIYI15TIt4FOqp3OOZog==
X-Gm-Gg: Acq92OF3rKJO+v7p0Vy5SR6a1cFej7OpJvCj9mdEp419utsVFI6yrAgomULdyREeKio
	h6hlyj+5T/GR9lk2J2g9l5TFFPjxhEgpfONXajuwvDNRdvURa+6Rql5CmOR1igN0xRrtaBcL9/B
	jcIV+fTu6zgLiH8yLyU/a2micg6UGdkI9pteWMD57EET5Gvl6MCIn3iYwlo7AFIu+m0NTzn690v
	NBm7ELpbl/09E50rRvYnO9694fkCxYXxiN8WkbqgzMlT0nlHpIynCiynHYaH8sJXqwadSOJNe9P
	8S0pKuTN8LmkJXZwu7YQrNcGswcOEYemrIEHNzfvoyzG5aKO1OzJfhA2TPYTwjXdqWHTn0BLq9D
	z68clGJqS3egvgYcp0xH5qB+Xl5V7r7vUBghkkTJQlS9drNCaLUAPx6asOMqidIGx9mt00efaPn
	l9SAQDXoq45nTHP6SYXzfsJbAOGZkys7km9IQ=
X-Received: by 2002:a05:7022:618f:b0:12b:ec67:3529 with SMTP id a92af1059eb24-138066c0641mr2396075c88.14.1780684555111;
        Fri, 05 Jun 2026 11:35:55 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.53.54])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f553ab33sm6090409c88.10.2026.06.05.11.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 11:35:54 -0700 (PDT)
Message-Id: <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v12.git.git.1780477479.gitgitgadget@gmail.com>
References: <pull.2285.v12.git.git.1780477479.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 05 Jun 2026 18:35:47 +0000
Subject: [PATCH v13 0/6] branch: prune-merged
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

 * Reworked --forked into a real ref-filter applied in apply_ref_filter()
   instead of a post-pass, so non-matching branches are never allocated.
 * Match exact --forked patterns on full refnames (only globs use the
   abbreviated upstream), and dropped the old helper machinery, forward
   declaration, and string_list in favor of a strvec.
 * Replaced the boolean parameters of
   delete_branches()/check_branch_commit() with a single unsigned int flags.
 * --prune-merged now collects candidates via filter_refs() rather than its
   own branch walk.
 * --prune-merged now takes its <branch> patterns as positional arguments
   (e.g. git branch --prune-merged origin/main 'feature*') instead of
   repeating the option.

Harald Nordgren (6):
  branch: add --forked filter for --list mode
  branch: let delete_branches warn instead of error on bulk refusal
  branch: prepare delete_branches for a bulk caller
  branch: add --prune-merged <branch>
  branch: add branch.<name>.pruneMerged opt-out
  branch: add --dry-run for --prune-merged

 Documentation/config/branch.adoc |   7 +
 Documentation/git-branch.adoc    |  41 +++-
 builtin/branch.c                 | 182 ++++++++++++---
 ref-filter.c                     |  70 ++++++
 ref-filter.h                     |  10 +
 t/t3200-branch.sh                | 367 +++++++++++++++++++++++++++++++
 6 files changed, 650 insertions(+), 27 deletions(-)


base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2285%2FHaraldNordgren%2Ffetch-prune-local-branches-v13
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2285/HaraldNordgren/fetch-prune-local-branches-v13
Pull-Request: https://github.com/git/git/pull/2285

Range-diff vs v12:

 1:  8834c424fb ! 1:  ccd07cff25 branch: add --forked filter for --list mode
     @@ Metadata
       ## Commit message ##
          branch: add --forked filter for --list mode
      
     -    Add a --forked option to "git branch" list mode that keeps only
     +    Add a --forked option to "git branch" list mode that lists only
          branches whose configured upstream matches <branch>. The argument
     -    can be a ref (e.g. "origin/main", "master") or a shell-style
     -    glob (e.g. "origin/*"). The option can be repeated to widen the
     -    filter.
     +    can be a ref (e.g. "origin/main", "master") or a shell glob
     +    (e.g. "origin/*"), and may be repeated to widen the filter.
      
     -    Because it is a filter on list mode, --forked composes with the
     -    existing list-mode filters, so
     +    It is an ordinary list filter, so it combines with the others:
      
              git branch --merged origin/main --forked 'origin/*'
      
     -    lists branches forked from origin that have already been
     -    integrated into origin/main, and --no-merged inverts the question.
     +    lists branches forked from origin that are already merged into
     +    origin/main, and --no-merged inverts the question.
      
          This is the building block for --prune-merged, which deletes the
          listed branches once they have landed on their upstream.
     @@ Commit message
      
       ## Documentation/git-branch.adoc ##
      @@ Documentation/git-branch.adoc: git branch [--color[=<when>] | --no-color] [--show-current]
     + 	   [--column[=<options>] | --no-column] [--sort=<key>]
       	   [--merged [<commit>]] [--no-merged [<commit>]]
       	   [--contains [<commit>]] [--no-contains [<commit>]]
     - 	   [--points-at <object>] [--format=<format>]
      +	   [(--forked <branch>)...]
     + 	   [--points-at <object>] [--format=<format>]
       	   [(-r|--remotes) | (-a|--all)]
       	   [--list] [<pattern>...]
     - git branch [--track[=(direct|inherit)] | --no-track] [-f]
     -@@ Documentation/git-branch.adoc: This option is only applicable in non-verbose mode.
     - 	Print the name of the current branch. In detached `HEAD` state,
     - 	nothing is printed.
     +@@ Documentation/git-branch.adoc: merged into the named commit (i.e. the branches whose tip commits are
     + reachable from the named commit) will be listed.  With `--no-merged` only
     + branches not merged into the named commit will be listed.  If the _<commit>_
     + argument is missing it defaults to `HEAD` (i.e. the tip of the current
     +-branch).
     ++branch).  With `--forked`, only branches whose configured upstream matches
     ++the given branch or pattern will be listed.
     + 
     + The command's second form creates a new branch head named _<branch-name>_
     + which points to the current `HEAD`, or _<start-point>_ if given. As a
     +@@ Documentation/git-branch.adoc: superproject's "origin/main", but tracks the submodule's "origin/main".
     + 	Only list branches whose tips are not reachable from
     + 	_<commit>_ (`HEAD` if not specified). Implies `--list`.
       
      +`--forked <branch>`::
     -+	List only branches whose configured upstream matches
     ++	Only list branches whose configured upstream matches
      +	_<branch>_. The argument can be a ref (e.g. `origin/main`,
      +	`master`) or a shell-style glob (e.g. `'origin/*'`). The
     -+	option can be repeated to widen the filter.
     ++	option can be repeated to widen the filter. Implies `--list`.
      +
     - `-v`::
     - `-vv`::
     - `--verbose`::
     + `--points-at <object>`::
     + 	Only list branches of _<object>_.
     + 
      
       ## builtin/branch.c ##
      @@
     - #include "help.h"
     - #include "advice.h"
       #include "commit-reach.h"
     -+#include "wildmatch.h"
       
       static const char * const builtin_branch_usage[] = {
      -	N_("git branch [<options>] [-r | -a] [--merged] [--no-merged]"),
     @@ builtin/branch.c
       	N_("git branch [<options>] [-f] [--recurse-submodules] <branch-name> [<start-point>]"),
       	N_("git branch [<options>] [-l] [<pattern>...]"),
       	N_("git branch [<options>] [-r] (-d | -D) <branch-name>..."),
     -@@ builtin/branch.c: static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
     - 	return strbuf_detach(&fmt, NULL);
     +@@ builtin/branch.c: static void copy_or_rename_branch(const char *oldname, const char *newname, int
     + 	free_worktrees(worktrees);
       }
       
     -+static void filter_array_by_forked(struct ref_array *array,
     -+				   const struct string_list *upstreams);
     ++static int parse_opt_forked(const struct option *opt, const char *arg, int unset)
     ++{
     ++	struct ref_filter *filter = opt->value;
      +
     - static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sorting,
     --			   struct ref_format *format, struct string_list *output)
     -+			   struct ref_format *format, struct string_list *output,
     -+			   const struct string_list *forked_upstreams)
     - {
     - 	int i;
     - 	struct ref_array array;
     -@@ builtin/branch.c: static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
     ++	BUG_ON_OPT_NEG(unset);
     ++	if (ref_filter_forked_add(filter, arg) < 0)
     ++		die(_("'%s' is not a valid branch or pattern"), arg);
     ++	return 0;
     ++}
     ++
     + static GIT_PATH_FUNC(edit_description, "EDIT_DESCRIPTION")
       
     - 	filter_refs(&array, filter, filter->kind);
     + static int edit_branch_description(const char *branch_name)
     +@@ builtin/branch.c: int cmd_branch(int argc,
     + 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
     + 		OPT_MERGED(&filter, N_("print only branches that are merged")),
     + 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
     ++		OPT_CALLBACK_F(0, "forked", &filter, N_("branch"),
     ++			N_("print only branches whose upstream matches <branch> (repeatable)"),
     ++			PARSE_OPT_NONEG, parse_opt_forked),
     + 		OPT_COLUMN(0, "column", &colopts, N_("list branches in columns")),
     + 		OPT_REF_SORT(&sorting_options),
     + 		OPT_CALLBACK(0, "points-at", &filter.points_at, N_("object"),
     +@@ builtin/branch.c: int cmd_branch(int argc,
     + 		list = 1;
       
     -+	if (forked_upstreams->nr)
     -+		filter_array_by_forked(&array, forked_upstreams);
     -+
     - 	if (filter->verbose)
     - 		maxwidth = calc_maxwidth(&array, strlen(remote_prefix));
     + 	if (filter.with_commit || filter.no_commit ||
     +-	    filter.reachable_from || filter.unreachable_from || filter.points_at.nr)
     ++	    filter.reachable_from || filter.unreachable_from ||
     ++	    filter.points_at.nr || filter.forked.nr)
     + 		list = 1;
       
     -@@ builtin/branch.c: static void copy_or_rename_branch(const char *oldname, const char *newname, int
     - 	free_worktrees(worktrees);
     + 	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
     +
     + ## ref-filter.c ##
     +@@ ref-filter.c: static int filter_exclude_match(struct ref_filter *filter, const char *refname)
     + 	return match_pattern(filter->exclude.v, refname, filter->ignore_case);
       }
       
     -+struct upstream_pattern {
     -+	char *name;
     -+	int is_wildcard;
     -+};
     -+
     -+static void upstream_pattern_list_clear(struct upstream_pattern *items,
     -+					size_t nr)
     -+{
     -+	size_t i;
     -+	for (i = 0; i < nr; i++)
     -+		free(items[i].name);
     -+	free(items);
     -+}
     -+
      +static const char *short_upstream_name(const char *full_ref)
      +{
      +	const char *short_name = full_ref;
     @@ builtin/branch.c: static void copy_or_rename_branch(const char *oldname, const c
      +	return short_name;
      +}
      +
     -+static int parse_one_forked_arg(const char *arg, struct upstream_pattern *out)
     -+{
     -+	struct object_id oid;
     -+	char *full_ref = NULL;
     -+
     -+	if (has_glob_specials(arg)) {
     -+		out->name = xstrdup(arg);
     -+		out->is_wildcard = 1;
     -+		return 0;
     -+	}
     -+
     -+	if (repo_dwim_ref(the_repository, arg, strlen(arg), &oid,
     -+			  &full_ref, 0) == 1 &&
     -+	    (starts_with(full_ref, "refs/heads/") ||
     -+	     starts_with(full_ref, "refs/remotes/"))) {
     -+		out->name = xstrdup(short_upstream_name(full_ref));
     -+		out->is_wildcard = 0;
     -+		free(full_ref);
     -+		return 0;
     -+	}
     -+	free(full_ref);
     -+	return -1;
     -+}
     -+
     -+static void parse_forked_args(const struct string_list *args,
     -+			      struct upstream_pattern **patterns_out,
     -+			      size_t *nr_out)
     -+{
     -+	struct upstream_pattern *patterns;
     -+	size_t i;
     -+
     -+	ALLOC_ARRAY(patterns, args->nr);
     -+	for (i = 0; i < args->nr; i++) {
     -+		const char *arg = args->items[i].string;
     -+		if (parse_one_forked_arg(arg, &patterns[i]) < 0) {
     -+			upstream_pattern_list_clear(patterns, i);
     -+			die(_("'%s' is not a valid branch or pattern"), arg);
     -+		}
     -+	}
     -+	*patterns_out = patterns;
     -+	*nr_out = args->nr;
     -+}
     -+
     -+static int upstream_matches(const char *short_upstream,
     -+			    const struct upstream_pattern *patterns,
     -+			    size_t nr)
     -+{
     -+	size_t i;
     -+
     -+	for (i = 0; i < nr; i++) {
     -+		const struct upstream_pattern *p = &patterns[i];
     -+		if (p->is_wildcard) {
     -+			if (!wildmatch(p->name, short_upstream, WM_PATHNAME))
     -+				return 1;
     -+		} else if (!strcmp(p->name, short_upstream)) {
     -+			return 1;
     -+		}
     -+	}
     -+	return 0;
     -+}
     -+
     -+static int branch_upstream_matches(const char *full_refname,
     -+				   const struct upstream_pattern *patterns,
     -+				   size_t nr_patterns)
     ++/*
     ++ * Match the configured upstream of a branch against the registered
     ++ * --forked patterns. Exact patterns are compared against the full
     ++ * upstream refname so they are unambiguous; glob patterns are matched
     ++ * against the abbreviated upstream so that a glob such as origin/...
     ++ * works as typed.
     ++ */
     ++static int filter_forked_match(struct ref_filter *filter, const char *refname)
      +{
      +	const char *short_name;
      +	struct branch *branch;
      +	const char *upstream;
     ++	int i;
      +
     -+	if (!skip_prefix(full_refname, "refs/heads/", &short_name))
     ++	if (!skip_prefix(refname, "refs/heads/", &short_name))
      +		return 0;
      +	branch = branch_get(short_name);
      +	if (!branch)
     @@ builtin/branch.c: static void copy_or_rename_branch(const char *oldname, const c
      +	upstream = branch_get_upstream(branch, NULL);
      +	if (!upstream)
      +		return 0;
     -+	return upstream_matches(short_upstream_name(upstream),
     -+				patterns, nr_patterns);
     ++
     ++	for (i = 0; i < filter->forked.nr; i++) {
     ++		const char *pattern = filter->forked.v[i];
     ++		if (has_glob_specials(pattern)) {
     ++			if (!wildmatch(pattern, short_upstream_name(upstream),
     ++				       WM_PATHNAME))
     ++				return 1;
     ++		} else if (!strcmp(pattern, upstream)) {
     ++			return 1;
     ++		}
     ++	}
     ++	return 0;
      +}
      +
     -+static void filter_array_by_forked(struct ref_array *array,
     -+				   const struct string_list *upstreams)
     ++int ref_filter_forked_add(struct ref_filter *filter, const char *arg)
      +{
     -+	struct upstream_pattern *patterns = NULL;
     -+	size_t nr_patterns = 0;
     -+	int i, kept = 0;
     -+
     -+	parse_forked_args(upstreams, &patterns, &nr_patterns);
     ++	struct object_id oid;
     ++	char *full_ref = NULL;
      +
     -+	for (i = 0; i < array->nr; i++) {
     -+		struct ref_array_item *item = array->items[i];
     -+		if (branch_upstream_matches(item->refname,
     -+					    patterns, nr_patterns))
     -+			array->items[kept++] = item;
     -+		else
     -+			free_ref_array_item(item);
     ++	if (has_glob_specials(arg)) {
     ++		strvec_push(&filter->forked, arg);
     ++		return 0;
      +	}
     -+	array->nr = kept;
      +
     -+	upstream_pattern_list_clear(patterns, nr_patterns);
     ++	if (repo_dwim_ref(the_repository, arg, strlen(arg), &oid,
     ++			  &full_ref, 0) == 1 &&
     ++	    (starts_with(full_ref, "refs/heads/") ||
     ++	     starts_with(full_ref, "refs/remotes/"))) {
     ++		strvec_push(&filter->forked, full_ref);
     ++		free(full_ref);
     ++		return 0;
     ++	}
     ++	free(full_ref);
     ++	return -1;
      +}
      +
     - static GIT_PATH_FUNC(edit_description, "EDIT_DESCRIPTION")
     - 
     - static int edit_branch_description(const char *branch_name)
     -@@ builtin/branch.c: int cmd_branch(int argc,
     - 	/* possible actions */
     - 	int delete = 0, rename = 0, copy = 0, list = 0,
     - 	    unset_upstream = 0, show_current = 0, edit_description = 0;
     -+	struct string_list forked_upstreams = STRING_LIST_INIT_DUP;
     - 	const char *new_upstream = NULL;
     - 	int noncreate_actions = 0;
     - 	/* possible options */
     -@@ builtin/branch.c: int cmd_branch(int argc,
     - 		OPT_BOOL(0, "create-reflog", &reflog, N_("create the branch's reflog")),
     - 		OPT_BOOL(0, "edit-description", &edit_description,
     - 			 N_("edit the description for the branch")),
     -+		OPT_STRING_LIST(0, "forked", &forked_upstreams, N_("branch"),
     -+			N_("list local branches whose upstream matches <branch> (repeatable)")),
     - 		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
     - 		OPT_MERGED(&filter, N_("print only branches that are merged")),
     - 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
     -@@ builtin/branch.c: int cmd_branch(int argc,
     - 		list = 1;
     - 
     - 	if (filter.with_commit || filter.no_commit ||
     --	    filter.reachable_from || filter.unreachable_from || filter.points_at.nr)
     -+	    filter.reachable_from || filter.unreachable_from ||
     -+	    filter.points_at.nr || forked_upstreams.nr)
     - 		list = 1;
     - 
     - 	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
     -@@ builtin/branch.c: int cmd_branch(int argc,
     - 		ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
     - 		ref_sorting_set_sort_flags_all(
     - 			sorting, REF_SORTING_DETACHED_HEAD_FIRST, 1);
     --		print_ref_list(&filter, sorting, &format, &output);
     -+		print_ref_list(&filter, sorting, &format, &output,
     -+			       &forked_upstreams);
     - 		print_columns(&output, colopts, NULL);
     - 		string_list_clear(&output, 0);
     - 		ref_sorting_release(sorting);
     -@@ builtin/branch.c: int cmd_branch(int argc,
     - 
     - out:
     - 	string_list_clear(&sorting_options, 0);
     -+	string_list_clear(&forked_upstreams, 0);
     - 	return ret;
     - }
     -
     - ## ref-filter.c ##
     -@@ ref-filter.c: static int filter_one(const struct reference *ref, void *cb_data)
     - }
     - 
     - /*  Free memory allocated for a ref_array_item */
     --static void free_array_item(struct ref_array_item *item)
     -+void free_ref_array_item(struct ref_array_item *item)
     - {
     - 	free((char *)item->symref);
     - 	if (item->value) {
     -@@ ref-filter.c: static int filter_and_format_one(const struct reference *ref, void *cb_data)
     - 
     - 	strbuf_release(&output);
     - 	strbuf_release(&err);
     --	free_array_item(item);
     -+	free_ref_array_item(item);
     + /*
     +  * We need to seek to the reference right after a given marker but excluding any
     +  * matching references. So we seek to the lexicographically next reference.
     +@@ ref-filter.c: static struct ref_array_item *apply_ref_filter(const struct reference *ref,
     + 	if (filter->points_at.nr && !match_points_at(&filter->points_at, ref->oid, ref->name))
     + 		return NULL;
       
     ++	if (filter->forked.nr && !filter_forked_match(filter, ref->name))
     ++		return NULL;
     ++
       	/*
     - 	 * Increment the running count of refs that match the filter. If
     -@@ ref-filter.c: void ref_array_clear(struct ref_array *array)
     - 	int i;
     - 
     - 	for (i = 0; i < array->nr; i++)
     --		free_array_item(array->items[i]);
     -+		free_ref_array_item(array->items[i]);
     - 	FREE_AND_NULL(array->items);
     - 	array->nr = array->alloc = 0;
     - 
     -@@ ref-filter.c: static void reach_filter(struct ref_array *array,
     - 		if (is_merged == include_reached)
     - 			array->items[array->nr++] = array->items[i];
     - 		else
     --			free_array_item(item);
     -+			free_ref_array_item(item);
     - 	}
     - 
     - 	clear_commit_marks_many(old_nr, to_clear, ALL_REV_FLAGS);
     -@@ ref-filter.c: void pretty_print_ref(const char *name, const struct object_id *oid,
     - 
     - 	strbuf_release(&err);
     - 	strbuf_release(&output);
     --	free_array_item(ref_item);
     -+	free_ref_array_item(ref_item);
     - }
     - 
     - static int parse_sorting_atom(const char *atom)
     + 	 * A merge filter is applied on refs pointing to commits. Hence
     + 	 * obtain the commit using the 'oid' available and discard all
     +@@ ref-filter.c: void ref_filter_init(struct ref_filter *filter)
     + void ref_filter_clear(struct ref_filter *filter)
     + {
     + 	strvec_clear(&filter->exclude);
     ++	strvec_clear(&filter->forked);
     + 	oid_array_clear(&filter->points_at);
     + 	commit_list_free(filter->with_commit);
     + 	commit_list_free(filter->no_commit);
      
       ## ref-filter.h ##
     -@@ ref-filter.h: void filter_and_format_refs(struct ref_filter *filter, unsigned int type,
     - 			    struct ref_format *format);
     - /*  Clear all memory allocated to ref_array */
     - void ref_array_clear(struct ref_array *array);
     -+/*  Free a single item from a ref_array */
     -+void free_ref_array_item(struct ref_array_item *item);
     - /*  Used to verify if the given format is correct and to parse out the used atoms */
     - int verify_ref_format(struct ref_format *format);
     - /*  Sort the given ref_array as per the ref_sorting provided */
     +@@ ref-filter.h: struct ref_filter {
     + 	const char **name_patterns;
     + 	const char *start_after;
     + 	struct strvec exclude;
     ++	struct strvec forked;
     + 	struct oid_array points_at;
     + 	struct commit_list *with_commit;
     + 	struct commit_list *no_commit;
     +@@ ref-filter.h: struct ref_format {
     + #define REF_FILTER_INIT { \
     + 	.points_at = OID_ARRAY_INIT, \
     + 	.exclude = STRVEC_INIT, \
     ++	.forked = STRVEC_INIT, \
     + }
     + #define REF_FORMAT_INIT {             \
     + 	.use_color = GIT_COLOR_UNKNOWN, \
     +@@ ref-filter.h: void ref_sorting_release(struct ref_sorting *);
     + struct ref_sorting *ref_sorting_options(struct string_list *);
     + /*  Function to parse --merged and --no-merged options */
     + int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset);
     ++/*
     ++ * Register a --forked <branch> pattern on the filter. The argument is
     ++ * either a ref, which is resolved to its full refname, or a shell-style
     ++ * glob. Branches are kept only when their configured upstream matches
     ++ * one of the registered patterns. Returns -1 if the argument is not a
     ++ * valid ref or pattern.
     ++ */
     ++int ref_filter_forked_add(struct ref_filter *filter, const char *arg);
     + /*  Get the current HEAD's description */
     + char *get_head_description(void);
     + /*  Set up translated strings in the output. */
      
       ## t/t3200-branch.sh ##
      @@ t/t3200-branch.sh: test_expect_success 'errors if given a bad branch name' '
 2:  6c95e4e77c ! 2:  a7672713f6 branch: let delete_branches warn instead of error on bulk refusal
     @@ Metadata
       ## Commit message ##
          branch: let delete_branches warn instead of error on bulk refusal
      
     -    Add a warn_only flag to delete_branches() and check_branch_commit()
     -    so a bulk caller can report not-fully-merged branches as one-line
     -    warnings and continue, instead of erroring with the four-line "use
     -    'git branch -D'" advice that the standalone "git branch -d" path
     -    emits. Default callers pass 0 and are unaffected.
     +    Add a warn-only mode to delete_branches() and check_branch_commit()
     +    so a bulk caller can report branches that are not fully merged as a
     +    short warning and carry on, rather than erroring with the longer
     +    "use 'git branch -D'" advice that the plain "git branch -d" path
     +    emits. Existing callers are unaffected.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## builtin/branch.c ##
      @@ builtin/branch.c: static int branch_merged(int kind, const char *name,
     + 	return merged;
     + }
       
     ++enum delete_branch_flags {
     ++	DELETE_BRANCH_FORCE = (1 << 0),
     ++	DELETE_BRANCH_QUIET = (1 << 1),
     ++	DELETE_BRANCH_WARN_ONLY = (1 << 2),
     ++};
     ++
       static int check_branch_commit(const char *branchname, const char *refname,
       			       const struct object_id *oid, struct commit *head_rev,
      -			       int kinds, int force)
     -+			       int kinds, int force, int warn_only)
     ++			       int kinds, unsigned int flags)
       {
     ++	int force = flags & DELETE_BRANCH_FORCE;
       	struct commit *rev = lookup_commit_reference(the_repository, oid);
       	if (!force && !rev) {
     -@@ builtin/branch.c: static int check_branch_commit(const char *branchname, const char *refname,
     + 		error(_("couldn't look up commit object for '%s'"), refname);
       		return -1;
       	}
       	if (!force && !branch_merged(kinds, branchname, rev, head_rev)) {
     @@ builtin/branch.c: static int check_branch_commit(const char *branchname, const c
      -		advise_if_enabled(ADVICE_FORCE_DELETE_BRANCH,
      -				  _("If you are sure you want to delete it, "
      -				  "run 'git branch -D %s'"), branchname);
     -+		if (warn_only) {
     ++		if (flags & DELETE_BRANCH_WARN_ONLY) {
      +			warning(_("the branch '%s' is not fully merged"),
      +				branchname);
      +		} else {
     @@ builtin/branch.c: static int check_branch_commit(const char *branchname, const c
       	}
       	return 0;
      @@ builtin/branch.c: static void delete_branch_config(const char *branchname)
     + 	strbuf_release(&buf);
       }
       
     - static int delete_branches(int argc, const char **argv, int force, int kinds,
     +-static int delete_branches(int argc, const char **argv, int force, int kinds,
      -			   int quiet)
     -+			   int quiet, int warn_only)
     ++static int delete_branches(int argc, const char **argv, int kinds,
     ++			   unsigned int flags)
       {
       	struct commit *head_rev = NULL;
       	struct object_id oid;
      @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int force, int kinds,
     + 	int i;
     + 	int ret = 0;
     + 	int remote_branch = 0;
     ++	int force = flags & DELETE_BRANCH_FORCE;
     ++	int quiet = flags & DELETE_BRANCH_QUIET;
     + 	struct strbuf bname = STRBUF_INIT;
     + 	enum interpret_branch_kind allowed_interpret;
     + 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
     +@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int force, int kinds,
     + 
     + 	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
     + 		char *target = NULL;
     +-		int flags = 0;
     ++		int ref_flags = 0;
     + 
     + 		copy_branchname(&bname, argv[i], allowed_interpret);
     + 		free(name);
     +@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int force, int kinds,
     + 					     RESOLVE_REF_READING
     + 					     | RESOLVE_REF_NO_RECURSE
     + 					     | RESOLVE_REF_ALLOW_BAD_NAME,
     +-					     &oid, &flags);
     ++					     &oid, &ref_flags);
     + 		if (!target) {
     + 			if (remote_branch) {
     + 				error(_("remote-tracking branch '%s' not found"), bname.buf);
     +@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int force, int kinds,
     + 									   | RESOLVE_REF_NO_RECURSE
     + 									   | RESOLVE_REF_ALLOW_BAD_NAME,
     + 									   &oid,
     +-									   &flags);
     ++									   &ref_flags);
     + 				FREE_AND_NULL(virtual_name);
       
     - 		if (!(flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
     + 				if (virtual_target)
     +@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int force, int kinds,
     + 			continue;
     + 		}
     + 
     +-		if (!(flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
     ++		if (!(ref_flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
       		    check_branch_commit(bname.buf, name, &oid, head_rev, kinds,
      -					force)) {
      -			ret = 1;
     -+					force, warn_only)) {
     -+			if (!warn_only)
     ++					flags)) {
     ++			if (!(flags & DELETE_BRANCH_WARN_ONLY))
      +				ret = 1;
       			goto next;
       		}
       
     + 		item = string_list_append(&refs_to_delete, name);
     +-		item->util = xstrdup((flags & REF_ISBROKEN) ? "broken"
     +-				    : (flags & REF_ISSYMREF) ? target
     ++		item->util = xstrdup((ref_flags & REF_ISBROKEN) ? "broken"
     ++				    : (ref_flags & REF_ISSYMREF) ? target
     + 				    : repo_find_unique_abbrev(the_repository, &oid, DEFAULT_ABBREV));
     + 
     + 	next:
      @@ builtin/branch.c: int cmd_branch(int argc,
       	if (delete) {
       		if (!argc)
       			die(_("branch name required"));
      -		ret = delete_branches(argc, argv, delete > 1, filter.kind, quiet);
     -+		ret = delete_branches(argc, argv, delete > 1, filter.kind,
     -+				      quiet, 0);
     ++		ret = delete_branches(argc, argv, filter.kind,
     ++				      (delete > 1 ? DELETE_BRANCH_FORCE : 0) |
     ++				      (quiet ? DELETE_BRANCH_QUIET : 0));
       		goto out;
       	} else if (show_current) {
       		print_current_branch_name();
 3:  004a96f7a4 ! 3:  5ee7643d3a branch: prepare delete_branches for a bulk caller
     @@ Metadata
       ## Commit message ##
          branch: prepare delete_branches for a bulk caller
      
     -    Add no_head_fallback and dry_run flags to delete_branches() so a
     -    bulk caller (the upcoming --prune-merged) can ask strictly about
     -    merged-into-upstream without a silent fallback to HEAD, and
     -    rehearse deletions with the same "Would delete branch ..." wording
     -    as the live run. Existing callers pass 0 for both and keep current
     -    behavior.
     -
     -    When no_head_fallback is set, head_rev stays NULL through to
     -    branch_merged(), whose "merged to X but not yet merged to HEAD"
     -    reminder otherwise compares against HEAD. For the bulk caller
     -    every candidate is known to have an upstream, so HEAD is
     -    irrelevant. Guard the block on head_rev so the NULL case skips
     -    it instead of treating "NULL != reference_rev" as "diverges from
     -    HEAD" and emitting a spurious warning.
     +    Teach delete_branches() two new modes for the upcoming
     +    --prune-merged: one that asks only whether a branch is merged into
     +    its upstream, without falling back to HEAD when there is no
     +    upstream, and one that rehearses the deletions without removing any
     +    ref. Existing callers keep their current behavior.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ builtin/branch.c: static int branch_merged(int kind, const char *name,
       		if (expect < 0)
       			exit(128);
       		if (expect == merged)
     -@@ builtin/branch.c: static void delete_branch_config(const char *branchname)
     - }
     +@@ builtin/branch.c: enum delete_branch_flags {
     + 	DELETE_BRANCH_FORCE = (1 << 0),
     + 	DELETE_BRANCH_QUIET = (1 << 1),
     + 	DELETE_BRANCH_WARN_ONLY = (1 << 2),
     ++	DELETE_BRANCH_NO_HEAD_FALLBACK = (1 << 3),
     ++	DELETE_BRANCH_DRY_RUN = (1 << 4),
     + };
       
     - static int delete_branches(int argc, const char **argv, int force, int kinds,
     --			   int quiet, int warn_only)
     -+			   int quiet, int warn_only, int no_head_fallback,
     -+			   int dry_run)
     - {
     - 	struct commit *head_rev = NULL;
     - 	struct object_id oid;
     -@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int force, int kinds,
     + static int check_branch_commit(const char *branchname, const char *refname,
     +@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int kinds,
     + 	int remote_branch = 0;
     + 	int force = flags & DELETE_BRANCH_FORCE;
     + 	int quiet = flags & DELETE_BRANCH_QUIET;
     ++	int dry_run = flags & DELETE_BRANCH_DRY_RUN;
     ++	int no_head_fallback = flags & DELETE_BRANCH_NO_HEAD_FALLBACK;
     + 	struct strbuf bname = STRBUF_INIT;
     + 	enum interpret_branch_kind allowed_interpret;
     + 	struct string_list refs_to_delete = STRING_LIST_INIT_DUP;
     +@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int kinds,
       	}
       	branch_name_pos = strcspn(fmt, "%");
       
     @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int fo
       		head_rev = lookup_commit_reference(the_repository, &head_oid);
       
       	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
     -@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int force, int kinds,
     +@@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int kinds,
       		free(target);
       	}
       
     @@ builtin/branch.c: static int delete_branches(int argc, const char **argv, int fo
       			char *refname = name + branch_name_pos;
       			if (!quiet)
       				printf(remote_branch
     -@@ builtin/branch.c: int cmd_branch(int argc,
     - 		if (!argc)
     - 			die(_("branch name required"));
     - 		ret = delete_branches(argc, argv, delete > 1, filter.kind,
     --				      quiet, 0);
     -+				      quiet, 0, 0, 0);
     - 		goto out;
     - 	} else if (show_current) {
     - 		print_current_branch_name();
 4:  cccfdb831c ! 4:  5f913c445c branch: add --prune-merged <branch>
     @@ Commit message
                  git branch --prune-merged <branch>...
      
          deletes the local branches that "--forked <branch>" would list,
     -    restricted to those whose tip is reachable from their configured
     +    keeping only those whose tip is reachable from their configured
          upstream: the work has already landed on the upstream they track,
          so the local copy is no longer needed.
      
     -    Reachability is read from local refs; nothing is fetched. Users
     -    who want fresh upstream refs run "git fetch" first.
     +    Reachability is read from local refs; nothing is fetched. Run
     +    "git fetch" first if you want fresh upstream refs.
      
     -    Three classes of branches are spared:
     +    Three kinds of branches are spared:
      
            * any branch checked out in any worktree;
     -      * any branch whose upstream no longer resolves locally (its
     -        disappearance is not, on its own, evidence of integration);
     +      * any branch whose upstream no longer resolves locally, since a
     +        missing upstream is not by itself a sign of integration;
            * any branch whose push destination equals its upstream
     -        (<branch>@{push} == <branch>@{upstream}). Such a branch
     -        cannot be distinguished from a freshly pulled trunk that
     -        just looks "fully merged", e.g. local "main" tracking and
     -        pushing to "origin/main" right after a pull. Only branches
     -        that push somewhere other than their upstream (typically
     -        topics in a fork-based workflow) are treated as candidates.
     +        (<branch>@{push} is the same as <branch>@{upstream}), such as
     +        a local "main" that tracks and pushes to "origin/main". Right
     +        after a pull it just looks "fully merged", so it is left
     +        alone. Only branches that push somewhere other than their
     +        upstream, typically topics in a fork workflow, are candidates.
      
     -    Deletion goes through the existing delete_branches() in warn-only
     -    mode and with the HEAD-fallback disabled: a branch that is not
     -    yet fully merged to its upstream is reported as a one-line warning
     -    and skipped, so a single un-mergeable topic does not abort the
     -    whole sweep. We only act on upstream-merged status.
     +    Branches that are not yet merged into their upstream are reported
     +    as a short warning and skipped, so one unmerged topic does not
     +    abort the whole sweep.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ Documentation/git-branch.adoc: git branch (-m|-M) [<old-branch>] <new-branch>
       git branch (-c|-C) [<old-branch>] <new-branch>
       git branch (-d|-D) [-r] <branch-name>...
       git branch --edit-description [<branch-name>]
     -+git branch (--prune-merged <branch>)...
     ++git branch --prune-merged <branch>...
       
       DESCRIPTION
       -----------
      @@ Documentation/git-branch.adoc: This option is only applicable in non-verbose mode.
     - 	`master`) or a shell-style glob (e.g. `'origin/*'`). The
     - 	option can be repeated to widen the filter.
     + 	Print the name of the current branch. In detached `HEAD` state,
     + 	nothing is printed.
       
     -+`--prune-merged <branch>`::
     ++`--prune-merged <branch>...`::
      +	Delete the local branches that `--forked` would list for the
     -+	same _<branch>_, but only those whose tip is reachable from
     -+	their configured upstream. In other words, the work on the
     -+	branch has already landed on the upstream it tracks, so the
     -+	local copy is no longer needed. May be given more than once to
     -+	union the matches; positional arguments are not accepted.
     ++	given _<branch>_ arguments, but only those whose tip is
     ++	reachable from their configured upstream. In other words, the
     ++	work on the branch has already landed on the upstream it
     ++	tracks, so the local copy is no longer needed. Several
     ++	_<branch>_ patterns may be given, e.g. `git branch
     ++	--prune-merged origin/main 'feature*'`.
      ++
      +Reachability is checked against whatever the upstream refs say
      +locally; nothing is fetched. Run `git fetch` first if you want
     @@ builtin/branch.c: static const char * const builtin_branch_usage[] = {
       	N_("git branch [<options>] (-c | -C) [<old-branch>] <new-branch>"),
       	N_("git branch [<options>] [-r | -a] [--points-at]"),
       	N_("git branch [<options>] [-r | -a] [--format]"),
     -+	N_("git branch [<options>] (--prune-merged <branch>)..."),
     ++	N_("git branch [<options>] --prune-merged <branch>..."),
       	NULL
       };
       
     -@@ builtin/branch.c: static int upstream_matches(const char *short_upstream,
     +@@ builtin/branch.c: static int parse_opt_forked(const struct option *opt, const char *arg, int unset
       	return 0;
       }
       
     --static int branch_upstream_matches(const char *full_refname,
     -+static int branch_upstream_matches(const char *short_branch_name,
     - 				   const struct upstream_pattern *patterns,
     - 				   size_t nr_patterns)
     - {
     --	const char *short_name;
     --	struct branch *branch;
     -+	struct branch *branch = branch_get(short_branch_name);
     - 	const char *upstream;
     - 
     --	if (!skip_prefix(full_refname, "refs/heads/", &short_name))
     --		return 0;
     --	branch = branch_get(short_name);
     - 	if (!branch)
     - 		return 0;
     - 	upstream = branch_get_upstream(branch, NULL);
     -@@ builtin/branch.c: static void filter_array_by_forked(struct ref_array *array,
     - 
     - 	for (i = 0; i < array->nr; i++) {
     - 		struct ref_array_item *item = array->items[i];
     --		if (branch_upstream_matches(item->refname,
     --					    patterns, nr_patterns))
     -+		const char *short_name;
     -+		if (skip_prefix(item->refname, "refs/heads/", &short_name) &&
     -+		    branch_upstream_matches(short_name, patterns, nr_patterns))
     - 			array->items[kept++] = item;
     - 		else
     - 			free_ref_array_item(item);
     -@@ builtin/branch.c: static void filter_array_by_forked(struct ref_array *array,
     - 	upstream_pattern_list_clear(patterns, nr_patterns);
     - }
     - 
     -+struct forked_cb {
     -+	const struct upstream_pattern *patterns;
     -+	size_t nr_patterns;
     -+	struct string_list *out;
     -+};
     -+
     -+static int collect_forked_branch(const struct reference *ref, void *cb_data)
     -+{
     -+	struct forked_cb *cb = cb_data;
     -+
     -+	if (ref->flags & REF_ISSYMREF)
     -+		return 0;
     -+	if (branch_upstream_matches(ref->name, cb->patterns, cb->nr_patterns))
     -+		string_list_append(cb->out, ref->name);
     -+	return 0;
     -+}
     -+
     -+static void collect_forked_set(const struct string_list *upstreams,
     -+			       struct string_list *out)
     -+{
     -+	struct upstream_pattern *patterns = NULL;
     -+	size_t nr_patterns = 0;
     -+	struct forked_cb cb;
     -+
     -+	parse_forked_args(upstreams, &patterns, &nr_patterns);
     -+	cb.patterns = patterns;
     -+	cb.nr_patterns = nr_patterns;
     -+	cb.out = out;
     -+
     -+	refs_for_each_branch_ref(get_main_ref_store(the_repository),
     -+				 collect_forked_branch, &cb);
     -+
     -+	string_list_sort(out);
     -+
     -+	upstream_pattern_list_clear(patterns, nr_patterns);
     -+}
     -+
     -+static int prune_merged_branches(const struct string_list *upstreams,
     ++static int prune_merged_branches(int argc, const char **argv,
      +				 int quiet)
      +{
      +	struct ref_store *refs = get_main_ref_store(the_repository);
     -+	struct string_list candidates = STRING_LIST_INIT_DUP;
     ++	struct ref_filter filter = REF_FILTER_INIT;
     ++	struct ref_array candidates;
      +	struct strvec deletable = STRVEC_INIT;
     -+	struct string_list_item *item;
     -+	int ret = 0;
     ++	int i, ret = 0;
      +
     -+	if (!upstreams->nr)
     ++	if (!argc)
      +		die(_("--prune-merged requires at least one <branch>"));
      +
     -+	collect_forked_set(upstreams, &candidates);
     ++	for (i = 0; i < argc; i++)
     ++		if (ref_filter_forked_add(&filter, argv[i]) < 0)
     ++			die(_("'%s' is not a valid branch or pattern"), argv[i]);
      +
     -+	for_each_string_list_item(item, &candidates) {
     -+		const char *short_name = item->string;
     -+		struct branch *branch = branch_get(short_name);
     ++	filter.kind = FILTER_REFS_BRANCHES;
     ++	memset(&candidates, 0, sizeof(candidates));
     ++	filter_refs(&candidates, &filter, filter.kind);
     ++
     ++	for (i = 0; i < candidates.nr; i++) {
     ++		const char *full_name = candidates.items[i]->refname;
     ++		const char *short_name;
     ++		struct branch *branch;
      +		const char *upstream, *push;
     -+		struct strbuf full = STRBUF_INIT;
     -+		int skip;
      +
     -+		strbuf_addf(&full, "refs/heads/%s", short_name);
     -+		skip = !!branch_checked_out(full.buf);
     -+		strbuf_release(&full);
     -+		if (skip)
     ++		if (!skip_prefix(full_name, "refs/heads/", &short_name))
     ++			continue;
     ++		if (branch_checked_out(full_name))
      +			continue;
      +
     ++		branch = branch_get(short_name);
      +		upstream = branch ? branch_get_upstream(branch, NULL) : NULL;
      +		if (!upstream || !refs_ref_exists(refs, upstream))
      +			continue;
     @@ builtin/branch.c: static void filter_array_by_forked(struct ref_array *array,
      +
      +	if (deletable.nr)
      +		ret = delete_branches(deletable.nr, deletable.v,
     -+				      0, /* force */
      +				      FILTER_REFS_BRANCHES,
     -+				      quiet,
     -+				      1, /* warn_only */
     -+				      1, /* no_head_fallback */
     -+				      0  /* dry_run */);
     ++				      DELETE_BRANCH_WARN_ONLY |
     ++				      DELETE_BRANCH_NO_HEAD_FALLBACK |
     ++				      (quiet ? DELETE_BRANCH_QUIET : 0));
      +
      +	strvec_clear(&deletable);
     -+	string_list_clear(&candidates, 0);
     ++	ref_array_clear(&candidates);
     ++	ref_filter_clear(&filter);
      +	return ret;
      +}
      +
     @@ builtin/branch.c: static void filter_array_by_forked(struct ref_array *array,
       
       static int edit_branch_description(const char *branch_name)
      @@ builtin/branch.c: int cmd_branch(int argc,
     + 	/* possible actions */
       	int delete = 0, rename = 0, copy = 0, list = 0,
       	    unset_upstream = 0, show_current = 0, edit_description = 0;
     - 	struct string_list forked_upstreams = STRING_LIST_INIT_DUP;
     -+	struct string_list prune_merged_upstreams = STRING_LIST_INIT_DUP;
     ++	int prune_merged = 0;
       	const char *new_upstream = NULL;
       	int noncreate_actions = 0;
       	/* possible options */
      @@ builtin/branch.c: int cmd_branch(int argc,
     + 		OPT_BOOL(0, "create-reflog", &reflog, N_("create the branch's reflog")),
     + 		OPT_BOOL(0, "edit-description", &edit_description,
       			 N_("edit the description for the branch")),
     - 		OPT_STRING_LIST(0, "forked", &forked_upstreams, N_("branch"),
     - 			N_("list local branches whose upstream matches <branch> (repeatable)")),
     -+		OPT_STRING_LIST(0, "prune-merged", &prune_merged_upstreams, N_("branch"),
     -+			N_("delete local branches whose upstream matches <branch> and is merged (repeatable)")),
     ++		OPT_BOOL(0, "prune-merged", &prune_merged,
     ++			N_("delete local branches whose upstream matches <branch> and is merged")),
       		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
       		OPT_MERGED(&filter, N_("print only branches that are merged")),
       		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
     @@ builtin/branch.c: int cmd_branch(int argc,
       
       	if (!delete && !rename && !copy && !edit_description && !new_upstream &&
      -	    !show_current && !unset_upstream && argc == 0)
     -+	    !show_current && !unset_upstream && !prune_merged_upstreams.nr &&
     ++	    !show_current && !unset_upstream && !prune_merged &&
      +	    argc == 0)
       		list = 1;
       
     @@ builtin/branch.c: int cmd_branch(int argc,
       	noncreate_actions = !!delete + !!rename + !!copy + !!new_upstream +
       			    !!show_current + !!list + !!edit_description +
      -			    !!unset_upstream;
     -+			    !!unset_upstream + !!prune_merged_upstreams.nr;
     ++			    !!unset_upstream + !!prune_merged;
       	if (noncreate_actions > 1)
       		usage_with_options(builtin_branch_usage, options);
       
      @@ builtin/branch.c: int cmd_branch(int argc,
     - 		ret = delete_branches(argc, argv, delete > 1, filter.kind,
     - 				      quiet, 0, 0, 0);
     + 				      (delete > 1 ? DELETE_BRANCH_FORCE : 0) |
     + 				      (quiet ? DELETE_BRANCH_QUIET : 0));
       		goto out;
     -+	} else if (prune_merged_upstreams.nr) {
     -+		if (argc)
     -+			die(_("--prune-merged does not take positional arguments; "
     -+			      "repeat --prune-merged for each <branch>"));
     -+		ret = prune_merged_branches(&prune_merged_upstreams, quiet);
     ++	} else if (prune_merged) {
     ++		ret = prune_merged_branches(argc, argv, quiet);
      +		goto out;
       	} else if (show_current) {
       		print_current_branch_name();
       		ret = 0;
     -@@ builtin/branch.c: int cmd_branch(int argc,
     - out:
     - 	string_list_clear(&sorting_options, 0);
     - 	string_list_clear(&forked_upstreams, 0);
     -+	string_list_clear(&prune_merged_upstreams, 0);
     - 	return ret;
     - }
      
       ## t/t3200-branch.sh ##
      @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
     @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
      +	git -C pm-union branch --set-upstream-to=origin/main two &&
      +	git -C pm-union checkout --detach &&
      +
     -+	git -C pm-union branch --prune-merged origin/next --prune-merged origin/main &&
     ++	git -C pm-union branch --prune-merged origin/next origin/main &&
      +
      +	test_must_fail git -C pm-union rev-parse --verify refs/heads/one &&
      +	test_must_fail git -C pm-union rev-parse --verify refs/heads/two
     @@ t/t3200-branch.sh: test_expect_success '--forked requires a value' '
      +	test_must_fail git -C pm-push-diff rev-parse --verify refs/heads/topic
      +'
      +
     -+test_expect_success '--prune-merged requires a value' '
     ++test_expect_success '--prune-merged requires at least one <branch>' '
      +	test_must_fail git -C forked branch --prune-merged 2>err &&
     -+	test_grep "requires a value" err
     ++	test_grep "requires at least one <branch>" err
      +'
      +
     -+test_expect_success '--prune-merged rejects positional arguments' '
     -+	test_must_fail git -C forked branch --prune-merged origin/one other/foreign 2>err &&
     -+	test_grep "does not take positional arguments" err
     ++test_expect_success '--prune-merged takes positional <branch> arguments' '
     ++	test_when_finished "rm -rf pm-positional" &&
     ++	git clone pm-upstream pm-positional &&
     ++	git -C pm-positional remote add fork ../pm-fork &&
     ++	test_config -C pm-positional remote.pushDefault fork &&
     ++	test_config -C pm-positional push.default current &&
     ++	git -C pm-positional branch one one-commit &&
     ++	git -C pm-positional branch --set-upstream-to=origin/next one &&
     ++	git -C pm-positional branch two base &&
     ++	git -C pm-positional branch --set-upstream-to=origin/main two &&
     ++	git -C pm-positional checkout --detach &&
     ++
     ++	git -C pm-positional branch --prune-merged origin/next origin/main &&
     ++
     ++	test_must_fail git -C pm-positional rev-parse --verify refs/heads/one &&
     ++	test_must_fail git -C pm-positional rev-parse --verify refs/heads/two
      +'
      +
       test_done
 5:  5f793f8d0d ! 5:  8e9a735ffe branch: add branch.<name>.pruneMerged opt-out
     @@ Commit message
          branch: add branch.<name>.pruneMerged opt-out
      
          Setting branch.<name>.pruneMerged=false exempts that branch from
     -    "git branch --prune-merged". Useful for a topic branch you want
     -    to develop further after an initial round has been merged
     -    upstream.
     +    "git branch --prune-merged", which is useful for a topic you want
     +    to keep developing after an early round of it has been merged
     +    upstream. Unless --quiet is given, each skip is reported so the
     +    user knows why their topic was kept.
      
     -    Unless --quiet is given, the skip is reported per branch so the
     -    user knows why their topic was preserved.
     -
     -    Explicit deletion via "git branch -d" continues to consult the
     -    normal merge check and is not affected by this setting.
     +    Explicit deletion with "git branch -d" still uses the normal merge
     +    check and ignores this setting.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ Documentation/git-branch.adoc: the upstream refs refreshed.
       warnings and skipped; pass them to `git branch -D` explicitly if
      
       ## builtin/branch.c ##
     -@@ builtin/branch.c: static int prune_merged_branches(const struct string_list *upstreams,
     - 		struct branch *branch = branch_get(short_name);
     +@@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv,
     + 		const char *short_name;
     + 		struct branch *branch;
       		const char *upstream, *push;
     - 		struct strbuf full = STRBUF_INIT;
      +		struct strbuf key = STRBUF_INIT;
     - 		int skip;
      +		int opt_out;
       
     - 		strbuf_addf(&full, "refs/heads/%s", short_name);
     - 		skip = !!branch_checked_out(full.buf);
     -@@ builtin/branch.c: static int prune_merged_branches(const struct string_list *upstreams,
     + 		if (!skip_prefix(full_name, "refs/heads/", &short_name))
     + 			continue;
     +@@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv,
       		if (!push || !strcmp(push, upstream))
       			continue;
       
     @@ builtin/branch.c: static int prune_merged_branches(const struct string_list *ups
       
      
       ## t/t3200-branch.sh ##
     -@@ t/t3200-branch.sh: test_expect_success '--prune-merged rejects positional arguments' '
     - 	test_grep "does not take positional arguments" err
     +@@ t/t3200-branch.sh: test_expect_success '--prune-merged takes positional <branch> arguments' '
     + 	test_must_fail git -C pm-positional rev-parse --verify refs/heads/two
       '
       
      +test_expect_success '--prune-merged honours branch.<name>.pruneMerged=false' '
 6:  1a0d5eab15 ! 6:  511de4788e branch: add --dry-run for --prune-merged
     @@ Commit message
          branch: add --dry-run for --prune-merged
      
          With --dry-run, --prune-merged prints the local branches it would
     -    delete, one "Would delete branch <name>" line per candidate, and
     -    exits without touching any ref.
     +    delete, one "Would delete branch <name>" line each, and exits
     +    without touching any ref. The same filtering applies, so the output
     +    is exactly the set that the real run would delete.
      
     -    The @{push}-vs-@{upstream} and unmerged filtering still applies,
     -    so the dry-run output is exactly the set that the live run would
     -    delete.
     -
     -    --dry-run is only meaningful in combination with --prune-merged
     -    and is rejected otherwise.
     +    --dry-run is only meaningful together with --prune-merged and is
     +    rejected otherwise.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ Documentation/git-branch.adoc: git branch (-m|-M) [<old-branch>] <new-branch>
       git branch (-c|-C) [<old-branch>] <new-branch>
       git branch (-d|-D) [-r] <branch-name>...
       git branch --edit-description [<branch-name>]
     --git branch (--prune-merged <branch>)...
     -+git branch [--dry-run] (--prune-merged <branch>)...
     +-git branch --prune-merged <branch>...
     ++git branch [--dry-run] --prune-merged <branch>...
       
       DESCRIPTION
       -----------
     @@ Documentation/git-branch.adoc: Branches refused by the "fully merged" safety che
       `--verbose`::
      
       ## builtin/branch.c ##
     -@@ builtin/branch.c: static void collect_forked_set(const struct string_list *upstreams,
     +@@ builtin/branch.c: static int parse_opt_forked(const struct option *opt, const char *arg, int unset
       }
       
     - static int prune_merged_branches(const struct string_list *upstreams,
     + static int prune_merged_branches(int argc, const char **argv,
      -				 int quiet)
      +				 int quiet, int dry_run)
       {
       	struct ref_store *refs = get_main_ref_store(the_repository);
     - 	struct string_list candidates = STRING_LIST_INIT_DUP;
     -@@ builtin/branch.c: static int prune_merged_branches(const struct string_list *upstreams,
     - 				      quiet,
     - 				      1, /* warn_only */
     - 				      1, /* no_head_fallback */
     --				      0  /* dry_run */);
     -+				      dry_run);
     + 	struct ref_filter filter = REF_FILTER_INIT;
     +@@ builtin/branch.c: static int prune_merged_branches(int argc, const char **argv,
     + 				      FILTER_REFS_BRANCHES,
     + 				      DELETE_BRANCH_WARN_ONLY |
     + 				      DELETE_BRANCH_NO_HEAD_FALLBACK |
     +-				      (quiet ? DELETE_BRANCH_QUIET : 0));
     ++				      (quiet ? DELETE_BRANCH_QUIET : 0) |
     ++				      (dry_run ? DELETE_BRANCH_DRY_RUN : 0));
       
       	strvec_clear(&deletable);
     - 	string_list_clear(&candidates, 0);
     + 	ref_array_clear(&candidates);
      @@ builtin/branch.c: int cmd_branch(int argc,
     + 	int delete = 0, rename = 0, copy = 0, list = 0,
       	    unset_upstream = 0, show_current = 0, edit_description = 0;
     - 	struct string_list forked_upstreams = STRING_LIST_INIT_DUP;
     - 	struct string_list prune_merged_upstreams = STRING_LIST_INIT_DUP;
     + 	int prune_merged = 0;
      +	int dry_run = 0;
       	const char *new_upstream = NULL;
       	int noncreate_actions = 0;
       	/* possible options */
      @@ builtin/branch.c: int cmd_branch(int argc,
     - 			N_("list local branches whose upstream matches <branch> (repeatable)")),
     - 		OPT_STRING_LIST(0, "prune-merged", &prune_merged_upstreams, N_("branch"),
     - 			N_("delete local branches whose upstream matches <branch> and is merged (repeatable)")),
     + 			 N_("edit the description for the branch")),
     + 		OPT_BOOL(0, "prune-merged", &prune_merged,
     + 			N_("delete local branches whose upstream matches <branch> and is merged")),
      +		OPT_BOOL(0, "dry-run", &dry_run,
      +			N_("with --prune-merged, only print which branches would be deleted")),
       		OPT__FORCE(&force, N_("force creation, move/rename, deletion"), PARSE_OPT_NOCOMPLETE),
     @@ builtin/branch.c: int cmd_branch(int argc,
       	if (noncreate_actions > 1)
       		usage_with_options(builtin_branch_usage, options);
       
     -+	if (dry_run && !prune_merged_upstreams.nr)
     ++	if (dry_run && !prune_merged)
      +		die(_("--dry-run requires --prune-merged"));
      +
       	if (recurse_submodules_explicit) {
       		if (!submodule_propagate_branches)
       			die(_("branch with --recurse-submodules can only be used if submodule.propagateBranches is enabled"));
      @@ builtin/branch.c: int cmd_branch(int argc,
     - 		if (argc)
     - 			die(_("--prune-merged does not take positional arguments; "
     - 			      "repeat --prune-merged for each <branch>"));
     --		ret = prune_merged_branches(&prune_merged_upstreams, quiet);
     -+		ret = prune_merged_branches(&prune_merged_upstreams, quiet, dry_run);
     + 				      (quiet ? DELETE_BRANCH_QUIET : 0));
     + 		goto out;
     + 	} else if (prune_merged) {
     +-		ret = prune_merged_branches(argc, argv, quiet);
     ++		ret = prune_merged_branches(argc, argv, quiet, dry_run);
       		goto out;
       	} else if (show_current) {
       		print_current_branch_name();

-- 
gitgitgadget
