Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A243FC433E0
	for <git@archiver.kernel.org>; Thu, 14 May 2020 09:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F50B206A5
	for <git@archiver.kernel.org>; Thu, 14 May 2020 09:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giwU6QKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgENJrv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 05:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725935AbgENJrv (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 14 May 2020 05:47:51 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20DEC061A0C
        for <git@vger.kernel.org>; Thu, 14 May 2020 02:47:50 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i15so2997492wrx.10
        for <git@vger.kernel.org>; Thu, 14 May 2020 02:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DZaUVTJ5z6MzpuY7hKu5zJRp6t9j+DchVMEBY7C4qsc=;
        b=giwU6QKWBJiYsAC1uODgGKnEW5mRRbTbqSybdbeNwVWSBIEXMwmYI/LnmKf9ieU63d
         6h0pWqyo+fo3fKsUefbwpqwXvbFGqVMsh4wwoodAzsYElR6l2P3e+TAp8DwZKKKjlpFL
         e7wT5k6tfwKDKVNUxnb9fZsJBMXoXD8nXKHY9ZMaa0f84o1pM/sq/AQqId2Gc5VIO7es
         sKS0yueq6IuQr/9VY/4NxCNKmBWeAIyJBbym4OHJHcAeVD1/kKR7UP0IG/F0Xd/lTpJZ
         KUi6gVKPH2IcmxP4lSBVqXC5B3ETi8hmhycV5hJcX8OGVL6T9aH9cFab2m/4U1zEUlTv
         IAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DZaUVTJ5z6MzpuY7hKu5zJRp6t9j+DchVMEBY7C4qsc=;
        b=nqlBb9lBbZnGtKajP+aazhDhfeqoqRtU07Bhvz7n5fMx3pdvdlsjL5CrSxHitIXeuH
         MXHFRTJF/H0xp3mSKa9Tuf8mdXwOEK69HUpS81bOUwZI+Fcg7MElbDYxDAyvCjTeMu5s
         G8hABQllde3S5I7RlhCH8OmjgXayO0+2wokLpySzTMJNmpfK9QbrCLr/+TvGkq91CQ4Q
         tiqE9fpSz5JEPxuh8xQo1lzbo3TNGVJcX3MI34+YIr//e+IN2axIq3gyR4PU9LUZdjZp
         oOBGsTDDfnyYo5MOtyb9vDRYygyuAeFbmaRV35HOVILyEqKxl+4VsVYds5osJ9iVzhCQ
         xiIg==
X-Gm-Message-State: AOAM533lNDceaNrtunp+1Cw1BelTAW20QEjxa0OsUq788noFDDQb5Yjc
        TXx6lM2DUxXPRWjX8Q8ZZX7rzgwo
X-Google-Smtp-Source: ABdhPJyeJe5XIeOb6WmBiYTRNHMrZ8RppwvQzXrT33XafEYZETzEhm85Rqu2Cg5wIshmUE93Qbmf3A==
X-Received: by 2002:a5d:400f:: with SMTP id n15mr4671715wrp.419.1589449668997;
        Thu, 14 May 2020 02:47:48 -0700 (PDT)
Received: from [192.168.1.201] (155.20.198.146.dyn.plus.net. [146.198.20.155])
        by smtp.googlemail.com with ESMTPSA id 89sm3352743wrj.37.2020.05.14.02.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 02:47:48 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] rebase -i: add --ignore-whitespace flag
To:     Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
 <20200429102521.47995-1-phillip.wood123@gmail.com>
 <20200429102521.47995-2-phillip.wood123@gmail.com>
 <CABPp-BG+nWR9S9fw=_0XV8GA5JRAKaL2TZUU578PQkW8f_z7ew@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <c3dad0e2-e381-499a-af02-ef3f49207c49@gmail.com>
Date:   Thu, 14 May 2020 10:47:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BG+nWR9S9fw=_0XV8GA5JRAKaL2TZUU578PQkW8f_z7ew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/05/2020 04:54, Elijah Newren wrote:
> Sorry for taking so long to get back to you, and thanks for pushing
> this forward.

Thanks for taking a look at this series

> 
> On Wed, Apr 29, 2020 at 3:26 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> From: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
>>
>> Rebase is implemented with two different backends - 'apply' and 'merge'
>> each of which support a different set of options. In particuar the apply
>> backend supports a number of options implemented by 'git am' that are
>> not available to the merge backend. As part of an on going effort to
>> remove the apply backend this patch adds support for the
>> --ignore-whitespace option to the merge backend. This option treats
>> lines with only whitespace changes as unchanged and is implemented in
>> the merge backend by translating it to -Xignore-space-change.
>>
>> Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> [...]

>> ---
>>  Documentation/git-rebase.txt           | 12 +++-
>>  builtin/rebase.c                       | 19 ++++--
>>  t/t3422-rebase-incompatible-options.sh |  1 -
>>  t/t3436-rebase-more-options.sh         | 86 ++++++++++++++++++++++++++
>>  4 files changed, 111 insertions(+), 7 deletions(-)
>>  create mode 100755 t/t3436-rebase-more-options.sh
>>
>> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
>> index f7a6033607..d060c143e6 100644
>> --- a/Documentation/git-rebase.txt
>> +++ b/Documentation/git-rebase.txt
>> @@ -422,8 +422,16 @@ your branch contains commits which were dropped, this option can be used
>>  with `--keep-base` in order to drop those commits from your branch.
>>
>>  --ignore-whitespace::
>> +       Behaves differently depending on which backend is selected.
> 
> I still don't like this wording; it defers answering the question,
> implies that the difference is intentional, and most importantly
> provides no context about *intended* behavior.  I tried to communicate
> this to Rohit multiple times, but he seemed to fixate on and highlight
> the differences in a way that made them sound like they were by
> design, rather than highlighting the intent we want to move towards
> and mentioning that this patch gets us most the way there.
> 
> As far as I can tell, the --ignore-whitespace and
> -Xignore-space-change were always meant to do the same thing: ignore
> differences in whitespace when doing so can avoid conflicts.
> 
> In case anyone isn't sure about my assertion that these were always
> meant to do the same thing:
>   * apply aliases --ignore-whitespace and --ignore-space-change; they
> meant the same thing
>   * commit f008cef4ab ("Merge branch 'jc/apply-ignore-whitespace'",
> 2014-06-03) says that apply's --ignore-space-change wasn't behaving
> consistently with diff's --ignore-space-change
>   * diff's --ignore-space-change goes through xdiff's XDL opts, much
> like merge-recursive does.
> Further, the original commit that introduced these xdiff options to
> merge-recursive, 4e5dd044c6 ("merge-recursive: options to ignore
> whitespace changes", 2010-08-26), it is clear that:
>   * he only cared about ignore-space-at-eol and implemented
> ignore-space-change at the same time only for completeness
>   * it wouldn't matter to his usecase if whitespace-only changes were
> stripped, thus he wouldn't have spotted the bug it has
>   * the wording also suggests these options were picked to match
> options of the same name elsewhere in git
> 
> I would rather we said something like:
>     Ignore whitespace differences when trying to reconcile
> differences.  Currently, each backend implements an approximation of
> this behavior:
> 
>> ++
>> +apply backend: When applying a patch, ignore changes in whitespace in
>> +context lines.
> 
> Maybe add something like:
>     (Unfortunately, this means that if the "old" lines being replaced
> by the patch differ only in whitespace from the existing file, you
> will get a merge conflict instead of a successful patch application.)
> 
>> ++
>> +merge backend: Treat lines with only whitespace changes as unchanged
>> +when merging.
> 
> Maybe add something like:
>    (Unfortunately, this means that any patch hunks that were intended
> to modify whitespace and nothing else will be dropped, even if the
> other side had no changes that conflicted.)

Thanks for the suggestions, I'll incorporate them into the re-roll.

Best Wishes

Phillip

>> +
>>  --whitespace=<option>::
>> -       These flags are passed to the 'git apply' program
>> +       This flag is passed to the 'git apply' program
>>         (see linkgit:git-apply[1]) that applies the patch.
>>         Implies --apply.
>>  +
>> @@ -572,7 +580,6 @@ The following options:
>>   * --apply
>>   * --committer-date-is-author-date
>>   * --ignore-date
>> - * --ignore-whitespace
>>   * --whitespace
>>   * -C
>>
>> @@ -598,6 +605,7 @@ In addition, the following pairs of options are incompatible:
>>   * --preserve-merges and --signoff
>>   * --preserve-merges and --rebase-merges
>>   * --preserve-merges and --empty=
>> + * --preserve-merges and --ignore-whitespace
>>   * --keep-base and --onto
>>   * --keep-base and --root
>>
>> diff --git a/builtin/rebase.c b/builtin/rebase.c
>> index 27a07d4e78..5d8e117276 100644
>> --- a/builtin/rebase.c
>> +++ b/builtin/rebase.c
>> @@ -86,6 +86,7 @@ struct rebase_options {
>>         int signoff;
>>         int allow_rerere_autoupdate;
>>         int autosquash;
>> +       int ignore_whitespace;
>>         char *gpg_sign_opt;
>>         int autostash;
>>         char *cmd;
>> @@ -108,6 +109,7 @@ struct rebase_options {
>>
>>  static struct replay_opts get_replay_opts(const struct rebase_options *opts)
>>  {
>> +       struct strbuf strategy_buf = STRBUF_INIT;
>>         struct replay_opts replay = REPLAY_OPTS_INIT;
>>
>>         replay.action = REPLAY_INTERACTIVE_REBASE;
>> @@ -126,14 +128,20 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
>>         replay.reschedule_failed_exec = opts->reschedule_failed_exec;
>>         replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
>>         replay.strategy = opts->strategy;
>> +
>>         if (opts->strategy_opts)
>> -               parse_strategy_opts(&replay, opts->strategy_opts);
>> +               strbuf_addstr(&strategy_buf, opts->strategy_opts);
>> +       if (opts->ignore_whitespace)
>> +               strbuf_addstr(&strategy_buf, " --ignore-space-change");
>> +       if (strategy_buf.len)
>> +               parse_strategy_opts(&replay, strategy_buf.buf);
>>
>>         if (opts->squash_onto) {
>>                 oidcpy(&replay.squash_onto, opts->squash_onto);
>>                 replay.have_squash_onto = 1;
>>         }
>>
>> +       strbuf_release(&strategy_buf);
>>         return replay;
>>  }
>>
>> @@ -539,6 +547,8 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
>>         argc = parse_options(argc, argv, prefix, options,
>>                         builtin_rebase_interactive_usage, PARSE_OPT_KEEP_ARGV0);
>>
>> +       opts.strategy_opts = xstrdup_or_null(opts.strategy_opts);
>> +
>>         if (!is_null_oid(&squash_onto))
>>                 opts.squash_onto = &squash_onto;
>>
>> @@ -991,6 +1001,8 @@ static int run_am(struct rebase_options *opts)
>>         am.git_cmd = 1;
>>         argv_array_push(&am.args, "am");
>>
>> +       if (opts->ignore_whitespace)
>> +               argv_array_push(&am.args, "--ignore-whitespace");
>>         if (opts->action && !strcmp("continue", opts->action)) {
>>                 argv_array_push(&am.args, "--resolved");
>>                 argv_array_pushf(&am.args, "--resolvemsg=%s", resolvemsg);
>> @@ -1495,16 +1507,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>>                         PARSE_OPT_NOARG, NULL, REBASE_DIFFSTAT },
>>                 OPT_BOOL(0, "signoff", &options.signoff,
>>                          N_("add a Signed-off-by: line to each commit")),
>> -               OPT_PASSTHRU_ARGV(0, "ignore-whitespace", &options.git_am_opts,
>> -                                 NULL, N_("passed to 'git am'"),
>> -                                 PARSE_OPT_NOARG),
>>                 OPT_PASSTHRU_ARGV(0, "committer-date-is-author-date",
>>                                   &options.git_am_opts, NULL,
>>                                   N_("passed to 'git am'"), PARSE_OPT_NOARG),
>>                 OPT_PASSTHRU_ARGV(0, "ignore-date", &options.git_am_opts, NULL,
>>                                   N_("passed to 'git am'"), PARSE_OPT_NOARG),
>>                 OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
>>                                   N_("passed to 'git apply'"), 0),
>> +               OPT_BOOL(0, "ignore-whitespace", &options.ignore_whitespace,
>> +                        N_("ignore changes in whitespace")),
>>                 OPT_PASSTHRU_ARGV(0, "whitespace", &options.git_am_opts,
>>                                   N_("action"), N_("passed to 'git apply'"), 0),
>>                 OPT_BIT('f', "force-rebase", &options.flags,
>> diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
>> index 50e7960702..55ca46786d 100755
>> --- a/t/t3422-rebase-incompatible-options.sh
>> +++ b/t/t3422-rebase-incompatible-options.sh
>> @@ -61,7 +61,6 @@ test_rebase_am_only () {
>>  }
>>
>>  test_rebase_am_only --whitespace=fix
>> -test_rebase_am_only --ignore-whitespace
>>  test_rebase_am_only --committer-date-is-author-date
>>  test_rebase_am_only -C4
>>
>> diff --git a/t/t3436-rebase-more-options.sh b/t/t3436-rebase-more-options.sh
>> new file mode 100755
>> index 0000000000..fb5e747e86
>> --- /dev/null
>> +++ b/t/t3436-rebase-more-options.sh
>> @@ -0,0 +1,86 @@
>> +#!/bin/sh
>> +#
>> +# Copyright (c) 2019 Rohit Ashiwal
>> +#
>> +
>> +test_description='tests to ensure compatibility between am and interactive backends'
>> +
>> +. ./test-lib.sh
>> +
>> +. "$TEST_DIRECTORY"/lib-rebase.sh
>> +
>> +# This is a special case in which both am and interactive backends
>> +# provide the same output. It was done intentionally because
>> +# both the backends fall short of optimal behaviour.
>> +test_expect_success 'setup' '
>> +       git checkout -b topic &&
>> +       q_to_tab >file <<-\EOF &&
>> +       line 1
>> +       Qline 2
>> +       line 3
>> +       EOF
>> +       git add file &&
>> +       git commit -m "add file" &&
>> +       cat >file <<-\EOF &&
>> +       line 1
>> +       new line 2
>> +       line 3
>> +       EOF
>> +       git commit -am "update file" &&
>> +       git tag side &&
>> +
>> +       git checkout --orphan master &&
>> +       sed -e "s/^|//" >file <<-\EOF &&
>> +       |line 1
>> +       |        line 2
>> +       |line 3
>> +       EOF
>> +       git add file &&
>> +       git commit -m "add file" &&
>> +       git tag main
>> +'
>> +
>> +test_expect_success '--ignore-whitespace works with apply backend' '
>> +       cat >expect <<-\EOF &&
>> +       line 1
>> +       new line 2
>> +       line 3
>> +       EOF
>> +       test_must_fail git rebase --apply main side &&
>> +       git rebase --abort &&
>> +       git rebase --apply --ignore-whitespace main side &&
>> +       test_cmp expect file
>> +'
>> +
>> +test_expect_success '--ignore-whitespace works with merge backend' '
>> +       cat >expect <<-\EOF &&
>> +       line 1
>> +       new line 2
>> +       line 3
>> +       EOF
>> +       test_must_fail git rebase --merge main side &&
>> +       git rebase --abort &&
>> +       git rebase --merge --ignore-whitespace main side &&
>> +       test_cmp expect file
>> +'
>> +
>> +test_expect_success '--ignore-whitespace is remembered when continuing' '
>> +       cat >expect <<-\EOF &&
>> +       line 1
>> +       new line 2
>> +       line 3
>> +       EOF
>> +       (
>> +               set_fake_editor &&
>> +               FAKE_LINES="break 1" git rebase -i --ignore-whitespace main side
>> +       ) &&
>> +       git rebase --continue &&
>> +       test_cmp expect file
>> +'
>> +
>> +# This must be the last test in this file
>> +test_expect_success '$EDITOR and friends are unchanged' '
>> +       test_editor_unchanged
>> +'
>> +
>> +test_done
>> --
>> 2.26.2
> 
> The rest looks good to me.
> 

