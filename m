Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78F2C07E95
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 21:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB9C261176
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 21:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhGBVPB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 17:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhGBVPA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 17:15:00 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1BEC061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 14:12:27 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id t3so12872573oic.5
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 14:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=AvheahUEBu1LqmnScsmkV6LP8WlYv/x18klkOciCoMM=;
        b=L8Hwey2PzK+qVlR8kNlYIz4clxv0VtbSZiGaYs7QyhNe5q15I58ojMijgp4j2Gtak0
         YjEBQYlyW6djPuzzH85NzVRGbThbnWtsOkZQAuWzoRF3mDCiKQL2d4BJvq0PIv7VaSAH
         S3I7Ka30itQLogVX8CGLCBrgV3HnHnYbwKRP3rwj/WmS6Y1aowir87zcveYz7q1Mflf4
         7d6vyHW6+hzQRoXgVUdR58gw2FPDNjzmbu3ngqmFG6E6+AFdf9dOVXewwsG1qXhRkUGq
         dDcAOFx53Nv0OHlmj/NAgif9f8d710CnFQbQAiLzAbp/Zr5Yq44Ky63zwpGcpHXNAqDy
         t71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=AvheahUEBu1LqmnScsmkV6LP8WlYv/x18klkOciCoMM=;
        b=G/K02yohYQDvMv+DmOugPQTlGHqxTuJ9CkmXixiC4rS6zjwo/P3t1pGynvQTTEV9uQ
         +mDRftqpSdckrHk2fAWPvRM/9qkdXGiBwA4Jn4IxRCet2v8NFUpnJO1BDu1MUowHAX7E
         swkwxO3l9/Q67zAI1jN1jKo5xCbMKbCuU1p3kK0PGITQOXCXqhVDNQKRM1cSbSMwIkom
         XZJSi/CFLbfVRQZ4qgTTppL2iL5xHJq77SC1ccycLHnk7q3yEDju6/j1ZsffuC3Kxu02
         gtARBeUvcldwBGS/Nquy9PYd8NXlBzsr71a09c33aQ5dICpDOtzo2PpJJkcAoXlYEA4p
         toRQ==
X-Gm-Message-State: AOAM533/+eaIDMilWRzprpROUa+xIBxuo8l23okAXW92QmJt2D3AyGVu
        gvyRW1sGZQRmqPjDsvJCdWY=
X-Google-Smtp-Source: ABdhPJwZfpWd+cXSOTZ7sPCwt3U2K0iPJfwREGlm7HhlEfDNRtKZGD6FkRkwwXraM8q286omrA6k2w==
X-Received: by 2002:aca:4302:: with SMTP id q2mr1150325oia.111.1625260346780;
        Fri, 02 Jul 2021 14:12:26 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id x18sm838846ooo.26.2021.07.02.14.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 14:12:26 -0700 (PDT)
Date:   Fri, 02 Jul 2021 16:12:25 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     martin <test2@mfriebe.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60df813938303_28bb208c8@natae.notmuch>
In-Reply-To: <3e82a574-fdcc-08b8-8fb5-1ff15f8ae564@mfriebe.de>
References: <20210702100506.1422429-1-felipe.contreras@gmail.com>
 <20210702100506.1422429-6-felipe.contreras@gmail.com>
 <871r8hauvi.fsf@igel.home>
 <60dee7d4e27bf_2964b20817@natae.notmuch>
 <65b1d215-c3ab-e0e3-f4ac-a30131541f9b@mfriebe.de>
 <60def07e686c7_7442083a@natae.notmuch>
 <3e82a574-fdcc-08b8-8fb5-1ff15f8ae564@mfriebe.de>
Subject: Re: [PATCH 5/5] config: add default aliases
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

martin wrote:
> On 02/07/2021 12:54, Felipe Contreras wrote:
> > martin wrote:
> >> IMHO it would be good to (partly) follow other vcs, and have
> >> commit = ci
> > I'm fine with leaving co out of the default aliases if it's deemed "too
> > controversial".
> >
> > But ci doesn't make sense. ci comes from "check in" which has no
> > similitude in git.
> svn uses it for "commit".
> It can be seen as CommIt.

I know, but it comes from CVS.

In both CVS and Subversion "commit" pushes a commit, so it can be seen
as the opposite of "checkout", which pulls a commit.

That's not the case in git.

> But of course other letters can be picked. I don't see an advantage in 
> it though.

The advantage is that it's straightforward: co -> commit.

> > I don't think it's a good idea to leave "git checkout" without an alias
> > (it's perhaps the second or third most used command), but at least some
> > aliases are better than no aliases.
> Well, that goes back to a bigger question. And from the brief time I 
> have been on this mail
> list, it appears to me there is a divide into 2 groups.

I'm on neither of those camps.

> If checkout is really meant to give way to switch/restore then it needs 
> no further
> advertising. And then the current usage statistics are a relict from the 
> before switch/restore time.

This is what I think eventually should happen, but we are not there yet.

If checkout were to disappear today, I wouldn't be able to do a lot of
things. switch/restore are not ready yet.

> If on the other hand checkout is not just to be kept for backward 
> compatibility, but should
> always remain an equal alternative to switch/restore (i.e. it should 
> still be taught to new
> user in 20 years) then it wants to have a default alias.

Why? Not all commands need an alias, only the most widely used. If
switch/restore can be used for 99% of use cases (not the case today),
then there's no need for checkout to have a default alias.

Of course if somebody wants to keep using checkout instead of
switch/restore, they can add an alias themselves.


I'm on the camp of "let's see".

-- 
Felipe Contreras
