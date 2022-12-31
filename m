Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7F9C3DA7A
	for <git@archiver.kernel.org>; Sat, 31 Dec 2022 14:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbiLaOy6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Dec 2022 09:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiLaOy5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2022 09:54:57 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91857FD0
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 06:54:55 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso14386479wms.5
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 06:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4IgNsqetMpCq0p45upZadmdv38Tl2HxLBd4cc0itKLQ=;
        b=PwfbSRj2GVhlvi5yHRuYSkq4EOqJQQshqAVRsu1fa7B1/1ZQjj+06VcSruWRm4Z/X7
         rIMaS4WF+7DWORtJulmtTP5xjEZXhrnOR9jce8xHioLL92k3CxEp9wUxCBrZqUb0ml+X
         WrT9mBz/y+xt71Tn6Ou9QB587tEmGGl+c7wHR70jtRCLKH2QIoxgwSVh/Vp6jg7n7yBE
         sDY/btIqWY4ACOehD3wOEmdLPs87WanuQZ/MaJPw8K1sGZl6dTJXY2jJpi9KoXRd+yGm
         kYUN36RZ6wIenbxLqjpj5uPjQ7D1dxD7UwGi3hNgaf8/TkB1P16Gv3ujSk4Zrk++KYbf
         BEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IgNsqetMpCq0p45upZadmdv38Tl2HxLBd4cc0itKLQ=;
        b=TizUbSanqNgLt7K3kPg+76y3BaMtLE/zgEdNG7zRNy9jia7agB6rtJbfQ+w3EM7EzV
         KKOicTJAriUM3WWmH/Dfu8fxD0TcYaxW2tQMqOmMa3TQM9Ex1IlnU2+Z5FMfkiwzDG/1
         JWLuuxXNs2MDJqOiqyT8XXq7/EetN9aou3oEpmRnwrMuqEWg3YIP+83LmNWShf7S3Hdr
         0lHhbJ88aRY7N8dNTFzf/YBpyZpqSbbIAHRQy7ALnCX0za6zeTFovwsasoGvqHAF3OpU
         srrqY7i3zP9shnQH8EWbKnFVEk7X2dvBKvw3GjG6riTq3qh2B7QFzz03A6orkNR+p/vp
         ihKA==
X-Gm-Message-State: AFqh2koEHT1QeBBPw4labUrFj7lQ3hZ/8VjKxu71dX5lYv1cvz+j895d
        9rUDCzFhLlF7dVvM/BQ1xro=
X-Google-Smtp-Source: AMrXdXtGRFodgVrOcjY2iUxYLUxFiEqlWGQLFS1of2NirvEPzUN5ZnxpJRIMbp9NVgZxE35yujm+hQ==
X-Received: by 2002:a05:600c:4995:b0:3d3:4f43:fbc2 with SMTP id h21-20020a05600c499500b003d34f43fbc2mr25225657wmp.41.1672498494112;
        Sat, 31 Dec 2022 06:54:54 -0800 (PST)
Received: from [192.168.1.14] (host-92-2-151-214.as13285.net. [92.2.151.214])
        by smtp.gmail.com with ESMTPSA id k39-20020a05600c1ca700b003a84375d0d1sm41133275wms.44.2022.12.31.06.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Dec 2022 06:54:53 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <0fd32979-9beb-93e8-8a03-253a08588c42@dunelm.org.uk>
Date:   Sat, 31 Dec 2022 14:54:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 03/10] rebase & sequencer API: fix get_replay_opts() leak
 in "rebase"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
 <patch-03.10-3e9c4df61fe-20221230T071741Z-avarab@gmail.com>
In-Reply-To: <patch-03.10-3e9c4df61fe-20221230T071741Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 30/12/2022 07:28, Ævar Arnfjörð Bjarmason wrote:
> Make the recently added replay_opts_release() function non-static and
> use it for freeing the "struct replay_opts" constructed by the
> get_replay_opts() function in "builtin/rebase.c". See [1] for the
> initial addition of get_replay_opts().
> 
> To safely call our new replay_opts_release() we'll need to change all
> the free() to a FREE_AND_NULL(), and set "xopts_nr" to "0" after we
> loop over it and free() it (the free() in the loop doesn't need to be
> a FREE_AND_NULL()).
> 
> This is because in e.g. do_interactive_rebase() we construct a "struct
> replay_opts" with "get_replay_opts()", and then call
> "complete_action()". If we get far enough in that function without
> encountering errors we'll call "pick_commits()" which (indirectly)
> calls sequencer_remove_state() at the end.

The way to fix this is to stop calling replay_opts_release() from 
sequencer_remove_state(), then you can be sure to call 
replay_opts_release() only once by adding calls to the functions that 
initialize a "struct replay_opts". That would be much cleaner than this 
FREE_AND_NULL() hackery.

Best Wishes

Phillip

> But if we encounter errors anywhere along the way we'd punt out early,
> and not free() the memory we allocated. Remembering whether we
> previously called sequencer_remove_state() would be a hassle, so let's
> make it safe to re-invoke replay_opts_release() instead.
> 
> I experimented with a change to be more paranoid instead, i.e. to
> exhaustively check our state via an enum. We could make sure that we:
> 
> - Only allow calling "replay_opts_release()" after
>    "sequencer_remove_state()", but not the other way around.
> 
> - Forbid invoking either function twice in a row.
> 
> But such paranoia isn't warranted here, let's instead take the easy
> way out and FREE_AND_NULL() this.
> 
> See [2] for the initial implementation of "sequencer_remove_state()",
> which assumed that it should be removing the full (including on-disk)
> rebase state as a one-off.
> 
> 1. 73fdc535d26 (rebase -i: use struct rebase_options to parse args,
>     2019-04-17)
> 2. 26ae337be11 (revert: Introduce --reset to remove sequencer state,
>     2011-08-04)
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> 
> Re the "I experimented with...", the earlier version can be seen at
> https://github.com/avar/git/commit/7a150d1b7e2; It's the commit I
> linked to from
> https://lore.kernel.org/git/221108.864jv9sc9r.gmgdl@evledraar.gmail.com/
> (which is mentioned in the CL).
> 
>   builtin/rebase.c                       |  2 ++
>   sequencer.c                            | 13 +++++++------
>   sequencer.h                            |  1 +
>   t/t3405-rebase-malformed.sh            |  1 +
>   t/t3412-rebase-root.sh                 |  1 +
>   t/t3423-rebase-reword.sh               |  1 +
>   t/t3437-rebase-fixup-options.sh        |  1 +
>   t/t3438-rebase-broken-files.sh         |  2 ++
>   t/t7402-submodule-rebase.sh            |  1 +
>   t/t9106-git-svn-commit-diff-clobber.sh |  1 -
>   t/t9164-git-svn-dcommit-concurrent.sh  |  1 -
>   11 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 7141fd5e0c1..91bf55be6e6 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -301,6 +301,7 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
>   	}
>   
>   cleanup:
> +	replay_opts_release(&replay);
>   	string_list_clear(&commands, 0);
>   	free(revisions);
>   	free(shortrevisions);
> @@ -343,6 +344,7 @@ static int run_sequencer_rebase(struct rebase_options *opts)
>   		struct replay_opts replay_opts = get_replay_opts(opts);
>   
>   		ret = sequencer_continue(the_repository, &replay_opts);
> +		replay_opts_release(&replay_opts);
>   		break;
>   	}
>   	case ACTION_EDIT_TODO:
> diff --git a/sequencer.c b/sequencer.c
> index 655ae9f1a72..e29a97b6caa 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -351,15 +351,16 @@ static const char *gpg_sign_opt_quoted(struct replay_opts *opts)
>   	return buf.buf;
>   }
>   
> -static void replay_opts_release(struct replay_opts *opts)
> +void replay_opts_release(struct replay_opts *opts)
>   {
> -	free(opts->gpg_sign);
> -	free(opts->reflog_action);
> -	free(opts->default_strategy);
> -	free(opts->strategy);
> +	FREE_AND_NULL(opts->gpg_sign);
> +	FREE_AND_NULL(opts->reflog_action);
> +	FREE_AND_NULL(opts->default_strategy);
> +	FREE_AND_NULL(opts->strategy);
>   	for (size_t i = 0; i < opts->xopts_nr; i++)
>   		free(opts->xopts[i]);
> -	free(opts->xopts);
> +	opts->xopts_nr = 0;
> +	FREE_AND_NULL(opts->xopts);
>   	strbuf_release(&opts->current_fixups);
>   }
>   
> diff --git a/sequencer.h b/sequencer.h
> index 888c18aad71..3bcdfa1b586 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -158,6 +158,7 @@ int sequencer_pick_revisions(struct repository *repo,
>   int sequencer_continue(struct repository *repo, struct replay_opts *opts);
>   int sequencer_rollback(struct repository *repo, struct replay_opts *opts);
>   int sequencer_skip(struct repository *repo, struct replay_opts *opts);
> +void replay_opts_release(struct replay_opts *opts);
>   int sequencer_remove_state(struct replay_opts *opts);
>   
>   #define TODO_LIST_KEEP_EMPTY (1U << 0)
> diff --git a/t/t3405-rebase-malformed.sh b/t/t3405-rebase-malformed.sh
> index 25243318618..8979bc34073 100755
> --- a/t/t3405-rebase-malformed.sh
> +++ b/t/t3405-rebase-malformed.sh
> @@ -5,6 +5,7 @@ test_description='rebase should handle arbitrary git message'
>   GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>   export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   . "$TEST_DIRECTORY"/lib-rebase.sh
>   
> diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
> index 58371d8a547..e75b3d0e07c 100755
> --- a/t/t3412-rebase-root.sh
> +++ b/t/t3412-rebase-root.sh
> @@ -7,6 +7,7 @@ Tests if git rebase --root --onto <newparent> can rebase the root commit.
>   GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>   export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   log_with_names () {
> diff --git a/t/t3423-rebase-reword.sh b/t/t3423-rebase-reword.sh
> index 4859bb8f722..2fab703d615 100755
> --- a/t/t3423-rebase-reword.sh
> +++ b/t/t3423-rebase-reword.sh
> @@ -2,6 +2,7 @@
>   
>   test_description='git rebase interactive with rewording'
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   . "$TEST_DIRECTORY"/lib-rebase.sh
> diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
> index c023fefd681..274699dadb8 100755
> --- a/t/t3437-rebase-fixup-options.sh
> +++ b/t/t3437-rebase-fixup-options.sh
> @@ -14,6 +14,7 @@ to the "fixup" command that works with "fixup!", "fixup -C" works with
>   "amend!" upon --autosquash.
>   '
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   . "$TEST_DIRECTORY"/lib-rebase.sh
> diff --git a/t/t3438-rebase-broken-files.sh b/t/t3438-rebase-broken-files.sh
> index b92a3ce46b8..c614c4f2e4b 100755
> --- a/t/t3438-rebase-broken-files.sh
> +++ b/t/t3438-rebase-broken-files.sh
> @@ -1,6 +1,8 @@
>   #!/bin/sh
>   
>   test_description='rebase behavior when on-disk files are broken'
> +
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   test_expect_success 'set up conflicting branches' '
> diff --git a/t/t7402-submodule-rebase.sh b/t/t7402-submodule-rebase.sh
> index ebeca12a711..b19792b3269 100755
> --- a/t/t7402-submodule-rebase.sh
> +++ b/t/t7402-submodule-rebase.sh
> @@ -5,6 +5,7 @@
>   
>   test_description='Test rebasing, stashing, etc. with submodules'
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   test_expect_success setup '
> diff --git a/t/t9106-git-svn-commit-diff-clobber.sh b/t/t9106-git-svn-commit-diff-clobber.sh
> index 3cab0b9720a..bca496c40e0 100755
> --- a/t/t9106-git-svn-commit-diff-clobber.sh
> +++ b/t/t9106-git-svn-commit-diff-clobber.sh
> @@ -3,7 +3,6 @@
>   # Copyright (c) 2006 Eric Wong
>   test_description='git svn commit-diff clobber'
>   
> -TEST_FAILS_SANITIZE_LEAK=true
>   . ./lib-git-svn.sh
>   
>   test_expect_success 'initialize repo' '
> diff --git a/t/t9164-git-svn-dcommit-concurrent.sh b/t/t9164-git-svn-dcommit-concurrent.sh
> index 1465156072e..c8e6c0733f4 100755
> --- a/t/t9164-git-svn-dcommit-concurrent.sh
> +++ b/t/t9164-git-svn-dcommit-concurrent.sh
> @@ -5,7 +5,6 @@
>   
>   test_description='concurrent git svn dcommit'
>   
> -TEST_FAILS_SANITIZE_LEAK=true
>   . ./lib-git-svn.sh
>   
>   
