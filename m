Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9A3C433F5
	for <git@archiver.kernel.org>; Sun, 17 Oct 2021 04:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4909F610A0
	for <git@archiver.kernel.org>; Sun, 17 Oct 2021 04:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244525AbhJQErO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Oct 2021 00:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbhJQErN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Oct 2021 00:47:13 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DADC061765
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 21:45:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u84-20020a254757000000b005bbc2bc51fcso9378787yba.3
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 21:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=b4yLqoXkQ8Vg28Ws/L0gVg2HqpQHdhBdHwG/xub+SrA=;
        b=gm9iAGOml6PMZfFYQ0G8I+uJhcGFQluO3M84rjJ8jelBIP2/LWn730QP6gB1rgkpMQ
         /V0rqmTX1MszAyyWy6vfebXq6X5OLohwx6dyE09W2vtk76SnaW7bBTG+2XyLt5b1dHYN
         gjYpG9NLn91Wmf1JlDlJ2VbHC0x0k17+ql6qZNnOcApx6sbHxbsLounrHhASgmGGpZQ9
         zMAhOLCUUUiHi6qULvkXT2T6ukhVhJzmVQu/bVjDO5jXn/jNGlAj8W8lCBdtc0Q+lO2T
         cy67z+reOEZiKm5krIdZk2U8gshfGtvQcZ7WXV2D7nHwbKH4EBcWPrHvnVVH7BkZBef8
         mX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=b4yLqoXkQ8Vg28Ws/L0gVg2HqpQHdhBdHwG/xub+SrA=;
        b=azIOxGpQsyuqYjjm3aArVn1rJAcA2JrlAJrBKjs1PQGDiyargoKCIUSgkeVsB2bF5u
         YAQgsXmTI9tXtJCvn+kOJ3RrNVJ1EbF4Vpqe8cq3rAs3D4XpCjGp4lX6ONdXkHYa3CZM
         mmtg78hn40x/NEi7fQln99u7Q0Oiulht0MKDSvd8fC4dlEujY53N9VYEb65//CYA2iW5
         yWLJ3wcw1LJJ14Rd9KkzXVJfcFXRZtEKE6GAz31bU/Cg8xXwNLn2m7uRwLyXYJFiCSQX
         4MIMWPIOaK6RWUHxSqYLyTQN1ijL5mf3XG9JVhgA7vurJcNFEBIAojPE06/5wxHQst8x
         6w5A==
X-Gm-Message-State: AOAM531FuqBpKR/a1VbN/HF5PT82TT5B3EAZViFU3oqlbQYaBRPwO8fj
        IZSTs4RhVFyxsD2QGR1oVaLIawX2d/98KyJq85b7qzbipfbnXem7n4BFk/j2tH03PLF1E3U9KFM
        6KOO2o6AIPJ9DmPxLE47RY40z61q1azGsL8qN73MmpfLmc7sfrbcTsCbJGx9bJY4=
X-Google-Smtp-Source: ABdhPJxP0ae9tfngucYxagAC7dxHQhf8mXdTlpn2VtVwuuNg0AEmOhwq/UuJids7mj3eLiNKCdfj6dy1V6l+hg==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:553d:e281:cf74:8cfc])
 (user=steadmon job=sendgmr) by 2002:a25:b4d:: with SMTP id
 74mr20404074ybl.443.1634445902956; Sat, 16 Oct 2021 21:45:02 -0700 (PDT)
Date:   Sat, 16 Oct 2021 21:45:00 -0700
In-Reply-To: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
Message-Id: <b9356d9837479914bcf9a265f52afe170be7e2e2.1634445482.git.steadmon@google.com>
Mime-Version: 1.0
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v3] branch: add flags and config to inherit tracking
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, emilyshaffer@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It can be helpful when creating a new branch to use the existing
tracking configuration from the branch point. However, there is
currently not a method to automatically do so.

Teach git-{branch,checkout,switch} an "inherit" argument to the
"--track" option. When this is set, creating a new branch will cause the
tracking configuration to default to the configuration of the branch
point, if set.

For example, if branch "main" tracks "origin/main", and we run
`git checkout --track=inherit -b feature main`, then branch "feature"
will track "origin/main". Thus, `git status` will show us how far
ahead/behind we are from origin, and `git pull` will pull from origin.

This is particularly useful when creating branches across many
submodules, such as with `git submodule foreach ...` (or if running with
a patch such as [1], which we use at $job), as it avoids having to
manually set tracking info for each submodule.

Since we've added an argument to "--track", also add "--track=direct" as
another way to explicitly get the original "--track" behavior ("--track"
without an argument still works as well).

Finally, teach branch.autoSetupMerge a new "inherit" option. When this
is set, "--track=inherit" becomes the default behavior.

[1]: https://lore.kernel.org/git/20180927221603.148025-1-sbeller@google.com/

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
Range-diff against v2:
1:  0346f44754 ! 1:  b9356d9837 branch: add "inherit" option for branch.autoSetupMerge
    @@ Metadata
     Author: Josh Steadmon <steadmon@google.com>
     
      ## Commit message ##
    -    branch: add "inherit" option for branch.autoSetupMerge
    +    branch: add flags and config to inherit tracking
     
         It can be helpful when creating a new branch to use the existing
         tracking configuration from the branch point. However, there is
         currently not a method to automatically do so.
     
    -    Teach branch.autoSetupMerge a new "inherit" option. When this is set,
    -    creating a new branch will cause the tracking configuration to default
    -    to the configuration of the branch point, if set.
    +    Teach git-{branch,checkout,switch} an "inherit" argument to the
    +    "--track" option. When this is set, creating a new branch will cause the
    +    tracking configuration to default to the configuration of the branch
    +    point, if set.
     
    -    For example, if branch.autoSetupMerge=inherit, branch "main" tracks
    -    "origin/main", and we run `git checkout -b feature main`, then branch
    -    "feature" will track "origin/main". Thus, `git status` will show us how
    -    far ahead/behind we are from origin, and `git pull` will pull from
    -    origin.
    +    For example, if branch "main" tracks "origin/main", and we run
    +    `git checkout --track=inherit -b feature main`, then branch "feature"
    +    will track "origin/main". Thus, `git status` will show us how far
    +    ahead/behind we are from origin, and `git pull` will pull from origin.
     
         This is particularly useful when creating branches across many
         submodules, such as with `git submodule foreach ...` (or if running with
         a patch such as [1], which we use at $job), as it avoids having to
         manually set tracking info for each submodule.
     
    +    Since we've added an argument to "--track", also add "--track=direct" as
    +    another way to explicitly get the original "--track" behavior ("--track"
    +    without an argument still works as well).
    +
    +    Finally, teach branch.autoSetupMerge a new "inherit" option. When this
    +    is set, "--track=inherit" becomes the default behavior.
    +
         [1]: https://lore.kernel.org/git/20180927221603.148025-1-sbeller@google.com/
     
    @@ Documentation/config/branch.txt: branch.autoSetupMerge::
      branch.autoSetupRebase::
     
      ## Documentation/git-branch.txt ##
    -@@ Documentation/git-branch.txt: This behavior is the default when the start point is a remote-tracking branch.
    +@@ Documentation/git-branch.txt: SYNOPSIS
    + 	[--points-at <object>] [--format=<format>]
    + 	[(-r | --remotes) | (-a | --all)]
    + 	[--list] [<pattern>...]
    +-'git branch' [--track | --no-track] [-f] <branchname> [<start-point>]
    ++'git branch' [--track [direct|inherit] | --no-track] [-f] <branchname> [<start-point>]
    + 'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
    + 'git branch' --unset-upstream [<branchname>]
    + 'git branch' (-m | -M) [<oldbranch>] <newbranch>
    +@@ Documentation/git-branch.txt: This option is only applicable in non-verbose mode.
    + 	Display the full sha1s in the output listing rather than abbreviating them.
    + 
    + -t::
    +---track::
    ++--track [inherit|direct]::
    + 	When creating a new branch, set up `branch.<name>.remote` and
    +-	`branch.<name>.merge` configuration entries to mark the
    +-	start-point branch as "upstream" from the new branch. This
    ++	`branch.<name>.merge` configuration entries to set "upstream" tracking
    ++	configuration for the new branch. This
    + 	configuration will tell git to show the relationship between the
    + 	two branches in `git status` and `git branch -v`. Furthermore,
    + 	it directs `git pull` without arguments to pull from the
    + 	upstream when the new branch is checked out.
    + +
    +-This behavior is the default when the start point is a remote-tracking branch.
    ++The exact upstream branch is chosen depending on the optional argument:
    ++`--track` or `--track direct` means to use the start-point branch itself as the
    ++upstream; `--track inherit` means to copy the upstream configuration of the
    ++start-point branch.
    +++
    ++`--track direct` is the default when the start point is a remote-tracking branch.
      Set the branch.autoSetupMerge configuration variable to `false` if you
      want `git switch`, `git checkout` and `git branch` to always behave as if `--no-track`
      were given. Set it to `always` if you want this behavior when the
     -start-point is either a local or remote-tracking branch.
     +start-point is either a local or remote-tracking branch. Set it to
     +`inherit` if you want to copy the tracking configuration from the
    -+start point.
    ++branch point.
      
      --no-track::
      	Do not set up "upstream" configuration, even if the
    +-	branch.autoSetupMerge configuration variable is true.
    ++	branch.autoSetupMerge configuration variable is set.
    + 
    + --set-upstream::
    + 	As this option had confusing syntax, it is no longer supported.
    +
    + ## Documentation/git-checkout.txt ##
    +@@ Documentation/git-checkout.txt: of it").
    + 	linkgit:git-branch[1] for details.
    + 
    + -t::
    +---track::
    ++--track [direct|inherit]::
    + 	When creating a new branch, set up "upstream" configuration. See
    + 	"--track" in linkgit:git-branch[1] for details.
    + +
    +
    + ## Documentation/git-switch.txt ##
    +@@ Documentation/git-switch.txt: should result in deletion of the path).
    + 	attached to a terminal, regardless of `--quiet`.
    + 
    + -t::
    +---track::
    ++--track [direct|inherit]::
    + 	When creating a new branch, set up "upstream" configuration.
    + 	`-c` is implied. See `--track` in linkgit:git-branch[1] for
    + 	details.
     
      ## branch.c ##
     @@ branch.c: int install_branch_config(int flag, const char *local, const char *origin, const
    @@ branch.c: int install_branch_config(int flag, const char *local, const char *ori
     +
     +	strbuf_addf(&key, "branch.%s.remote", bare_ref);
     +	if (git_config_get_string(key.buf, &remote)) {
    -+		warning("branch.autoSetupMerge=inherit, but could not find %s",
    -+			key.buf);
    ++		warning(_("asked to inherit tracking from %s, but could not find %s"),
    ++			bare_ref, key.buf);
     +		strbuf_release(&key);
    -+		return 1;
    ++		return -1;
     +	}
    -+	tracking->remote = remote;
     +
     +	strbuf_reset(&key);
     +	strbuf_addf(&key, "branch.%s.merge", bare_ref);
     +	if (git_config_get_string(key.buf, &tracking->src)) {
    -+		warning("branch.autoSetupMerge=inherit, but could not find %s",
    -+			key.buf);
    ++		warning(_("asked to inherit tracking from %s, but could not find %s"),
    ++			bare_ref, key.buf);
     +		strbuf_release(&key);
    -+		return 1;
    ++		free(remote);
    ++		return -1;
     +	}
     +
    ++	tracking->remote = remote;
     +	tracking->matches = 1;
     +	strbuf_release(&key);
     +	return 0;
    @@ branch.c: static void setup_tracking(const char *new_ref, const char *orig_ref,
      	memset(&tracking, 0, sizeof(tracking));
      	tracking.spec.dst = (char *)orig_ref;
     -	if (for_each_remote(find_tracked_branch, &tracking))
    -+	if (track == BRANCH_TRACK_INHERIT && inherit_tracking(&tracking, orig_ref))
    -+		return;
    -+	else if (for_each_remote(find_tracked_branch, &tracking))
    ++	if (track != BRANCH_TRACK_INHERIT) {
    ++		for_each_remote(find_tracked_branch, &tracking);
    ++	} else if (inherit_tracking(&tracking, orig_ref))
      		return;
      
      	if (!tracking.matches)
    @@ branch.h: enum branch_track {
      
      extern enum branch_track git_branch_track;
     
    + ## builtin/branch.c ##
    +@@ builtin/branch.c: int cmd_branch(int argc, const char **argv, const char *prefix)
    + 		OPT__VERBOSE(&filter.verbose,
    + 			N_("show hash and subject, give twice for upstream branch")),
    + 		OPT__QUIET(&quiet, N_("suppress informational messages")),
    +-		OPT_SET_INT('t', "track",  &track, N_("set up tracking mode (see git-pull(1))"),
    +-			BRANCH_TRACK_EXPLICIT),
    ++		OPT_CALLBACK_F('t', "track",  &track, "direct|inherit",
    ++			N_("set up tracking mode (see git-pull(1))"),
    ++			PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
    ++			parse_opt_tracking_mode),
    + 		OPT_SET_INT_F(0, "set-upstream", &track, N_("do not use"),
    + 			BRANCH_TRACK_OVERRIDE, PARSE_OPT_HIDDEN),
    + 		OPT_STRING('u', "set-upstream-to", &new_upstream, N_("upstream"), N_("change the upstream info")),
    +
    + ## builtin/checkout.c ##
    +@@ builtin/checkout.c: static struct option *add_common_switch_branch_options(
    + {
    + 	struct option options[] = {
    + 		OPT_BOOL('d', "detach", &opts->force_detach, N_("detach HEAD at named commit")),
    +-		OPT_SET_INT('t', "track",  &opts->track, N_("set upstream info for new branch"),
    +-			BRANCH_TRACK_EXPLICIT),
    ++		OPT_CALLBACK_F('t', "track",  &opts->track, "direct|inherit",
    ++			N_("set up tracking mode (see git-pull(1))"),
    ++			PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
    ++			parse_opt_tracking_mode),
    + 		OPT__FORCE(&opts->force, N_("force checkout (throw away local modifications)"),
    + 			   PARSE_OPT_NOCOMPLETE),
    + 		OPT_STRING(0, "orphan", &opts->new_orphan_branch, N_("new-branch"), N_("new unparented branch")),
    +
      ## config.c ##
     @@ config.c: static int git_default_branch_config(const char *var, const char *value)
      		if (value && !strcasecmp(value, "always")) {
    @@ config.c: static int git_default_branch_config(const char *var, const char *valu
      		git_branch_track = git_config_bool(var, value);
      		return 0;
     
    + ## parse-options-cb.c ##
    +@@
    + #include "git-compat-util.h"
    + #include "parse-options.h"
    ++#include "branch.h"
    + #include "cache.h"
    + #include "commit.h"
    + #include "color.h"
    +@@ parse-options-cb.c: int parse_opt_passthru_argv(const struct option *opt, const char *arg, int unset
    + 
    + 	return 0;
    + }
    ++
    ++int parse_opt_tracking_mode(const struct option *opt, const char *arg, int unset) {
    ++	if (unset)
    ++		*(enum branch_track *)opt->value = BRANCH_TRACK_NEVER;
    ++	else if (!arg || !strcmp(arg, "direct"))
    ++		*(enum branch_track *)opt->value = BRANCH_TRACK_EXPLICIT;
    ++	else if (!strcmp(arg, "inherit"))
    ++		*(enum branch_track *)opt->value = BRANCH_TRACK_INHERIT;
    ++	else
    ++		return error(_("option `%s' expects \"direct\" or \"inherit\""),
    ++			     opt->long_name);
    ++
    ++	return 0;
    ++}
    +
    + ## parse-options.h ##
    +@@ parse-options.h: enum parse_opt_result parse_opt_unknown_cb(struct parse_opt_ctx_t *ctx,
    + 					   const char *, int);
    + int parse_opt_passthru(const struct option *, const char *, int);
    + int parse_opt_passthru_argv(const struct option *, const char *, int);
    ++/* value is enum branch_track* */
    ++int parse_opt_tracking_mode(const struct option *, const char *, int);
    + 
    + #define OPT__VERBOSE(var, h)  OPT_COUNTUP('v', "verbose", (var), (h))
    + #define OPT__QUIET(var, h)    OPT_COUNTUP('q', "quiet",   (var), (h))
    +
      ## t/t2017-checkout-orphan.sh ##
     @@ t/t2017-checkout-orphan.sh: test_expect_success '--orphan ignores branch.autosetupmerge' '
      	git checkout --orphan gamma &&
    @@ t/t2027-checkout-track.sh: test_expect_success 'checkout --track -b rejects an e
     +	git config branch.main.remote origin &&
     +	git config branch.main.merge refs/heads/main &&
     +	test_config branch.autoSetupMerge inherit &&
    -+	# With branch.autoSetupMerge=inherit, we copy the tracking config
    -+	git checkout -b b1 main &&
    ++	# With --track=inherit, we copy the tracking config from main
    ++	git checkout --track=inherit -b b1 main &&
     +	test_cmp_config origin branch.b1.remote &&
     +	test_cmp_config refs/heads/main branch.b1.merge &&
    ++	# With branch.autoSetupMerge=inherit, we do the same
    ++	git checkout -b b2 main &&
    ++	test_cmp_config origin branch.b2.remote &&
    ++	test_cmp_config refs/heads/main branch.b2.merge &&
     +	# But --track overrides this
    -+	git checkout --track -b b2 main &&
    -+	test_cmp_config . branch.b2.remote &&
    -+	test_cmp_config refs/heads/main branch.b2.merge
    ++	git checkout --track -b b3 main &&
    ++	test_cmp_config . branch.b3.remote &&
    ++	test_cmp_config refs/heads/main branch.b3.merge &&
    ++	# And --track=direct does as well
    ++	git checkout --track=direct -b b4 main &&
    ++	test_cmp_config . branch.b4.remote &&
    ++	test_cmp_config refs/heads/main branch.b4.merge
     +'
     +
      test_done
    @@ t/t2060-switch.sh: test_expect_success 'not switching when something is in progr
     +	git switch -c foo-no-inherit foo &&
     +	test -z "$(git config branch.foo-no-inherit.remote)" &&
     +	test -z "$(git config branch.foo-no-inherit.merge)" &&
    -+	# with autoSetupMerge=inherit, we copy tracking info from foo
    -+	test_config branch.autoSetupMerge inherit &&
    -+	git switch -c foo2 foo &&
    ++	# with --track=inherit, we copy tracking info from foo
    ++	git switch --track=inherit -c foo2 foo &&
     +	test_cmp_config origin branch.foo2.remote &&
     +	test_cmp_config refs/heads/foo branch.foo2.merge &&
    ++	# with autoSetupMerge=inherit, we do the same
    ++	test_config branch.autoSetupMerge inherit &&
    ++	git switch -c foo3 foo &&
    ++	test_cmp_config origin branch.foo3.remote &&
    ++	test_cmp_config refs/heads/foo branch.foo3.merge &&
    ++	# with --track, we override autoSetupMerge
    ++	git switch --track -c foo4 foo &&
    ++	test_cmp_config . branch.foo4.remote &&
    ++	test_cmp_config refs/heads/foo branch.foo4.merge &&
    ++	# and --track=direct does as well
    ++	git switch --track=direct -c foo5 foo &&
    ++	test_cmp_config . branch.foo5.remote &&
    ++	test_cmp_config refs/heads/foo branch.foo5.merge &&
     +	# no tracking info to inherit from main
     +	git switch -c main2 main &&
     +	test -z "$(git config branch.main2.remote)" &&
    @@ t/t3200-branch.sh: test_expect_success 'invalid sort parameter in configuration'
      	)
      '
      
    ++test_expect_success 'tracking info copied with --track=inherit' '
    ++	git branch --track=inherit foo2 my1 &&
    ++	test_cmp_config local branch.foo2.remote &&
    ++	test_cmp_config refs/heads/main branch.foo2.merge
    ++'
    ++
     +test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
     +	test_unconfig branch.autoSetupMerge &&
     +	# default config does not copy tracking info
    @@ t/t3200-branch.sh: test_expect_success 'invalid sort parameter in configuration'
     +	test -z "$(git config branch.foo-no-inherit.merge)" &&
     +	# with autoSetupMerge=inherit, we copy tracking info from my1
     +	test_config branch.autoSetupMerge inherit &&
    -+	git branch foo2 my1 &&
    -+	test_cmp_config local branch.foo2.remote &&
    -+	test_cmp_config refs/heads/main branch.foo2.merge &&
    ++	git branch foo3 my1 &&
    ++	test_cmp_config local branch.foo3.remote &&
    ++	test_cmp_config refs/heads/main branch.foo3.merge &&
     +	# no tracking info to inherit from main
     +	git branch main2 main &&
     +	test -z "$(git config branch.main2.remote)" &&
     +	test -z "$(git config branch.main2.merge)"
     +'
    ++
    ++test_expect_success '--track overrides branch.autoSetupMerge' '
    ++	test_config branch.autoSetupMerge inherit &&
    ++	git branch --track=direct foo4 my1 &&
    ++	test_cmp_config . branch.foo4.remote &&
    ++	test_cmp_config refs/heads/my1 branch.foo4.merge &&
    ++	git branch --no-track foo5 my1 &&
    ++	test -z "$(git config branch.foo5.remote)" &&
    ++	test -z "$(git config branch.foo5.merge)"
    ++'
     +
      test_done
     

 Documentation/config/branch.txt |  3 ++-
 Documentation/git-branch.txt    | 21 ++++++++++++-------
 Documentation/git-checkout.txt  |  2 +-
 Documentation/git-switch.txt    |  2 +-
 branch.c                        | 37 ++++++++++++++++++++++++++++++++-
 branch.h                        |  3 ++-
 builtin/branch.c                |  6 ++++--
 builtin/checkout.c              |  6 ++++--
 config.c                        |  3 +++
 parse-options-cb.c              | 15 +++++++++++++
 parse-options.h                 |  2 ++
 t/t2017-checkout-orphan.sh      |  7 +++++++
 t/t2027-checkout-track.sh       | 23 ++++++++++++++++++++
 t/t2060-switch.sh               | 28 +++++++++++++++++++++++++
 t/t3200-branch.sh               | 33 +++++++++++++++++++++++++++++
 t/t7201-co.sh                   | 17 +++++++++++++++
 16 files changed, 192 insertions(+), 16 deletions(-)

diff --git a/Documentation/config/branch.txt b/Documentation/config/branch.txt
index cc5f3249fc..55f7522e12 100644
--- a/Documentation/config/branch.txt
+++ b/Documentation/config/branch.txt
@@ -7,7 +7,8 @@ branch.autoSetupMerge::
 	automatic setup is done; `true` -- automatic setup is done when the
 	starting point is a remote-tracking branch; `always` --
 	automatic setup is done when the starting point is either a
-	local branch or remote-tracking
+	local branch or remote-tracking branch; `inherit` -- if the starting point
+	has a tracking configuration, it is copied to the new
 	branch. This option defaults to true.
 
 branch.autoSetupRebase::
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 94dc9a54f2..e484a3803a 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 	[--points-at <object>] [--format=<format>]
 	[(-r | --remotes) | (-a | --all)]
 	[--list] [<pattern>...]
-'git branch' [--track | --no-track] [-f] <branchname> [<start-point>]
+'git branch' [--track [direct|inherit] | --no-track] [-f] <branchname> [<start-point>]
 'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
 'git branch' --unset-upstream [<branchname>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
@@ -205,24 +205,31 @@ This option is only applicable in non-verbose mode.
 	Display the full sha1s in the output listing rather than abbreviating them.
 
 -t::
---track::
+--track [inherit|direct]::
 	When creating a new branch, set up `branch.<name>.remote` and
-	`branch.<name>.merge` configuration entries to mark the
-	start-point branch as "upstream" from the new branch. This
+	`branch.<name>.merge` configuration entries to set "upstream" tracking
+	configuration for the new branch. This
 	configuration will tell git to show the relationship between the
 	two branches in `git status` and `git branch -v`. Furthermore,
 	it directs `git pull` without arguments to pull from the
 	upstream when the new branch is checked out.
 +
-This behavior is the default when the start point is a remote-tracking branch.
+The exact upstream branch is chosen depending on the optional argument:
+`--track` or `--track direct` means to use the start-point branch itself as the
+upstream; `--track inherit` means to copy the upstream configuration of the
+start-point branch.
++
+`--track direct` is the default when the start point is a remote-tracking branch.
 Set the branch.autoSetupMerge configuration variable to `false` if you
 want `git switch`, `git checkout` and `git branch` to always behave as if `--no-track`
 were given. Set it to `always` if you want this behavior when the
-start-point is either a local or remote-tracking branch.
+start-point is either a local or remote-tracking branch. Set it to
+`inherit` if you want to copy the tracking configuration from the
+branch point.
 
 --no-track::
 	Do not set up "upstream" configuration, even if the
-	branch.autoSetupMerge configuration variable is true.
+	branch.autoSetupMerge configuration variable is set.
 
 --set-upstream::
 	As this option had confusing syntax, it is no longer supported.
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index b1a6fe4499..a48e1ab62f 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -155,7 +155,7 @@ of it").
 	linkgit:git-branch[1] for details.
 
 -t::
---track::
+--track [direct|inherit]::
 	When creating a new branch, set up "upstream" configuration. See
 	"--track" in linkgit:git-branch[1] for details.
 +
diff --git a/Documentation/git-switch.txt b/Documentation/git-switch.txt
index 5c438cd505..96dc036ea5 100644
--- a/Documentation/git-switch.txt
+++ b/Documentation/git-switch.txt
@@ -152,7 +152,7 @@ should result in deletion of the path).
 	attached to a terminal, regardless of `--quiet`.
 
 -t::
---track::
+--track [direct|inherit]::
 	When creating a new branch, set up "upstream" configuration.
 	`-c` is implied. See `--track` in linkgit:git-branch[1] for
 	details.
diff --git a/branch.c b/branch.c
index 7a88a4861e..eef31f373d 100644
--- a/branch.c
+++ b/branch.c
@@ -126,6 +126,39 @@ int install_branch_config(int flag, const char *local, const char *origin, const
 	return -1;
 }
 
+static int inherit_tracking(struct tracking *tracking, const char *orig_ref)
+{
+	struct strbuf key = STRBUF_INIT;
+	char *remote;
+	const char *bare_ref;
+
+	bare_ref = orig_ref;
+	skip_prefix(orig_ref, "refs/heads/", &bare_ref);
+
+	strbuf_addf(&key, "branch.%s.remote", bare_ref);
+	if (git_config_get_string(key.buf, &remote)) {
+		warning(_("asked to inherit tracking from %s, but could not find %s"),
+			bare_ref, key.buf);
+		strbuf_release(&key);
+		return -1;
+	}
+
+	strbuf_reset(&key);
+	strbuf_addf(&key, "branch.%s.merge", bare_ref);
+	if (git_config_get_string(key.buf, &tracking->src)) {
+		warning(_("asked to inherit tracking from %s, but could not find %s"),
+			bare_ref, key.buf);
+		strbuf_release(&key);
+		free(remote);
+		return -1;
+	}
+
+	tracking->remote = remote;
+	tracking->matches = 1;
+	strbuf_release(&key);
+	return 0;
+}
+
 /*
  * This is called when new_ref is branched off of orig_ref, and tries
  * to infer the settings for branch.<new_ref>.{remote,merge} from the
@@ -139,7 +172,9 @@ static void setup_tracking(const char *new_ref, const char *orig_ref,
 
 	memset(&tracking, 0, sizeof(tracking));
 	tracking.spec.dst = (char *)orig_ref;
-	if (for_each_remote(find_tracked_branch, &tracking))
+	if (track != BRANCH_TRACK_INHERIT) {
+		for_each_remote(find_tracked_branch, &tracking);
+	} else if (inherit_tracking(&tracking, orig_ref))
 		return;
 
 	if (!tracking.matches)
diff --git a/branch.h b/branch.h
index df0be61506..6484bda8a2 100644
--- a/branch.h
+++ b/branch.h
@@ -10,7 +10,8 @@ enum branch_track {
 	BRANCH_TRACK_REMOTE,
 	BRANCH_TRACK_ALWAYS,
 	BRANCH_TRACK_EXPLICIT,
-	BRANCH_TRACK_OVERRIDE
+	BRANCH_TRACK_OVERRIDE,
+	BRANCH_TRACK_INHERIT
 };
 
 extern enum branch_track git_branch_track;
diff --git a/builtin/branch.c b/builtin/branch.c
index b23b1d1752..15f70fe3fa 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -632,8 +632,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT__VERBOSE(&filter.verbose,
 			N_("show hash and subject, give twice for upstream branch")),
 		OPT__QUIET(&quiet, N_("suppress informational messages")),
-		OPT_SET_INT('t', "track",  &track, N_("set up tracking mode (see git-pull(1))"),
-			BRANCH_TRACK_EXPLICIT),
+		OPT_CALLBACK_F('t', "track",  &track, "direct|inherit",
+			N_("set up tracking mode (see git-pull(1))"),
+			PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
+			parse_opt_tracking_mode),
 		OPT_SET_INT_F(0, "set-upstream", &track, N_("do not use"),
 			BRANCH_TRACK_OVERRIDE, PARSE_OPT_HIDDEN),
 		OPT_STRING('u', "set-upstream-to", &new_upstream, N_("upstream"), N_("change the upstream info")),
diff --git a/builtin/checkout.c b/builtin/checkout.c
index b5d477919a..45dab414ea 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1532,8 +1532,10 @@ static struct option *add_common_switch_branch_options(
 {
 	struct option options[] = {
 		OPT_BOOL('d', "detach", &opts->force_detach, N_("detach HEAD at named commit")),
-		OPT_SET_INT('t', "track",  &opts->track, N_("set upstream info for new branch"),
-			BRANCH_TRACK_EXPLICIT),
+		OPT_CALLBACK_F('t', "track",  &opts->track, "direct|inherit",
+			N_("set up tracking mode (see git-pull(1))"),
+			PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
+			parse_opt_tracking_mode),
 		OPT__FORCE(&opts->force, N_("force checkout (throw away local modifications)"),
 			   PARSE_OPT_NOCOMPLETE),
 		OPT_STRING(0, "orphan", &opts->new_orphan_branch, N_("new-branch"), N_("new unparented branch")),
diff --git a/config.c b/config.c
index cb4a8058bf..4bd5a18faf 100644
--- a/config.c
+++ b/config.c
@@ -1580,6 +1580,9 @@ static int git_default_branch_config(const char *var, const char *value)
 		if (value && !strcasecmp(value, "always")) {
 			git_branch_track = BRANCH_TRACK_ALWAYS;
 			return 0;
+		} else if (value && !strcasecmp(value, "inherit")) {
+			git_branch_track = BRANCH_TRACK_INHERIT;
+			return 0;
 		}
 		git_branch_track = git_config_bool(var, value);
 		return 0;
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 3c811e1e4a..b1a1ab797e 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "parse-options.h"
+#include "branch.h"
 #include "cache.h"
 #include "commit.h"
 #include "color.h"
@@ -293,3 +294,17 @@ int parse_opt_passthru_argv(const struct option *opt, const char *arg, int unset
 
 	return 0;
 }
+
+int parse_opt_tracking_mode(const struct option *opt, const char *arg, int unset) {
+	if (unset)
+		*(enum branch_track *)opt->value = BRANCH_TRACK_NEVER;
+	else if (!arg || !strcmp(arg, "direct"))
+		*(enum branch_track *)opt->value = BRANCH_TRACK_EXPLICIT;
+	else if (!strcmp(arg, "inherit"))
+		*(enum branch_track *)opt->value = BRANCH_TRACK_INHERIT;
+	else
+		return error(_("option `%s' expects \"direct\" or \"inherit\""),
+			     opt->long_name);
+
+	return 0;
+}
diff --git a/parse-options.h b/parse-options.h
index a845a9d952..f35dbfdd5a 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -303,6 +303,8 @@ enum parse_opt_result parse_opt_unknown_cb(struct parse_opt_ctx_t *ctx,
 					   const char *, int);
 int parse_opt_passthru(const struct option *, const char *, int);
 int parse_opt_passthru_argv(const struct option *, const char *, int);
+/* value is enum branch_track* */
+int parse_opt_tracking_mode(const struct option *, const char *, int);
 
 #define OPT__VERBOSE(var, h)  OPT_COUNTUP('v', "verbose", (var), (h))
 #define OPT__QUIET(var, h)    OPT_COUNTUP('q', "quiet",   (var), (h))
diff --git a/t/t2017-checkout-orphan.sh b/t/t2017-checkout-orphan.sh
index 88d6992a5e..31fb64c5be 100755
--- a/t/t2017-checkout-orphan.sh
+++ b/t/t2017-checkout-orphan.sh
@@ -64,6 +64,13 @@ test_expect_success '--orphan ignores branch.autosetupmerge' '
 	git checkout --orphan gamma &&
 	test -z "$(git config branch.gamma.merge)" &&
 	test refs/heads/gamma = "$(git symbolic-ref HEAD)" &&
+	test_must_fail git rev-parse --verify HEAD^ &&
+	git checkout main &&
+	git config branch.autosetupmerge inherit &&
+	git checkout --orphan eta &&
+	test -z "$(git config branch.eta.merge)" &&
+	test -z "$(git config branch.eta.remote)" &&
+	test refs/heads/eta = "$(git symbolic-ref HEAD)" &&
 	test_must_fail git rev-parse --verify HEAD^
 '
 
diff --git a/t/t2027-checkout-track.sh b/t/t2027-checkout-track.sh
index 4453741b96..e87d77f629 100755
--- a/t/t2027-checkout-track.sh
+++ b/t/t2027-checkout-track.sh
@@ -24,4 +24,27 @@ test_expect_success 'checkout --track -b rejects an extra path argument' '
 	test_i18ngrep "cannot be used with updating paths" err
 '
 
+test_expect_success 'checkout --track -b overrides autoSetupMerge=inherit' '
+	# Set up tracking config on main
+	git config branch.main.remote origin &&
+	git config branch.main.merge refs/heads/main &&
+	test_config branch.autoSetupMerge inherit &&
+	# With --track=inherit, we copy the tracking config from main
+	git checkout --track=inherit -b b1 main &&
+	test_cmp_config origin branch.b1.remote &&
+	test_cmp_config refs/heads/main branch.b1.merge &&
+	# With branch.autoSetupMerge=inherit, we do the same
+	git checkout -b b2 main &&
+	test_cmp_config origin branch.b2.remote &&
+	test_cmp_config refs/heads/main branch.b2.merge &&
+	# But --track overrides this
+	git checkout --track -b b3 main &&
+	test_cmp_config . branch.b3.remote &&
+	test_cmp_config refs/heads/main branch.b3.merge &&
+	# And --track=direct does as well
+	git checkout --track=direct -b b4 main &&
+	test_cmp_config . branch.b4.remote &&
+	test_cmp_config refs/heads/main branch.b4.merge
+'
+
 test_done
diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
index 9bc6a3aa5c..76e9d12e36 100755
--- a/t/t2060-switch.sh
+++ b/t/t2060-switch.sh
@@ -107,4 +107,32 @@ test_expect_success 'not switching when something is in progress' '
 	test_must_fail git switch -d @^
 '
 
+test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
+	# default config does not copy tracking info
+	git switch -c foo-no-inherit foo &&
+	test -z "$(git config branch.foo-no-inherit.remote)" &&
+	test -z "$(git config branch.foo-no-inherit.merge)" &&
+	# with --track=inherit, we copy tracking info from foo
+	git switch --track=inherit -c foo2 foo &&
+	test_cmp_config origin branch.foo2.remote &&
+	test_cmp_config refs/heads/foo branch.foo2.merge &&
+	# with autoSetupMerge=inherit, we do the same
+	test_config branch.autoSetupMerge inherit &&
+	git switch -c foo3 foo &&
+	test_cmp_config origin branch.foo3.remote &&
+	test_cmp_config refs/heads/foo branch.foo3.merge &&
+	# with --track, we override autoSetupMerge
+	git switch --track -c foo4 foo &&
+	test_cmp_config . branch.foo4.remote &&
+	test_cmp_config refs/heads/foo branch.foo4.merge &&
+	# and --track=direct does as well
+	git switch --track=direct -c foo5 foo &&
+	test_cmp_config . branch.foo5.remote &&
+	test_cmp_config refs/heads/foo branch.foo5.merge &&
+	# no tracking info to inherit from main
+	git switch -c main2 main &&
+	test -z "$(git config branch.main2.remote)" &&
+	test -z "$(git config branch.main2.merge)"
+'
+
 test_done
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index cc4b10236e..bc547b08e1 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1409,4 +1409,37 @@ test_expect_success 'invalid sort parameter in configuration' '
 	)
 '
 
+test_expect_success 'tracking info copied with --track=inherit' '
+	git branch --track=inherit foo2 my1 &&
+	test_cmp_config local branch.foo2.remote &&
+	test_cmp_config refs/heads/main branch.foo2.merge
+'
+
+test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
+	test_unconfig branch.autoSetupMerge &&
+	# default config does not copy tracking info
+	git branch foo-no-inherit my1 &&
+	test -z "$(git config branch.foo-no-inherit.remote)" &&
+	test -z "$(git config branch.foo-no-inherit.merge)" &&
+	# with autoSetupMerge=inherit, we copy tracking info from my1
+	test_config branch.autoSetupMerge inherit &&
+	git branch foo3 my1 &&
+	test_cmp_config local branch.foo3.remote &&
+	test_cmp_config refs/heads/main branch.foo3.merge &&
+	# no tracking info to inherit from main
+	git branch main2 main &&
+	test -z "$(git config branch.main2.remote)" &&
+	test -z "$(git config branch.main2.merge)"
+'
+
+test_expect_success '--track overrides branch.autoSetupMerge' '
+	test_config branch.autoSetupMerge inherit &&
+	git branch --track=direct foo4 my1 &&
+	test_cmp_config . branch.foo4.remote &&
+	test_cmp_config refs/heads/my1 branch.foo4.merge &&
+	git branch --no-track foo5 my1 &&
+	test -z "$(git config branch.foo5.remote)" &&
+	test -z "$(git config branch.foo5.merge)"
+'
+
 test_done
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 7f6e23a4bb..ae9f8d02c2 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -657,4 +657,21 @@ test_expect_success 'custom merge driver with checkout -m' '
 	test_cmp expect arm
 '
 
+test_expect_success 'tracking info copied with autoSetupMerge=inherit' '
+	git reset --hard main &&
+	# default config does not copy tracking info
+	git checkout -b foo-no-inherit koala/bear &&
+	test -z "$(git config branch.foo-no-inherit.remote)" &&
+	test -z "$(git config branch.foo-no-inherit.merge)" &&
+	# with autoSetupMerge=inherit, we copy tracking info from koala/bear
+	test_config branch.autoSetupMerge inherit &&
+	git checkout -b foo koala/bear &&
+	test_cmp_config origin branch.foo.remote &&
+	test_cmp_config refs/heads/koala/bear branch.foo.merge &&
+	# no tracking info to inherit from main
+	git checkout -b main2 main &&
+	test -z "$(git config branch.main2.remote)" &&
+	test -z "$(git config branch.main2.merge)"
+'
+
 test_done

base-commit: 6c40894d2466d4e7fddc047a05116aa9d14712ee
-- 
2.33.0.1079.g6e70778dc9-goog

