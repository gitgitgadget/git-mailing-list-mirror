Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B40C433DF
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 09:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41BE92053B
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 09:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFx8Y65W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgFZJzj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 05:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgFZJzj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 05:55:39 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65A0C08C5C1
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 02:55:38 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l17so8272498wmj.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 02:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=ezSyVS7Jcte+W2mUkj63XR1W9asf6wnVtX/M9YHN/Oo=;
        b=pFx8Y65WxRAsqYTYWLxRDJacBfL7je+IuXJokkwBpmGYdA6x7aFjuGdQVhrn5mj4r2
         lE5NCDWU2EXNUMiIcOQgQXns0lpHNEbugEiuO/k1eTwJFdFsgQTiOSMZpk8Db7z8io4d
         6lm3SKk6CkbdfoRvToTQbaNOAP/VIW8cou8oym/OGhTgWhifUfPy2BhHbyzG5cCCElnN
         scJEjdrYJ8pBL1FysVKawgMT3HwYbo1fqm20I+kJYbJkdSpVJEV0XW62PkKMt2HddBVp
         GZPFN/ANgMjvpHqKCzu/KQsIDyZhxKeDVcAz4xY/W1SgaNJgYa3ztJZgns2dwHfB5cEu
         1Nbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=ezSyVS7Jcte+W2mUkj63XR1W9asf6wnVtX/M9YHN/Oo=;
        b=Z77vWx3M0zU5tvjKpf0DJFlxMLN7XSmcid+osMwGBJgu4WiD92P6gPqMD2Gs1KKxx7
         3DfV2y/NLNaY7HaVjauAfQx1dlouFRxiTyxiAOKw7r+v1nPm9+aJ4JEZfktb9h9utfiI
         Pk87d8S92N47FCgfFYYcD+qeC9Z4Ufpwa4+FWwdyd7X6lJ4b5NJbgbBqbYnpOX8IKWm7
         64cXHDL3okCI0dg1CrGtvp0QmsWjra94TnmxOLz2ims4QvFNZAy1hIeH4DDvg3LJ17Db
         nspK/HT921TP59iz7pbSLp54vj5+k7rd/p5Ap0RYxhjAZKNz6F1IFkcINJf/KtlyjJnz
         NcCw==
X-Gm-Message-State: AOAM533sd4ZcrT3Jskr345YgSMLEyX5F7+ZXyJnnEQAn2Mx7aBkdpi4Y
        w+ApVgteKnKxdFgJ/Vxa/2k=
X-Google-Smtp-Source: ABdhPJyldRoevZVptAWLn31WcnIf6THmevLLTcodn528UBlpq5AkVCVikjA7BsykgVdwHkwhOzdYqw==
X-Received: by 2002:a1c:7f81:: with SMTP id a123mr2498835wmd.107.1593165337043;
        Fri, 26 Jun 2020 02:55:37 -0700 (PDT)
Received: from localhost.localdomain (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.gmail.com with ESMTPSA id n14sm14327755wro.81.2020.06.26.02.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 02:55:36 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v5 0/5] cleanup ra/rebase-i-more-options
Date:   Fri, 26 Jun 2020 10:55:23 +0100
Message-Id: <20200626095528.117524-1-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200407141125.30872-1-phillip.wood123@gmail.com>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

I've updated the commit messages, option handling and tests as
suggested by dscho. I've also changed the tests that used
'--strategy=resolve' to use a real external merge strategy so they
continue to test the same code path once Alban's patches to handle the
resolve strategy without forking are merged

Thanks for the review

Phillip

Phillip Wood (2):
  rebase -i: support --committer-date-is-author-date
  rebase -i: support --ignore-date

Rohit Ashiwal (3):
  rebase -i: add --ignore-whitespace flag
  sequencer: rename amend_author to author_to_free
  rebase: add --reset-author-date

 Documentation/git-rebase.txt           |  33 ++++-
 builtin/rebase.c                       |  44 ++++--
 sequencer.c                            | 112 ++++++++++++++-
 sequencer.h                            |   2 +
 t/t3422-rebase-incompatible-options.sh |   2 -
 t/t3436-rebase-more-options.sh         | 180 +++++++++++++++++++++++++
 6 files changed, 350 insertions(+), 23 deletions(-)
 create mode 100755 t/t3436-rebase-more-options.sh

Range-diff against v4:
1:  df8c4ed2e9 ! 1:  43ee10d4d5 rebase -i: add --ignore-whitespace flag
    @@ Metadata
      ## Commit message ##
         rebase -i: add --ignore-whitespace flag
     
    -    Rebase is implemented with two different backends - 'apply' and 'merge'
    -    each of which support a different set of options. In particuar the apply
    -    backend supports a number of options implemented by 'git am' that are
    -    not available to the merge backend. As part of an on going effort to
    -    remove the apply backend this patch adds support for the
    +    Rebase is implemented with two different backends - 'apply' and
    +    'merge' each of which support a different set of options. In
    +    particular the apply backend supports a number of options implemented
    +    by 'git am' that are not implemented in the merge backend. This means
    +    that the available options are different depending on which backend is
    +    used which is confusing. This patch adds support for the
         --ignore-whitespace option to the merge backend. This option treats
         lines with only whitespace changes as unchanged and is implemented in
         the merge backend by translating it to -Xignore-space-change.
    @@ Documentation/git-rebase.txt: In addition, the following pairs of options are in
      
     
      ## builtin/rebase.c ##
    -@@ builtin/rebase.c: struct rebase_options {
    - 	int signoff;
    - 	int allow_rerere_autoupdate;
    - 	int autosquash;
    -+	int ignore_whitespace;
    - 	char *gpg_sign_opt;
    - 	int autostash;
    - 	char *cmd;
    -@@ builtin/rebase.c: struct rebase_options {
    - 
    - static struct replay_opts get_replay_opts(const struct rebase_options *opts)
    - {
    -+	struct strbuf strategy_buf = STRBUF_INIT;
    - 	struct replay_opts replay = REPLAY_OPTS_INIT;
    - 
    - 	replay.action = REPLAY_INTERACTIVE_REBASE;
     @@ builtin/rebase.c: static struct replay_opts get_replay_opts(const struct rebase_options *opts)
      	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
      	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
      	replay.strategy = opts->strategy;
     +
      	if (opts->strategy_opts)
    --		parse_strategy_opts(&replay, opts->strategy_opts);
    -+		strbuf_addstr(&strategy_buf, opts->strategy_opts);
    -+	if (opts->ignore_whitespace)
    -+		strbuf_addstr(&strategy_buf, " --ignore-space-change");
    -+	if (strategy_buf.len)
    -+		parse_strategy_opts(&replay, strategy_buf.buf);
    - 
    - 	if (opts->squash_onto) {
    - 		oidcpy(&replay.squash_onto, opts->squash_onto);
    - 		replay.have_squash_onto = 1;
    - 	}
    - 
    -+	strbuf_release(&strategy_buf);
    - 	return replay;
    - }
    - 
    -@@ builtin/rebase.c: int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
    - 	argc = parse_options(argc, argv, prefix, options,
    - 			builtin_rebase_interactive_usage, PARSE_OPT_KEEP_ARGV0);
    - 
    -+	opts.strategy_opts = xstrdup_or_null(opts.strategy_opts);
    -+
    - 	if (!is_null_oid(&squash_onto))
    - 		opts.squash_onto = &squash_onto;
    - 
    -@@ builtin/rebase.c: static int run_am(struct rebase_options *opts)
    - 	am.git_cmd = 1;
    - 	argv_array_push(&am.args, "am");
    - 
    -+	if (opts->ignore_whitespace)
    -+		argv_array_push(&am.args, "--ignore-whitespace");
    - 	if (opts->action && !strcmp("continue", opts->action)) {
    - 		argv_array_push(&am.args, "--resolved");
    - 		argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
    + 		parse_strategy_opts(&replay, opts->strategy_opts);
    + 
    +@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
    + 	struct strbuf revisions = STRBUF_INIT;
    + 	struct strbuf buf = STRBUF_INIT;
    + 	struct object_id merge_base;
    ++	int ignore_whitespace = 0;
    + 	enum action action = ACTION_NONE;
    + 	const char *gpg_sign = NULL;
    + 	struct string_list exec = STRING_LIST_INIT_NODUP;
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
      			PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
      		OPT_BOOL(0, "signoff", &options.signoff,
    @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
      				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
      		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
      				  N_("passed to 'git apply'"), 0),
    -+		OPT_BOOL(0, "ignore-whitespace", &options.ignore_whitespace,
    ++		OPT_BOOL(0, "ignore-whitespace", &ignore_whitespace,
     +			 N_("ignore changes in whitespace")),
      		OPT_PASSTHRU_ARGV(0, "whitespace", &options.git_am_opts,
      				  N_("action"), N_("passed to 'git apply'"), 0),
      		OPT_BIT('f', "force-rebase", &options.flags,
    +@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
    + 		imply_merge(&options, "--rebase-merges");
    + 	}
    + 
    ++	if (options.type == REBASE_APPLY) {
    ++		if (ignore_whitespace)
    ++			argv_array_push (&options.git_am_opts,
    ++					 "--ignore-whitespace");
    ++	} else if (ignore_whitespace) {
    ++			string_list_append (&strategy_options,
    ++					    "ignore-space-change");
    ++	}
    ++
    + 	if (strategy_options.nr) {
    + 		int i;
    + 
     
      ## t/t3422-rebase-incompatible-options.sh ##
     @@ t/t3422-rebase-incompatible-options.sh: test_rebase_am_only () {
    @@ t/t3436-rebase-more-options.sh (new)
     +# both the backends fall short of optimal behaviour.
     +test_expect_success 'setup' '
     +	git checkout -b topic &&
    -+	q_to_tab >file <<-\EOF &&
    -+	line 1
    -+	Qline 2
    -+	line 3
    -+	EOF
    ++	test_write_lines "line 1" "	line 2" "line 3" >file &&
     +	git add file &&
     +	git commit -m "add file" &&
    -+	cat >file <<-\EOF &&
    -+	line 1
    -+	new line 2
    -+	line 3
    -+	EOF
    ++
    ++	test_write_lines "line 1" "new line 2" "line 3" >file &&
     +	git commit -am "update file" &&
     +	git tag side &&
     +
     +	git checkout --orphan master &&
    -+	sed -e "s/^|//" >file <<-\EOF &&
    -+	|line 1
    -+	|        line 2
    -+	|line 3
    -+	EOF
    -+	git add file &&
    -+	git commit -m "add file" &&
    ++	test_write_lines "line 1" "        line 2" "line 3" >file &&
    ++	git commit -am "add file" &&
     +	git tag main
     +'
     +
     +test_expect_success '--ignore-whitespace works with apply backend' '
    -+	cat >expect <<-\EOF &&
    -+	line 1
    -+	new line 2
    -+	line 3
    -+	EOF
     +	test_must_fail git rebase --apply main side &&
     +	git rebase --abort &&
     +	git rebase --apply --ignore-whitespace main side &&
    -+	test_cmp expect file
    ++	git diff --exit-code side
     +'
     +
     +test_expect_success '--ignore-whitespace works with merge backend' '
    -+	cat >expect <<-\EOF &&
    -+	line 1
    -+	new line 2
    -+	line 3
    -+	EOF
     +	test_must_fail git rebase --merge main side &&
     +	git rebase --abort &&
     +	git rebase --merge --ignore-whitespace main side &&
    -+	test_cmp expect file
    ++	git diff --exit-code side
     +'
     +
     +test_expect_success '--ignore-whitespace is remembered when continuing' '
    -+	cat >expect <<-\EOF &&
    -+	line 1
    -+	new line 2
    -+	line 3
    -+	EOF
     +	(
     +		set_fake_editor &&
    -+		FAKE_LINES="break 1" git rebase -i --ignore-whitespace main side
    ++		FAKE_LINES="break 1" git rebase -i --ignore-whitespace \
    ++			main side &&
    ++		git rebase --continue
     +	) &&
    -+	git rebase --continue &&
    -+	test_cmp expect file
    ++	git diff --exit-code side
     +'
     +
     +# This must be the last test in this file
2:  ad21e5d8fb ! 2:  a2b57df19c rebase -i: support --committer-date-is-author-date
    @@ Metadata
      ## Commit message ##
         rebase -i: support --committer-date-is-author-date
     
    -    As part of the on-going effort to retire the apply rebase backend teach
    -    the merge backend how to handle --committer-date-is-author-date.
    +    Rebase is implemented with two different backends - 'apply' and
    +    'merge' each of which support a different set of options. In
    +    particular the apply backend supports a number of options implemented
    +    by 'git am' that are not implemented in the merge backend. This means
    +    that the available options are different depending on which backend is
    +    used which is confusing. This patch adds support for the
    +    --committer-date-is-author-date option to the merge backend. This
    +    option uses the author date of the commit that is being rewritten as
    +    the committer date when the new commit is created.
     
         Original-patch-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
    @@ Documentation/git-rebase.txt: In addition, the following pairs of options are in
     
      ## builtin/rebase.c ##
     @@ builtin/rebase.c: struct rebase_options {
    - 	int ignore_whitespace;
    + 	int autosquash;
      	char *gpg_sign_opt;
      	int autostash;
     +	int committer_date_is_author_date;
    @@ builtin/rebase.c: static struct replay_opts get_replay_opts(const struct rebase_
      	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
      	replay.strategy = opts->strategy;
      
    -@@ builtin/rebase.c: static int run_am(struct rebase_options *opts)
    - 
    - 	if (opts->ignore_whitespace)
    - 		argv_array_push(&am.args, "--ignore-whitespace");
    -+	if (opts->committer_date_is_author_date)
    -+		argv_array_push(&opts->git_am_opts, "--committer-date-is-author-date");
    - 	if (opts->action && !strcmp("continue", opts->action)) {
    - 		argv_array_push(&am.args, "--resolved");
    - 		argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
      			PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
      		OPT_BOOL(0, "signoff", &options.signoff,
    @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
      		    !strcmp(option, "--whitespace=fix") ||
      		    !strcmp(option, "--whitespace=strip"))
      			allow_preemptive_ff = 0;
    +@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
    + 		if (ignore_whitespace)
    + 			argv_array_push (&options.git_am_opts,
    + 					 "--ignore-whitespace");
    ++		if (options.committer_date_is_author_date)
    ++			argv_array_push(&options.git_am_opts,
    ++					"--committer-date-is-author-date");
    + 	} else if (ignore_whitespace) {
    + 			string_list_append (&strategy_options,
    + 					    "ignore-space-change");
     
      ## sequencer.c ##
     @@ sequencer.c: static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
    @@ sequencer.c: static int try_to_commit(struct repository *r,
      	}
      
     +	if (opts->committer_date_is_author_date) {
    -+		int len = strlen(author);
     +		struct ident_split ident;
     +		struct strbuf date = STRBUF_INIT;
     +
    -+		if (split_ident_line(&ident, author, len) < 0) {
    ++		if (split_ident_line(&ident, author, (int)strlen(author)) < 0) {
     +			res = error(_("malformed ident line '%s'"), author);
     +			goto out;
     +		}
    @@ sequencer.c: static int try_to_commit(struct repository *r,
     +		}
     +
     +		strbuf_addf(&date, "@%.*s %.*s",
    -+			    (int)(ident.date_end - ident.date_begin), ident.date_begin,
    -+			    (int)(ident.tz_end - ident.tz_begin), ident.tz_begin);
    ++			    (int)(ident.date_end - ident.date_begin),
    ++			    ident.date_begin,
    ++			    (int)(ident.tz_end - ident.tz_begin),
    ++			    ident.tz_begin);
     +		res = setenv("GIT_COMMITTER_DATE", date.buf, 1);
     +		strbuf_release(&date);
     +
    @@ t/t3436-rebase-more-options.sh: test_description='tests to ensure compatibility
      # provide the same output. It was done intentionally because
      # both the backends fall short of optimal behaviour.
     @@ t/t3436-rebase-more-options.sh: test_expect_success 'setup' '
    - 	EOF
    + 	test_write_lines "line 1" "new line 2" "line 3" >file &&
      	git commit -am "update file" &&
      	git tag side &&
     +	test_commit commit1 foo foo1 &&
     +	test_commit commit2 foo foo2 &&
     +	test_commit commit3 foo foo3 &&
      
      	git checkout --orphan master &&
    -+	git rm --cached foo &&
     +	rm foo &&
    - 	sed -e "s/^|//" >file <<-\EOF &&
    - 	|line 1
    - 	|        line 2
    + 	test_write_lines "line 1" "        line 2" "line 3" >file &&
    + 	git commit -am "add file" &&
    +-	git tag main
    ++	git tag main &&
    ++
    ++	mkdir test-bin &&
    ++	write_script test-bin/git-merge-test <<-\EOF
    ++	exec git-merge-recursive "$@"
    ++	EOF
    + '
    + 
    + test_expect_success '--ignore-whitespace works with apply backend' '
     @@ t/t3436-rebase-more-options.sh: test_expect_success '--ignore-whitespace is remembered when continuing' '
    - 	test_cmp expect file
    + 	git diff --exit-code side
      '
      
    ++test_ctime_is_atime () {
    ++	git log $1 --format=%ai >authortime &&
    ++	git log $1 --format=%ci >committertime &&
    ++	test_cmp authortime committertime
    ++}
    ++
     +test_expect_success '--committer-date-is-author-date works with apply backend' '
     +	GIT_AUTHOR_DATE="@1234 +0300" git commit --amend --reset-author &&
     +	git rebase --apply --committer-date-is-author-date HEAD^ &&
    -+	git log -1 --pretty=%ai >authortime &&
    -+	git log -1 --pretty=%ci >committertime &&
    -+	test_cmp authortime committertime
    ++	test_ctime_is_atime -1
     +'
     +
     +test_expect_success '--committer-date-is-author-date works with merge backend' '
     +	GIT_AUTHOR_DATE="@1234 +0300" git commit --amend --reset-author &&
     +	git rebase -m --committer-date-is-author-date HEAD^ &&
    -+	git log -1 --pretty=%ai >authortime &&
    -+	git log -1 --pretty=%ci >committertime &&
    -+	test_cmp authortime committertime
    ++	test_ctime_is_atime -1
     +'
     +
     +test_expect_success '--committer-date-is-author-date works with rebase -r' '
     +	git checkout side &&
     +	GIT_AUTHOR_DATE="@1234 +0300" git merge --no-ff commit3 &&
     +	git rebase -r --root --committer-date-is-author-date &&
    -+	git log --pretty=%ai >authortime &&
    -+	git log --pretty=%ci >committertime &&
    -+	test_cmp authortime committertime
    ++	test_ctime_is_atime
     +'
     +
     +test_expect_success '--committer-date-is-author-date works when forking merge' '
     +	git checkout side &&
     +	GIT_AUTHOR_DATE="@1234 +0300" git merge --no-ff commit3 &&
    -+	git rebase -r --root --strategy=resolve --committer-date-is-author-date &&
    -+	git log --pretty=%ai >authortime &&
    -+	git log --pretty=%ci >committertime &&
    -+	test_cmp authortime committertime
    -+
    ++	PATH="./test-bin:$PATH" git rebase -r --root --strategy=test \
    ++					--committer-date-is-author-date &&
    ++	test_ctime_is_atime
     +'
     +
     +test_expect_success '--committer-date-is-author-date works when committing conflict resolution' '
     +	git checkout commit2 &&
     +	GIT_AUTHOR_DATE="@1980 +0000" git commit --amend --only --reset-author &&
    -+	git log -1 --format=%at HEAD >expect &&
     +	test_must_fail git rebase -m --committer-date-is-author-date \
     +		--onto HEAD^^ HEAD^ &&
     +	echo resolved > foo &&
     +	git add foo &&
     +	git rebase --continue &&
    -+	git log -1 --format=%ct HEAD >actual &&
    -+	test_cmp expect actual
    ++	test_ctime_is_atime -1
     +'
     +
      # This must be the last test in this file
3:  af92e29cf9 = 3:  363a0140ad sequencer: rename amend_author to author_to_free
4:  4399dc19b6 ! 4:  46d9e108be rebase -i: support --ignore-date
    @@ Metadata
      ## Commit message ##
         rebase -i: support --ignore-date
     
    -    As part of the on-going effort to retire the apply rebase backend
    -    teach the merge backend how to handle --ignore-date. We take care to
    -    handle the combination of --ignore-date and
    -    --committer-date-is-author-date in the same way as the apply backend.
    +    Rebase is implemented with two different backends - 'apply' and
    +    'merge' each of which support a different set of options. In
    +    particular the apply backend supports a number of options implemented
    +    by 'git am' that are not implemented in the merge backend. This means
    +    that the available options are different depending on which backend is
    +    used which is confusing. This patch adds support for the --ignore-date
    +    option to the merge backend. This option uses the current time as the
    +    author date rather than reusing the original author date when
    +    rewriting commits. We take care to handle the combination of
    +    --ignore-date and --committer-date-is-author-date in the same way as
    +    the apply backend.
     
         Original-patch-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
    @@ builtin/rebase.c: static struct replay_opts get_replay_opts(const struct rebase_
      	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
      	replay.strategy = opts->strategy;
      
    -@@ builtin/rebase.c: static int run_am(struct rebase_options *opts)
    - 		argv_array_push(&am.args, "--ignore-whitespace");
    - 	if (opts->committer_date_is_author_date)
    - 		argv_array_push(&opts->git_am_opts, "--committer-date-is-author-date");
    -+	if (opts->ignore_date)
    -+		argv_array_push(&opts->git_am_opts, "--ignore-date");
    - 	if (opts->action && !strcmp("continue", opts->action)) {
    - 		argv_array_push(&am.args, "--resolved");
    - 		argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
      		OPT_BOOL(0, "committer-date-is-author-date",
      			 &options.committer_date_is_author_date,
    @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
     +			 "ignore author date and use current date"),
      		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
      				  N_("passed to 'git apply'"), 0),
    - 		OPT_BOOL(0, "ignore-whitespace", &options.ignore_whitespace,
    + 		OPT_BOOL(0, "ignore-whitespace", &ignore_whitespace,
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
      	    options.autosquash) {
      		allow_preemptive_ff = 0;
    @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
      		    !strcmp(option, "--whitespace=strip"))
      			allow_preemptive_ff = 0;
      		else if (skip_prefix(option, "-C", &p)) {
    +@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
    + 		if (options.committer_date_is_author_date)
    + 			argv_array_push(&options.git_am_opts,
    + 					"--committer-date-is-author-date");
    ++		if (options.ignore_date)
    ++			argv_array_push(&options.git_am_opts, "--ignore-date");
    + 	} else if (ignore_whitespace) {
    + 			string_list_append (&strategy_options,
    + 					    "ignore-space-change");
     
      ## sequencer.c ##
     @@ sequencer.c: static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
    @@ sequencer.c: static int run_git_commit(struct repository *r,
      	argv_array_push(&cmd.args, "commit");
      
     @@ sequencer.c: static int try_to_commit(struct repository *r,
    - 		strbuf_addf(&date, "@%.*s %.*s",
    - 			    (int)(ident.date_end - ident.date_begin), ident.date_begin,
    - 			    (int)(ident.tz_end - ident.tz_begin), ident.tz_begin);
    + 			    ident.date_begin,
    + 			    (int)(ident.tz_end - ident.tz_begin),
    + 			    ident.tz_begin);
     -		res = setenv("GIT_COMMITTER_DATE", date.buf, 1);
     +		res = setenv("GIT_COMMITTER_DATE",
     +			     opts->ignore_date ? "" : date.buf, 1);
    @@ sequencer.h: struct replay_opts {
     
      ## t/t3436-rebase-more-options.sh ##
     @@ t/t3436-rebase-more-options.sh: test_expect_success '--committer-date-is-author-date works when committing confl
    - 	test_cmp expect actual
    + 	test_ctime_is_atime -1
      '
      
    -+# Checking for +0000 in author time is enough since default
    -+# timezone is UTC, but the timezone used while committing
    -+# sets to +0530.
    ++# Checking for +0000 in the author date is sufficient since the
    ++# default timezone is UTC but the timezone used while committing is
    ++# +0530. The inverted logic in the grep is necessary to check all the
    ++# author dates in the file.
    ++test_ctime_is_ignored () {
    ++	git log $1 --format=%ai >authortime &&
    ++	! grep -v +0000 authortime
    ++}
    ++
     +test_expect_success '--ignore-date works with apply backend' '
     +	git commit --amend --date="$GIT_AUTHOR_DATE" &&
     +	git rebase --apply --ignore-date HEAD^ &&
    -+	git log -1 --pretty=%ai >authortime &&
    -+	grep "+0000" authortime
    ++	test_ctime_is_ignored -1
     +'
     +
     +test_expect_success '--ignore-date works with merge backend' '
     +	git commit --amend --date="$GIT_AUTHOR_DATE" &&
     +	git rebase --ignore-date -m HEAD^ &&
    -+	git log -1 --pretty=%ai >authortime &&
    -+	grep "+0000" authortime
    ++	test_ctime_is_ignored -1
     +'
     +
     +test_expect_success '--ignore-date works after conflict resolution' '
    @@ t/t3436-rebase-more-options.sh: test_expect_success '--committer-date-is-author-
     +	echo resolved >foo &&
     +	git add foo &&
     +	git rebase --continue &&
    -+	git log -1 --pretty=%ai >authortime &&
    -+	grep +0000 authortime
    ++	test_ctime_is_ignored -1
     +'
     +
     +test_expect_success '--ignore-date works with rebase -r' '
     +	git checkout side &&
     +	git merge --no-ff commit3 &&
     +	git rebase -r --root --ignore-date &&
    -+	git log --pretty=%ai >authortime &&
    -+	! grep -v "+0000" authortime
    ++	test_ctime_is_ignored
     +'
     +
     +test_expect_success '--ignore-date with --committer-date-is-author-date works' '
    @@ t/t3436-rebase-more-options.sh: test_expect_success '--committer-date-is-author-
     +	git checkout --theirs foo &&
     +	git add foo &&
     +	git rebase --continue &&
    -+	git log -2 --pretty=%ai >authortime &&
    -+	git log -2 --pretty=%ci >committertime &&
    -+	test_cmp authortime committertime &&
    -+	! grep -v "+0000" authortime
    ++	test_ctime_is_atime -2 &&
    ++	test_ctime_is_ignored -2
     +'
     +
     +test_expect_success '--ignore-date --committer-date-is-author-date works when forking merge' '
     +	GIT_SEQUENCE_EDITOR="echo \"merge -C $(git rev-parse HEAD) commit3\">" \
    -+		git rebase -i --strategy=resolve --ignore-date \
    -+		--committer-date-is-author-date side side &&
    -+	git log -1 --pretty=%ai >authortime &&
    -+	git log -1 --pretty=%ci >committertime &&
    -+	test_cmp authortime committertime &&
    -+	grep "+0000" authortime
    ++		PATH="./test-bin:$PATH" git rebase -i --strategy=test \
    ++				--ignore-date --committer-date-is-author-date \
    ++				side side &&
    ++	test_ctime_is_atime -1 &&
    ++	test_ctime_is_ignored -1
     + '
     +
      # This must be the last test in this file
5:  a11db78eb4 ! 5:  26d5eefdcb rebase: add --reset-author-date
    @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
     +				N_("synonym of --reset-author-date")),
      		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
      				  N_("passed to 'git apply'"), 0),
    - 		OPT_BOOL(0, "ignore-whitespace", &options.ignore_whitespace,
    + 		OPT_BOOL(0, "ignore-whitespace", &ignore_whitespace,
     
      ## t/t3436-rebase-more-options.sh ##
    -@@ t/t3436-rebase-more-options.sh: test_expect_success '--committer-date-is-author-date works when committing confl
    - # Checking for +0000 in author time is enough since default
    - # timezone is UTC, but the timezone used while committing
    - # sets to +0530.
    +@@ t/t3436-rebase-more-options.sh: test_ctime_is_ignored () {
    + 	! grep -v +0000 authortime
    + }
    + 
     -test_expect_success '--ignore-date works with apply backend' '
     +test_expect_success '--reset-author-date works with apply backend' '
      	git commit --amend --date="$GIT_AUTHOR_DATE" &&
     -	git rebase --apply --ignore-date HEAD^ &&
     +	git rebase --apply --reset-author-date HEAD^ &&
    - 	git log -1 --pretty=%ai >authortime &&
    - 	grep "+0000" authortime
    + 	test_ctime_is_ignored -1
      '
      
     -test_expect_success '--ignore-date works with merge backend' '
     +test_expect_success '--reset-author-date works with merge backend' '
      	git commit --amend --date="$GIT_AUTHOR_DATE" &&
     -	git rebase --ignore-date -m HEAD^ &&
     +	git rebase --reset-author-date -m HEAD^ &&
    - 	git log -1 --pretty=%ai >authortime &&
    - 	grep "+0000" authortime
    + 	test_ctime_is_ignored -1
      '
      
     -test_expect_success '--ignore-date works after conflict resolution' '
    @@ t/t3436-rebase-more-options.sh: test_expect_success '--committer-date-is-author-
      		--onto commit2^^ commit2^ commit2 &&
      	echo resolved >foo &&
      	git add foo &&
    -@@ t/t3436-rebase-more-options.sh: test_expect_success '--ignore-date works after conflict resolution' '
    - 	grep +0000 authortime
    + 	git rebase --continue &&
    + 	test_ctime_is_ignored -1
      '
      
     -test_expect_success '--ignore-date works with rebase -r' '
    @@ t/t3436-rebase-more-options.sh: test_expect_success '--ignore-date works after c
      	git merge --no-ff commit3 &&
     -	git rebase -r --root --ignore-date &&
     +	git rebase -r --root --reset-author-date &&
    - 	git log --pretty=%ai >authortime &&
    - 	! grep -v "+0000" authortime
    + 	test_ctime_is_ignored
      '
      
     -test_expect_success '--ignore-date with --committer-date-is-author-date works' '
    @@ t/t3436-rebase-more-options.sh: test_expect_success '--ignore-date works after c
      	git checkout --theirs foo &&
      	git add foo &&
      	git rebase --continue &&
    -@@ t/t3436-rebase-more-options.sh: test_expect_success '--ignore-date with --committer-date-is-author-date works' '
    - 	! grep -v "+0000" authortime
    + 	test_ctime_is_atime -2 &&
    + 	test_ctime_is_ignored -2
      '
      
     -test_expect_success '--ignore-date --committer-date-is-author-date works when forking merge' '
     +test_expect_success '--reset-author-date --committer-date-is-author-date works when forking merge' '
      	GIT_SEQUENCE_EDITOR="echo \"merge -C $(git rev-parse HEAD) commit3\">" \
    --		git rebase -i --strategy=resolve --ignore-date \
    -+		git rebase -i --strategy=resolve --reset-author-date \
    - 		--committer-date-is-author-date side side &&
    - 	git log -1 --pretty=%ai >authortime &&
    - 	git log -1 --pretty=%ci >committertime &&
    - 	test_cmp authortime committertime &&
    - 	grep "+0000" authortime
    + 		PATH="./test-bin:$PATH" git rebase -i --strategy=test \
    +-				--ignore-date --committer-date-is-author-date \
    +-				side side &&
    ++				--reset-author-date \
    ++				--committer-date-is-author-date side side &&
    + 	test_ctime_is_atime -1 &&
    + 	test_ctime_is_ignored -1
       '
      
     +test_expect_success '--ignore-date is an alias for --reset-author-date' '
     +	git commit --amend --date="$GIT_AUTHOR_DATE" &&
     +	git rebase --apply --ignore-date HEAD^ &&
     +	git commit --allow-empty -m empty --date="$GIT_AUTHOR_DATE" &&
     +	git rebase -m --ignore-date HEAD^ &&
    -+	git log -2 --pretty="format:%ai" >authortime &&
    -+	grep "+0000" authortime >output &&
    -+	test_line_count = 2 output
    ++	test_ctime_is_ignored -2
     +'
     +
      # This must be the last test in this file
-- 
2.27.0

