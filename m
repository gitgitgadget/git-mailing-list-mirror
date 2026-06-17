Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AA23AD501
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 10:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781693835; cv=none; b=I20daVMe1fcU7b1g1tYSiToTlN7a3kIv+aXriqOsTy/OCvfnf0O60qHBYIuDi6SeBd67hdeec6tsQk7yxiY6VNFExczTYmzVNBUD+HsvcclEHJ+JfRB2oyucl9QXR0Todjjk2uUisom6rVUSRZTOEGbUoVfc3k5lGjeGdtX/+no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781693835; c=relaxed/simple;
	bh=L8Pv6Uxfd/JE+w4ogzgoM2HKOP+8KsDTIWxKWHqSJ4w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=st6b1ZFWhpptfY8Fr6KxFRF1yukFp0jJIlalWftB1NgLYagLw4Mjtskyjb+UiAej6RH3EUfB49HICvtiKvNnF+2oYF14ghfZ7enZJobVg/QougxyUieBaQ4wbd8w43+k5Fgj8pZGWDxqp13qIGkqmEgVG+v07zDwmf1hVBHKGWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fX4ihsXk; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fX4ihsXk"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-13809223fd4so6073826c88.1
        for <git@vger.kernel.org>; Wed, 17 Jun 2026 03:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781693831; x=1782298631; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/M63VKDXThXTFulyEGzH3bUA/B7lZ2YMYyk8s9ttUO4=;
        b=fX4ihsXk85geFoUs9UvWb1QPs58tnkTV4d9UjVLSLLu3X6MhUC7VLSB2hfZara76mP
         ql4VcU8jBZ+D0eiYMrOTjDcjROZeiswNQvANWZkruYIPZBLWIbIfSqEYEVXrMIkOVI6T
         ND0PBSj8YUn3NpjjhU/28NKEv2sHeKdI59UjoDFoOBKZo0gWmHUHpusp5TUlb8yEnnz1
         t986aH778/8Z78BLJTFYKIiQGOl62hzRYUaF6mzmya3FAGEOpE4jNzljm4B5UIYY08KV
         SB6ix3cPbXK6a5RvjxF1jrVrFUxRrKj2773xjHGa++XkEsRCxLoj2ID/mrY/unSDto+/
         TsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781693831; x=1782298631;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/M63VKDXThXTFulyEGzH3bUA/B7lZ2YMYyk8s9ttUO4=;
        b=QqQKXCczaBe2NA24caXVglTBN8JPzxswUQCruKMw8SdPlxZ/O1etmI3rDRnLUTh9S0
         R/FCNgK6KSsZKgajIY1UrxTHE19EmbpELGZ58kG1/FBYyFMsTUym1oPS2zIHxw+eyJCH
         a7u7nyUVxwdVmZ8L3BhXPq/c/PkHwQGwOxanC+tTX74WRJz/7WTWijQAuv30awyRsTcd
         lg7o2GI4m+0TgBhVakjjgtvmV8m/iTi3LWPnHmt2Mobag9j2sFWrU76WP3g2YJh056EL
         arFAa9qYOyJbFoStRHWlHSlUJC1b9eWbHPfBljzNOHShS7spqGufLLFQ4NQ4rqzd77BZ
         Tlzw==
X-Gm-Message-State: AOJu0YyXbV2z1AuHQ1pxehfUZ1VpvT3nNmPz9K0nrYBFJ9xFAavkGhR7
	IdNSMAT2KldyG115u046r/KBl9kPozTTLceJrfgd+8VtjkJOOM3hUcWclSKeXw==
X-Gm-Gg: AfdE7clkBLCEqgyxGQAZ0KZjBSsvW4AGnlc1o4buMCHjVBnS1qs+AzTds13mMlr7Rk3
	Mj+0a93xYmHaGaRbC0Nn5hIk8DhhAkcYKHukA0hY4F0ajP2/FqBPnI9uMUeUdCpOCAEAl7s2Fmw
	RNLOYTbM7GrOxuIZMwjw5ZVgxgtfpGreeGzHsJ9p+g2uu3W6bYo76zs/NdOMH4d5iL+Iyt5vZ8D
	pYFAzbkvtXGzxUnwMtXEWBrNbZID1Zs4ZXZKh6FmTgujF51KbG2EPEdVVIJt28x6TWS2KN2hT7V
	y5TFEKyD28uoRoXUNMiQYGZ97CDbtEQYcbbo+bSmvqU7S2op0g+MjeEL0eiRwJ9Zah/r8Y1/UF6
	Ryad7V64GiD4lqb84YpJSOxkSZGuh8HuUEOH7on65W1SXu7cZqcsWB+DWJ31dRJQkI/kJElIxs4
	SdcBipHb6XpMDnwT2V
X-Received: by 2002:a05:7300:6146:b0:2ed:e14:e954 with SMTP id 5a478bee46e88-30bca0a6ea3mr1602158eec.30.1781693830460;
        Wed, 17 Jun 2026 03:57:10 -0700 (PDT)
Received: from [127.0.0.1] ([172.185.167.42])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e5d0849sm25067775eec.7.2026.06.17.03.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 03:57:09 -0700 (PDT)
Message-Id: <pull.2324.v2.git.git.1781693828456.gitgitgadget@gmail.com>
In-Reply-To: <pull.2324.git.git.1780997009796.gitgitgadget@gmail.com>
References: <pull.2324.git.git.1780997009796.gitgitgadget@gmail.com>
From: "Lei Zhu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Jun 2026 10:57:08 +0000
Subject: [PATCH v2] checkout/switch: add --create-if-missing option
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
Cc: Lei Zhu <korov9.c@gmail.com>,
    Korov <korov9.c@gmail.com>

From: Korov <korov9.c@gmail.com>

Add a new `--create-if-missing` option to `git switch` and `git
checkout` that behaves like an idempotent form of branch switching.

Users who often switch between topic branches may not know whether the
local branch already exists. Without this option, they need to check for
the branch first and then choose between switching to it or creating it.
The new option folds that workflow into a single command.

When the target branch does not exist, `--create-if-missing <branch>`
behaves like `git switch -c <branch>` or `git checkout -b <branch>`,
including existing `--track` and `--no-track` handling.

When the target branch already exists, `--create-if-missing <branch>`
switches to it without resetting the branch tip. If `--track` is given,
update the branch's upstream configuration using the explicit
start-point, or the current branch when no start-point is provided. Fail
in detached HEAD state when no start-point is available for tracking
setup.

For `git checkout`, keep this as a branch operation and reject pathspec
usage with `--create-if-missing` to avoid mixing branch switching with
path checkout semantics.

Document the new option and add tests covering branch creation,
existing-branch switching, tracking updates, pathspec rejection, and
detached-HEAD failure cases.

Signed-off-by: Korov <korov9.c@gmail.com>
---
    checkout/switch: add --create-if-missing option

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2324%2FKorov%2Fdev3-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2324/Korov/dev3-v2
Pull-Request: https://github.com/git/git/pull/2324

Range-diff vs v1:

 1:  64a6947ad1 ! 1:  0070592d49 switch: add --ensure option
     @@ Metadata
      Author: Korov <korov9.c@gmail.com>
      
       ## Commit message ##
     -    switch: add --ensure option
     +    checkout/switch: add --create-if-missing option
      
     -    Add a new `git switch --ensure` (`-e`) option that behaves like an
     -    idempotent form of branch switching.
     +    Add a new `--create-if-missing` option to `git switch` and `git
     +    checkout` that behaves like an idempotent form of branch switching.
      
          Users who often switch between topic branches may not know whether the
     -    local branch already exists. Without this option, they need to check
     -    for the branch first and then choose between `git switch <branch>` and
     -    `git switch -c <branch>`. The new option folds that workflow into a
     -    single command.
     +    local branch already exists. Without this option, they need to check for
     +    the branch first and then choose between switching to it or creating it.
     +    The new option folds that workflow into a single command.
      
     -    When the target branch does not exist, `git switch -e <branch>`
     -    behaves like `git switch -c <branch>`, including existing `--track`
     -    and `--no-track` handling.
     +    When the target branch does not exist, `--create-if-missing <branch>`
     +    behaves like `git switch -c <branch>` or `git checkout -b <branch>`,
     +    including existing `--track` and `--no-track` handling.
      
     -    When the target branch already exists, `git switch -e <branch>`
     -    switches to it without resetting the branch tip. If `--track` is
     -    given, update the branch's upstream configuration using the explicit
     -    start-point, or the current branch when no start-point is provided.
     -    Fail in detached HEAD state when no start-point is available for
     -    tracking setup.
     +    When the target branch already exists, `--create-if-missing <branch>`
     +    switches to it without resetting the branch tip. If `--track` is given,
     +    update the branch's upstream configuration using the explicit
     +    start-point, or the current branch when no start-point is provided. Fail
     +    in detached HEAD state when no start-point is available for tracking
     +    setup.
      
     -    Document the new option and add tests covering create-branch tracking,
     -    existing-branch tracking updates, and detached-HEAD failure cases.
     +    For `git checkout`, keep this as a branch operation and reject pathspec
     +    usage with `--create-if-missing` to avoid mixing branch switching with
     +    path checkout semantics.
     +
     +    Document the new option and add tests covering branch creation,
     +    existing-branch switching, tracking updates, pathspec rejection, and
     +    detached-HEAD failure cases.
      
          Signed-off-by: Korov <korov9.c@gmail.com>
      
     + ## Documentation/git-checkout.adoc ##
     +@@ Documentation/git-checkout.adoc: git checkout [-q] [-f] [-m] [<branch>]
     + git checkout [-q] [-f] [-m] --detach [<branch>]
     + git checkout [-q] [-f] [-m] [--detach] <commit>
     + git checkout [-q] [-f] [-m] [[-b|-B|--orphan] <new-branch>] [<start-point>]
     ++git checkout [-q] [-f] [-m] --create-if-missing <branch> [<start-point>]
     + git checkout <tree-ish> [--] <pathspec>...
     + git checkout <tree-ish> --pathspec-from-file=<file> [--pathspec-file-nul]
     + git checkout [-f|--ours|--theirs|-m|--conflict=<style>] [--] <pathspec>...
     +@@ Documentation/git-checkout.adoc: This will fail if there's an error checking out _<new-branch>_, for
     + example if checking out the `<start-point>` commit would overwrite your
     + uncommitted changes.
     + 
     ++`git checkout --create-if-missing <branch> [<start-point>]`::
     ++
     ++	Check out _<branch>_ if it already exists, or create it from
     ++	_<start-point>_ before checking it out if it does not.
     +++
     ++When _<branch>_ does not already exist, this behaves like
     ++`git checkout -b <branch> [<start-point>]`, including any `--track`
     ++or `--no-track` options.
     +++
     ++When _<branch>_ already exists, the branch tip is not changed. If
     ++`--track[=(direct|inherit)]` is given, the existing branch's upstream
     ++configuration is updated using _<start-point>_ when one is provided,
     ++or the current branch when _<start-point>_ is omitted. This form fails
     ++when `HEAD` is detached and no _<start-point>_ is given.
     ++
     + `git checkout -B <branch> [<start-point>]`::
     + 
     + 	The same as `-b`, except that if the branch already exists it
     +@@ Documentation/git-checkout.adoc: of it").
     + 	The same as `-b`, except that if the branch already exists it
     + 	resets _<branch>_ to the start point instead of failing.
     + 
     ++`--create-if-missing <branch>`::
     ++	Check out _<branch>_ if it already exists, or create it from
     ++	_<start-point>_ before checking it out if it does not.
     +++
     ++When _<branch>_ does not already exist, this behaves like
     ++`git checkout -b <branch> [<start-point>]`, including any `--track`
     ++or `--no-track` options.
     +++
     ++When _<branch>_ already exists, the branch tip is not changed. If
     ++`--track[=(direct|inherit)]` is given, the existing branch's upstream
     ++configuration is updated using _<start-point>_ when one is provided,
     ++or the current branch when _<start-point>_ is omitted. This form fails
     ++when `HEAD` is detached and no _<start-point>_ is given.
     +++
     ++This option cannot be used when checking out paths.
     ++
     + `-t`::
     + `--track[=(direct|inherit)]`::
     + 	When creating a new branch, set up "upstream" configuration. See
     +
       ## Documentation/git-switch.adoc ##
      @@ Documentation/git-switch.adoc: SYNOPSIS
       git switch [<options>] [--no-guess] <branch>
       git switch [<options>] --detach [<start-point>]
       git switch [<options>] (-c|-C) <new-branch> [<start-point>]
     -+git switch [<options>] -e <branch> [<start-point>]
     ++git switch [<options>] --create-if-missing <branch> [<start-point>]
       git switch [<options>] --orphan <new-branch>
       
       DESCRIPTION
     @@ Documentation/git-switch.adoc: $ git branch -f _<new-branch>_
       $ git switch _<new-branch>_
       ------------
       
     -+`-e <branch>`::
     -+`--ensure <branch>`::
     ++`--create-if-missing <branch>`::
      +	Switch to _<branch>_ if it already exists, or create it from
      +	_<start-point>_ before switching to it if it does not.
      ++
     @@ builtin/checkout.c: struct checkout_opts {
       	const char *new_branch;
       	const char *new_branch_force;
       	const char *new_orphan_branch;
     -+	const char *ensure_branch;
     -+	const char *ensure_branch_start;
     ++	const char *create_if_missing_branch;
     ++	const char *create_if_missing_start;
       	int new_branch_log;
       	enum branch_track track;
       	struct diff_options diff_options;
     +@@ builtin/checkout.c: static int checkout_paths(const struct checkout_opts *opts,
     + 		die(_("Cannot update paths and switch to branch '%s' at the same time."),
     + 		    opts->new_branch);
     + 
     ++	if (opts->create_if_missing_branch)
     ++		die(_("Cannot update paths and switch to branch '%s' at the same time."),
     ++		    opts->create_if_missing_branch);
     ++
     + 	if (!opts->checkout_worktree && !opts->checkout_index)
     + 		die(_("neither '%s' or '%s' is specified"),
     + 		    "--staged", "--worktree");
      @@ builtin/checkout.c: static void update_refs_for_switch(const struct checkout_opts *opts,
       		free(new_branch_info->refname);
       		new_branch_info->name = xstrdup(opts->new_branch);
       		setup_branch_path(new_branch_info);
     -+	} else if (opts->ensure_branch && opts->branch_exists &&
     ++	} else if (opts->create_if_missing_branch && opts->branch_exists &&
      +		   opts->track != BRANCH_TRACK_UNSPECIFIED) {
     -+		const char *tracking_source = opts->ensure_branch_start ?
     -+			opts->ensure_branch_start :
     ++		const char *tracking_source = opts->create_if_missing_start ?
     ++			opts->create_if_missing_start :
      +			old_branch_info->name;
     -+		dwim_and_setup_tracking(the_repository, opts->ensure_branch,
     ++		dwim_and_setup_tracking(the_repository, opts->create_if_missing_branch,
      +					tracking_source, opts->track,
      +					opts->quiet);
     -+		remote_state_clear(the_repository->remote_state);
       	}
       
       	old_desc = old_branch_info->name;
     +@@ builtin/checkout.c: static void update_refs_for_switch(const struct checkout_opts *opts,
     + 					fprintf(stderr, _("Switched to and reset branch '%s'\n"), new_branch_info->name);
     + 				else
     + 					fprintf(stderr, _("Switched to a new branch '%s'\n"), new_branch_info->name);
     ++			} else if (opts->create_if_missing_branch &&
     ++				   opts->branch_exists) {
     ++				fprintf(stderr, _("Switched to existing branch '%s'\n"),
     ++					new_branch_info->name);
     + 			} else {
     + 				fprintf(stderr, _("Switched to branch '%s'\n"),
     + 					new_branch_info->name);
      @@ builtin/checkout.c: static int checkout_main(int argc, const char **argv, const char *prefix,
       		die(_("options '-%c', '-%c', and '%s' cannot be used together"),
       			cb_option, toupper(cb_option), "--orphan");
       
     -+	if (opts->ensure_branch) {
     ++	if (opts->create_if_missing_branch) {
      +		struct strbuf ref = STRBUF_INIT;
      +		int exists;
      +
      +		if (opts->new_branch || opts->new_branch_force || opts->new_orphan_branch)
     -+			die(_("'%s' cannot be used with '%s'"), "-e", "-c/-C/--orphan");
     ++			die(_("'%s' cannot be used with '%s'"), "--create-if-missing", "-c/-C/--orphan");
      +		if (opts->force_detach)
     -+			die(_("'%s' cannot be used with '%s'"), "-e", "--detach");
     ++			die(_("'%s' cannot be used with '%s'"), "--create-if-missing", "--detach");
      +
     -+		exists = validate_branchname(opts->ensure_branch, &ref);
     ++		exists = validate_branchname(opts->create_if_missing_branch, &ref);
      +		strbuf_release(&ref);
      +
      +		/* Save an explicit start point for tracking setup. */
      +		if (argc > 0 && opts->track != BRANCH_TRACK_UNSPECIFIED)
     -+			opts->ensure_branch_start = argv[0];
     ++			opts->create_if_missing_start = argv[0];
      +
      +		if (exists) {
      +			/*
     @@ builtin/checkout.c: static int checkout_main(int argc, const char **argv, const
      +			opts->branch_exists = 1;
      +		} else {
      +			/* Branch doesn't exist: create it like -c */
     -+			opts->new_branch = opts->ensure_branch;
     ++			opts->new_branch = opts->create_if_missing_branch;
      +		}
      +	}
      +
     -+	if (opts->ensure_branch && opts->branch_exists &&
     ++	if (opts->create_if_missing_branch && opts->branch_exists &&
      +	    opts->track != BRANCH_TRACK_UNSPECIFIED &&
     -+	    !opts->ensure_branch_start) {
     ++	    !opts->create_if_missing_start) {
      +		struct object_id head_oid;
      +		char *head = refs_resolve_refdup(get_main_ref_store(the_repository),
      +						 "HEAD", 0, &head_oid, NULL);
     @@ builtin/checkout.c: static int checkout_main(int argc, const char **argv, const
       
      -	/* --track without -c/-C/-b/-B/--orphan should DWIM */
      -	if (opts->track != BRANCH_TRACK_UNSPECIFIED && !opts->new_branch) {
     -+	/* --track without -c/-C/-b/-B/--orphan/-e should DWIM */
     ++	/* --track without -c/-C/-b/-B/--orphan/--create-if-missing should DWIM */
      +	if (opts->track != BRANCH_TRACK_UNSPECIFIED && !opts->new_branch &&
     -+	    !(opts->ensure_branch && opts->branch_exists)) {
     ++	    !(opts->create_if_missing_branch && opts->branch_exists)) {
       		const char *argv0 = argv[0];
       		if (!argc || !strcmp(argv0, "--"))
       			die(_("--track needs a branch name"));
     @@ builtin/checkout.c: static int checkout_main(int argc, const char **argv, const
       	}
       
      +	/*
     -+	 * Handle -e with existing branch: set up new_branch_info to switch
     -+	 * to the existing branch.
     ++	 * Handle --create-if-missing with existing branch: set up
     ++	 * new_branch_info to switch to the existing branch.
      +	 */
     -+	if (opts->ensure_branch && opts->branch_exists) {
     ++	if (opts->create_if_missing_branch && opts->branch_exists) {
      +		struct object_id rev;
      +
     ++		if (repo_get_oid_mb(the_repository, opts->create_if_missing_branch,
     ++				    &rev))
     ++			die(_("could not resolve '%s'"),
     ++			    opts->create_if_missing_branch);
     ++
      +		branch_info_release(&new_branch_info);
      +		memset(&new_branch_info, 0, sizeof(new_branch_info));
     -+		new_branch_info.name = xstrdup(opts->ensure_branch);
     -+		setup_branch_path(&new_branch_info);
     -+
     -+		if (new_branch_info.path &&
     -+		    !refs_read_ref(get_main_ref_store(the_repository),
     -+				   new_branch_info.path, &rev)) {
     -+			new_branch_info.commit = lookup_commit_reference_gently(
     -+				the_repository, &rev, 1);
     -+			if (new_branch_info.commit)
     -+				parse_commit_or_die(new_branch_info.commit);
     -+		}
     ++		setup_new_branch_info_and_source_tree(&new_branch_info, opts, &rev,
     ++						      opts->create_if_missing_branch);
      +	}
      +
       	if (argc) {
       		parse_pathspec(&opts->pathspec, 0,
       			       opts->patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0,
     +@@ builtin/checkout.c: int cmd_checkout(int argc,
     + 			   N_("create and checkout a new branch")),
     + 		OPT_STRING('B', NULL, &opts.new_branch_force, N_("branch"),
     + 			   N_("create/reset and checkout a branch")),
     ++		OPT_STRING_F(0, "create-if-missing", &opts.create_if_missing_branch, N_("branch"),
     ++			     N_("create if needed and checkout branch"),
     ++			     PARSE_OPT_NONEG),
     + 		OPT_BOOL('l', NULL, &opts.new_branch_log, N_("create reflog for new branch")),
     + 		OPT_BOOL(0, "guess", &opts.dwim_new_local_branch,
     + 			 N_("second guess 'git checkout <no-such-branch>' (default)")),
      @@ builtin/checkout.c: int cmd_switch(int argc,
       			   N_("create and switch to a new branch")),
       		OPT_STRING('C', "force-create", &opts.new_branch_force, N_("branch"),
       			   N_("create/reset and switch to a branch")),
     -+		OPT_STRING('e', "ensure", &opts.ensure_branch, N_("branch"),
     -+			   N_("create if needed and switch to branch")),
     ++		OPT_STRING_F(0, "create-if-missing", &opts.create_if_missing_branch, N_("branch"),
     ++			     N_("create if needed and switch to branch"),
     ++			     PARSE_OPT_NONEG),
       		OPT_BOOL(0, "guess", &opts.dwim_new_local_branch,
       			 N_("second guess 'git switch <no-such-branch>'")),
       		OPT_BOOL(0, "discard-changes", &opts.discard_changes,
      
     + ## contrib/completion/git-completion.bash ##
     +@@ contrib/completion/git-completion.bash: _git_checkout ()
     + 	local dwim_opt="$(__git_checkout_default_dwim_mode)"
     + 
     + 	case "$prev" in
     +-	-b|-B|--orphan)
     ++	-b|-B|--orphan|--create-if-missing)
     + 		# Complete local branches (and DWIM branch
     + 		# remote branch names) for an option argument
     + 		# specifying a new branch name. This is for
     +@@ contrib/completion/git-completion.bash: _git_checkout ()
     + 		;;
     + 	*)
     + 		# At this point, we've already handled special completion for
     +-		# the arguments to -b/-B, and --orphan. There are 3 main
     +-		# things left we can possibly complete:
     +-		# 1) a start-point for -b/-B, -d/--detach, or --orphan
     ++		# the arguments to -b/-B, --orphan, and
     ++		# --create-if-missing. There are 3 main things left
     ++		# we can possibly complete:
     ++		# 1) a start-point for -b/-B, -d/--detach, --orphan,
     ++		#    or --create-if-missing
     + 		# 2) a remote head, for --track
     + 		# 3) an arbitrary reference, possibly including DWIM names
     + 		#
     + 
     +-		if [ -n "$(__git_find_on_cmdline "-b -B -d --detach --orphan")" ]; then
     ++		if [ -n "$(__git_find_on_cmdline "-b -B -d --detach --orphan --create-if-missing")" ]; then
     + 			__git_complete_refs --mode="refs"
     + 		elif [ -n "$(__git_find_on_cmdline "-t --track")" ]; then
     + 			__git_complete_refs --mode="remote-heads"
     +@@ contrib/completion/git-completion.bash: _git_switch ()
     + 	local dwim_opt="$(__git_checkout_default_dwim_mode)"
     + 
     + 	case "$prev" in
     +-	-c|-C|--orphan)
     ++	-c|-C|--orphan|--create-if-missing)
     + 		# Complete local branches (and DWIM branch
     + 		# remote branch names) for an option argument
     + 		# specifying a new branch name. This is for
     +@@ contrib/completion/git-completion.bash: _git_switch ()
     + 		fi
     + 
     + 		# At this point, we've already handled special completion for
     +-		# -c/-C, and --orphan. There are 3 main things left to
     +-		# complete:
     +-		# 1) a start-point for -c/-C or -d/--detach
     ++		# -c/-C, --orphan, and --create-if-missing. There
     ++		# are 3 main things left to complete:
     ++		# 1) a start-point for -c/-C, -d/--detach, or --create-if-missing
     + 		# 2) a remote head, for --track
     + 		# 3) a branch name, possibly including DWIM remote branches
     + 
     +-		if [ -n "$(__git_find_on_cmdline "-c -C -d --detach")" ]; then
     ++		if [ -n "$(__git_find_on_cmdline "-c -C -d --detach --create-if-missing")" ]; then
     + 			__git_complete_refs --mode="refs"
     + 		elif [ -n "$(__git_find_on_cmdline "-t --track")" ]; then
     + 			__git_complete_refs --mode="remote-heads"
     +
     + ## t/t2018-checkout-branch.sh ##
     +@@ t/t2018-checkout-branch.sh: test_expect_success 'checkout -B to the current branch works' '
     + 	test_dirty_mergeable
     + '
     + 
     ++test_expect_success 'checkout --create-if-missing creates a branch' '
     ++	test_when_finished "
     ++		git checkout branch1 &&
     ++		test_might_fail git branch -D create-if-missing-new
     ++	" &&
     ++	git checkout --create-if-missing create-if-missing-new $HEAD1 &&
     ++	echo refs/heads/create-if-missing-new >expect &&
     ++	git symbolic-ref HEAD >actual &&
     ++	test_cmp expect actual &&
     ++	test_cmp_rev $HEAD1 HEAD
     ++'
     ++
     ++test_expect_success 'checkout --create-if-missing switches to existing branch' '
     ++	test_when_finished "
     ++		git checkout branch1 &&
     ++		test_might_fail git branch -D create-if-missing-existing
     ++	" &&
     ++	git branch create-if-missing-existing $HEAD1 &&
     ++	git checkout branch1 &&
     ++	git checkout --create-if-missing create-if-missing-existing 2>err &&
     ++	test_grep "Switched to existing branch '\''create-if-missing-existing'\''" err &&
     ++	echo refs/heads/create-if-missing-existing >expect &&
     ++	git symbolic-ref HEAD >actual &&
     ++	test_cmp expect actual &&
     ++	test_cmp_rev $HEAD1 HEAD
     ++'
     ++
     + test_expect_success 'checkout -b after clone --no-checkout does a checkout of HEAD' '
     + 	git init src &&
     + 	test_commit -C src a &&
     +@@ t/t2018-checkout-branch.sh: test_expect_success 'checkout -b rejects an extra path argument' '
     + 	test_grep "Cannot update paths and switch to branch" err
     + '
     + 
     ++test_expect_success 'checkout --create-if-missing rejects a path argument' '
     ++	test_when_finished "
     ++		git checkout branch1 &&
     ++		test_might_fail git branch -D create-if-missing-path
     ++	" &&
     ++	git branch create-if-missing-path branch1 &&
     ++	test_must_fail git checkout --create-if-missing create-if-missing-path -- file1 2>err &&
     ++	test_grep "Cannot update paths and switch to branch '\''create-if-missing-path'\''" err
     ++'
     ++
     + test_done
     +
     + ## t/t2027-checkout-track.sh ##
     +@@ t/t2027-checkout-track.sh: test_expect_success 'checkout --track -b creates a new tracking branch' '
     + 	test $(git config --get branch.branch1.merge) = refs/heads/main
     + '
     + 
     ++test_expect_success 'checkout --create-if-missing --track creates branch from current branch' '
     ++	test_when_finished "
     ++		git checkout main &&
     ++		git branch -D branch2
     ++	" &&
     ++	git checkout main &&
     ++	git checkout --create-if-missing branch2 --track &&
     ++	test $(git rev-parse --abbrev-ref HEAD) = branch2 &&
     ++	test_cmp_config . branch.branch2.remote &&
     ++	test_cmp_config refs/heads/main branch.branch2.merge
     ++'
     ++
     ++test_expect_success 'checkout --create-if-missing --track uses current branch for existing branch' '
     ++	test_when_finished "
     ++		git checkout main &&
     ++		git branch -D branch3 branch3-source
     ++	" &&
     ++	git checkout -b branch3-source main &&
     ++	git branch branch3 main &&
     ++	git checkout --create-if-missing branch3 --track >out 2>err &&
     ++	test_grep "branch '\''branch3'\'' set up to track '\''branch3-source'\''." out &&
     ++	test_grep "Switched to existing branch '\''branch3'\''" err &&
     ++	test_cmp_config . branch.branch3.remote &&
     ++	test_cmp_config refs/heads/branch3-source branch.branch3.merge
     ++'
     ++
     ++test_expect_success 'checkout --create-if-missing --track fails from detached HEAD without start-point' '
     ++	test_when_finished "
     ++		git checkout main &&
     ++		git branch -D branch4
     ++	" &&
     ++	git branch branch4 main &&
     ++	git checkout --detach main &&
     ++	test_must_fail git checkout --create-if-missing branch4 --track 2>err &&
     ++	test_grep "cannot set up tracking information; starting point '\''HEAD'\'' is not a branch" err
     ++'
     ++
     + test_expect_success 'checkout --track -b rejects an extra path argument' '
     + 	test_must_fail git checkout --track -b branch2 main one.t 2>err &&
     + 	test_grep "cannot be used with updating paths" err
     +
       ## t/t2060-switch.sh ##
      @@ t/t2060-switch.sh: test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
       	test_cmp_config "" --default "" branch.main2.merge
       '
       
     -+test_expect_success 'switch -e --track creates branch from current branch' '
     ++test_expect_success 'switch --create-if-missing --track creates branch from current branch' '
      +	test_when_finished "
      +		git switch main || :
      +		git branch -D ensure-new-current || :
      +	" &&
      +	git switch main &&
     -+	git switch -e ensure-new-current --track &&
     ++	git switch --create-if-missing ensure-new-current --track &&
      +	test_cmp_rev refs/heads/main refs/heads/ensure-new-current &&
      +	test_cmp_config . branch.ensure-new-current.remote &&
      +	test_cmp_config refs/heads/main branch.ensure-new-current.merge
      +'
      +
     -+test_expect_success 'switch -e --track creates branch from remote-tracking branch' '
     ++test_expect_success 'switch --create-if-missing --track creates branch from remote-tracking branch' '
      +	test_when_finished "
      +		git switch main || :
      +		git branch -D ensure-new || :
      +	" &&
     -+	git switch -e ensure-new --track origin/foo &&
     ++	git switch --create-if-missing ensure-new --track origin/foo &&
      +	test_cmp_rev refs/remotes/origin/foo refs/heads/ensure-new &&
      +	test_cmp_config origin branch.ensure-new.remote &&
      +	test_cmp_config refs/heads/foo branch.ensure-new.merge
      +'
      +
     -+test_expect_success 'switch -e --track uses current branch for existing branch' '
     ++test_expect_success 'switch --create-if-missing switches to existing branch' '
     ++	test_when_finished "
     ++		git switch main || :
     ++		git branch -D ensure-existing-plain || :
     ++	" &&
     ++	git branch ensure-existing-plain main &&
     ++	git switch --create-if-missing ensure-existing-plain 2>err &&
     ++	test_grep "Switched to existing branch '\''ensure-existing-plain'\''" err
     ++'
     ++
     ++test_expect_success 'switch --create-if-missing reports tracking for existing branch' '
     ++	test_when_finished "
     ++		git switch main || :
     ++		git branch -D ensure-existing-report || :
     ++		git update-ref refs/remotes/origin/foo first-branch || :
     ++	" &&
     ++	git branch ensure-existing-report first-branch &&
     ++	git config branch.ensure-existing-report.remote origin &&
     ++	git config branch.ensure-existing-report.merge refs/heads/foo &&
     ++	git update-ref refs/remotes/origin/foo main &&
     ++	git switch --create-if-missing ensure-existing-report >out 2>err &&
     ++	test_grep "Switched to existing branch '\''ensure-existing-report'\''" err &&
     ++	test_grep "Your branch is behind '\''origin/foo'\''" out
     ++'
     ++
     ++test_expect_success 'switch --create-if-missing --track uses current branch for existing branch' '
      +	test_when_finished "
      +		git switch main || :
      +		git branch -D ensure-existing source-for-track || :
      +	" &&
      +	git switch -c source-for-track main &&
      +	git branch ensure-existing main &&
     -+	git switch -e ensure-existing --track &&
     ++	git switch --create-if-missing ensure-existing --track >out 2>err &&
     ++	test_grep "branch '\''ensure-existing'\'' set up to track '\''source-for-track'\''." out &&
     ++	test_grep "Switched to existing branch '\''ensure-existing'\''" err &&
      +	test_cmp_config . branch.ensure-existing.remote &&
      +	test_cmp_config refs/heads/source-for-track branch.ensure-existing.merge
      +'
      +
     -+test_expect_success 'switch -e --track fails from detached HEAD without start-point' '
     ++test_expect_success 'switch --create-if-missing --track fails from detached HEAD without start-point' '
      +	test_when_finished "
      +		git switch main || :
      +		git branch -D detached-target || :
      +	" &&
      +	git branch detached-target main &&
      +	git switch --detach main &&
     -+	test_must_fail git switch -e detached-target --track 2>stderr &&
     ++	test_must_fail git switch --create-if-missing detached-target --track 2>stderr &&
      +	test_grep "cannot set up tracking information; starting point '\''HEAD'\'' is not a branch" stderr
      +'
      +
       test_expect_success 'switch back when temporarily detached and checked out elsewhere ' '
       	test_when_finished "
       		git worktree remove wt1 ||:
     +
     + ## t/t9902-completion.sh ##
     +@@ t/t9902-completion.sh: test_expect_success 'double dash "git checkout"' '
     + 	--quiet Z
     + 	--detach Z
     + 	--track Z
     ++	--create-if-missing=Z
     + 	--orphan=Z
     + 	--ours Z
     + 	--theirs Z


 Documentation/git-checkout.adoc        | 32 +++++++++
 Documentation/git-switch.adoc          | 15 +++++
 builtin/checkout.c                     | 93 +++++++++++++++++++++++++-
 contrib/completion/git-completion.bash | 22 +++---
 t/t2018-checkout-branch.sh             | 37 ++++++++++
 t/t2027-checkout-track.sh              | 37 ++++++++++
 t/t2060-switch.sh                      | 73 ++++++++++++++++++++
 t/t9902-completion.sh                  |  1 +
 8 files changed, 298 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index a8b3b8c2e2..a80f6fe6f6 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -12,6 +12,7 @@ git checkout [-q] [-f] [-m] [<branch>]
 git checkout [-q] [-f] [-m] --detach [<branch>]
 git checkout [-q] [-f] [-m] [--detach] <commit>
 git checkout [-q] [-f] [-m] [[-b|-B|--orphan] <new-branch>] [<start-point>]
+git checkout [-q] [-f] [-m] --create-if-missing <branch> [<start-point>]
 git checkout <tree-ish> [--] <pathspec>...
 git checkout <tree-ish> --pathspec-from-file=<file> [--pathspec-file-nul]
 git checkout [-f|--ours|--theirs|-m|--conflict=<style>] [--] <pathspec>...
@@ -58,6 +59,21 @@ This will fail if there's an error checking out _<new-branch>_, for
 example if checking out the `<start-point>` commit would overwrite your
 uncommitted changes.
 
+`git checkout --create-if-missing <branch> [<start-point>]`::
+
+	Check out _<branch>_ if it already exists, or create it from
+	_<start-point>_ before checking it out if it does not.
++
+When _<branch>_ does not already exist, this behaves like
+`git checkout -b <branch> [<start-point>]`, including any `--track`
+or `--no-track` options.
++
+When _<branch>_ already exists, the branch tip is not changed. If
+`--track[=(direct|inherit)]` is given, the existing branch's upstream
+configuration is updated using _<start-point>_ when one is provided,
+or the current branch when _<start-point>_ is omitted. This form fails
+when `HEAD` is detached and no _<start-point>_ is given.
+
 `git checkout -B <branch> [<start-point>]`::
 
 	The same as `-b`, except that if the branch already exists it
@@ -157,6 +173,22 @@ of it").
 	The same as `-b`, except that if the branch already exists it
 	resets _<branch>_ to the start point instead of failing.
 
+`--create-if-missing <branch>`::
+	Check out _<branch>_ if it already exists, or create it from
+	_<start-point>_ before checking it out if it does not.
++
+When _<branch>_ does not already exist, this behaves like
+`git checkout -b <branch> [<start-point>]`, including any `--track`
+or `--no-track` options.
++
+When _<branch>_ already exists, the branch tip is not changed. If
+`--track[=(direct|inherit)]` is given, the existing branch's upstream
+configuration is updated using _<start-point>_ when one is provided,
+or the current branch when _<start-point>_ is omitted. This form fails
+when `HEAD` is detached and no _<start-point>_ is given.
++
+This option cannot be used when checking out paths.
+
 `-t`::
 `--track[=(direct|inherit)]`::
 	When creating a new branch, set up "upstream" configuration. See
diff --git a/Documentation/git-switch.adoc b/Documentation/git-switch.adoc
index d6c4f229a5..461a6f0b96 100644
--- a/Documentation/git-switch.adoc
+++ b/Documentation/git-switch.adoc
@@ -11,6 +11,7 @@ SYNOPSIS
 git switch [<options>] [--no-guess] <branch>
 git switch [<options>] --detach [<start-point>]
 git switch [<options>] (-c|-C) <new-branch> [<start-point>]
+git switch [<options>] --create-if-missing <branch> [<start-point>]
 git switch [<options>] --orphan <new-branch>
 
 DESCRIPTION
@@ -81,6 +82,20 @@ $ git branch -f _<new-branch>_
 $ git switch _<new-branch>_
 ------------
 
+`--create-if-missing <branch>`::
+	Switch to _<branch>_ if it already exists, or create it from
+	_<start-point>_ before switching to it if it does not.
++
+When _<branch>_ does not already exist, this behaves like
+`git switch -c <branch> [<start-point>]`, including any `--track`
+or `--no-track` options.
++
+When _<branch>_ already exists, the branch tip is not changed. If
+`--track[=(direct|inherit)]` is given, the existing branch's upstream
+configuration is updated using _<start-point>_ when one is provided,
+or the current branch when _<start-point>_ is omitted. This form fails
+when `HEAD` is detached and no _<start-point>_ is given.
+
 `-d`::
 `--detach`::
 	Switch to a commit for inspection and discardable
diff --git a/builtin/checkout.c b/builtin/checkout.c
index b78b3a1d16..f5bc882f2e 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -81,6 +81,8 @@ struct checkout_opts {
 	const char *new_branch;
 	const char *new_branch_force;
 	const char *new_orphan_branch;
+	const char *create_if_missing_branch;
+	const char *create_if_missing_start;
 	int new_branch_log;
 	enum branch_track track;
 	struct diff_options diff_options;
@@ -551,6 +553,10 @@ static int checkout_paths(const struct checkout_opts *opts,
 		die(_("Cannot update paths and switch to branch '%s' at the same time."),
 		    opts->new_branch);
 
+	if (opts->create_if_missing_branch)
+		die(_("Cannot update paths and switch to branch '%s' at the same time."),
+		    opts->create_if_missing_branch);
+
 	if (!opts->checkout_worktree && !opts->checkout_index)
 		die(_("neither '%s' or '%s' is specified"),
 		    "--staged", "--worktree");
@@ -988,6 +994,14 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 		free(new_branch_info->refname);
 		new_branch_info->name = xstrdup(opts->new_branch);
 		setup_branch_path(new_branch_info);
+	} else if (opts->create_if_missing_branch && opts->branch_exists &&
+		   opts->track != BRANCH_TRACK_UNSPECIFIED) {
+		const char *tracking_source = opts->create_if_missing_start ?
+			opts->create_if_missing_start :
+			old_branch_info->name;
+		dwim_and_setup_tracking(the_repository, opts->create_if_missing_branch,
+					tracking_source, opts->track,
+					opts->quiet);
 	}
 
 	old_desc = old_branch_info->name;
@@ -1030,6 +1044,10 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 					fprintf(stderr, _("Switched to and reset branch '%s'\n"), new_branch_info->name);
 				else
 					fprintf(stderr, _("Switched to a new branch '%s'\n"), new_branch_info->name);
+			} else if (opts->create_if_missing_branch &&
+				   opts->branch_exists) {
+				fprintf(stderr, _("Switched to existing branch '%s'\n"),
+					new_branch_info->name);
 			} else {
 				fprintf(stderr, _("Switched to branch '%s'\n"),
 					new_branch_info->name);
@@ -1927,6 +1945,52 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 		die(_("options '-%c', '-%c', and '%s' cannot be used together"),
 			cb_option, toupper(cb_option), "--orphan");
 
+	if (opts->create_if_missing_branch) {
+		struct strbuf ref = STRBUF_INIT;
+		int exists;
+
+		if (opts->new_branch || opts->new_branch_force || opts->new_orphan_branch)
+			die(_("'%s' cannot be used with '%s'"), "--create-if-missing", "-c/-C/--orphan");
+		if (opts->force_detach)
+			die(_("'%s' cannot be used with '%s'"), "--create-if-missing", "--detach");
+
+		exists = validate_branchname(opts->create_if_missing_branch, &ref);
+		strbuf_release(&ref);
+
+		/* Save an explicit start point for tracking setup. */
+		if (argc > 0 && opts->track != BRANCH_TRACK_UNSPECIFIED)
+			opts->create_if_missing_start = argv[0];
+
+		if (exists) {
+			/*
+			 * Branch exists: just switch to it, don't reset.
+			 * We'll set up tracking after the switch if --track was given.
+			 */
+			opts->branch_exists = 1;
+		} else {
+			/* Branch doesn't exist: create it like -c */
+			opts->new_branch = opts->create_if_missing_branch;
+		}
+	}
+
+	if (opts->create_if_missing_branch && opts->branch_exists &&
+	    opts->track != BRANCH_TRACK_UNSPECIFIED &&
+	    !opts->create_if_missing_start) {
+		struct object_id head_oid;
+		char *head = refs_resolve_refdup(get_main_ref_store(the_repository),
+						 "HEAD", 0, &head_oid, NULL);
+		const char *branch;
+
+		if (!head)
+			die(_("failed to resolve HEAD as a valid ref"));
+		if (!strcmp(head, "HEAD"))
+			die(_("cannot set up tracking information; starting point '%s' is not a branch"),
+			    "HEAD");
+		if (!skip_prefix(head, "refs/heads/", &branch))
+			die(_("HEAD not found below refs/heads!"));
+		free(head);
+	}
+
 	if (opts->overlay_mode == 1 && opts->patch_mode)
 		die(_("options '%s' and '%s' cannot be used together"), "-p", "--overlay");
 
@@ -1961,8 +2025,9 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	if (opts->new_orphan_branch)
 		opts->new_branch = opts->new_orphan_branch;
 
-	/* --track without -c/-C/-b/-B/--orphan should DWIM */
-	if (opts->track != BRANCH_TRACK_UNSPECIFIED && !opts->new_branch) {
+	/* --track without -c/-C/-b/-B/--orphan/--create-if-missing should DWIM */
+	if (opts->track != BRANCH_TRACK_UNSPECIFIED && !opts->new_branch &&
+	    !(opts->create_if_missing_branch && opts->branch_exists)) {
 		const char *argv0 = argv[0];
 		if (!argc || !strcmp(argv0, "--"))
 			die(_("--track needs a branch name"));
@@ -2012,6 +2077,24 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			die(_("reference is not a tree: %s"), opts->from_treeish);
 	}
 
+	/*
+	 * Handle --create-if-missing with existing branch: set up
+	 * new_branch_info to switch to the existing branch.
+	 */
+	if (opts->create_if_missing_branch && opts->branch_exists) {
+		struct object_id rev;
+
+		if (repo_get_oid_mb(the_repository, opts->create_if_missing_branch,
+				    &rev))
+			die(_("could not resolve '%s'"),
+			    opts->create_if_missing_branch);
+
+		branch_info_release(&new_branch_info);
+		memset(&new_branch_info, 0, sizeof(new_branch_info));
+		setup_new_branch_info_and_source_tree(&new_branch_info, opts, &rev,
+						      opts->create_if_missing_branch);
+	}
+
 	if (argc) {
 		parse_pathspec(&opts->pathspec, 0,
 			       opts->patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0,
@@ -2098,6 +2181,9 @@ int cmd_checkout(int argc,
 			   N_("create and checkout a new branch")),
 		OPT_STRING('B', NULL, &opts.new_branch_force, N_("branch"),
 			   N_("create/reset and checkout a branch")),
+		OPT_STRING_F(0, "create-if-missing", &opts.create_if_missing_branch, N_("branch"),
+			     N_("create if needed and checkout branch"),
+			     PARSE_OPT_NONEG),
 		OPT_BOOL('l', NULL, &opts.new_branch_log, N_("create reflog for new branch")),
 		OPT_BOOL(0, "guess", &opts.dwim_new_local_branch,
 			 N_("second guess 'git checkout <no-such-branch>' (default)")),
@@ -2150,6 +2236,9 @@ int cmd_switch(int argc,
 			   N_("create and switch to a new branch")),
 		OPT_STRING('C', "force-create", &opts.new_branch_force, N_("branch"),
 			   N_("create/reset and switch to a branch")),
+		OPT_STRING_F(0, "create-if-missing", &opts.create_if_missing_branch, N_("branch"),
+			     N_("create if needed and switch to branch"),
+			     PARSE_OPT_NONEG),
 		OPT_BOOL(0, "guess", &opts.dwim_new_local_branch,
 			 N_("second guess 'git switch <no-such-branch>'")),
 		OPT_BOOL(0, "discard-changes", &opts.discard_changes,
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e875787710..1c72b4c853 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1740,7 +1740,7 @@ _git_checkout ()
 	local dwim_opt="$(__git_checkout_default_dwim_mode)"
 
 	case "$prev" in
-	-b|-B|--orphan)
+	-b|-B|--orphan|--create-if-missing)
 		# Complete local branches (and DWIM branch
 		# remote branch names) for an option argument
 		# specifying a new branch name. This is for
@@ -1762,14 +1762,16 @@ _git_checkout ()
 		;;
 	*)
 		# At this point, we've already handled special completion for
-		# the arguments to -b/-B, and --orphan. There are 3 main
-		# things left we can possibly complete:
-		# 1) a start-point for -b/-B, -d/--detach, or --orphan
+		# the arguments to -b/-B, --orphan, and
+		# --create-if-missing. There are 3 main things left
+		# we can possibly complete:
+		# 1) a start-point for -b/-B, -d/--detach, --orphan,
+		#    or --create-if-missing
 		# 2) a remote head, for --track
 		# 3) an arbitrary reference, possibly including DWIM names
 		#
 
-		if [ -n "$(__git_find_on_cmdline "-b -B -d --detach --orphan")" ]; then
+		if [ -n "$(__git_find_on_cmdline "-b -B -d --detach --orphan --create-if-missing")" ]; then
 			__git_complete_refs --mode="refs"
 		elif [ -n "$(__git_find_on_cmdline "-t --track")" ]; then
 			__git_complete_refs --mode="remote-heads"
@@ -2692,7 +2694,7 @@ _git_switch ()
 	local dwim_opt="$(__git_checkout_default_dwim_mode)"
 
 	case "$prev" in
-	-c|-C|--orphan)
+	-c|-C|--orphan|--create-if-missing)
 		# Complete local branches (and DWIM branch
 		# remote branch names) for an option argument
 		# specifying a new branch name. This is for
@@ -2721,13 +2723,13 @@ _git_switch ()
 		fi
 
 		# At this point, we've already handled special completion for
-		# -c/-C, and --orphan. There are 3 main things left to
-		# complete:
-		# 1) a start-point for -c/-C or -d/--detach
+		# -c/-C, --orphan, and --create-if-missing. There
+		# are 3 main things left to complete:
+		# 1) a start-point for -c/-C, -d/--detach, or --create-if-missing
 		# 2) a remote head, for --track
 		# 3) a branch name, possibly including DWIM remote branches
 
-		if [ -n "$(__git_find_on_cmdline "-c -C -d --detach")" ]; then
+		if [ -n "$(__git_find_on_cmdline "-c -C -d --detach --create-if-missing")" ]; then
 			__git_complete_refs --mode="refs"
 		elif [ -n "$(__git_find_on_cmdline "-t --track")" ]; then
 			__git_complete_refs --mode="remote-heads"
diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index a48ebdbf4d..f910563170 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -243,6 +243,33 @@ test_expect_success 'checkout -B to the current branch works' '
 	test_dirty_mergeable
 '
 
+test_expect_success 'checkout --create-if-missing creates a branch' '
+	test_when_finished "
+		git checkout branch1 &&
+		test_might_fail git branch -D create-if-missing-new
+	" &&
+	git checkout --create-if-missing create-if-missing-new $HEAD1 &&
+	echo refs/heads/create-if-missing-new >expect &&
+	git symbolic-ref HEAD >actual &&
+	test_cmp expect actual &&
+	test_cmp_rev $HEAD1 HEAD
+'
+
+test_expect_success 'checkout --create-if-missing switches to existing branch' '
+	test_when_finished "
+		git checkout branch1 &&
+		test_might_fail git branch -D create-if-missing-existing
+	" &&
+	git branch create-if-missing-existing $HEAD1 &&
+	git checkout branch1 &&
+	git checkout --create-if-missing create-if-missing-existing 2>err &&
+	test_grep "Switched to existing branch '\''create-if-missing-existing'\''" err &&
+	echo refs/heads/create-if-missing-existing >expect &&
+	git symbolic-ref HEAD >actual &&
+	test_cmp expect actual &&
+	test_cmp_rev $HEAD1 HEAD
+'
+
 test_expect_success 'checkout -b after clone --no-checkout does a checkout of HEAD' '
 	git init src &&
 	test_commit -C src a &&
@@ -285,4 +312,14 @@ test_expect_success 'checkout -b rejects an extra path argument' '
 	test_grep "Cannot update paths and switch to branch" err
 '
 
+test_expect_success 'checkout --create-if-missing rejects a path argument' '
+	test_when_finished "
+		git checkout branch1 &&
+		test_might_fail git branch -D create-if-missing-path
+	" &&
+	git branch create-if-missing-path branch1 &&
+	test_must_fail git checkout --create-if-missing create-if-missing-path -- file1 2>err &&
+	test_grep "Cannot update paths and switch to branch '\''create-if-missing-path'\''" err
+'
+
 test_done
diff --git a/t/t2027-checkout-track.sh b/t/t2027-checkout-track.sh
index c01f1cd617..67f073ddf0 100755
--- a/t/t2027-checkout-track.sh
+++ b/t/t2027-checkout-track.sh
@@ -19,6 +19,43 @@ test_expect_success 'checkout --track -b creates a new tracking branch' '
 	test $(git config --get branch.branch1.merge) = refs/heads/main
 '
 
+test_expect_success 'checkout --create-if-missing --track creates branch from current branch' '
+	test_when_finished "
+		git checkout main &&
+		git branch -D branch2
+	" &&
+	git checkout main &&
+	git checkout --create-if-missing branch2 --track &&
+	test $(git rev-parse --abbrev-ref HEAD) = branch2 &&
+	test_cmp_config . branch.branch2.remote &&
+	test_cmp_config refs/heads/main branch.branch2.merge
+'
+
+test_expect_success 'checkout --create-if-missing --track uses current branch for existing branch' '
+	test_when_finished "
+		git checkout main &&
+		git branch -D branch3 branch3-source
+	" &&
+	git checkout -b branch3-source main &&
+	git branch branch3 main &&
+	git checkout --create-if-missing branch3 --track >out 2>err &&
+	test_grep "branch '\''branch3'\'' set up to track '\''branch3-source'\''." out &&
+	test_grep "Switched to existing branch '\''branch3'\''" err &&
+	test_cmp_config . branch.branch3.remote &&
+	test_cmp_config refs/heads/branch3-source branch.branch3.merge
+'
+
+test_expect_success 'checkout --create-if-missing --track fails from detached HEAD without start-point' '
+	test_when_finished "
+		git checkout main &&
+		git branch -D branch4
+	" &&
+	git branch branch4 main &&
+	git checkout --detach main &&
+	test_must_fail git checkout --create-if-missing branch4 --track 2>err &&
+	test_grep "cannot set up tracking information; starting point '\''HEAD'\'' is not a branch" err
+'
+
 test_expect_success 'checkout --track -b rejects an extra path argument' '
 	test_must_fail git checkout --track -b branch2 main one.t 2>err &&
 	test_grep "cannot be used with updating paths" err
diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
index c91c4db936..f17afda28e 100755
--- a/t/t2060-switch.sh
+++ b/t/t2060-switch.sh
@@ -146,6 +146,79 @@ test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
 	test_cmp_config "" --default "" branch.main2.merge
 '
 
+test_expect_success 'switch --create-if-missing --track creates branch from current branch' '
+	test_when_finished "
+		git switch main || :
+		git branch -D ensure-new-current || :
+	" &&
+	git switch main &&
+	git switch --create-if-missing ensure-new-current --track &&
+	test_cmp_rev refs/heads/main refs/heads/ensure-new-current &&
+	test_cmp_config . branch.ensure-new-current.remote &&
+	test_cmp_config refs/heads/main branch.ensure-new-current.merge
+'
+
+test_expect_success 'switch --create-if-missing --track creates branch from remote-tracking branch' '
+	test_when_finished "
+		git switch main || :
+		git branch -D ensure-new || :
+	" &&
+	git switch --create-if-missing ensure-new --track origin/foo &&
+	test_cmp_rev refs/remotes/origin/foo refs/heads/ensure-new &&
+	test_cmp_config origin branch.ensure-new.remote &&
+	test_cmp_config refs/heads/foo branch.ensure-new.merge
+'
+
+test_expect_success 'switch --create-if-missing switches to existing branch' '
+	test_when_finished "
+		git switch main || :
+		git branch -D ensure-existing-plain || :
+	" &&
+	git branch ensure-existing-plain main &&
+	git switch --create-if-missing ensure-existing-plain 2>err &&
+	test_grep "Switched to existing branch '\''ensure-existing-plain'\''" err
+'
+
+test_expect_success 'switch --create-if-missing reports tracking for existing branch' '
+	test_when_finished "
+		git switch main || :
+		git branch -D ensure-existing-report || :
+		git update-ref refs/remotes/origin/foo first-branch || :
+	" &&
+	git branch ensure-existing-report first-branch &&
+	git config branch.ensure-existing-report.remote origin &&
+	git config branch.ensure-existing-report.merge refs/heads/foo &&
+	git update-ref refs/remotes/origin/foo main &&
+	git switch --create-if-missing ensure-existing-report >out 2>err &&
+	test_grep "Switched to existing branch '\''ensure-existing-report'\''" err &&
+	test_grep "Your branch is behind '\''origin/foo'\''" out
+'
+
+test_expect_success 'switch --create-if-missing --track uses current branch for existing branch' '
+	test_when_finished "
+		git switch main || :
+		git branch -D ensure-existing source-for-track || :
+	" &&
+	git switch -c source-for-track main &&
+	git branch ensure-existing main &&
+	git switch --create-if-missing ensure-existing --track >out 2>err &&
+	test_grep "branch '\''ensure-existing'\'' set up to track '\''source-for-track'\''." out &&
+	test_grep "Switched to existing branch '\''ensure-existing'\''" err &&
+	test_cmp_config . branch.ensure-existing.remote &&
+	test_cmp_config refs/heads/source-for-track branch.ensure-existing.merge
+'
+
+test_expect_success 'switch --create-if-missing --track fails from detached HEAD without start-point' '
+	test_when_finished "
+		git switch main || :
+		git branch -D detached-target || :
+	" &&
+	git branch detached-target main &&
+	git switch --detach main &&
+	test_must_fail git switch --create-if-missing detached-target --track 2>stderr &&
+	test_grep "cannot set up tracking information; starting point '\''HEAD'\'' is not a branch" stderr
+'
+
 test_expect_success 'switch back when temporarily detached and checked out elsewhere ' '
 	test_when_finished "
 		git worktree remove wt1 ||:
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 55dc9eabfc..e782c39c5e 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2588,6 +2588,7 @@ test_expect_success 'double dash "git checkout"' '
 	--quiet Z
 	--detach Z
 	--track Z
+	--create-if-missing=Z
 	--orphan=Z
 	--ours Z
 	--theirs Z

base-commit: 0fae78c9d55efe705877ea537fe42c59164ccd94
-- 
gitgitgadget
