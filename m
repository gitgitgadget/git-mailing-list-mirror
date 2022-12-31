Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B52C3DA7A
	for <git@archiver.kernel.org>; Sat, 31 Dec 2022 15:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235745AbiLaPG4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Dec 2022 10:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235735AbiLaPGy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2022 10:06:54 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71519B1E7
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 07:06:53 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id o15so17292832wmr.4
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 07:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fCBl0Ajqq91zKHyRJf0H3X12XORAd+xxHqH7iXDIy9Y=;
        b=JjzfOXPmSy34M8RnJL3uP7Azhcuy13JqlrAYe1rNRvTUTV8h8NBO8e8+YtvX2Mu9NI
         W1tXoLqQ0kD/m6NxSSv/RfAzCjjmLabY4L4urFdyp1r9/2I0kWGaM97INx6JIP+9u0RP
         Ssujv9re1ZkRBXZLP2eLR5UhaowpnLHFigdxLDKC3vHe1kH5eBMcts0Z62jtEW6tXGON
         FuqRLrR9frFyGqNJLlO74cJjG/zkiuhs0q0blS9UY5cEIR+ez7nxTAaAuN2h7VRTyoky
         h+TH3QACQx2jDFTHqBYBW2dL9E9kuOlQ0QcHvGndKqLsZK9WQOQD81goDTThFobWsyy2
         gUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCBl0Ajqq91zKHyRJf0H3X12XORAd+xxHqH7iXDIy9Y=;
        b=3VQlOY+Yx7TuWRT+ua6xaS9jmoTNgoyiO69FC5alI32LpTujHw94LizsI06n9otK9D
         1CbRDvNVX/vKwWB1rilMTEmwGvsdMGP1fXygDnhHaRYuXuCpJn7m2BXuzBzKyIgsp8D8
         LjuFDoWcDlcuBhLvSkZTt8RW/oCFHzlQ+aF6KfZw/jHWrIYTcnOCDLtm50C0A4pq2Smd
         ydG9wR2/HKadt8obxbkOKqDo+ZEr2U+ORA1Vrl4XRRP6o4M64luL04gnDD+VUVZlBFor
         sqAZJyzkrBbg1hYyTzgD5dj78eFQkpbNEEIZwpGGwxE/Y7wrhlodwqh46jWIui5/piQk
         YuNQ==
X-Gm-Message-State: AFqh2krWD+XdTacTo15M9qSWYyn+1JNqirEs68WaXwbTaPkFeHwDOUJh
        m/5N0Cv29kdBuRNWHCTJon4=
X-Google-Smtp-Source: AMrXdXsMKeYYs7U1LErkyyLmU15mNuZMrExcPfsYdapY459y52sDNNUVxNAn1a8lfAZemxYStcTUiw==
X-Received: by 2002:a05:600c:3495:b0:3c6:e62e:2e74 with SMTP id a21-20020a05600c349500b003c6e62e2e74mr25384999wmq.15.1672499212061;
        Sat, 31 Dec 2022 07:06:52 -0800 (PST)
Received: from [192.168.1.14] (host-92-2-151-214.as13285.net. [92.2.151.214])
        by smtp.gmail.com with ESMTPSA id k5-20020a05600c080500b003d208eb17ecsm30011614wmp.26.2022.12.31.07.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Dec 2022 07:06:51 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <813dc31d-f36a-a4f0-ff99-2373df0eedac@dunelm.org.uk>
Date:   Sat, 31 Dec 2022 15:06:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 00/10] sequencer API & users: fix widespread leaks
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
In-Reply-To: <cover-00.10-00000000000-20221230T071741Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 30/12/2022 07:28, Ævar Arnfjörð Bjarmason wrote:
> This series fixes various widespread leaks in the sequencer and its
> users (rebase, revert, cherry-pick). As a result 18 tests become
> leak-free in their entirety.
> 
> The main change is the 3/10 here, where we introduce a
> replay_opts_release() to free the "struct replay_opts". The rest is
> then either refactorings to be able to call that destructor
> (e.g. "return" to "goto cleanup"), or other miscellanious adjacent
> leaks.
> 
> This is a follow-up to the discussion ending at [1], as noted there
> the recent ff84d031a9d (Merge branch 'pw/rebase-no-reflog-action',
> 2022-11-23) ended up introducing a leak because of the disfunctional
> lack of a destructor (or rather, the current logic being tied up in
> sequencer_remove_state().

Thanks for working on this. Separating out replay_opts_release() from 
sequencer_remove_state() enables us to free struct replay_opts properly. 
I've left some comments, the patches I haven't commented on all looked fine.

Best Wishes

Phillip

> This can be queued and graduated independently of the other concurrent
> leak series I've submitted[2]. When the two are combined we'll end up
> passing more tests, i.e. both topics combined get us over the finish
> line for some of them, but neither one is enough in isolation.
> 
> But that's OK, we just won't opt them into the "linux-leaks"
> testing. I'll submit a follow-up similar to [3] at some later date to
> mark them as passing. I think that's a better trade-off than making
> these two depend on one another.
> 
> 1. https://lore.kernel.org/git/221108.864jv9sc9r.gmgdl@evledraar.gmail.com/
> 2. https://lore.kernel.org/git/cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com/
> 3. https://lore.kernel.org/git/patch-v2-01.20-3de29c6d75f-20221230T020341Z-avarab@gmail.com/
> 
> Ævar Arnfjörð Bjarmason (10):
>    rebase: use "cleanup" pattern in do_interactive_rebase()
>    sequencer.c: split up sequencer_remove_state()
>    rebase & sequencer API: fix get_replay_opts() leak in "rebase"
>    builtin/revert.c: refactor run_sequencer() return pattern
>    builtin/revert.c: fix common leak by using replay_opts_release()
>    builtin/revert.c: move free-ing of "revs" to replay_opts_release()
>    builtin/rebase.c: fix "options.onto_name" leak
>    sequencer.c: always free() the "msgbuf" in do_pick_commit()
>    builtin/rebase.c: free() "options.strategy_opts"
>    commit.c: free() revs.commit in get_fork_point()
> 
>   builtin/rebase.c                       | 19 +++++-----
>   builtin/revert.c                       | 40 +++++++++++----------
>   commit.c                               |  1 +
>   sequencer.c                            | 48 +++++++++++++++++---------
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
>   23 files changed, 82 insertions(+), 47 deletions(-)
> 
