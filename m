Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0E2C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 17:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2889F613CB
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 17:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbhFQRm1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 13:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbhFQRm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 13:42:26 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0E3C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 10:40:18 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id o39-20020a05600c5127b02901d23584fd9bso4120400wms.0
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 10:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sYQfvQTi8dtT7Ahw/OpPk9D4js1pe5uC9VE2BwpNiZU=;
        b=qcKqFeyjyoq2L4gpL99RERqAXSB5qix5m7ICe+WsaonTouUrvePiSrBasgQ86cBuk8
         K0A1oPm1VYAB4Ut0zDrpWbFJtNn43xK9eDfRjR1PTL0h+MABmnV/Hru33OqguNIZSRIZ
         yfJy2OD6BnFBVLd4FBUB3ciLxuWmBOSqgKUHrnUZSMSto7m9iaS/7n/JA5TwmO0bnMor
         j9uLHwx4j0C2k4dLWctV/AEYXvWks0GHJQdFl5pOWzfhDAWdU2C9wz0WvF7iyXmLzMQ6
         dNzeoXBZD26miAhSOP3ClHPz7eohoNJCv52CMcHbz4MtzeWubhE1BPflOYE80OiQosds
         17lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sYQfvQTi8dtT7Ahw/OpPk9D4js1pe5uC9VE2BwpNiZU=;
        b=tYS4BQcx+vN/dk5jMSlOp/ToVbt3Wg/mXcsRpGfzlv/dDhAkMmwtfivzbgDnopAzqC
         WTZyknLpYNTNA25wMTEh5IANVn6N4sBuPEX7SXtOfZUKNoxZIoY5K/xTsxdGC+zbz0RC
         UQvCkGAGq2VJgnSl10PVQdxSYg5WKaJCnkjzms5tjjYwhdeBS46qfVZZnUIzQTAYX+24
         DCd+PVk6lwU67XZt5E3AlgRUQIddHzAIBPFLmv3fc5HMcWaRXzPs+vAf61B5oYIfkhCF
         SCLSPvNdRJRIkGPhdU34xZt8B3Zgwd+k1bA8kpaMX7ycM6YklzsPwv/qmPvAFXZPkiuP
         V/1w==
X-Gm-Message-State: AOAM533b6gUGXtYSLWgokz4CcMb82zUcXp9V55bDBuCLxL6D9yfd6JbM
        gIq8bAiBt8bCgbZdF1oM1w208vfvvMTBgw==
X-Google-Smtp-Source: ABdhPJz8Nn7+5xDGhfFaVp1NKTpGBLLjcs0aGI8Xa9xzjGGrDajEHiBIPG/WyvHlduDnXgQy+c1VEQ==
X-Received: by 2002:a7b:c005:: with SMTP id c5mr6491355wmb.113.1623951616889;
        Thu, 17 Jun 2021 10:40:16 -0700 (PDT)
Received: from [192.168.1.201] (11.22.198.146.dyn.plus.net. [146.198.22.11])
        by smtp.googlemail.com with ESMTPSA id e17sm6921122wre.79.2021.06.17.10.40.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 10:40:16 -0700 (PDT)
Subject: Re: [PATCH 0/7] Make diff3 the default conflict style
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Denton Liu <liu.denton@gmail.com>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <5c27a8ac-f6b1-3551-0af3-4e242437005d@gmail.com>
Date:   Thu, 17 Jun 2021 18:40:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210609192842.696646-1-felipe.contreras@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/06/2021 20:28, Felipe Contreras wrote:
> This patch series turned out much more complicated that simply flipping
> the switch and dealing with the consequences. Apparently some commands
> are completely ignoring the configuration (notes and merge-tree), and
> others are handling it wrong (checkout).
> 
> So in preparation I created a new test to make sure these rowdy
> commands handle the configuration correctly, and then step by step I fix
> them.
> 
> Once all the commands are fixed I proceed to cleanup xdiff-interface in
> preparation for the switch.
> 
> And finally once the switch is flipped the documnetation is updated, and
> funch of test scripts receive a temporary configuration that returns
> them to the old "merge" (diff2) behavior so they pass with minimum
> changes.
> 
> I have already written patches to update the tests so no configuration
> is needed and they parse the diff3 style directly, but the series is
> already quite verbose as it is.
> 
> One salient thorn is that from my point of view merge_recursive_config()
> is implemtend wrongly and thus can't be called as other configuration
> functions, like git_diff_basic_config(). It seems there's a huge area of
> opportunity there to clean all that up, but that's for another series.

Regrettably I shall not be commenting further on these or any future 
patches from you. I do not feel it would be a productive use of my time 
as you have not entered into the kind of constructive discussion that is 
the expected norm on this list.

Best Wishes

Phillip

> Felipe Contreras (7):
>    test: add merge style config test
>    merge-tree: fix merge.conflictstyle handling
>    notes: fix merge.conflictstyle handling
>    checkout: fix merge.conflictstyle handling
>    xdiff: rename XDL_MERGE_STYLE_DIFF3
>    xdiff: simplify style assignments
>    xdiff: make diff3 the default conflictStyle
> 
>   Documentation/config/merge.txt           |  12 +--
>   Documentation/git-merge-file.txt         |   2 +
>   Documentation/git-merge.txt              |  28 ++----
>   Documentation/git-rerere.txt             |   2 +-
>   Documentation/gitattributes.txt          |   6 +-
>   Documentation/technical/rerere.txt       |   3 +-
>   Documentation/user-manual.txt            |   6 +-
>   builtin/merge-file.c                     |   5 +-
>   builtin/merge-recursive.c                |   3 +
>   builtin/merge-tree.c                     |   4 +
>   builtin/merge.c                          |   4 +
>   builtin/notes.c                          |   3 +-
>   ll-merge.c                               |   3 +-
>   merge-recursive.c                        |   2 +-
>   sequencer.c                              |   5 +
>   t/t2023-checkout-m.sh                    |   2 +
>   t/t3310-notes-merge-manual-resolve.sh    |   2 +
>   t/t3311-notes-merge-fanout.sh            |   2 +
>   t/t3404-rebase-interactive.sh            |   2 +
>   t/t3507-cherry-pick-conflict.sh          |   2 +
>   t/t4017-diff-retval.sh                   |   2 +
>   t/t4048-diff-combined-binary.sh          |   2 +
>   t/t4200-rerere.sh                        |   2 +
>   t/t4300-merge-tree.sh                    |   2 +
>   t/t6402-merge-rename.sh                  |   2 +
>   t/t6403-merge-file.sh                    |   2 +
>   t/t6404-recursive-merge.sh               |   2 +
>   t/t6416-recursive-corner-cases.sh        |   2 +
>   t/t6417-merge-ours-theirs.sh             |   2 +
>   t/t6418-merge-text-auto.sh               |   2 +
>   t/t6422-merge-rename-corner-cases.sh     |   2 +
>   t/t6423-merge-rename-directories.sh      |   1 +
>   t/t6428-merge-conflicts-sparse.sh        |   1 +
>   t/t6432-merge-recursive-space-options.sh |   2 +
>   t/t6440-config-conflict-markers.sh       | 123 +++++++++++++++++++++++
>   t/t7201-co.sh                            |   2 +
>   t/t7506-status-submodule.sh              |   1 +
>   xdiff-interface.c                        |   6 +-
>   xdiff/xdiff.h                            |   3 +-
>   xdiff/xmerge.c                           |   4 +-
>   40 files changed, 217 insertions(+), 46 deletions(-)
>   create mode 100755 t/t6440-config-conflict-markers.sh
> 

