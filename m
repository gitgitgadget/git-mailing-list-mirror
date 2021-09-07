Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C65C433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6F656103D
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245220AbhIGKV3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 06:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbhIGKV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 06:21:28 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8C1C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 03:20:22 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id eb14so13159721edb.8
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 03:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=EDQj5fWCH2h1qm8h2u2WhBS87+4bbcDVBDhc7gxRC7A=;
        b=WnNorekrydKfHvznthrCXxJ81gyir6gTasF1+0a26TofJDHv7Elmc9/wJyJtoQVO0C
         PZzObafJvTR9ZWYNzhSSUd3rz0jSJsCF7FmlqSP+9OLBrniNveQ1qLqEACN7kXZeaOGr
         DpfWzWkvFGgoN32oeHKggCRpAskE5BHGQIvTgCf6m++/UXiI2/lQGHPI67RCosE7ll4I
         evcSc9J88LilT0Xd2zxxV+dheK4M6lj8OCIwd+YKGrWluFeIOz2bg7xEMVRYrWga+jq1
         x+2G5L+RwXqy9IPaiMiPXxdNUao03YdIN4Kl18c2U0V/W3LBIpebEDv2ARugbjStEV5w
         3Igg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=EDQj5fWCH2h1qm8h2u2WhBS87+4bbcDVBDhc7gxRC7A=;
        b=WqJcz9dPwcNfMEUFZJzPc/k+BDNTypoDz8r1xN6DB14gMCsU2+RtsCUbcryJzS1snC
         ue72QZLjNAjIcmp4r3Vbjafmpvt1Rnp1pWNSVRi29CC2DpufTKrhn92aQNYdkLgf0RjC
         lOVpq94gkPUKvLcBM4ChS1jzqXfqNjowGdvoNtZRHqH//ZqGkIxpi6T62aOBx9D+bj1i
         YtmsG/WsdUDCbFadYhUyBtfmhYORS9D6veWv7qm1GcUxbkk4kRcK17Tx3Aa/ndjOUK/N
         pYNhBrsy/QadbIz0I4TkwtFmc96ejGRLvASN5ORbMyMOk9FvoyG74MPtiaweNS37Uwpn
         QF2Q==
X-Gm-Message-State: AOAM5318otR1UEsgCDR2GVfAI2nFQHKpsFyjQFOHbJa6yLhQ8/GOIbFa
        PPoAovKJJzEIguBDu5SoBAx4u5Sb+bM=
X-Google-Smtp-Source: ABdhPJxd8QebW24JvJsNciB0Li3muVoeOUUBixoIoKQxVGZKL3L26Ah55AIymQ5WiDwh/ypjDVaU2Q==
X-Received: by 2002:aa7:d592:: with SMTP id r18mr17806723edq.317.1631010021016;
        Tue, 07 Sep 2021 03:20:21 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h22sm5215820eji.112.2021.09.07.03.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 03:20:20 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Sep 2021, #01; Thu, 2)
Date:   Tue, 07 Sep 2021 12:13:54 +0200
References: <xmqq35qmiofp.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqq35qmiofp.fsf@gitster.g>
Message-ID: <87ilzcn0v0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 02 2021, Junio C Hamano wrote:

> * js/retire-preserve-merges (2021-09-01) 7 commits
>  - tests: stop testing `git rebase --preserve-merges`
>  - remote: warn about unhandled branch.<name>.rebase values
>  - t5520: do not use `pull.rebase=preserve`
>  - rebase: drop the internal `rebase--interactive` command
>  - git-svn: drop support for `--preserve-merges`
>  - rebase: drop support for `--preserve-merges`
>  - pull: remove support for `--rebase=preserve`
>
>  The "--preserve-merges" option of "git rebase" has been removed.
>
>  Will merge to 'next'?

There's an outstanding re-roll of this topic that hasn't yet hit the
list. If you've got Johannes's git.git on github as a remote:

    git range-diff origin/master gitster/js/retire-preserve-merges dscho/drop-rebase-p

I.e. this is in response to some of my comments about now-dead code &
loose ends. Not all of that was addressed, e.g. the git-sh-i18n.sh
change, which is fine & per the discussion there can be done as a
follow-up, but I believe the current state per the above is that
Johannes is still going to submit a (hopefully final) v3.

> * gh/gitweb-branch-sort (2021-06-10) 1 commit
>  - gitweb: use HEAD as secondary sort key in git_get_heads_list()
>
>  Tie-break branches that point at the same object in the list of
>  branches on GitWeb to show the one pointed at by HEAD early.
>
>  Waiting for reviews.

I reviewed this & left a note in the last What's Cooking at
<8735qnax0o.fsf@evledraar.gmail.com>. I.e.:

    I don't use gitweb anymore, but looked this
    (<20210609192806.45406-1-greg@hurrell.net>) over just now. Looks
    good to me.

Perhaps it's better if I respond to the patches themselves with such
notes instead of to What's Cooking?
