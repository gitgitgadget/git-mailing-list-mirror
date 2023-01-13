Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06ABC61DB3
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 10:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240698AbjAMKtV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 05:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241252AbjAMKqr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 05:46:47 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8406B77D33
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 02:45:41 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id g10so14979051wmo.1
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 02:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dxsmc9IhE/wuYB1GTeSjSYiRLpRH3f51S78xf2fIluo=;
        b=hKpm76I2Rt1SDZeesxjOAc0nSzzgLSVGJuLQu59eTQc9aPk3io15FmjSa3CG1isiHj
         klVG/TF95Ue+yrg4o6uJjmKdXPGN7CacWj/rPJeiZu6/dTu+vTMzoWkcnUswKRXTQM9M
         TmrFyp3OcaeqGLFdsP93XlFW5S68dhXFU9lYemtXMOYSHzwonozdjl/msb781BR9V0Qs
         hBCMc8VHv1pk9OQynuo8oskkc9YewMMLD9KiB6sj46phzwjxpsi0GrwtaSwHor7wTqnj
         vm4eSALdxUy0mbM8c8yu3FN63azBy2ScU7KUN9LpsLtSwGisq+IwehR/aIsibe9jfLYP
         3WyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxsmc9IhE/wuYB1GTeSjSYiRLpRH3f51S78xf2fIluo=;
        b=u6TLL7iu4Dobh3NSqnoJyVlcaPr3t//XIOC82aNCk4EWYShnn3305TdPmWwgPtOlxn
         CMFwDvqF+PiSwpThO0tntzYPE2hvNDEnNQe+vYHC7SKn4SFsg1vtdNV8XptB2PhppZlM
         0gGWtsSqYBzFKuUDVOZMk5sI1Q5d8OCRKu2nf+GArh0DSwVFwhtTlLH07R4aEmXax/9S
         VaTDG4yjW1rbDCQXwbbcqt7vc7W9uGPtSpsKy7+MjOy3vFK+BEUgxA24i+1QGaMxLPuq
         DF5FW5OX4wuNG2vqK4OEQj6AS8CWZuYR78TAMVc2bNt6oWnLuB7/tnPmUl/fE/NwQboW
         d69A==
X-Gm-Message-State: AFqh2kpBW/ugD+YX17cXSpMwEwicGs2obFF6AJfHU34MmNKhAMSV1I0D
        YlO/SCcc2ks4ZLbSOUeS2f8=
X-Google-Smtp-Source: AMrXdXuTZp+olawar23cUjQY4A6z8M7Sd2k89jKVffOWhTCNo1EVxitFW4AWErJOQXwfw5w4nbSv+g==
X-Received: by 2002:a05:600c:1e10:b0:3da:2032:6c0f with SMTP id ay16-20020a05600c1e1000b003da20326c0fmr1677010wmb.31.1673606739947;
        Fri, 13 Jan 2023 02:45:39 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id x14-20020a1c7c0e000000b003d9f15efcd5sm15377100wmc.6.2023.01.13.02.45.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 02:45:39 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <e1722673-b444-2dcf-4087-46d2d15b9331@dunelm.org.uk>
Date:   Fri, 13 Jan 2023 10:45:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/9] sequencer API & users: fix widespread leaks
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
 <cover-v2-0.9-00000000000-20230112T124201Z-avarab@gmail.com>
In-Reply-To: <cover-v2-0.9-00000000000-20230112T124201Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

The code changes in this version look good modulo a couple of minor 
comments, however some of the commit messages need to be updated to 
reflect the (very welcome) changes you've made in v2.

Thanks again for working on this

Phillip

On 12/01/2023 12:45, Ævar Arnfjörð Bjarmason wrote:
> This series fixes various widespread leaks in the sequencer and its
> users (rebase, revert, cherry-pick). As a result 18 tests become
> leak-free in their entirety.
> 
> See the v1 for a longer general summary:
> https://lore.kernel.org/git/cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com/
> 
> Changes since v1:
> 
>   * I think this addresses all the outstanding feedback, thanks all.
>   * Most significantly, the replay_opts_release() is now moved out of
>     sequencer_remove_state() as suggested.
>   * There's a prep change for renaming "squash_onto_name", per the
>     discussion in v1.
>   * Just do "goto leave" rather than being paranoid and introdungi
>     "goto cleanup", thanks Phillip!
>   * Various other small changes, see the range-diff.
> 
> A branch & passing CI for this are at:
> https://github.com/avar/git/tree/avar/leak-fixes-sequencer-rebase-2
> 
> Ævar Arnfjörð Bjarmason (9):
>    rebase: use "cleanup" pattern in do_interactive_rebase()
>    sequencer.c: split up sequencer_remove_state()
>    rebase & sequencer API: fix get_replay_opts() leak in "rebase"
>    builtin/revert.c: move free-ing of "revs" to replay_opts_release()
>    builtin/rebase.c: rename "squash_onto_name" to "to_free"
>    builtin/rebase.c: fix "options.onto_name" leak
>    sequencer.c: always free() the "msgbuf" in do_pick_commit()
>    builtin/rebase.c: free() "options.strategy_opts"
>    commit.c: free() revs.commit in get_fork_point()
> 
>   builtin/rebase.c                       | 27 +++++++++-------
>   builtin/revert.c                       |  8 ++---
>   commit.c                               |  1 +
>   sequencer.c                            | 43 ++++++++++++++++----------
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
>   23 files changed, 64 insertions(+), 36 deletions(-)
> 
> Range-diff against v1:
>   1:  f3a4ed79c7d !  1:  d0a0524f3d4 rebase: use "cleanup" pattern in do_interactive_rebase()
>      @@ Commit message
>           rebase: use "cleanup" pattern in do_interactive_rebase()
>       
>           Use a "goto cleanup" pattern in do_interactive_rebase(). This
>      -    eliminates some duplicated free() code added in 0609b741a43 (rebase
>      -    -i: combine rebase--interactive.c with rebase.c, 2019-04-17), and sets
>      -    us up for a subsequent commit which'll make further use of the
>      -    "cleanup" label.
>      +    eliminates some duplicated free() code added in 53bbcfbde7c (rebase
>      +    -i: implement the main part of interactive rebase as a builtin,
>      +    2018-09-27), and sets us up for a subsequent commit which'll make
>      +    further use of the "cleanup" label.
>       
>           Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>       
>   2:  4994940a0a9 !  2:  c4eaa8dfef4 sequencer.c: split up sequencer_remove_state()
>      @@ Commit message
>           function, which will be adjusted and called independent of the other
>           code in sequencer_remove_state() in a subsequent commit.
>       
>      -    The only functional changes here are:
>      -
>      -     * Changing the "int" to a "size_t", which is the correct type, as
>      -       "xopts_nr" is a "size_t".
>      -
>      -     * Calling the free() before the "if (is_rebase_i(opts) && ...)",
>      -       which is OK, and makes a subsequent change smaller.
>      +    The only functional change here is changing the "int" to a "size_t",
>      +    which is the correct type, as "xopts_nr" is a "size_t".
>       
>           Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>       
>      @@ sequencer.c: static const char *gpg_sign_opt_quoted(struct replay_opts *opts)
>        	struct strbuf buf = STRBUF_INIT;
>       -	int i, ret = 0;
>       +	int ret = 0;
>      -+
>      -+	replay_opts_release(opts);
>        
>        	if (is_rebase_i(opts) &&
>        	    strbuf_read_file(&buf, rebase_path_refs_to_delete(), 0) > 0) {
>      @@ sequencer.c: int sequencer_remove_state(struct replay_opts *opts)
>       -		free(opts->xopts[i]);
>       -	free(opts->xopts);
>       -	strbuf_release(&opts->current_fixups);
>      --
>      ++	replay_opts_release(opts);
>      +
>        	strbuf_reset(&buf);
>        	strbuf_addstr(&buf, get_dir(opts));
>      - 	if (remove_dir_recursively(&buf, 0))
>   3:  3e9c4df61fe !  3:  f06f565ceaf rebase & sequencer API: fix get_replay_opts() leak in "rebase"
>      @@ builtin/rebase.c: static int run_sequencer_rebase(struct rebase_options *opts)
>        		break;
>        	}
>        	case ACTION_EDIT_TODO:
>      +@@ builtin/rebase.c: static int finish_rebase(struct rebase_options *opts)
>      +
>      + 		replay.action = REPLAY_INTERACTIVE_REBASE;
>      + 		ret = sequencer_remove_state(&replay);
>      ++		replay_opts_release(&replay);
>      + 	} else {
>      + 		strbuf_addstr(&dir, opts->state_dir);
>      + 		if (remove_dir_recursively(&dir, 0))
>      +@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
>      +
>      + 			replay.action = REPLAY_INTERACTIVE_REBASE;
>      + 			ret = sequencer_remove_state(&replay);
>      ++			replay_opts_release(&replay);
>      + 		} else {
>      + 			strbuf_reset(&buf);
>      + 			strbuf_addstr(&buf, options.state_dir);
>      +
>      + ## builtin/revert.c ##
>      +@@ builtin/revert.c: int cmd_revert(int argc, const char **argv, const char *prefix)
>      + 	if (opts.revs)
>      + 		release_revisions(opts.revs);
>      + 	free(opts.revs);
>      ++	replay_opts_release(&opts);
>      + 	return res;
>      + }
>      +
>      +@@ builtin/revert.c: int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
>      + 	free(opts.revs);
>      + 	if (res < 0)
>      + 		die(_("cherry-pick failed"));
>      ++	replay_opts_release(&opts);
>      + 	return res;
>      + }
>       
>        ## sequencer.c ##
>       @@ sequencer.c: static const char *gpg_sign_opt_quoted(struct replay_opts *opts)
>      @@ sequencer.c: static const char *gpg_sign_opt_quoted(struct replay_opts *opts)
>       -static void replay_opts_release(struct replay_opts *opts)
>       +void replay_opts_release(struct replay_opts *opts)
>        {
>      --	free(opts->gpg_sign);
>      --	free(opts->reflog_action);
>      --	free(opts->default_strategy);
>      --	free(opts->strategy);
>      -+	FREE_AND_NULL(opts->gpg_sign);
>      -+	FREE_AND_NULL(opts->reflog_action);
>      -+	FREE_AND_NULL(opts->default_strategy);
>      -+	FREE_AND_NULL(opts->strategy);
>      + 	free(opts->gpg_sign);
>      + 	free(opts->reflog_action);
>      +@@ sequencer.c: static void replay_opts_release(struct replay_opts *opts)
>      + 	free(opts->strategy);
>        	for (size_t i = 0; i < opts->xopts_nr; i++)
>        		free(opts->xopts[i]);
>      --	free(opts->xopts);
>       +	opts->xopts_nr = 0;
>      -+	FREE_AND_NULL(opts->xopts);
>      + 	free(opts->xopts);
>        	strbuf_release(&opts->current_fixups);
>        }
>      +@@ sequencer.c: int sequencer_remove_state(struct replay_opts *opts)
>      + 		}
>      + 	}
>        
>      +-	replay_opts_release(opts);
>      +-
>      + 	strbuf_reset(&buf);
>      + 	strbuf_addstr(&buf, get_dir(opts));
>      + 	if (remove_dir_recursively(&buf, 0))
>       
>        ## sequencer.h ##
>       @@ sequencer.h: int sequencer_pick_revisions(struct repository *repo,
>      @@ t/t3412-rebase-root.sh: Tests if git rebase --root --onto <newparent> can rebase
>        
>        log_with_names () {
>       
>      + ## t/t3419-rebase-patch-id.sh ##
>      +@@ t/t3419-rebase-patch-id.sh: test_description='git rebase - test patch id computation'
>      + GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>      + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>      +
>      ++TEST_PASSES_SANITIZE_LEAK=true
>      + . ./test-lib.sh
>      +
>      + scramble () {
>      +
>        ## t/t3423-rebase-reword.sh ##
>       @@
>        
>      @@ t/t3423-rebase-reword.sh
>        
>        . "$TEST_DIRECTORY"/lib-rebase.sh
>       
>      + ## t/t3425-rebase-topology-merges.sh ##
>      +@@
>      + #!/bin/sh
>      +
>      + test_description='rebase topology tests with merges'
>      ++
>      ++TEST_PASSES_SANITIZE_LEAK=true
>      + . ./test-lib.sh
>      + . "$TEST_DIRECTORY"/lib-rebase.sh
>      +
>      +
>        ## t/t3437-rebase-fixup-options.sh ##
>       @@ t/t3437-rebase-fixup-options.sh: to the "fixup" command that works with "fixup!", "fixup -C" works with
>        "amend!" upon --autosquash.
>      @@ t/t3438-rebase-broken-files.sh
>        
>        test_expect_success 'set up conflicting branches' '
>       
>      + ## t/t3501-revert-cherry-pick.sh ##
>      +@@ t/t3501-revert-cherry-pick.sh: test_description='test cherry-pick and revert with renames
>      + GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>      + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>      +
>      ++TEST_PASSES_SANITIZE_LEAK=true
>      + . ./test-lib.sh
>      +
>      + test_expect_success setup '
>      +
>      + ## t/t3502-cherry-pick-merge.sh ##
>      +@@ t/t3502-cherry-pick-merge.sh: test_description='cherry picking and reverting a merge
>      + GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>      + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>      +
>      ++TEST_PASSES_SANITIZE_LEAK=true
>      + . ./test-lib.sh
>      +
>      + test_expect_success setup '
>      +
>      + ## t/t3503-cherry-pick-root.sh ##
>      +@@ t/t3503-cherry-pick-root.sh: test_description='test cherry-picking (and reverting) a root commit'
>      + GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>      + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>      +
>      ++TEST_PASSES_SANITIZE_LEAK=true
>      + . ./test-lib.sh
>      +
>      + test_expect_success setup '
>      +
>      + ## t/t3506-cherry-pick-ff.sh ##
>      +@@ t/t3506-cherry-pick-ff.sh: test_description='test cherry-picking with --ff option'
>      + GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>      + export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>      +
>      ++TEST_PASSES_SANITIZE_LEAK=true
>      + . ./test-lib.sh
>      +
>      + test_expect_success setup '
>      +
>      + ## t/t3511-cherry-pick-x.sh ##
>      +@@
>      +
>      + test_description='Test cherry-pick -x and -s'
>      +
>      ++TEST_PASSES_SANITIZE_LEAK=true
>      + . ./test-lib.sh
>      +
>      + pristine_detach () {
>      +
>        ## t/t7402-submodule-rebase.sh ##
>       @@
>        
>   4:  1e4e504c533 <  -:  ----------- builtin/revert.c: refactor run_sequencer() return pattern
>   5:  e2895bb9795 <  -:  ----------- builtin/revert.c: fix common leak by using replay_opts_release()
>   6:  21eea8eb802 !  4:  e83bdfab046 builtin/revert.c: move free-ing of "revs" to replay_opts_release()
>      @@ builtin/revert.c: int cmd_revert(int argc, const char **argv, const char *prefix
>       -	if (opts.revs)
>       -		release_revisions(opts.revs);
>       -	free(opts.revs);
>      -+	replay_opts_release(&opts);
>      + 	replay_opts_release(&opts);
>        	return res;
>        }
>      -
>       @@ builtin/revert.c: int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
>        	opts.action = REPLAY_PICK;
>        	sequencer_init_config(&opts);
>      @@ builtin/revert.c: int cmd_cherry_pick(int argc, const char **argv, const char *p
>       -	if (opts.revs)
>       -		release_revisions(opts.revs);
>       -	free(opts.revs);
>      -+	replay_opts_release(&opts);
>        	if (res < 0)
>        		die(_("cherry-pick failed"));
>      - 	return res;
>      + 	replay_opts_release(&opts);
>       
>        ## sequencer.c ##
>       @@ sequencer.c: void replay_opts_release(struct replay_opts *opts)
>        	opts->xopts_nr = 0;
>      - 	FREE_AND_NULL(opts->xopts);
>      + 	free(opts->xopts);
>        	strbuf_release(&opts->current_fixups);
>       +	if (opts->revs)
>       +		release_revisions(opts->revs);
>      -+	FREE_AND_NULL(opts->revs);
>      ++	free(opts->revs);
>        }
>        
>        int sequencer_remove_state(struct replay_opts *opts)
>   -:  ----------- >  5:  4fea2b77c6d builtin/rebase.c: rename "squash_onto_name" to "to_free"
>   7:  484ebbfd6d1 !  6:  898bb7698fc builtin/rebase.c: fix "options.onto_name" leak
>      @@ Commit message
>       
>           In [1] we started saving away the earlier xstrdup()'d
>           "options.onto_name" assignment to free() it, but when [2] added this
>      -    "keep_base" branch it didn't free() the already assigned
>      -    "squash_onto_name" before re-assigning to "options.onto_name". Let's
>      -    do that, and fix the memory leak.
>      +    "keep_base" branch it didn't free() the already assigned value before
>      +    re-assigning to "options.onto_name". Let's do that, and fix the memory
>      +    leak.
>       
>           1. 9dba809a69a (builtin rebase: support --root, 2018-09-04)
>           2. 414d924beb4 (rebase: teach rebase --keep-base, 2019-08-27)
>      @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
>        		strbuf_addstr(&buf, "...");
>        		strbuf_addstr(&buf, branch_name);
>       -		options.onto_name = xstrdup(buf.buf);
>      -+		free(squash_onto_name);
>      -+		options.onto_name = squash_onto_name = xstrdup(buf.buf);
>      ++		free(to_free);
>      ++		options.onto_name = to_free = xstrdup(buf.buf);
>        	} else if (!options.onto_name)
>        		options.onto_name = options.upstream_name;
>        	if (strstr(options.onto_name, "...")) {
>   8:  d607dbac38e !  7:  fb38dc873f9 sequencer.c: always free() the "msgbuf" in do_pick_commit()
>      @@ Commit message
>           we'd return before the strbuf_release(&msgbuf).
>       
>           Then when the "fixup" support was added in [3] this leak got worse, as
>      -    we added another place where we'd "return" before reaching the
>      -    strbuf_release().
>      +    in this error case we added another place where we'd "return" before
>      +    reaching the strbuf_release().
>       
>      -    Let's move it to a "cleanup" label, and use an appropriate "goto". It
>      -    may or may not be safe to combine the existing "leave" and "cleanup"
>      -    labels, but this change doesn't attempt to answer that question. Let's
>      -    instead avoid calling update_abort_safety_file() in these cases, as we
>      -    didn't do so before.
>      +    This changes the behavior so that we'll call
>      +    update_abort_safety_file() in these cases where we'd previously
>      +    "return", but as noted in [4] "update_abort_safety_file() is a no-op
>      +    when rebasing and you're changing code that is only run when
>      +    rebasing.". Here "no-op" refers to the early return in
>      +    update_abort_safety_file() if git_path_seq_dir() doesn't exist.
>       
>           1. 452202c74b8 (sequencer: stop releasing the strbuf in
>              write_message(), 2016-10-21)
>      @@ Commit message
>              2016-07-26)
>           3. 6e98de72c03 (sequencer (rebase -i): add support for the 'fixup' and
>              'squash' commands, 2017-01-02)
>      +    4. https://lore.kernel.org/git/bcace50b-a4c3-c468-94a3-4fe0c62b3671@dunelm.org.uk/
>       
>           Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>       
>      @@ sequencer.c: static int do_pick_commit(struct repository *r,
>       -			return -1;
>       +					   opts, item->flags)) {
>       +			res = -1;
>      -+			goto cleanup;
>      ++			goto leave;
>       +		}
>        		flags |= AMEND_MSG;
>        		if (!final_fixup)
>      @@ sequencer.c: static int do_pick_commit(struct repository *r,
>       +			if (copy_file(dest, rebase_path_squash_msg(), 0666)) {
>       +				res = error(_("could not rename '%s' to '%s'"),
>       +					    rebase_path_squash_msg(), dest);
>      -+				goto cleanup;
>      ++				goto leave;
>       +			}
>        			unlink(git_path_merge_msg(r));
>        			msg_file = dest;
>      @@ sequencer.c: static int do_pick_commit(struct repository *r,
>        	/*
>        	 * If the merge was clean or if it failed due to conflict, we write
>       @@ sequencer.c: static int do_pick_commit(struct repository *r,
>      - 	}
>      -
>        leave:
>      -+	update_abort_safety_file();
>      -+cleanup:
>        	free_message(commit, &msg);
>        	free(author);
>      --	update_abort_safety_file();
>       +	strbuf_release(&msgbuf);
>      + 	update_abort_safety_file();
>        
>        	return res;
>      - }
>   9:  cd0489a2384 !  8:  d4b0e2a5c83 builtin/rebase.c: free() "options.strategy_opts"
>      @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
>        	free(options.strategy);
>       +	free(options.strategy_opts);
>        	strbuf_release(&options.git_format_patch_opt);
>      - 	free(squash_onto_name);
>      + 	free(to_free);
>        	string_list_clear(&exec, 0);
> 10:  eb3678b4667 =  9:  fd9c7a5547c commit.c: free() revs.commit in get_fork_point()
