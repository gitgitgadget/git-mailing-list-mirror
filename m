Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CE2C433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 15:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbiKGP47 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 10:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiKGP46 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 10:56:58 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA681A3A2
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 07:56:55 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id v17so18284882edc.8
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 07:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8WkDG/XODrp85E/O1gGgWOSgE68PLXUYesvRY2LKOYo=;
        b=AzvvJ3PM437gmTWOcmsujRwX4G9nnS909gzzF6oEGnkjB6Sb4Zqy3pa5VjXyU7eS1K
         zQJST7aN6iuQxoSqqb2sMAqomaZrh0Cf3rphF70a3s/uxVPdpNzXJh3wl3nertDDgybT
         BmiRfVr8h7KWMJ4lLl6CvP4X9D2Zy6AGldbTyup7HqBUNh7OjOiPC6AgnqewPCrOf/Dg
         VcKtNkLej0SEiwYSaUPAjkFu9VqY7ODm2FuMb9C+Y1fZXtGk72nxkIS6LmwMItKw2pTr
         B9IuMISkA36R0P3D+/GvaTFJJFqECnFkxvz0fW+DTE+gIDuR+4DszEA+AyRGIVJ2HkjW
         ySDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WkDG/XODrp85E/O1gGgWOSgE68PLXUYesvRY2LKOYo=;
        b=n9K+7bHospx2C8C/yUaCwJIQceVLlxfXebAI/kdYaKwsT+3IEDkVC4/kMlGc0vfuRu
         pIvnXhCRBzAhAmhrmtHW6p7IDLRCiHC/pVfVZ3vaD0CcfVMBl9y0HGlWDmPnkymCVDEi
         cLMZsluKc17KoUZXG6bYDHGRl2QGPu64VFnB+UgeJWPUlpc1IuJ5O4hL44V01+WNgLUc
         yrTZW8l8/H6IIMvzNta0zNu5HlJJkEcZzcxBQQEkZq4fdXzSM8wC5abRkBvELmfOylOk
         k8OnpS5WW3ykWp3YniK/tHA07ME1TagEtGp+wXXi6fslaHsFGWa2DsUhB07MsFmGEKmn
         Betg==
X-Gm-Message-State: ACrzQf2Nk1L+v0lngaQc61xL/DzFlhiog9mZDYXy5CQfboKTKXkppugI
        fCccNK2rPD2os5DlMEYQp/0=
X-Google-Smtp-Source: AMsMyM4YvAJ3AQXSgNpIHJfHbHMsVaFE1+1TW8y7FPRDMH14/YTNNEasCwkzXzsZ7fqkcpOw6ZmrOw==
X-Received: by 2002:aa7:cc8a:0:b0:45b:f851:2943 with SMTP id p10-20020aa7cc8a000000b0045bf8512943mr52284195edt.103.1667836614127;
        Mon, 07 Nov 2022 07:56:54 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id em3-20020a056402364300b00458824aee80sm4436827edb.38.2022.11.07.07.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 07:56:53 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1os4UU-000ALF-2o;
        Mon, 07 Nov 2022 16:56:50 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        y@nand.local, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 0/2] rebase: stop setting GIT_REFLOG_ACTION
Date:   Mon, 07 Nov 2022 16:51:38 +0100
References: <pull.1405.git.1667575142.gitgitgadget@gmail.com>
 <Y2WIz5qvjQMfXPgP@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y2WIz5qvjQMfXPgP@nand.local>
Message-ID: <221107.86mt92vjul.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 04 2022, Taylor Blau wrote:

> On Fri, Nov 04, 2022 at 03:19:00PM +0000, Phillip Wood via GitGitGadget wrote:
>> This is a follow up to pw/rebase-reflog-fixes that moves away from using
>> GIT_REFLOG_ACTION internally. This conflicts with patches 12 & 14 in [1]. As
>> this series replaces the code being changed in those patches I think the
>> best solution would be to just drop them.
>
> Thanks, I appreciate the updated round.
>
> The conflict you noted in [1] is a perfect example of why I dislike
> queuing sweeping leak cleanups like in that series. Those two patches
> need to get dropped in order to queue this series. OK, except what
> happens if a different part of [1] marks a test as leak-free when that
> is no longer the case because of something in this series?

I'm about to rebase my v2 on this topic, which I think is the best way
forward, so this is about to become a moot point.

But I think this is a good example of why it's better to solve the merge
conflict rather than dropping patches from one topic:

In this case the merge conflict is trivial to solve: Keep the side of
this topic over mine, and after remove the one function call the
compiler was alerting about.

> I haven't queued this topic yet, so perhaps all of this is moot with
> respect to these particular two series. But in general, such a problem
> is not hard to imagine.

Yes, by ejecting the two patches from my topic it doesn't pass anymore
with:

	git rebase -i -x 'GIT_TEST_PASSING_SANITIZE_LEAK=check GIT_TEST_SANITIZE_LEAK_LOG=true make SANITIZE=leak test'

Which is not really a problem, it's an obscure test mode that only I'm
using, and before that topic we failed on "master" anyway. Just say'n,
in general... :)
