Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7794CCA486
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 18:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236587AbiF3SLj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 14:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236575AbiF3SLh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 14:11:37 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64AC3C71B
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:11:35 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id fw3so12900860ejc.10
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 11:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=z0MrKVScdRnLjyBFux/tbDAzb7oPO43yCkMRR5tSCH4=;
        b=MOzxTblzphmwIT7asEGjXPcFmiZRfhRhVtFvVh9gVxAaIjXsluXH0SYSEM4VNvaCp/
         L+YpMyD2z4x7oxS9YtXs83NT6g1hrpEggDFcDsHxpQ7/iMG7G3XzgfHJ6jbIiUyz2Rid
         NmR4HtEvr80l/0zzWYYdEtqCrZvinEmf2nT1SKQwEHtPbGHeKd7Ms9t09eueSdPgXfLX
         YfJtSlUHzDxbbSMhWAHPnyi/7Vcldg2BeAPymaFbvDV2SbGNfFIQ37Y7NkaK2gP9rNWn
         SWhhp8c3hrbyEVXHgCaU1BV6ve91sgn5qmDiQIB5dRgWX2zfos9Og854F4wVOVbs8z5u
         CEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=z0MrKVScdRnLjyBFux/tbDAzb7oPO43yCkMRR5tSCH4=;
        b=Km5ri5Nw69BNEsOpOd2DNX/7ddLmtnpLGrrzma+R9Cojzcu0XJREH5VokFFH3JvPKz
         txSHIfuDIpyyJuFqIKgQWxWeJ1mZr/crXagZh1oE/VrfjqUsrrmEdUBfaz2vrejejJdn
         N1OHz0YP4BfPmbJucrA5fMw/x7H/A6pMRPFfVcIPCek8PbRGpOQWv73iyzQ2Fnxcyx3a
         P0AINH3RUK0p8+MFDd9Oo+kCgo63Qnzpm9mwo1znigdJIooJqWi2do/Ejb3Ef6aEA6kR
         HcG3PFdEMjHxem0xCJ+V7MZuhRj/ROUg+Slu9vQ6Lb77oGc6eOdIaDeRp6fLvNritFKQ
         RPMg==
X-Gm-Message-State: AJIora9LuygHS+EOddgVWhQpq0uXvhQ0/Lc9UcyDQg7X7dK8j9qlKavm
        XPQfUnjyXdkXQ+q7o8AVG8juiEcg1efQlg==
X-Google-Smtp-Source: AGRyM1sY0Poy05wPd29KrfufVbJ09Rnva3YMi/BEmE1vAwXP5TWYIQUEK8izH3jhIVfndzBEOkjI+Q==
X-Received: by 2002:a17:907:160f:b0:726:a7a4:c626 with SMTP id hb15-20020a170907160f00b00726a7a4c626mr10195205ejc.449.1656612694381;
        Thu, 30 Jun 2022 11:11:34 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id w16-20020a1709061f1000b0071d3b6ed4eesm9406448ejj.160.2022.06.30.11.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 11:11:33 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1o6ydZ-002R8H-4h;
        Thu, 30 Jun 2022 20:11:33 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: Non-interactively rewording commit messages
Date:   Thu, 30 Jun 2022 20:10:39 +0200
References: <20220630152757.yxwhijvj5xoosrws@meerkat.local>
 <CAP8UFD1Ar13wqQP0ecb37saShSVj5Gxcjdpz=pckXZ7X9TRfSQ@mail.gmail.com>
 <20220630175421.wbgqnmym7ioazdzo@meerkat.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220630175421.wbgqnmym7ioazdzo@meerkat.local>
Message-ID: <220630.86iloic97u.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jun 30 2022, Konstantin Ryabitsev wrote:

> On Thu, Jun 30, 2022 at 07:34:54PM +0200, Christian Couder wrote:
>> > Hello, all:
>> >
>> > What's the best approach to non-interactively rewrite specific commit
>> > messages? In this particular case, I am trying to automatically retrieve code
>> > review trailers sent to the mailing list and put them into corresponding
>> > commits.
>> >
>> > For example, I have a set of commits:
>> >
>> > abcabc: This commit does foo
>> > bcdbcd: This commit does bar
>> > cdecde: This commit does baz
>> >
>> > They were all sent to the mailing list and a maintainer sent a "Reviewed-by"
>> > to the second commit. In a usual interactive rebase session this would be:
>> >
>> > pick abcabc
>> > reword bcdbcd
>> > pick cdecde
>> >
>> > When the edit screen comes up for the bcdbcd commit, the author would manually
>> > stick the new trailer into the commit message. However, I can automate all
>> > that away with b4 -- just need a sane strategy for non-interactively rewriting
>> > entire commit messages at arbitrary points in the recent history.
>> >
>> > Any pointers?
>> 
>> Have you tried `git interpret-trailers`?
>
> I'm aware of interpret-trailers, but unless I'm missing something large, it's
> just a way of analyzing standalone text files to retrieve or insert trailers.
> What I'm looking for is a way to amend arbitrary commit messages within recent
> git history.

I think what's being suggested is that once you have a program that can
munge a commit message on stdin, you can combine it with rebase, git
commit --amend etc. to change existing commits.q

The t/t7513-interpret-trailers.sh test has some examples of munging
existing content.

