Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3136C433EF
	for <git@archiver.kernel.org>; Fri, 24 Dec 2021 17:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbhLXRlC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 12:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbhLXRlC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 12:41:02 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A8DC061401
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 09:41:01 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id m21so36886652edc.0
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 09:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:date:user-agent:message-id
         :mime-version;
        bh=TP44PkToaGn6/yRAWqbcq5JLujhLa5GqWUHinrMAYbE=;
        b=VA6vdxBmgIcXmKVc7eA5miKdqOAu9QXdZu0K2AoWF5tAU9zHpFKGVVmAe45tp9ebZZ
         ZeLA7S3U22TKPj+0mYyena1FGV/rTI6Rdh2ssjhbsFj2Tj6THoCYMaeLzJDHUiQlWo5r
         fn/3wZN4fwcdMuLWDCrOF07lfjXZjirf3q3gDPXO0KhBVoCltu9v7dg/BfHfSmHO3bkw
         /Cymn1oU3jVl6mVBU/TaT7K3B23BVIbDIXvn4QoKHd4TtcU90ZwYNlwJF5zz4VBZ+z+n
         rRepRn3AMTSTppcACwO91720vICvA3RPARTRdbRkvmXs8yHRdQDw6lff2z7iqYXAWiRg
         YbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:date:user-agent
         :message-id:mime-version;
        bh=TP44PkToaGn6/yRAWqbcq5JLujhLa5GqWUHinrMAYbE=;
        b=XWW1V5S6rjOOqmzz2Em/ZBaooLr9F6XhiMV9uMt5bgM6448fRHcPk/WAAsLqoukpX/
         XzTiA2Ai1Roinh2DRZI9a1vl7KBlWubp4fx6WsgIaPZttDeqrhfmWmb8GCcuSknRAQAd
         TlXXnpgthVXKAinqRCcwfXb7iAk2wgRS81r61Ve7D0JdlNje9EL4FL89WbkDPeGzcAHA
         4sV6UikSutDaUrrsWFTYMMiIeK9p869lfTLXWrC4vwj0Pt9VxrIJ5mqDMeXCmVKRsix2
         LNsFLkl4alm0uzfHBy71fcybkKDHWQkrN/71WwHMXAEXWWImYEvr36DGIIEGRp1yFSYI
         /baA==
X-Gm-Message-State: AOAM530ZRrMxK3+gw8GfXEaHdkBel10luIUKOkVPSLumR/9Q8nhBuN2P
        q0x5+yfskgTKY1hu4TKDBZRoyNEYFHSfK2kn
X-Google-Smtp-Source: ABdhPJwGRiqtMcxxBC1wVvuTUm+9I6PXFyPyzGIM1wVl/Wruw+Kbjz0J/Aw41wnI2REUOiAx4e59xQ==
X-Received: by 2002:aa7:de86:: with SMTP id j6mr6737209edv.1.1640367660590;
        Fri, 24 Dec 2021 09:41:00 -0800 (PST)
Received: from gmgdl (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id b10sm3269586ede.52.2021.12.24.09.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Dec 2021 09:41:00 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n0oYt-0003kU-Jk;
        Fri, 24 Dec 2021 18:40:59 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Git ML" <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: ab/make-dependency (was "What's cooking in git.git (Dec 2021, #05;
 Thu, 23))
In-Reply-To: <xmqqsfui6g7q.fsf@gitster.g>
Date:   Fri, 24 Dec 2021 18:29:03 +0100
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
Message-ID: <211224.86bl15hpec.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Between the December 15th[1] and 23rd[2] "What's Cooking" the
"ab/make-dependency" topic was dropped. In the interim I'd submitted
these smaller topics split-out from it:

    https://lore.kernel.org/git/patch-1.1-58408f384e7-20211217T000729Z-avarab@gmail.com/
    https://lore.kernel.org/git/patch-1.1-1fafa6c643b-20211217T001137Z-avarab@gmail.com/
    https://lore.kernel.org/git/patch-1.1-90d1e77ad5e-20211217T001628Z-avarab@gmail.com/
    https://lore.kernel.org/git/cover-00.11-00000000000-20211217T002023Z-avarab@gmail.com
    https://lore.kernel.org/git/cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com

The last of those I re-rolled just now to address a trivial typo/grammar
issues pointed out by Eric on the v1 (but I notice now I broke the
In-Reply-To chain, d'oh!).

It would be great if you could pick those up as a replacement, in
particular the 2nd on the list is the reason I started splitting these
out. I.e. it's an indivdiual fix for the hook-list.h compilation race
impacting "master" right now. Thanks.

1. https://lore.kernel.org/git/xmqq8rwlz3cq.fsf@gitster.g/
2. https://lore.kernel.org/git/xmqqsfui6g7q.fsf@gitster.g/
