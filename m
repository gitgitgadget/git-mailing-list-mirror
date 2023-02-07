Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433C7C636CC
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 10:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjBGKTw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 05:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjBGKTv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 05:19:51 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43F722016
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 02:19:48 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id q8so10656469wmo.5
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 02:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iKocahA2vsmC5PIQPoNkEwGs703WecqEtX0bFeQEY6M=;
        b=g8YyYe1k2WdnNr7Hmzfi4l6wPEzEFDR2eOYnN5qxhWF50JFdzjLzWwoQSbcBp8a5xW
         ERrBQl3LP5oSvhsjtRIFbVeJFCY1itYd6aGBQp7UnImWLWrjPv5GydY9l1Y+87TClGpt
         orwbiz4zrHsDSbaZZjJTR7o16UIlsCSAQJaK7VEK9YHDWRMFNLlHMWsfFciQlGm2RCle
         e6B+mrEH73YO+nt+vwCTFFuBGuWCGfwXpRsOqddHwCHyyFJsf9VKzFnjsU4CvPACpAyR
         9CQUFU31/JhEj3a1o2hMkW2hCIhWuEu2KX1Owd4l937vNnIg/Eyfm5vDPU2zEjrqR4bN
         TImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKocahA2vsmC5PIQPoNkEwGs703WecqEtX0bFeQEY6M=;
        b=ruZmAhllzemvbgcBDi8xX9Juu8UkeuAwco11DxuYi7Gzp/0SuWXKV3GiN/ZO6MyDLE
         UqJtlzQKDGmdjzF8FguHNBDgeC4O07xtwxMF9m1cB0molr9GHylj1fP/8ZiM5psKn1R/
         AHU+AucyzaFOs4BXoeQTpaKzSobKyIYFbeDRkTG/qNY/Lx8VBxc5Em6zNcqOlRNSZ6Tf
         OINFJjXsUYPqJQQfuiP34IjGFlS0Ca+4Qeps9rva3+Tcdl7oWZ//3ZrsyGPSOUUuIzAH
         QGdyVwWtYuRCh4VnzZoTYwbGCKcTWvhtOzxQt4iS+lUlJqGQiWKthHg2lhNgZ71EVqva
         ReDg==
X-Gm-Message-State: AO0yUKV/2jouwxKKKguePMI1KXx4/Dz6PYMVKoOs4yelHvUecq8GiWUY
        DI01GwrLL1OcnQQbEqGRPkg=
X-Google-Smtp-Source: AK7set9icjtHDKD8JbJuVqVNqdsvf4gNjRbX8xUziZebIHykt0To4Xm2ZOikoF2kh9ZRWsTOyQa00Q==
X-Received: by 2002:a05:600c:3596:b0:3df:d431:cf64 with SMTP id p22-20020a05600c359600b003dfd431cf64mr2511769wmq.39.1675765187272;
        Tue, 07 Feb 2023 02:19:47 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id i14-20020a1c540e000000b003db03725e86sm13920981wmb.8.2023.02.07.02.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 02:19:46 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <0d7919c8-f2b5-881a-bf8c-56506ada52a5@dunelm.org.uk>
Date:   Tue, 7 Feb 2023 10:19:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 0/8] sequencer API & users: fix widespread leaks
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <patch-v3-7.8-ee8262ab22a-20230118T160600Z-avarab@gmail.com>
 <cover-v4-0.8-00000000000-20230206T190346Z-avarab@gmail.com>
In-Reply-To: <cover-v4-0.8-00000000000-20230206T190346Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 06/02/2023 19:08, Ævar Arnfjörð Bjarmason wrote:
> This series fixes various widespread leaks in the sequencer and its
> users (rebase, revert, cherry-pick). As a result 18 tests become
> leak-free in their entirety.
> 
> See the v1 for a longer general summary:
> https://lore.kernel.org/git/cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com/
> 
> Changes since v3:
> 
> * Rebased for newer "master", there were some conflicts due to
>    adjacent changes.
> * Addressed Phillip's commit message comments (hopefully).

You have! Thanks for the re-roll this all looks good to me now

Best Wishes

Phillip

> Branch & CI for this at:
> https://github.com/avar/git/tree/avar/leak-fixes-sequencer-rebase-4
> 
> Ævar Arnfjörð Bjarmason (8):
>    rebase: use "cleanup" pattern in do_interactive_rebase()
>    sequencer.c: split up sequencer_remove_state()
>    sequencer API users: fix get_replay_opts() leaks
>    builtin/revert.c: move free-ing of "revs" to replay_opts_release()
>    builtin/rebase.c: fix "options.onto_name" leak
>    sequencer.c: always free() the "msgbuf" in do_pick_commit()
>    builtin/rebase.c: free() "options.strategy_opts"
>    commit.c: free() revs.commit in get_fork_point()
> 
>   builtin/rebase.c                       | 22 ++++++++------
>   builtin/revert.c                       |  8 ++---
>   commit.c                               |  1 +
>   sequencer.c                            | 42 ++++++++++++++++----------
>   sequencer.h                            |  1 +
>   t/t3405-rebase-malformed.sh            |  1 +
>   t/t3412-rebase-root.sh                 |  1 +
>   t/t3416-rebase-onto-threedots.sh       |  1 +
>   t/t3419-rebase-patch-id.sh             |  1 +
>   t/t3423-rebase-reword.sh               |  1 +
>   t/t3425-rebase-topology-merges.sh      |  2 ++
>   t/t3431-rebase-fork-point.sh           |  1 +
>   t/t3432-rebase-fast-forward.sh         |  1 +
>   t/t3437-rebase-fixup-options.sh        |  1 +
>   t/t3438-rebase-broken-files.sh         |  2 ++
>   t/t3501-revert-cherry-pick.sh          |  1 +
>   t/t3502-cherry-pick-merge.sh           |  1 +
>   t/t3503-cherry-pick-root.sh            |  1 +
>   t/t3506-cherry-pick-ff.sh              |  1 +
>   t/t3511-cherry-pick-x.sh               |  1 +
>   t/t7402-submodule-rebase.sh            |  1 +
>   t/t9106-git-svn-commit-diff-clobber.sh |  1 -
>   t/t9164-git-svn-dcommit-concurrent.sh  |  1 -
>   23 files changed, 61 insertions(+), 33 deletions(-)
> 
> Range-diff against v3:
> 1:  b223429df33 ! 1:  029fc5f4b8c rebase: use "cleanup" pattern in do_interactive_rebase()
>      @@ Commit message
>           Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>       
>        ## builtin/rebase.c ##
>      -@@ builtin/rebase.c: static void split_exec_commands(const char *cmd, struct string_list *commands)
>      +@@ builtin/rebase.c: static int init_basic_state(struct replay_opts *opts, const char *head_name,
>        
>        static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
>        {
>      @@ builtin/rebase.c: static int do_interactive_rebase(struct rebase_options *opts,
>        	}
>        
>       +cleanup:
>      - 	string_list_clear(&commands, 0);
>        	free(revisions);
>        	free(shortrevisions);
>      + 	todo_list_release(&todo_list);
> 2:  00c7f04363f = 2:  b0c9da95ca1 sequencer.c: split up sequencer_remove_state()
> 3:  e4a96898a68 ! 3:  dbac0501424 rebase & sequencer API: fix get_replay_opts() leak in "rebase"
>      @@ Metadata
>       Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>       
>        ## Commit message ##
>      -    rebase & sequencer API: fix get_replay_opts() leak in "rebase"
>      +    sequencer API users: fix get_replay_opts() leaks
>       
>      -    Make the recently added replay_opts_release() function non-static and
>      -    use it for freeing the "struct replay_opts" constructed by the
>      -    get_replay_opts() function in "builtin/rebase.c". See [1] for the
>      -    initial addition of get_replay_opts().
>      +    Make the replay_opts_release() function added in the preceding commit
>      +    non-static, and use it for freeing the "struct replay_opts"
>      +    constructed for "rebase" and "revert".
>       
>           To safely call our new replay_opts_release() we'll need to stop
>           calling it in sequencer_remove_state(), and instead call it where we
>      @@ Commit message
>           previously called sequencer_remove_state() would be a hassle.
>       
>           Using a FREE_AND_NULL() pattern would also work, as it would be safe
>      -    replay_opts_release() repeatedly, but let's fix this properly instead,
>      -    by having the owner of the data free() it.
>      -
>      -    See [2] for the initial implementation of "sequencer_remove_state()",
>      -    which assumed that it should be removing the full (including on-disk)
>      -    rebase state as a one-off.
>      -
>      -    1. 73fdc535d26 (rebase -i: use struct rebase_options to parse args,
>      -       2019-04-17)
>      -    2. 26ae337be11 (revert: Introduce --reset to remove sequencer state,
>      -       2011-08-04)
>      +    to call replay_opts_release() repeatedly. But let's fix this properly
>      +    instead, by having the owner of the data free() it.
>       
>           Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>       
>      @@ builtin/rebase.c: static int do_interactive_rebase(struct rebase_options *opts,
>        
>        cleanup:
>       +	replay_opts_release(&replay);
>      - 	string_list_clear(&commands, 0);
>        	free(revisions);
>        	free(shortrevisions);
>      + 	todo_list_release(&todo_list);
>       @@ builtin/rebase.c: static int run_sequencer_rebase(struct rebase_options *opts)
>        		struct replay_opts replay_opts = get_replay_opts(opts);
>        
> 4:  9f72cc6e46b = 4:  6b29d7d00c2 builtin/revert.c: move free-ing of "revs" to replay_opts_release()
> 5:  3d5c3152f69 ! 5:  f9c4d17fe70 builtin/rebase.c: fix "options.onto_name" leak
>      @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
>        	strbuf_release(&options.git_format_patch_opt);
>        	free(squash_onto_name);
>       +	free(keep_base_onto_name);
>      - 	string_list_clear(&exec, 0);
>        	string_list_clear(&strategy_options, 0);
>        	return !!ret;
>      + }
>       
>        ## t/t3416-rebase-onto-threedots.sh ##
>       @@ t/t3416-rebase-onto-threedots.sh: test_description='git rebase --onto A...B'
> 6:  c07dc006c6d = 6:  5c2870ed2e6 sequencer.c: always free() the "msgbuf" in do_pick_commit()
> 7:  ee8262ab22a ! 7:  07ab875c3e2 builtin/rebase.c: free() "options.strategy_opts"
>      @@ Commit message
>        ## builtin/rebase.c ##
>       @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
>        	free(options.gpg_sign_opt);
>      - 	free(options.cmd);
>      + 	string_list_clear(&options.exec, 0);
>        	free(options.strategy);
>       +	free(options.strategy_opts);
>        	strbuf_release(&options.git_format_patch_opt);
> 8:  84343ea6bf6 = 8:  6ab2edcc135 commit.c: free() revs.commit in get_fork_point()
