Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC71C433DF
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 10:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10562206C3
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 10:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLjCRKok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgFAKd4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Jun 2020 06:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgFAKdz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jun 2020 06:33:55 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B91C061A0E
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 03:33:53 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l26so10184125wme.3
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 03:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xke8hKTVfL2w7XasIGwv3QOxQhHQYNGlDXzHasTctVA=;
        b=ZLjCRKokTgjJcsXiaWctMv/lbu+9DLFNeKaU7cJssdkH4rH/jZ/R/UFZUcxXBfMJLZ
         FcbiKTXwoDIRFMn6fDEh0tJeYEvn4OVMbFedsAaFF2UC1A9qpDQxl5Sg2B0EU5hMCkSr
         /BZ4atov66y+3bgjdXBQ1s1jrnSy0gd2P1562ACgLbOdLN4re+iWEwNfrrS25rfCBBHg
         qFehHv22gGYs2qsKNfR32DlhDEgvx/wXY05aeqWTpLruvCXxoJb7Uv4ltNyuirYnkDx+
         fC7U3aKKcAZtLeLJAv/N70lVsFwzrTPMaFu/H06N6qrX1QTP0XEg1XxeUBiuLRBhGlC1
         Y9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xke8hKTVfL2w7XasIGwv3QOxQhHQYNGlDXzHasTctVA=;
        b=oov8cpYsIkMu896mdyUo76C5fNSJzzCnqXeQOp+8Wz/nge65Ehvyu7oINLTMgr76+X
         2AsvbKqRapxgWAXXDrA4vWTqdWnXC9XTWUU+cIRBJP+YtAItFhBe/itrDjZYZuM42UD2
         vWK+XlQjd6WWlNCr6DmUDeYljufyu5cYVVX9eCkeHNwUrrXCOzUSerDLqqXpSgRagqxK
         zM2f6PxLfk5+ZhS2Aj1yIZbM4VayIzFj4I5U9uVbgErZT8ktEXYXA/X53juwVNDnkhtk
         YQRJy0v2Mw4nwyxRX+NHcQK+XnbkWFOfp0gmKg/qP1iwlVQREQZfYDhsbUSbSmLeYIoj
         ce/Q==
X-Gm-Message-State: AOAM532LOj+v85wz+LHeJiSGQN5286M3swh5O3ypr/LGMGFz1iJKv1OU
        a3vL6C9yIEpfnpayam5zhYre1uw4
X-Google-Smtp-Source: ABdhPJxJ8/eXoD0Vo5OSnPJSosG9D9vkToKg9itOh3Ruk3eZzyh07TUEYaOE77UFyOILDPQ/4o8lLA==
X-Received: by 2002:a1c:f712:: with SMTP id v18mr20846610wmh.27.1591007632147;
        Mon, 01 Jun 2020 03:33:52 -0700 (PDT)
Received: from [192.168.1.201] (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.googlemail.com with ESMTPSA id t13sm20440175wrn.64.2020.06.01.03.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 03:33:51 -0700 (PDT)
Subject: Re: [PATCH v4 2/5] rebase -i: support --committer-date-is-author-date
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200527173356.47364-1-phillip.wood123@gmail.com>
 <20200527173356.47364-3-phillip.wood123@gmail.com>
 <nycvar.QRO.7.76.6.2005290439030.56@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <eb1d1067-ad1e-167e-747e-b04debf7d844@gmail.com>
Date:   Mon, 1 Jun 2020 11:33:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2005290439030.56@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi dscho

On 29/05/2020 03:52, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Wed, 27 May 2020, Phillip Wood wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> As part of the on-going effort to retire the apply rebase backend teach
>> the merge backend how to handle --committer-date-is-author-date.
> 
> I forgot to mention this in my reply to the first patch in this series: it
> strikes me as a mis-characterization that the `apply` backend is about to
> be retired. What _is_ true is that the `merge` backend is the default
> backend, and what is even more true is that it is cumbersome if certain
> `rebase` options cannot be combined because they are only implemented by
> one of both rebase backends.

I'm not trying to imply that the apply backend is about to be retired
but it is the long term plan to get rid of it isn't it?

> 
>>
>> Original-patch-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>  Documentation/git-rebase.txt           | 10 +++--
>>  builtin/rebase.c                       | 16 ++++---
>>  sequencer.c                            | 59 +++++++++++++++++++++++++-
>>  sequencer.h                            |  1 +
>>  t/t3422-rebase-incompatible-options.sh |  1 -
>>  t/t3436-rebase-more-options.sh         | 56 ++++++++++++++++++++++++
>>  6 files changed, 133 insertions(+), 10 deletions(-)
>>
>> diff --git a/builtin/rebase.c b/builtin/rebase.c
>> index 5d8e117276..357cd6acf3 100644
>> --- a/builtin/rebase.c
>> +++ b/builtin/rebase.c
>> @@ -89,6 +89,7 @@ struct rebase_options {
>>  	int ignore_whitespace;
>>  	char *gpg_sign_opt;
>>  	int autostash;
>> +	int committer_date_is_author_date;
>>  	char *cmd;
>>  	int allow_empty_message;
>>  	int rebase_merges, rebase_cousins;
>> @@ -126,6 +127,8 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
>>  	replay.quiet = !(opts->flags & REBASE_NO_QUIET);
>>  	replay.verbose = opts->flags & REBASE_VERBOSE;
>>  	replay.reschedule_failed_exec = opts->reschedule_failed_exec;
>> +	replay.committer_date_is_author_date =
>> +					opts->committer_date_is_author_date;
>>  	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
>>  	replay.strategy = opts->strategy;
>>
>> @@ -1003,6 +1006,8 @@ static int run_am(struct rebase_options *opts)
>>
>>  	if (opts->ignore_whitespace)
>>  		argv_array_push(&am.args, "--ignore-whitespace");
>> +	if (opts->committer_date_is_author_date)
>> +		argv_array_push(&opts->git_am_opts, "--committer-date-is-author-date");
> 
> As before, I would rather see this in `cmd__rebase()` rahn in `run_am()`.

Right I'll take a look at that

>>  	if (opts->action && !strcmp("continue", opts->action)) {
>>  		argv_array_push(&am.args, "--resolved");
>>  		argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
>> @@ -1507,9 +1512,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>>  			PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
>>  		OPT_BOOL(0, "signoff", &options.signoff,
>>  			 N_("add a Signed-off-by: line to each commit")),
>> -		OPT_PASSTHRU_ARGV(0, "committer-date-is-author-date",
>> -				  &options.git_am_opts, NULL,
>> -				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
>> +		OPT_BOOL(0, "committer-date-is-author-date",
>> +			 &options.committer_date_is_author_date,
>> +			 N_("make committer date match author date")),
>>  		OPT_PASSTHRU_ARGV(0, "ignore-date", &options.git_am_opts, NULL,
>>  				  N_("passed to 'git am'"), PARSE_OPT_NOARG),
>>  		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
>> @@ -1804,11 +1809,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>>  	    options.autosquash) {
>>  		allow_preemptive_ff = 0;
>>  	}
>> +	if (options.committer_date_is_author_date)
>> +		options.flags |= REBASE_FORCE;
>>
>>  	for (i = 0; i < options.git_am_opts.argc; i++) {
>>  		const char *option = options.git_am_opts.argv[i], *p;
>> -		if (!strcmp(option, "--committer-date-is-author-date") ||
>> -		    !strcmp(option, "--ignore-date") ||
>> +		if (!strcmp(option, "--ignore-date") ||
>>  		    !strcmp(option, "--whitespace=fix") ||
>>  		    !strcmp(option, "--whitespace=strip"))
>>  			allow_preemptive_ff = 0;
>> diff --git a/sequencer.c b/sequencer.c
>> index 6fd2674632..8826c6325b 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -149,6 +149,7 @@ static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
>>   * command-line.
>>   */
>>  static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
>> +static GIT_PATH_FUNC(rebase_path_cdate_is_adate, "rebase-merge/cdate_is_adate")
>>  static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
>>  static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
>>  static GIT_PATH_FUNC(rebase_path_quiet, "rebase-merge/quiet")
>> @@ -872,6 +873,22 @@ static char *get_author(const char *message)
>>  	return NULL;
>>  }
>>
>> +static const char *author_date_from_env_array(const struct argv_array *env)
>> +{
>> +	int i;
>> +	const char *date;
>> +
>> +	for (i = 0; i < env->argc; i++)
>> +		if (skip_prefix(env->argv[i],
>> +				"GIT_AUTHOR_DATE=", &date))
>> +			return date;
>> +	/*
>> +	 * If GIT_AUTHOR_DATE is missing we should have already errored out when
>> +	 * reading the script
>> +	 */
>> +	BUG("GIT_AUTHOR_DATE missing from author script");
>> +}
>> +
>>  static const char staged_changes_advice[] =
>>  N_("you have staged changes in your working tree\n"
>>  "If these changes are meant to be squashed into the previous commit, run:\n"
>> @@ -938,6 +955,10 @@ static int run_git_commit(struct repository *r,
>>  			     gpg_opt, gpg_opt);
>>  	}
>>
>> +	if (opts->committer_date_is_author_date)
>> +		argv_array_pushf(&cmd.env_array, "GIT_COMMITTER_DATE=%s",
>> +				 author_date_from_env_array(&cmd.env_array));
>> +
>>  	argv_array_push(&cmd.args, "commit");
>>
>>  	if (!(flags & VERIFY_MSG))
>> @@ -1349,6 +1370,30 @@ static int try_to_commit(struct repository *r,
>>  		commit_list_insert(current_head, &parents);
>>  	}
>>
>> +	if (opts->committer_date_is_author_date) {
>> +		int len = strlen(author);
> 
> Given that `len` is used only once, is this local variable really
> necessary? You could just as well pass `(int)strlen(author)` in the
> `split_ident_line()` call below.

I wonder if it makes the `split_ident_line()` line too long, I'll take a
look.

>> +		struct ident_split ident;
>> +		struct strbuf date = STRBUF_INIT;
>> +
>> +		if (split_ident_line(&ident, author, len) < 0) {
>> +			res = error(_("malformed ident line '%s'"), author);
>> +			goto out;
>> +		}
>> +		if (!ident.date_begin) {
>> +			res = error(_("corrupted author without date information"));
>> +			goto out;
>> +		}
>> +
>> +		strbuf_addf(&date, "@%.*s %.*s",
>> +			    (int)(ident.date_end - ident.date_begin), ident.date_begin,
>> +			    (int)(ident.tz_end - ident.tz_begin), ident.tz_begin);
>> +		res = setenv("GIT_COMMITTER_DATE", date.buf, 1);
>> +		strbuf_release(&date);
> 
> It might be easier to read if it was written this way:
> 
> 		if (split_ident_line(...) < 0)
> 			res = ...
> 		else if (!ident.date_begin)
> 			res = ...
> 		else {
> 			strbuf_addf(...)
> 			res = ...
> 			strbuf_release(&date);
> 		}
> 
> 		if (res)
> 			goto out;

I'm not sure. The current style of "if there's an error goto out" makes
the control flow clear without having to reason ones way through a
series of else ifs

>> +
>> +		if (res)
>> +			goto out;
>> +	}
>> +
>>  	if (write_index_as_tree(&tree, r->index, r->index_file, 0, NULL)) {
>>  		res = error(_("git write-tree failed to write a tree"));
>>  		goto out;
>> @@ -2532,6 +2577,11 @@ static int read_populate_opts(struct replay_opts *opts)
>>  			opts->signoff = 1;
>>  		}
>>
>> +		if (file_exists(rebase_path_cdate_is_adate())) {
>> +			opts->allow_ff = 0;
>> +			opts->committer_date_is_author_date = 1;
>> +		}
>> +
>>  		if (file_exists(rebase_path_reschedule_failed_exec()))
>>  			opts->reschedule_failed_exec = 1;
>>
>> @@ -2622,6 +2672,8 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
>>  		write_file(rebase_path_drop_redundant_commits(), "%s", "");
>>  	if (opts->keep_redundant_commits)
>>  		write_file(rebase_path_keep_redundant_commits(), "%s", "");
>> +	if (opts->committer_date_is_author_date)
>> +		write_file(rebase_path_cdate_is_adate(), "%s", "");
>>  	if (opts->reschedule_failed_exec)
>>  		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
>>
>> @@ -3542,6 +3594,10 @@ static int do_merge(struct repository *r,
>>  			goto leave_merge;
>>  		}
>>
>> +		if (opts->committer_date_is_author_date)
>> +			argv_array_pushf(&cmd.env_array, "GIT_COMMITTER_DATE=%s",
>> +					 author_date_from_env_array(&cmd.env_array));
>> +
>>  		cmd.git_cmd = 1;
>>  		argv_array_push(&cmd.args, "merge");
>>  		argv_array_push(&cmd.args, "-s");
>> @@ -3819,7 +3875,8 @@ static int pick_commits(struct repository *r,
>>  	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
>>  	if (opts->allow_ff)
>>  		assert(!(opts->signoff || opts->no_commit ||
>> -				opts->record_origin || opts->edit));
>> +				opts->record_origin || opts->edit ||
>> +				opts->committer_date_is_author_date));
>>  	if (read_and_refresh_cache(r, opts))
>>  		return -1;
>>
>> diff --git a/sequencer.h b/sequencer.h
>> index 0bee85093e..4ab94119ae 100644
>> --- a/sequencer.h
>> +++ b/sequencer.h
>> @@ -45,6 +45,7 @@ struct replay_opts {
>>  	int verbose;
>>  	int quiet;
>>  	int reschedule_failed_exec;
>> +	int committer_date_is_author_date;
>>
>>  	int mainline;
>>
>> diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
>> index 55ca46786d..c8234062c6 100755
>> --- a/t/t3422-rebase-incompatible-options.sh
>> +++ b/t/t3422-rebase-incompatible-options.sh
>> @@ -61,7 +61,6 @@ test_rebase_am_only () {
>>  }
>>
>>  test_rebase_am_only --whitespace=fix
>> -test_rebase_am_only --committer-date-is-author-date
>>  test_rebase_am_only -C4
>>
>>  test_expect_success REBASE_P '--preserve-merges incompatible with --signoff' '
>> diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
>> index fb5e747e86..7e68fb9753 100755
>> --- a/t/t3436-rebase-more-options.sh
>> +++ b/t/t3436-rebase-more-options.sh
>> @@ -9,6 +9,9 @@ test_description='tests to ensure compatibility between am and interactive backe
>>
>>  . "$TEST_DIRECTORY"/lib-rebase.sh
>>
>> +GIT_AUTHOR_DATE="1999-04-02T08:03:20+05:30"
>> +export GIT_AUTHOR_DATE
>> +
>>  # This is a special case in which both am and interactive backends
>>  # provide the same output. It was done intentionally because
>>  # both the backends fall short of optimal behaviour.
>> @@ -28,8 +31,13 @@ test_expect_success 'setup' '
>>  	EOF
>>  	git commit -am "update file" &&
>>  	git tag side &&
>> +	test_commit commit1 foo foo1 &&
>> +	test_commit commit2 foo foo2 &&
>> +	test_commit commit3 foo foo3 &&
>>
>>  	git checkout --orphan master &&
>> +	git rm --cached foo &&
>> +	rm foo &&
>>  	sed -e "s/^|//" >file <<-\EOF &&
>>  	|line 1
>>  	|        line 2
>> @@ -78,6 +86,54 @@ test_expect_success '--ignore-whitespace is remembered when continuing' '
>>  	test_cmp expect file
>>  '
>>
>> +test_expect_success '--committer-date-is-author-date works with apply backend' '
>> +	GIT_AUTHOR_DATE="@1234 +0300" git commit --amend --reset-author &&
>> +	git rebase --apply --committer-date-is-author-date HEAD^ &&
>> +	git log -1 --pretty=%ai >authortime &&
>> +	git log -1 --pretty=%ci >committertime &&
>> +	test_cmp authortime committertime
> 
> This seems to be a repeated pattern. To dry it up, it would make sense to
> do this:
> 
> 	test_ctime_is_atime () {
> 		git log -1 --pretty=%ai >authortime &&
> 		git log -1 --pretty=%ci >committertime &&
> 		test_cmp authortime committertime
> 	}

Good suggestion (though we need to parametrize the -1 so we can use it
with the rebase --root cases)

Thanks

Phillip

> 
> Ciao,
> Dscho
> 
>> +'
>> +
>> +test_expect_success '--committer-date-is-author-date works with merge backend' '
>> +	GIT_AUTHOR_DATE="@1234 +0300" git commit --amend --reset-author &&
>> +	git rebase -m --committer-date-is-author-date HEAD^ &&
>> +	git log -1 --pretty=%ai >authortime &&
>> +	git log -1 --pretty=%ci >committertime &&
>> +	test_cmp authortime committertime
>> +'
>> +
>> +test_expect_success '--committer-date-is-author-date works with rebase -r' '
>> +	git checkout side &&
>> +	GIT_AUTHOR_DATE="@1234 +0300" git merge --no-ff commit3 &&
>> +	git rebase -r --root --committer-date-is-author-date &&
>> +	git log --pretty=%ai >authortime &&
>> +	git log --pretty=%ci >committertime &&
>> +	test_cmp authortime committertime
>> +'
>> +
>> +test_expect_success '--committer-date-is-author-date works when forking merge' '
>> +	git checkout side &&
>> +	GIT_AUTHOR_DATE="@1234 +0300" git merge --no-ff commit3 &&
>> +	git rebase -r --root --strategy=resolve --committer-date-is-author-date &&
>> +	git log --pretty=%ai >authortime &&
>> +	git log --pretty=%ci >committertime &&
>> +	test_cmp authortime committertime
>> +
>> +'
>> +
>> +test_expect_success '--committer-date-is-author-date works when committing conflict resolution' '
>> +	git checkout commit2 &&
>> +	GIT_AUTHOR_DATE="@1980 +0000" git commit --amend --only --reset-author &&
>> +	git log -1 --format=%at HEAD >expect &&
>> +	test_must_fail git rebase -m --committer-date-is-author-date \
>> +		--onto HEAD^^ HEAD^ &&
>> +	echo resolved > foo &&
>> +	git add foo &&
>> +	git rebase --continue &&
>> +	git log -1 --format=%ct HEAD >actual &&
>> +	test_cmp expect actual
>> +'
>> +
>>  # This must be the last test in this file
>>  test_expect_success '$EDITOR and friends are unchanged' '
>>  	test_editor_unchanged
>> --
>> 2.26.2
>>
>>

