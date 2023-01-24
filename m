Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF2BC54E94
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 14:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbjAXOm2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 09:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233936AbjAXOm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 09:42:26 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3AC4A21E
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 06:41:59 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id kt14so39621391ejc.3
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 06:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+zN3mZVfmvdghfdSemRN/1yWF6njTrsJKWk33bMEFE0=;
        b=NTS6GB1Bfvc11gXTe08iUM7kMX7ubK7ckW9hgZCyL62r9rVmV3FJEbk5IIsKCcDhI5
         K0CI6lAOCV4xqbiG2ADopRf3jUA4PMp4DPTTwGCN+eEvaMIfST9u6fEO+RptEYNSm+1J
         aH42gcE3T1OyP7li+tyfvv6f+hf59R3tUUPurbm/hC5BawWibQBAaOnWQtO6v+lE1kNo
         SW2krz6I8p/rQAYSMBNEyTU7XA8x9j6RuvEO2cJhis2Uyeg3Fo+6JBMSOcvweEMZyr0D
         Zxva38rufqOrhcLRWnJX7n2Qjnusm6dD23LZYFTHfuvGmZ9TOYZ4Wd5wlv9m95mzZqpf
         SCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zN3mZVfmvdghfdSemRN/1yWF6njTrsJKWk33bMEFE0=;
        b=GyL9Z/el/25ZNjxU5gzqcFW7DlUZyrzEIt8SSDRVlLmGOW0O3Ouhq5tJjX6jEzMNan
         nXCMT9sTuhqeJsQ76MahmqyA6OtBu7nJkDx55cjmIxh3w2aiyc2z7p1PHYOIUOQIimFy
         CiRQEcQlSO29fhMeeuJjTtAPBPYqz4XJVm+f6Ay/6MXOPSJL9CUE8xgjOMtHoersOE7u
         dTOEo8RLxo0Zg/BTPNpXQV4x87YjRBDQh7dIsgleAabM/OEuU/LglgG7OH7Q+/yW0lY2
         4y0ykDdlFgMcgiUUlCom+1vpW/LoauOysCGXtvO6wrPRCVDQ7UmXnKPlKIAqLwnz9bM/
         y0Pw==
X-Gm-Message-State: AFqh2kpwaCq42z5P6ZhfUjMUkLHUygVt0AmSGHsvDZERm17dYwJjPwBJ
        qvTe3Gsjhaycc355U28TMYM=
X-Google-Smtp-Source: AMrXdXsQqgYhqZ2tYQWMBpkZC/bpqnOziWMJKtoGg48BH67rcueEQIujwOdN/OB7mKbHUNl1vrcJpw==
X-Received: by 2002:a17:906:1be1:b0:7c1:5248:4f3a with SMTP id t1-20020a1709061be100b007c152484f3amr27017035ejg.56.1674571318051;
        Tue, 24 Jan 2023 06:41:58 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id a23-20020a170906369700b007933047f923sm994367ejc.118.2023.01.24.06.41.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 06:41:57 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <f8ef62c8-5477-86ae-7fdc-501ff61a46cf@dunelm.org.uk>
Date:   Tue, 24 Jan 2023 14:41:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/8] sequencer API & users: fix widespread leaks
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <cover-v2-0.9-00000000000-20230112T124201Z-avarab@gmail.com>
 <cover-v3-0.8-00000000000-20230118T160600Z-avarab@gmail.com>
In-Reply-To: <cover-v3-0.8-00000000000-20230118T160600Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 18/01/2023 16:09, Ævar Arnfjörð Bjarmason wrote:
> This series fixes various widespread leaks in the sequencer and its
> users (rebase, revert, cherry-pick). As a result 18 tests become
> leak-free in their entirety.
> 
> See the v1 for a longer general summary:
> https://lore.kernel.org/git/cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com/
> 
> Changes since v2:
> 
>   * Reword/amend commit messages for some of the functional changes in
>     v1..v2.
>   * Remove leftover "opts->xopts_nr = 0" now that we don't
>     FREE_AND_NULL() anymore.
>   * Drop the "squash_onto_name" refactoring to a "to_free"
>   * Instead add a new "keep_base_onto_name" in the next commit. I'd
>     missed that if both options were provided we'd die(), so that
>     free() wasn't needed before re-assignment, as Phillip pointed
>     out...

This version looks good. The commit message for patch 3 is a bit 
rambling and the commit citation is not entirely accurate but I'm not 
sure it is worth a re-roll just for that.

Thanks for working on this

Phillip


> CI & branch for this available at:
> https://github.com/avar/git/tree/avar/leak-fixes-sequencer-rebase-3
> 
> Ævar Arnfjörð Bjarmason (8):
>    rebase: use "cleanup" pattern in do_interactive_rebase()
>    sequencer.c: split up sequencer_remove_state()
>    rebase & sequencer API: fix get_replay_opts() leak in "rebase"
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
> Range-diff against v2:
>   1:  d0a0524f3d4 =  1:  b223429df33 rebase: use "cleanup" pattern in do_interactive_rebase()
>   2:  c4eaa8dfef4 =  2:  00c7f04363f sequencer.c: split up sequencer_remove_state()
>   3:  f06f565ceaf !  3:  e4a96898a68 rebase & sequencer API: fix get_replay_opts() leak in "rebase"
>      @@ Commit message
>           get_replay_opts() function in "builtin/rebase.c". See [1] for the
>           initial addition of get_replay_opts().
>       
>      -    To safely call our new replay_opts_release() we'll need to change all
>      -    the free() to a FREE_AND_NULL(), and set "xopts_nr" to "0" after we
>      -    loop over it and free() it (the free() in the loop doesn't need to be
>      -    a FREE_AND_NULL()).
>      +    To safely call our new replay_opts_release() we'll need to stop
>      +    calling it in sequencer_remove_state(), and instead call it where we
>      +    allocate the "struct replay_opts" itself.
>       
>           This is because in e.g. do_interactive_rebase() we construct a "struct
>           replay_opts" with "get_replay_opts()", and then call
>      @@ Commit message
>       
>           But if we encounter errors anywhere along the way we'd punt out early,
>           and not free() the memory we allocated. Remembering whether we
>      -    previously called sequencer_remove_state() would be a hassle, so let's
>      -    make it safe to re-invoke replay_opts_release() instead.
>      +    previously called sequencer_remove_state() would be a hassle.
>       
>      -    I experimented with a change to be more paranoid instead, i.e. to
>      -    exhaustively check our state via an enum. We could make sure that we:
>      -
>      -    - Only allow calling "replay_opts_release()" after
>      -      "sequencer_remove_state()", but not the other way around.
>      -
>      -    - Forbid invoking either function twice in a row.
>      -
>      -    But such paranoia isn't warranted here, let's instead take the easy
>      -    way out and FREE_AND_NULL() this.
>      +    Using a FREE_AND_NULL() pattern would also work, as it would be safe
>      +    replay_opts_release() repeatedly, but let's fix this properly instead,
>      +    by having the owner of the data free() it.
>       
>           See [2] for the initial implementation of "sequencer_remove_state()",
>           which assumed that it should be removing the full (including on-disk)
>      @@ sequencer.c: static const char *gpg_sign_opt_quoted(struct replay_opts *opts)
>        {
>        	free(opts->gpg_sign);
>        	free(opts->reflog_action);
>      -@@ sequencer.c: static void replay_opts_release(struct replay_opts *opts)
>      - 	free(opts->strategy);
>      - 	for (size_t i = 0; i < opts->xopts_nr; i++)
>      - 		free(opts->xopts[i]);
>      -+	opts->xopts_nr = 0;
>      - 	free(opts->xopts);
>      - 	strbuf_release(&opts->current_fixups);
>      - }
>       @@ sequencer.c: int sequencer_remove_state(struct replay_opts *opts)
>        		}
>        	}
>   4:  e83bdfab046 !  4:  9f72cc6e46b builtin/revert.c: move free-ing of "revs" to replay_opts_release()
>      @@ Commit message
>           rather than having these users reach into the struct to free its
>           individual members.
>       
>      -    As explained in earlier change we should be using FREE_AND_NULL() in
>      -    replay_opts_release() rather than free().
>      -
>           1. d1ec656d68f (cherry-pick: free "struct replay_opts" members,
>              2022-11-08)
>           2. fd74ac95ac3 (revert: free "struct replay_opts" members, 2022-07-01)
>      @@ builtin/revert.c: int cmd_cherry_pick(int argc, const char **argv, const char *p
>       
>        ## sequencer.c ##
>       @@ sequencer.c: void replay_opts_release(struct replay_opts *opts)
>      - 	opts->xopts_nr = 0;
>      + 		free(opts->xopts[i]);
>        	free(opts->xopts);
>        	strbuf_release(&opts->current_fixups);
>       +	if (opts->revs)
>   5:  4fea2b77c6d <  -:  ----------- builtin/rebase.c: rename "squash_onto_name" to "to_free"
>   6:  898bb7698fc !  5:  3d5c3152f69 builtin/rebase.c: fix "options.onto_name" leak
>      @@ Metadata
>        ## Commit message ##
>           builtin/rebase.c: fix "options.onto_name" leak
>       
>      -    In [1] we started saving away the earlier xstrdup()'d
>      -    "options.onto_name" assignment to free() it, but when [2] added this
>      -    "keep_base" branch it didn't free() the already assigned value before
>      -    re-assigning to "options.onto_name". Let's do that, and fix the memory
>      -    leak.
>      +    Similar to the existing "squash_onto_name" added in [1] we need to
>      +    free() the xstrdup()'d "options.onto.name" added for "--keep-base" in
>      +    [2]..
>       
>           1. 9dba809a69a (builtin rebase: support --root, 2018-09-04)
>           2. 414d924beb4 (rebase: teach rebase --keep-base, 2019-08-27)
>      @@ Commit message
>           Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>       
>        ## builtin/rebase.c ##
>      +@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
>      + 	struct string_list strategy_options = STRING_LIST_INIT_NODUP;
>      + 	struct object_id squash_onto;
>      + 	char *squash_onto_name = NULL;
>      ++	char *keep_base_onto_name = NULL;
>      + 	int reschedule_failed_exec = -1;
>      + 	int allow_preemptive_ff = 1;
>      + 	int preserve_merges_selected = 0;
>       @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
>        		strbuf_addstr(&buf, options.upstream_name);
>        		strbuf_addstr(&buf, "...");
>        		strbuf_addstr(&buf, branch_name);
>       -		options.onto_name = xstrdup(buf.buf);
>      -+		free(to_free);
>      -+		options.onto_name = to_free = xstrdup(buf.buf);
>      ++		options.onto_name = keep_base_onto_name = xstrdup(buf.buf);
>        	} else if (!options.onto_name)
>        		options.onto_name = options.upstream_name;
>        	if (strstr(options.onto_name, "...")) {
>      +@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
>      + 	free(options.strategy);
>      + 	strbuf_release(&options.git_format_patch_opt);
>      + 	free(squash_onto_name);
>      ++	free(keep_base_onto_name);
>      + 	string_list_clear(&exec, 0);
>      + 	string_list_clear(&strategy_options, 0);
>      + 	return !!ret;
>       
>        ## t/t3416-rebase-onto-threedots.sh ##
>       @@ t/t3416-rebase-onto-threedots.sh: test_description='git rebase --onto A...B'
>   7:  fb38dc873f9 =  6:  c07dc006c6d sequencer.c: always free() the "msgbuf" in do_pick_commit()
>   8:  d4b0e2a5c83 !  7:  ee8262ab22a builtin/rebase.c: free() "options.strategy_opts"
>      @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
>        	free(options.strategy);
>       +	free(options.strategy_opts);
>        	strbuf_release(&options.git_format_patch_opt);
>      - 	free(to_free);
>      - 	string_list_clear(&exec, 0);
>      + 	free(squash_onto_name);
>      + 	free(keep_base_onto_name);
>   9:  fd9c7a5547c =  8:  84343ea6bf6 commit.c: free() revs.commit in get_fork_point()
