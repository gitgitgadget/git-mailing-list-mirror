Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06FC2C33CB6
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A8020728
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wa/r6ri4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbgAPGOq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 01:14:46 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40176 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgAPGOn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 01:14:43 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so2430861wmi.5
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 22:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wTVcnLRNXBu7uGJi1ad11EImbJVc1NIT69cP2XH6Ocs=;
        b=Wa/r6ri4yslRCaATKP40U9h0o4vBk9pacYcqOD5BPbn1yhZSOg5KT3AXpgs04L71CJ
         pFSvGvvCQK0+lv7mPJqMLxlk/K5Ci1ORZEmjOY0NnbzjXeIe/RXZYi9326ORZcgbh/ln
         goXzpwfSe48SWdSKeGxL73RK3DgZVChPnimKPNI6wd8pgHO++S05GjYgf21XFPG7UIrX
         bxbBzbMvzmFlJ3m+Sakd6qClYRq6ThNDIg3pRucvCbIzNRxi4MnHVfjc7ar8QO22KZ4G
         TmIZf4lfUSkDyrT1tYm/Wd1BUAxfuAydiTyPzdPSo3ZkU8T7ZLE/FPswt2tY+Y4tRLVd
         +GBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wTVcnLRNXBu7uGJi1ad11EImbJVc1NIT69cP2XH6Ocs=;
        b=ekoV4BJDP4WwMXg7GKH39L57ho2mlLuPTl8syK3IkPVkL+Rpk/RwXk2rxz+SQGhsvV
         FwYn63lJMUrOFTVUa8FOOMc/TLus4DguA3sl8ojEDbyIP48mleGKTyW7yxwrX3G1MIUJ
         BpKI8d335mliIKsXY1++7DroeI2wafCiEf4nNhiBmOTWeIcH/ip+QTPKPayg8Jk38Ans
         o8H0i+rqha3cGMs9cX6kCLH0tS70o8qQC4Gq+VtkONbSnWM8rPXQwSQJWcCHYBTCNpUs
         9EbwQbRY2JBEIwZIalX8z7rrR3V1dBHS8jury4jGIHx2eTk87Wnn7nPy4Yuo/2hXIXHE
         gpsg==
X-Gm-Message-State: APjAAAVXCu1ADjx2LxOllALuMrAA2RWiVlIDQ8ce2aLCYg6kqK3Cdwqp
        mwjCEN5KDNlcZjzNHs13Zj/bAUJ2
X-Google-Smtp-Source: APXvYqwkAMqZbaiu2uM585FT/I9ihgD2bq8HP/NaxZ676fjfG9bwFJRw4af7Gn9fz2VhK1CruEjc5Q==
X-Received: by 2002:a1c:7715:: with SMTP id t21mr4047375wmi.149.1579155275510;
        Wed, 15 Jan 2020 22:14:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q15sm27750235wrr.11.2020.01.15.22.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 22:14:34 -0800 (PST)
Message-Id: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
References: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 06:14:14 +0000
Subject: [PATCH v4 00/19] rebase: make the default backend configurable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a re-roll of en/rebase-backend which has been rebased on v2.25.0 and
updated to remove the dependence on ra/rebase-i-more-options, and also tries
to address feedback from Phillip, Junio, and Jonathan. This series does a
lot of work around making the default rebase backend configurable, and
switches the default from the am backend to the merge/interactive one.

Changes since v3:

 * Rebased on origin/master and updated to remove the dependence on
   ra/rebase-i-more-options.
 * Added two new patches at the start of the series.
 * Split the old first patch into two, while modifying them based on
   Phillip's feedback (though slightly differently than discussed on the
   list; instead of making --keep-empty a synonym for --empty=keep, I
   instead kept backward compatibility by making it a no-op).
 * I noted the post-commit hook in the differences between backends. Emily
   is investigating what changes need to happen there, so I merely
   documented the existing differences.
 * dropped '-i' from the reflog messages; now they just refer to 'rebase'

Changes possibly missing from this version, for discussion:

 * I did not remove the --am option as suggested by Phillip, since Junio and
   Phillip were still discussing whether it is wanted/needed.
 * I did not address the last two items Jonathan brought up as I couldn't
   find enough information to reproduce or understand the problems.

Elijah Newren (19):
  git-rebase.txt: update description of --allow-empty-message
  t3404: directly test the behavior of interest
  rebase (interactive-backend): make --keep-empty the default
  rebase (interactive-backend): fix handling of commits that become
    empty
  t3406: simplify an already simple test
  rebase, sequencer: remove the broken GIT_QUIET handling
  rebase: make sure to pass along the quiet flag to the sequencer
  rebase: fix handling of restrict_revision
  t3432: make these tests work with either am or merge backends
  rebase: allow more types of rebases to fast-forward
  git-rebase.txt: add more details about behavioral differences of
    backends
  rebase: move incompatibility checks between backend options a bit
    earlier
  rebase: add an --am option
  git-prompt: change the prompt for interactive-based rebases
  rebase: drop '-i' from the reflog for interactive-based rebases
  rebase tests: mark tests specific to the am-backend with --am
  rebase tests: repeat some tests using the merge backend instead of am
  rebase: make the backend configurable via config setting
  rebase: change the default backend from "am" to "merge"

 Documentation/config/rebase.txt        |   8 ++
 Documentation/git-rebase.txt           | 150 +++++++++++++++++---
 builtin/rebase.c                       | 186 +++++++++++++++++++------
 contrib/completion/git-prompt.sh       |   6 +-
 rebase-interactive.c                   |   7 +-
 rebase-interactive.h                   |   2 +-
 sequencer.c                            |  84 ++++++-----
 sequencer.h                            |   3 +-
 t/t3400-rebase.sh                      |  36 ++++-
 t/t3401-rebase-and-am-rename.sh        |   4 +-
 t/t3404-rebase-interactive.sh          |  19 +--
 t/t3406-rebase-message.sh              |  19 ++-
 t/t3407-rebase-abort.sh                |   6 +-
 t/t3420-rebase-autostash.sh            |   2 +-
 t/t3421-rebase-topology-linear.sh      |  16 +--
 t/t3424-rebase-empty.sh                | 108 ++++++++++++++
 t/t3425-rebase-topology-merges.sh      |   8 +-
 t/t3427-rebase-subtree.sh              |  12 +-
 t/t3432-rebase-fast-forward.sh         |  54 ++++---
 t/t5407-post-rewrite-hook.sh           |  12 +-
 t/t5520-pull.sh                        |  27 +++-
 t/t6047-diff3-conflict-markers.sh      |  13 +-
 t/t7512-status-help.sh                 |  12 +-
 t/t9106-git-svn-commit-diff-clobber.sh |   3 +-
 t/t9903-bash-prompt.sh                 |   8 +-
 25 files changed, 595 insertions(+), 210 deletions(-)
 create mode 100755 t/t3424-rebase-empty.sh


base-commit: d0654dc308b0ba76dd8ed7bbb33c8d8f7aacd783
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-679%2Fnewren%2Frebase-fixes-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-679/newren/rebase-fixes-v4
Pull-Request: https://github.com/git/git/pull/679

Range-diff vs v3:

  -:  ---------- >  1:  3ea48d5394 git-rebase.txt: update description of --allow-empty-message
  -:  ---------- >  2:  10fdd162a0 t3404: directly test the behavior of interest
  1:  1c2b77e94d !  3:  179f82ab83 rebase: extend the options for handling of empty commits
     @@ -1,49 +1,46 @@
      Author: Elijah Newren <newren@gmail.com>
      
     -    rebase: extend the options for handling of empty commits
     +    rebase (interactive-backend): make --keep-empty the default
      
     -    Extend the interactive machinery with the ability to handle the full
     -    spread of options for how to handle commits that either start or become
     -    empty (by "become empty" I mean the changes in a commit are a subset of
     -    changes that exist upstream, so the net effect of applying the commit is
     -    no changes).  Introduce a new command line flag for selecting the
     -    desired behavior:
     -        --empty={drop,keep,ask}
     -    with the definitions:
     -        drop: drop empty commits
     -        keep: keep empty commits
     -        ask:  provide the user a chance to interact and pick what to do with
     -              empty commits on a case-by-case basis
     +    Different rebase backends have different treatment for commits which
     +    start empty (i.e. have no changes relative to their parent), and the
     +    --keep-empty option was added at some point to allow adjusting behavior
     +    for the interactive backend.  The handling of commits which start empty
     +    is actually quite similar to commit b00bf1c9a8dd (git-rebase: make
     +    --allow-empty-message the default, 2018-06-27), which pointed out that
     +    the behavior for various backends is often more happenstance than
     +    design.  The specific change made in that commit is actually quite
     +    relevant as well and much of the logic there directly applies here.
      
     -    Note that traditionally, am-based rebases have always dropped commits
     -    that either started or became empty, while interactive-based rebases
     -    have defaulted to ask (and provided an option to keep commits that
     -    started empty).  This difference made sense since users of an am-based
     -    rebase just wanted to quickly batch apply a sequence of commits, while
     -    users editing a todo list will likely want the chance to interact and
     -    handle unusual cases on a case-by-case basis.  However, not all rebases
     -    using the interactive machinery are explicitly interactive anymore.  In
     -    particular --merge was always meant to behave more like --am: just
     -    rebase a batch of commits without popping up a todo list.
     +    It makes a lot of sense in 'git commit' to error out on the creation of
     +    empty commits, unless an override flag is provided.  However, once
     +    someone determines that there is a rare case that merits using the
     +    manual override to create such a commit, it is somewhere between
     +    annoying and harmful to have to take extra steps to keep such
     +    intentional commits around.  Granted, empty commits are quite rare,
     +    which is why handling of them doesn't get considered much and folks tend
     +    to defer to existing (accidental) behavior and assume there was a reason
     +    for it, leading them to just add flags (--keep-empty in this case) that
     +    allow them to override the bad defaults.  Fix the interactive backend so
     +    that --keep-empty is the default, much like we did with
     +    --allow-empty-message.  The am backend should also be fixed to have
     +    --keep-empty semantics for commits that start empty, but that is not
     +    included in this patch other than a testcase documenting the failure.
      
     -    If the --empty flag is not specified, pick defaults as follows:
     -        explicitly interactive: ask
     -        --exec: keep (exec is about checking existing commits, and often
     -                      used without actually changing the base.  Thus the
     -                      expectation is that the user doesn't necessarily want
     -                      anything to change; they just want to test).
     -        otherwise: drop
     -
     -    Also, this commit makes --keep-empty just imply --empty=keep, and hides
     -    it from help so that we aren't confusing users with different ways to do
     -    the same thing.  (I could have added a --drop-empty flag, but then that
     -    invites users to specify both --keep-empty and --drop-empty and we have
     -    to add sanity checking around that; it seems cleaner to have a single
     -    multi-valued option.)  This actually fixes --keep-empty too; previously,
     -    it only meant to sometimes keep empty commits, in particular commits
     -    which started empty would be kept.  But it would still error out and ask
     -    the user what to do with commits that became empty.  Now it keeps empty
     -    commits, as instructed.
     +    Note that there was one test in t3421 which appears to have been written
     +    expecting --keep-empty to not be the default as correct behavior.  This
     +    test was introduced in commit 00b8be5a4d38 ("add tests for rebasing of
     +    empty commits", 2013-06-06), which was part of a series focusing on
     +    rebase topology and which had an interesting original cover letter at
     +    https://lore.kernel.org/git/1347949878-12578-1-git-send-email-martinvonz@gmail.com/
     +    which noted
     +        Your input especially appreciated on whether you agree with the
     +        intent of the test cases.
     +    and then went into a long example about how one of the many tests added
     +    had several questions about whether it was correct.  As such, I believe
     +    most the tests in that series were about testing rebase topology with as
     +    many different flags as possible and were not trying to state in general
     +    how those flags should behave otherwise.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ -51,126 +48,62 @@
       --- a/Documentation/git-rebase.txt
       +++ b/Documentation/git-rebase.txt
      @@
     - 	original branch. The index and working tree are also left
       	unchanged as a result.
       
     -+--empty={drop,keep,ask}::
     -+	How to handle commits that become empty (because they contain a
     -+	subset of already upstream changes) or start empty.  With drop
     -+	(the default), commits that start or become empty are dropped.
     -+	With keep (implied by --exec), such commits are kept.  With ask
     -+	(implied by --interactive), the rebase will halt when an empty
     -+	commit is applied allowing you to choose whether to drop it or
     -+	commit it.  Also with ask, if the rebase is interactive then
     -+	commits which start empty will be commented out in the todo
     -+	action list (giving you a chance to uncomment).
     -++
     -+Note that this has no effect on commits which are already upstream (as
     -+can be checked via `git log --cherry-mark ...`), which are always
     -+dropped by rebase.
     -++
     -+See also INCOMPATIBLE OPTIONS below.
     -+
       --keep-empty::
      -	Keep the commits that do not change anything from its
      -	parents in the result.
     -+	Deprecated alias for what is now known as --empty=keep.
     ++	No-op.  Rebasing commits that started empty (had no change
     ++	relative to their parent) used to fail and this option would
     ++	override that behavior, allowing commits with empty changes to
     ++	be rebased.  Now commits with no changes do not cause rebasing
     ++	to halt.
       +
     - See also INCOMPATIBLE OPTIONS below.
     - 
     -@@
     -  * --interactive
     -  * --exec
     -  * --keep-empty
     -+ * --empty=
     -  * --edit-todo
     -  * --root when used in combination with --onto
     - 
     -@@
     -  * --preserve-merges and --ignore-whitespace
     -  * --preserve-merges and --committer-date-is-author-date
     -  * --preserve-merges and --ignore-date
     -+ * --preserve-merges and --empty=
     -  * --keep-base and --onto
     -  * --keep-base and --root
     +-See also INCOMPATIBLE OPTIONS below.
     ++See also BEHAVIORAL DIFFERENCES and INCOMPATIBLE OPTIONS below.
       
     + --allow-empty-message::
     + 	No-op.  Rebasing commits with an empty message used to fail
      @@
     + Empty commits
     + ~~~~~~~~~~~~~
       
     - There are some subtle differences how the backends behave.
     - 
     --Empty commits
     --~~~~~~~~~~~~~
     --
      -The am backend drops any "empty" commits, regardless of whether the
      -commit started empty (had no changes relative to its parent to
      -start with) or ended empty (all changes were already applied
      -upstream in other commits).
     --
     ++The am backend unfortunately drops intentionally empty commits, i.e.
     ++commits that started empty, though these are rare in practice.  It
     ++also drops commits that become empty and has no option for controlling
     ++this behavior.
     + 
      -The interactive backend drops commits by default that
      -started empty and halts if it hits a commit that ended up empty.
      -The `--keep-empty` option exists for the interactive backend to allow
      -it to keep commits that started empty.
     --
     ++The interactive backend keeps intentionally empty commits.
     ++Unfortunately, it always halts whenever it runs across a commit that
     ++becomes empty, even when the rebase is not explicitly interactive.
     + 
       Directory rename detection
       ~~~~~~~~~~~~~~~~~~~~~~~~~~
     - 
      
       diff --git a/builtin/rebase.c b/builtin/rebase.c
       --- a/builtin/rebase.c
       +++ b/builtin/rebase.c
     -@@
     - 	REBASE_PRESERVE_MERGES
     - };
     - 
     -+enum empty_type {
     -+	EMPTY_UNSPECIFIED = -1,
     -+	EMPTY_DROP,
     -+	EMPTY_KEEP,
     -+	EMPTY_ASK
     -+};
     -+
     - struct rebase_options {
     - 	enum rebase_type type;
     -+	enum empty_type empty;
     - 	const char *state_dir;
     - 	struct commit *upstream;
     - 	const char *upstream_name;
      @@
       	const char *action;
       	int signoff;
       	int allow_rerere_autoupdate;
      -	int keep_empty;
       	int autosquash;
     - 	int ignore_whitespace;
       	char *gpg_sign_opt;
     -@@
     - 
     - #define REBASE_OPTIONS_INIT {			  	\
     - 		.type = REBASE_UNSPECIFIED,	  	\
     -+		.empty = EMPTY_UNSPECIFIED,	  	\
     - 		.flags = REBASE_NO_QUIET, 		\
     - 		.git_am_opts = ARGV_ARRAY_INIT,		\
     - 		.git_format_patch_opt = STRBUF_INIT	\
     -@@
     - 		replay.allow_rerere_auto = opts->allow_rerere_autoupdate;
     - 	replay.allow_empty = 1;
     - 	replay.allow_empty_message = opts->allow_empty_message;
     -+	replay.drop_redundant_commits = (opts->empty == EMPTY_DROP);
     -+	replay.keep_redundant_commits = (opts->empty == EMPTY_KEEP);
     -+	replay.ask_on_initially_empty = (opts->empty == EMPTY_ASK &&
     -+					 !(opts->flags & REBASE_INTERACTIVE_EXPLICIT));
     - 	replay.verbose = opts->flags & REBASE_VERBOSE;
     - 	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
     - 	replay.committer_date_is_author_date =
     + 	int autostash;
      @@
       
       	git_config_get_bool("rebase.abbreviatecommands", &abbreviate_commands);
       
      -	flags |= opts->keep_empty ? TODO_LIST_KEEP_EMPTY : 0;
     -+	flags |= (opts->empty == EMPTY_DROP) ? TODO_LIST_DROP_EMPTY : 0;
     -+	flags |= (opts->empty == EMPTY_ASK &&
     -+		  opts->flags & REBASE_INTERACTIVE_EXPLICIT) ?
     -+			TODO_LIST_ASK_EMPTY : 0;
       	flags |= abbreviate_commands ? TODO_LIST_ABBREVIATE_CMDS : 0;
       	flags |= opts->rebase_merges ? TODO_LIST_REBASE_MERGES : 0;
       	flags |= opts->rebase_cousins > 0 ? TODO_LIST_REBASE_COUSINS : 0;
     @@ -183,10 +116,8 @@
      +{
      +	struct rebase_options *opts = opt->value;
      +
     -+	BUG_ON_OPT_NEG(unset);
      +	BUG_ON_OPT_ARG(arg);
      +
     -+	opts->empty = EMPTY_KEEP;
      +	opts->type = REBASE_INTERACTIVE;
      +	return 0;
      +}
     @@ -201,62 +132,28 @@
      -		OPT_BOOL(0, "keep-empty", &opts.keep_empty, N_("keep empty commits")),
      +		{ OPTION_CALLBACK, 'k', "keep-empty", &options, NULL,
      +			N_("(DEPRECATED) keep empty commits"),
     -+			PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_HIDDEN,
     ++			PARSE_OPT_NOARG | PARSE_OPT_HIDDEN,
      +			parse_opt_keep_empty },
     - 		OPT_BOOL(0, "allow-empty-message", &opts.allow_empty_message,
     - 			 N_("allow commits with empty messages")),
     - 		OPT_BOOL(0, "rebase-merges", &opts.rebase_merges, N_("rebase merge commits")),
     + 		OPT_BOOL_F(0, "allow-empty-message", &opts.allow_empty_message,
     + 			   N_("allow commits with empty messages"),
     + 			   PARSE_OPT_HIDDEN),
      @@
       		opts->allow_rerere_autoupdate ?
       			opts->allow_rerere_autoupdate == RERERE_AUTOUPDATE ?
       			"--rerere-autoupdate" : "--no-rerere-autoupdate" : "");
      -	add_var(&script_snippet, "keep_empty", opts->keep_empty ? "yes" : "");
     -+	add_var(&script_snippet, "empty", opts->empty == EMPTY_KEEP ? "yes" : "");
       	add_var(&script_snippet, "autosquash", opts->autosquash ? "t" : "");
       	add_var(&script_snippet, "gpg_sign_opt", opts->gpg_sign_opt);
       	add_var(&script_snippet, "cmd", opts->cmd);
     -@@
     - 	return 0;
     - }
     - 
     -+static enum empty_type parse_empty_value(const char *value)
     -+{
     -+	if (!strcasecmp(value, "drop"))
     -+		return EMPTY_DROP;
     -+	else if (!strcasecmp(value, "keep"))
     -+		return EMPTY_KEEP;
     -+	else if (!strcasecmp(value, "ask"))
     -+		return EMPTY_ASK;
     -+
     -+	die(_("unrecognized empty type '%s'; valid values are \"drop\", \"keep\", and \"ask\"."), value);
     -+}
     -+
     -+static int parse_opt_empty(const struct option *opt, const char *arg, int unset)
     -+{
     -+	struct rebase_options *options = opt->value;
     -+	enum empty_type value = parse_empty_value(arg);
     -+
     -+	BUG_ON_OPT_NEG(unset);
     -+
     -+	options->empty = value;
     -+	return 0;
     -+}
     -+
     - static void NORETURN error_on_missing_default_upstream(void)
     - {
     - 	struct branch *current_branch = branch_get(NULL);
      @@
       				 "ignoring them"),
       			      REBASE_PRESERVE_MERGES, PARSE_OPT_HIDDEN),
       		OPT_RERERE_AUTOUPDATE(&options.allow_rerere_autoupdate),
      -		OPT_BOOL('k', "keep-empty", &options.keep_empty,
      -			 N_("preserve empty commits during rebase")),
     -+		OPT_CALLBACK_F(0, "empty", &options, N_("{drop,keep,ask}"),
     -+			       N_("how to handle empty commits"),
     -+			       PARSE_OPT_NONEG, parse_opt_empty),
      +		{ OPTION_CALLBACK, 'k', "keep-empty", &options, NULL,
      +			N_("(DEPRECATED) keep empty commits"),
     -+			PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_HIDDEN,
     ++			PARSE_OPT_NOARG | PARSE_OPT_HIDDEN,
      +			parse_opt_keep_empty },
       		OPT_BOOL(0, "autosquash", &options.autosquash,
       			 N_("move commits that begin with "
     @@ -267,26 +164,10 @@
       
      -	if (options.keep_empty)
      -		imply_interactive(&options, "--keep-empty");
     -+	if (options.empty != EMPTY_UNSPECIFIED)
     -+		imply_interactive(&options, "--empty");
     - 
     +-
       	if (gpg_sign) {
       		free(options.gpg_sign_opt);
     -@@
     - 		break;
     - 	}
     - 
     -+	if (options.empty == EMPTY_UNSPECIFIED) {
     -+		if (options.flags & REBASE_INTERACTIVE_EXPLICIT)
     -+			options.empty = EMPTY_ASK;
     -+		else if (exec.nr > 0)
     -+			options.empty = EMPTY_KEEP;
     -+		else
     -+			options.empty = EMPTY_DROP;
     -+	}
     - 	if (reschedule_failed_exec > 0 && !is_interactive(&options))
     - 		die(_("--reschedule-failed-exec requires "
     - 		      "--exec or --interactive"));
     + 		options.gpg_sign_opt = xstrfmt("-S%s", gpg_sign);
      
       diff --git a/rebase-interactive.c b/rebase-interactive.c
       --- a/rebase-interactive.c
     @@ -296,19 +177,22 @@
       }
       
      -void append_todo_help(unsigned keep_empty, int command_count,
     -+void append_todo_help(unsigned no_ask_empty, int command_count,
     ++void append_todo_help(int command_count,
       		      const char *shortrevisions, const char *shortonto,
       		      struct strbuf *buf)
       {
      @@
     + 			"the rebase will be aborted.\n\n");
       
       	strbuf_add_commented_lines(buf, msg, strlen(msg));
     - 
     +-
      -	if (!keep_empty) {
     -+	if (!no_ask_empty) {
     - 		msg = _("Note that empty commits are commented out");
     - 		strbuf_add_commented_lines(buf, msg, strlen(msg));
     - 	}
     +-		msg = _("Note that empty commits are commented out");
     +-		strbuf_add_commented_lines(buf, msg, strlen(msg));
     +-	}
     + }
     + 
     + int edit_todo_list(struct repository *r, struct todo_list *todo_list,
      
       diff --git a/rebase-interactive.h b/rebase-interactive.h
       --- a/rebase-interactive.h
     @@ -318,7 +202,7 @@
       struct todo_list;
       
      -void append_todo_help(unsigned keep_empty, int command_count,
     -+void append_todo_help(unsigned no_ask_empty, int command_count,
     ++void append_todo_help(int command_count,
       		      const char *shortrevisions, const char *shortonto,
       		      struct strbuf *buf);
       int edit_todo_list(struct repository *r, struct todo_list *todo_list,
     @@ -327,157 +211,51 @@
       --- a/sequencer.c
       +++ b/sequencer.c
      @@
     - static GIT_PATH_FUNC(rebase_path_strategy_opts, "rebase-merge/strategy_opts")
     - static GIT_PATH_FUNC(rebase_path_allow_rerere_autoupdate, "rebase-merge/allow_rerere_autoupdate")
     - static GIT_PATH_FUNC(rebase_path_reschedule_failed_exec, "rebase-merge/reschedule-failed-exec")
     -+static GIT_PATH_FUNC(rebase_path_drop_redundant_commits, "rebase-merge/drop_redundant_commits")
     -+static GIT_PATH_FUNC(rebase_path_keep_redundant_commits, "rebase-merge/keep_redundant_commits")
     -+static GIT_PATH_FUNC(rebase_path_ask_on_initially_empty, "rebase-merge/ask_on_initially_empty")
     - 
     - static int git_sequencer_config(const char *k, const char *v, void *cb)
     + 		       struct replay_opts *opts,
     + 		       struct commit *commit)
       {
     +-	int index_unchanged, empty_commit;
     ++	int index_unchanged, originally_empty;
     + 
     + 	/*
     + 	 * Three cases:
      @@
     - 	empty_commit = is_original_commit_empty(commit);
     - 	if (empty_commit < 0)
     - 		return empty_commit;
     + 	if (opts->keep_redundant_commits)
     + 		return 1;
     + 
     +-	empty_commit = is_original_commit_empty(commit);
     +-	if (empty_commit < 0)
     +-		return empty_commit;
      -	if (!empty_commit)
     -+	if (!empty_commit || opts->ask_on_initially_empty)
     ++	originally_empty = is_original_commit_empty(commit);
     ++	if (originally_empty < 0)
     ++		return originally_empty;
     ++	if (!originally_empty)
       		return 0;
       	else
       		return 1;
     -@@
     - 	char *author = NULL;
     - 	struct commit_message msg = { NULL, NULL, NULL, NULL };
     - 	struct strbuf msgbuf = STRBUF_INIT;
     --	int res, unborn = 0, reword = 0, allow;
     -+	int res, unborn = 0, reword = 0, allow, drop_commit;
     - 
     - 	if (opts->no_commit) {
     - 		/*
     -@@
     - 		goto leave;
     - 	}
     - 
     --	allow = allow_empty(r, opts, commit);
     --	if (allow < 0) {
     --		res = allow;
     --		goto leave;
     --	} else if (allow)
     --		flags |= ALLOW_EMPTY;
     --	if (!opts->no_commit) {
     -+	drop_commit = 0;
     -+	if (opts->drop_redundant_commits && is_index_unchanged(r)) {
     -+		drop_commit = 1;
     -+		fprintf(stderr, _("No changes -- Patch already applied."));
     -+	} else {
     -+		allow = allow_empty(r, opts, commit);
     -+		if (allow < 0) {
     -+			res = allow;
     -+			goto leave;
     -+		} else if (allow) {
     -+			flags |= ALLOW_EMPTY;
     -+		}
     -+	}
     -+	if (!opts->no_commit && !drop_commit) {
     - 		if (author || command == TODO_REVERT || (flags & AMEND_MSG))
     - 			res = do_commit(r, msg_file, author, opts, flags);
     - 		else
     -@@
     - 	else if (!strcmp(key, "options.allow-empty-message"))
     - 		opts->allow_empty_message =
     - 			git_config_bool_or_int(key, value, &error_flag);
     -+	else if (!strcmp(key, "options.drop-redundant-commits"))
     -+		opts->drop_redundant_commits =
     -+			git_config_bool_or_int(key, value, &error_flag);
     - 	else if (!strcmp(key, "options.keep-redundant-commits"))
     - 		opts->keep_redundant_commits =
     - 			git_config_bool_or_int(key, value, &error_flag);
     -+	else if (!strcmp(key, "options.ask_on_initially_empty"))
     -+		opts->ask_on_initially_empty =
     -+			git_config_bool_or_int(key, value, &error_flag);
     - 	else if (!strcmp(key, "options.signoff"))
     - 		opts->signoff = git_config_bool_or_int(key, value, &error_flag);
     - 	else if (!strcmp(key, "options.record-origin"))
     -@@
     - 		if (file_exists(rebase_path_reschedule_failed_exec()))
     - 			opts->reschedule_failed_exec = 1;
     - 
     -+		if (file_exists(rebase_path_drop_redundant_commits()))
     -+			opts->drop_redundant_commits = 1;
     -+
     -+		if (file_exists(rebase_path_keep_redundant_commits()))
     -+			opts->keep_redundant_commits = 1;
     -+
     -+		if (file_exists(rebase_path_ask_on_initially_empty()))
     -+			opts->ask_on_initially_empty = 1;
     -+
     - 		read_strategy_opts(opts, &buf);
     - 		strbuf_release(&buf);
     - 
     -@@
     - 		write_file(rebase_path_cdate_is_adate(), "%s", "");
     - 	if (opts->ignore_date)
     - 		write_file(rebase_path_ignore_date(), "%s", "");
     -+	if (opts->drop_redundant_commits)
     -+		write_file(rebase_path_drop_redundant_commits(), "%s", "");
     -+	if (opts->keep_redundant_commits)
     -+		write_file(rebase_path_keep_redundant_commits(), "%s", "");
     -+	if (opts->ask_on_initially_empty)
     -+		write_file(rebase_path_ask_on_initially_empty(), "%s", "");
     - 	if (opts->reschedule_failed_exec)
     - 		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
     - 
     -@@
     - 	if (opts->allow_empty_message)
     - 		res |= git_config_set_in_file_gently(opts_file,
     - 				"options.allow-empty-message", "true");
     -+	if (opts->drop_redundant_commits)
     -+		res |= git_config_set_in_file_gently(opts_file,
     -+				"options.drop-redundant-commits", "true");
     - 	if (opts->keep_redundant_commits)
     - 		res |= git_config_set_in_file_gently(opts_file,
     - 				"options.keep-redundant-commits", "true");
     -+	if (opts->ask_on_initially_empty)
     -+		res |= git_config_set_in_file_gently(opts_file,
     -+				"options.ask_on_initially_empty", "true");
     - 	if (opts->signoff)
     - 		res |= git_config_set_in_file_gently(opts_file,
     - 					"options.signoff", "true");
      @@
       				   struct rev_info *revs, struct strbuf *out,
       				   unsigned flags)
       {
      -	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
     -+	int drop_empty = flags & TODO_LIST_DROP_EMPTY;
     -+	int ask_empty = flags & TODO_LIST_ASK_EMPTY;
       	int rebase_cousins = flags & TODO_LIST_REBASE_COUSINS;
       	int root_with_onto = flags & TODO_LIST_ROOT_WITH_ONTO;
       	struct strbuf buf = STRBUF_INIT, oneline = STRBUF_INIT;
     -@@
     - 		is_empty = is_original_commit_empty(commit);
     - 		if (!is_empty && (commit->object.flags & PATCHSAME))
     - 			continue;
     -+		if (is_empty && drop_empty)
     -+			continue;
     - 
     - 		strbuf_reset(&oneline);
     - 		pretty_print_commit(pp, commit, &oneline);
      @@
       		if (!to_merge) {
       			/* non-merge commit: easy case */
       			strbuf_reset(&buf);
      -			if (!keep_empty && is_empty)
     -+			if (is_empty && ask_empty)
     - 				strbuf_addf(&buf, "%c ", comment_line_char);
     +-				strbuf_addf(&buf, "%c ", comment_line_char);
       			strbuf_addf(&buf, "%s %s %s", cmd_pick,
       				    oid_to_hex(&commit->object.oid),
     + 				    oneline.buf);
      @@
       	struct pretty_print_context pp = {0};
       	struct rev_info revs;
       	struct commit *commit;
      -	int keep_empty = flags & TODO_LIST_KEEP_EMPTY;
     -+	int drop_empty = flags & TODO_LIST_DROP_EMPTY;
     -+	int ask_empty = flags & TODO_LIST_ASK_EMPTY;
       	const char *insn = flags & TODO_LIST_ABBREVIATE_CMDS ? "p" : "pick";
       	int rebase_merges = flags & TODO_LIST_REBASE_MERGES;
       
     @@ -491,19 +269,16 @@
       		if (!is_empty && (commit->object.flags & PATCHSAME))
       			continue;
      -		if (!keep_empty && is_empty)
     -+		if (is_empty && drop_empty)
     -+			continue;
     -+		if (is_empty && ask_empty)
     - 			strbuf_addf(out, "%c ", comment_line_char);
     +-			strbuf_addf(out, "%c ", comment_line_char);
       		strbuf_addf(out, "%s %s ", insn,
       			    oid_to_hex(&commit->object.oid));
     + 		pretty_print_commit(&pp, commit, out);
      @@
       
       	todo_list_to_strbuf(r, todo_list, &buf, num, flags);
       	if (flags & TODO_LIST_APPEND_TODO_HELP)
      -		append_todo_help(flags & TODO_LIST_KEEP_EMPTY, count_commands(todo_list),
     -+		append_todo_help(!(flags & TODO_LIST_ASK_EMPTY),
     -+				 count_commands(todo_list),
     ++		append_todo_help(count_commands(todo_list),
       				 shortrevisions, shortonto, &buf);
       
       	res = write_message(buf.buf, buf.len, file, 0);
     @@ -511,16 +286,6 @@
       diff --git a/sequencer.h b/sequencer.h
       --- a/sequencer.h
       +++ b/sequencer.h
     -@@
     - 	int allow_rerere_auto;
     - 	int allow_empty;
     - 	int allow_empty_message;
     -+	int drop_redundant_commits;
     - 	int keep_redundant_commits;
     -+	int ask_on_initially_empty;
     - 	int verbose;
     - 	int quiet;
     - 	int reschedule_failed_exec;
      @@
       int sequencer_skip(struct repository *repo, struct replay_opts *opts);
       int sequencer_remove_state(struct replay_opts *opts);
     @@ -530,19 +295,34 @@
       #define TODO_LIST_SHORTEN_IDS (1U << 1)
       #define TODO_LIST_ABBREVIATE_CMDS (1U << 2)
       #define TODO_LIST_REBASE_MERGES (1U << 3)
     -@@
     -  * `--onto`, we do not want to re-generate the root commits.
     -  */
     - #define TODO_LIST_ROOT_WITH_ONTO (1U << 6)
     -+#define TODO_LIST_DROP_EMPTY (1U << 7)
     -+#define TODO_LIST_ASK_EMPTY (1U << 8)
     - 
     - 
     - int sequencer_make_script(struct repository *r, struct strbuf *out, int argc,
      
       diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
       --- a/t/t3421-rebase-topology-linear.sh
       +++ b/t/t3421-rebase-topology-linear.sh
     +@@
     + test_run_rebase () {
     + 	result=$1
     + 	shift
     +-	test_expect_$result "rebase $* drops empty commit" "
     ++	test_expect_$result "rebase $* keeps begin-empty commits" "
     + 		reset_rebase &&
     +-		git rebase $* c l &&
     +-		test_cmp_rev c HEAD~2 &&
     +-		test_linear_range 'd l' c..
     ++		git rebase $* j l &&
     ++		test_cmp_rev c HEAD~4 &&
     ++		test_linear_range 'j d k l' c..
     + 	"
     + }
     +-test_run_rebase success ''
     ++test_run_rebase failure ''
     + test_run_rebase success -m
     + test_run_rebase success -i
     +-test_have_prereq !REBASE_P || test_run_rebase success -p
     ++test_have_prereq !REBASE_P || test_run_rebase failure -p
     + 
     + test_run_rebase () {
     + 	result=$1
      @@
       test_run_rebase success ''
       test_run_rebase success -m
     @@ -603,31 +383,22 @@
      +	git commit -m "Five letters ought to be enough for anybody"
      +'
      +
     -+test_expect_success 'rebase --merge --empty=drop' '
     ++test_expect_failure 'rebase (am-backend) with a variety of empty commits' '
     ++	test_when_finished "git rebase --abort" &&
      +	git checkout -B testing localmods &&
     -+	git rebase --merge --empty=drop upstream &&
     -+
     -+	test_write_lines C B A >expect &&
     -+	git log --format=%s >actual &&
     -+	test_cmp expect actual
     -+'
     ++	# rebase (--am) should not drop commits that start empty
     ++	git rebase upstream &&
      +
     -+test_expect_success 'rebase --merge --empty=keep' '
     -+	git checkout -B testing localmods &&
     -+	git rebase --merge --empty=keep upstream &&
     -+
     -+	test_write_lines D C2 C B A >expect &&
     ++	test_write_lines D C B A >expect &&
      +	git log --format=%s >actual &&
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'rebase --merge --empty=ask' '
     ++test_expect_failure 'rebase --merge with a variety of empty commits' '
     ++	test_when_finished "git rebase --abort" &&
      +	git checkout -B testing localmods &&
     -+	test_must_fail git rebase --merge --empty=ask upstream &&
     -+
     -+	test_must_fail git rebase --skip &&
     -+	git commit --allow-empty &&
     -+	git rebase --continue &&
     ++	# rebase --merge should not halt on the commit that becomes empty
     ++	git rebase --merge upstream &&
      +
      +	test_write_lines D C B A >expect &&
      +	git log --format=%s >actual &&
     @@ -636,25 +407,17 @@
      +
      +GIT_SEQUENCE_EDITOR=: && export GIT_SEQUENCE_EDITOR
      +
     -+test_expect_success 'rebase --interactive --empty=drop' '
     ++test_expect_success 'rebase --interactive with a variety of empty commits' '
      +	git checkout -B testing localmods &&
     -+	git rebase --interactive --empty=drop upstream &&
     ++	test_must_fail git rebase --interactive upstream &&
      +
     -+	test_write_lines C B A >expect &&
     -+	git log --format=%s >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success 'rebase --interactive --empty=keep' '
     -+	git checkout -B testing localmods &&
     -+	git rebase --interactive --empty=keep upstream &&
     ++	git rebase --skip &&
      +
     -+	test_write_lines D C2 C B A >expect &&
     ++	test_write_lines D C B A >expect &&
      +	git log --format=%s >actual &&
      +	test_cmp expect actual
      +'
      +
     -+
      +test_done
      
       diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
     @@ -665,32 +428,28 @@
       '
       
      -test_expect_success 'Rebase -Xsubtree --keep-empty --onto commit' '
     -+test_expect_success 'Rebase -Xsubtree --empty=ask --onto commit' '
     ++test_expect_success 'Rebase -Xsubtree --onto commit' '
       	reset_rebase &&
       	git checkout -b rebase-onto to-rebase &&
      -	test_must_fail git rebase -Xsubtree=files_subtree --keep-empty --onto files-master master &&
     -+	test_must_fail git rebase -Xsubtree=files_subtree --empty=ask --onto files-master master &&
     ++	test_must_fail git rebase -Xsubtree=files_subtree --onto files-master master &&
       	: first pick results in no changes &&
      -	git rebase --continue &&
     -+	test_must_fail git rebase --skip &&
     -+	: last pick was an empty commit that has no changes, but we want to keep it &&
     -+	git commit --allow-empty &&
     ++	git rebase --skip &&
       	verbose test "$(commit_message HEAD~2)" = "master4" &&
       	verbose test "$(commit_message HEAD~)" = "files_subtree/master5" &&
       	verbose test "$(commit_message HEAD)" = "Empty commit"
       '
       
      -test_expect_success 'Rebase -Xsubtree --keep-empty --rebase-merges --onto commit' '
     -+test_expect_success 'Rebase -Xsubtree --empty=ask --rebase-merges --onto commit' '
     ++test_expect_success 'Rebase -Xsubtree --rebase-merges --onto commit' '
       	reset_rebase &&
       	git checkout -b rebase-merges-onto to-rebase &&
      -	test_must_fail git rebase -Xsubtree=files_subtree --keep-empty --rebase-merges --onto files-master --root &&
     -+	test_must_fail git rebase -Xsubtree=files_subtree --empty=ask --rebase-merges --onto files-master --root &&
     ++	test_must_fail git rebase -Xsubtree=files_subtree --rebase-merges --onto files-master --root &&
       	: first pick results in no changes &&
      -	git rebase --continue &&
     -+	test_must_fail git rebase --skip &&
     -+	: last pick was an empty commit that has no changes, but we want to keep it &&
     -+	git commit --allow-empty &&
     ++	git rebase --skip &&
       	verbose test "$(commit_message HEAD~2)" = "master4" &&
       	verbose test "$(commit_message HEAD~)" = "files_subtree/master5" &&
       	verbose test "$(commit_message HEAD)" = "Empty commit"
  -:  ---------- >  4:  c9542a2abe rebase (interactive-backend): fix handling of commits that become empty
  2:  bd3c5ec155 =  5:  9f66229d5c t3406: simplify an already simple test
  3:  49388b79fd =  6:  8d731fa39c rebase, sequencer: remove the broken GIT_QUIET handling
  4:  478479358f !  7:  b6b6597eef rebase: make sure to pass along the quiet flag to the sequencer
     @@ -8,13 +8,13 @@
       --- a/builtin/rebase.c
       +++ b/builtin/rebase.c
      @@
     + 	replay.allow_empty_message = opts->allow_empty_message;
     + 	replay.drop_redundant_commits = (opts->empty == EMPTY_DROP);
       	replay.keep_redundant_commits = (opts->empty == EMPTY_KEEP);
     - 	replay.ask_on_initially_empty = (opts->empty == EMPTY_ASK &&
     - 					 !(opts->flags & REBASE_INTERACTIVE_EXPLICIT));
      +	replay.quiet = !(opts->flags & REBASE_NO_QUIET);
       	replay.verbose = opts->flags & REBASE_VERBOSE;
       	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
     - 	replay.committer_date_is_author_date =
     + 	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
      @@
       			 N_("allow pre-rebase hook to run")),
       		OPT_NEGBIT('q', "quiet", &options.flags,
  5:  ee26f5a161 =  8:  0acefa988b rebase: fix handling of restrict_revision
  6:  34a69def33 =  9:  8c5b5b5133 t3432: make these tests work with either am or merge backends
  7:  f2c92853b4 ! 10:  b8c087d6fb rebase: allow more types of rebases to fast-forward
     @@ -35,8 +35,8 @@
       		OPT_STRING(0, "onto", &options.onto_name,
       			   N_("revision"),
      @@
     - 	    options.ignore_date)
     - 		options.flags |= REBASE_FORCE;
     + 		    state_dir_base, cmd_live_rebase, buf.buf);
     + 	}
       
      +	if ((options.flags & REBASE_INTERACTIVE_EXPLICIT) ||
      +	    (action != ACTION_NONE) ||
     @@ -47,7 +47,9 @@
      +
       	for (i = 0; i < options.git_am_opts.argc; i++) {
       		const char *option = options.git_am_opts.argv[i], *p;
     - 		if (!strcmp(option, "--whitespace=fix") ||
     + 		if (!strcmp(option, "--committer-date-is-author-date") ||
     + 		    !strcmp(option, "--ignore-date") ||
     + 		    !strcmp(option, "--whitespace=fix") ||
       		    !strcmp(option, "--whitespace=strip"))
      -			options.flags |= REBASE_FORCE;
      +			allow_preemptive_ff = 0;
  8:  b307340f7c ! 11:  b50a1741e0 git-rebase.txt: add more details about behavioral differences of backends
     @@ -8,23 +8,24 @@
       --- a/Documentation/git-rebase.txt
       +++ b/Documentation/git-rebase.txt
      @@
     - with `--keep-base` in order to drop those commits from your branch.
       
       --ignore-whitespace::
     --	Behaves differently depending on which backend is selected.
     --+
     --'am' backend: When applying a patch, ignore changes in whitespace in
     --context lines if necessary.
     --+
     --'interactive' backend: Treat lines with only whitespace changes as
     --unchanged for the sake of a three-way merge.
     -+	Ignore whitespace-only changes in the commits being rebased,
     -+	which may avoid "unnecessary" conflicts.  (Both backends
     -+	currently have differing edgecase bugs with this option; see
     -+	BEHAVIORAL DIFFERENCES.)
     - 
       --whitespace=<option>::
     - 	This flag is passed to the 'git apply' program
     +-	These flag are passed to the 'git apply' program
     ++	These flags are passed to the 'git apply' program
     + 	(see linkgit:git-apply[1]) that applies the patch.
     + +
     + See also INCOMPATIBLE OPTIONS below.
     +@@
     + 
     +  * --committer-date-is-author-date
     +  * --ignore-date
     +- * --whitespace
     +  * --ignore-whitespace
     ++ * --whitespace
     +  * -C
     + 
     + are incompatible with the following options:
      @@
       Directory rename detection
       ~~~~~~~~~~~~~~~~~~~~~~~~~~
     @@ -82,24 +83,14 @@
      +The interactive backend works with the full commits on both sides of
      +history and thus has no such limitations.
      +
     -+--ignore-whitespace
     -+~~~~~~~~~~~~~~~~~~~
     ++Hooks
     ++~~~~~
      +
     -+The --ignore-whitespace option is supposed to ignore whitespace-only
     -+changes if it allows the code to merge cleanly.  Unfortunately, the
     -+different backends implement this differently, and both have different
     -+edge case bugs.
     -++
     -+'am' backend: When applying a patch, ignore changes in whitespace in
     -+context lines if necessary.  (Which implies that if the whitespace
     -+change was not in the context lines but on a line with a real change,
     -+then the rebase will still fail with "unnecessary" content conflicts.)
     -++
     -+'interactive' backend: Treat lines with only whitespace changes as
     -+unchanged for the sake of a three-way merge.  This means that if one
     -+side made no changes and the commits being rebased had whitespace-only
     -+changes, those whitespaces fixups will be discarded despite the fact
     -+that they present no content conflict.
     ++The am backend has not traditionally called the post-commit hook,
     ++while the merge/interactive backend has.  However, this was by
     ++accident of implementation rather than by design.  Both backends
     ++should have the same behavior, though it is not clear which one is
     ++correct.
      +
      +Miscellaneous differences
      +~~~~~~~~~~~~~~~~~~~~~~~~~
     @@ -123,19 +114,3 @@
       
       include::merge-strategies.txt[]
       
     -
     - diff --git a/t/t3433-rebase-options-compatibility.sh b/t/t3433-rebase-options-compatibility.sh
     - --- a/t/t3433-rebase-options-compatibility.sh
     - +++ b/t/t3433-rebase-options-compatibility.sh
     -@@
     - GIT_AUTHOR_DATE="1999-04-02T08:03:20+05:30"
     - export GIT_AUTHOR_DATE
     - 
     --# This is a special case in which both am and interactive backends
     --# provide the same output. It was done intentionally because
     --# both the backends fall short of optimal behaviour.
     -+# This is a common case in which both am and interactive backends
     -+# provide the same output with --ignore-whitespace.
     - test_expect_success 'setup' '
     - 	git checkout -b topic &&
     - 	q_to_tab >file <<-\EOF &&
  9:  7c3f2e07f3 = 12:  58e6e4ffb3 rebase: move incompatibility checks between backend options a bit earlier
 10:  1df11f0b51 ! 13:  5478c730ac rebase: add an --am option
     @@ -24,8 +24,8 @@
      +See also INCOMPATIBLE OPTIONS below.
      +
       --empty={drop,keep,ask}::
     - 	How to handle commits that become empty (because they contain a
     - 	subset of already upstream changes) or start empty.  With drop
     + 	How to handle commits that are not empty to start and are not
     + 	clean cherry-picks of any upstream commit, but which become
      @@
       	Ensure at least <n> lines of surrounding context match before
       	and after each change.  When fewer lines of surrounding
     @@ -37,7 +37,7 @@
       
      @@
       --whitespace=<option>::
     - 	This flag is passed to the 'git apply' program
     + 	These flags are passed to the 'git apply' program
       	(see linkgit:git-apply[1]) that applies the patch.
      +	Implies --am.
       +
     @@ -48,9 +48,9 @@
       The following options:
       
      + * --am
     -  * --whitespace
     -  * -C
     - 
     +  * --committer-date-is-author-date
     +  * --ignore-date
     +  * --ignore-whitespace
      
       diff --git a/builtin/rebase.c b/builtin/rebase.c
       --- a/builtin/rebase.c
 11:  ff43593211 = 14:  db5e29bd81 git-prompt: change the prompt for interactive-based rebases
  -:  ---------- > 15:  413e190ac9 rebase: drop '-i' from the reflog for interactive-based rebases
 12:  99388f24e5 ! 16:  170be283a8 rebase tests: mark tests specific to the am-backend with --am
     @@ -228,40 +228,6 @@
       	test_rebase_same_head_ $status_f $what_f $cmp_f " --merge --no-ff" "$*"
       }
      
     - diff --git a/t/t3433-rebase-options-compatibility.sh b/t/t3433-rebase-options-compatibility.sh
     - --- a/t/t3433-rebase-options-compatibility.sh
     - +++ b/t/t3433-rebase-options-compatibility.sh
     -@@
     - 	new line 2
     - 	line 3
     - 	EOF
     --	test_must_fail git rebase main side &&
     -+	test_must_fail git rebase --am main side &&
     - 	git rebase --abort &&
     --	git rebase --ignore-whitespace main side &&
     -+	git rebase --am --ignore-whitespace main side &&
     - 	test_cmp expect file
     - '
     - 
     -@@
     - 
     - test_expect_success '--committer-date-is-author-date works with am backend' '
     - 	git commit --amend &&
     --	git rebase --committer-date-is-author-date HEAD^ &&
     -+	git rebase --am --committer-date-is-author-date HEAD^ &&
     - 	git show HEAD --pretty="format:%ai" >authortime &&
     - 	git show HEAD --pretty="format:%ci" >committertime &&
     - 	test_cmp authortime committertime
     -@@
     - # sets to +0530.
     - test_expect_success '--ignore-date works with am backend' '
     - 	git commit --amend --date="$GIT_AUTHOR_DATE" &&
     --	git rebase --ignore-date HEAD^ &&
     -+	git rebase --am --ignore-date HEAD^ &&
     - 	git show HEAD --pretty="format:%ai" >authortime &&
     - 	grep "+0000" authortime
     - '
     -
       diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
       --- a/t/t5407-post-rewrite-hook.sh
       +++ b/t/t5407-post-rewrite-hook.sh
 13:  c2ba6317bf = 17:  1e3d4066c4 rebase tests: repeat some tests using the merge backend instead of am
 14:  8bec6df51a = 18:  9b4ac83d2d rebase: make the backend configurable via config setting
 15:  044853fd61 = 19:  859a4a94d7 rebase: change the default backend from "am" to "merge"

-- 
gitgitgadget
