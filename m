Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1C9C433DF
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 10:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 681F420732
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 10:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkpZ5U02"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgFRKR2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbgFRKRS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 06:17:18 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50E2C06174E
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 03:17:16 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id l17so4930660qki.9
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 03:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ARUHRDMUxsP/StW/U8aJ+aPUeVU5PkScFmz4NDD+Yo=;
        b=GkpZ5U02TPBayIq2sHrat1Gh3t5ZrKt12qp7IvqgmZ3OGTh6d5KZLulunOfoNaHBa7
         rLOGsNdX15884XNNdmsJGe0ZO1IqVSIcchW5IVI4ZZ0oQ7HSJKjGjvvo14hfgh29jAem
         7/6M9r2mykoppc+cGVjteY/io3CwKV9Dul0itWffDW06uBuRNurt/da+w+xlpgAhWFYo
         10usE+K2odyDXHVSyhGFyKlT9b91cC/uINvXpann9UdIcqFnw0rrIdA1/VyDKPxhRNb9
         45Jps9w4lOGbuYRipY0P0lgWzmDRQsWOpwpY947/2n1ogpq7aX1+FrXg5Nnj/M3ThX+i
         +zqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ARUHRDMUxsP/StW/U8aJ+aPUeVU5PkScFmz4NDD+Yo=;
        b=EaWbUq6aMgDhxYySw9CkHFy4V+rHq4eeVwrRROar8bJGmTSQ3hsHm+YUB0VKQnh9Ua
         T/LWS4OhQTWCHIUsTYWQEPWakah9wetMZRrPmGSFboabiVJkNv2BfOQKqvxmqAg6WAVz
         7/2Dk2K62dX2+8rTPtel1xTRDO8DNWM9y/o1XIAWy1JnFs+6Hr0qzPRj6nKpCKc7Mehu
         MKWakKBzqPPr1grl2B14c39hVW5quXNTF0xTn3OrBHwL3Gr+6Lh5dyqL7y/Fx3E6RWbF
         /SI0EZ33KibN/yA4rFefie4fzlME74fa+j7uP/MGepmSQawCA77iWf1ZNvJyaeFTJZtw
         jlNw==
X-Gm-Message-State: AOAM532Gmi315K1XBAg6TztGOOSfDgFc3oAHfiN/XEqbj7TDN0z3Xluh
        MrDz9VmhbIyuFP8//0mM6n+vGxH2RwZ2CO8ef/A=
X-Google-Smtp-Source: ABdhPJxq+TKGkTyn33ITQZT6r5tYWmFlWaKHgzE/rBQWnhwstXww2cqWuUfIJc4HoAGVMzsZW3jCNg3rtu6wCTm80KI=
X-Received: by 2002:a37:e107:: with SMTP id c7mr2798325qkm.483.1592475435540;
 Thu, 18 Jun 2020 03:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200614181906.u42tuny3eipvhd46@chatter.i7.local>
 <b82bdf57-840d-f9c2-0e42-95a93d9336b7@gmail.com> <CANgJU+WoGNKuvZHAtLAfNAUfFdoLWHiDis_rSV-AfT9WspmHgA@mail.gmail.com>
 <20200616074316.GA21462@kitsune.suse.cz> <CANgJU+XzD9Nnnu4qWExpOUBy+u1=23SRCQy-=6aAVFJAowkjYg@mail.gmail.com>
 <xmqq5zbpv53g.fsf@gitster.c.googlers.com> <20200617201037.GA86579@google.com>
 <20200617201709.GB86579@google.com> <CANgJU+WbPgSTxQ=G3sFSvNFQ1cL3onYk5yKLBR=3AqWeEUCfZQ@mail.gmail.com>
 <20200618083825.GB20837@legohost>
In-Reply-To: <20200618083825.GB20837@legohost>
From:   demerphq <demerphq@gmail.com>
Date:   Thu, 18 Jun 2020 12:17:04 +0200
Message-ID: <CANgJU+WFEC_Z9mUF5NLq5FD_YL1Y9+Z5hGXi0M30p1nehBL94A@mail.gmail.com>
Subject: Re: Rename offensive terminology (master)
To:     Oleg <lego_12239@rambler.ru>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 18 Jun 2020 at 11:57, Oleg <lego_12239@rambler.ru> wrote:
>
> On Thu, Jun 18, 2020 at 09:57:42AM +0200, demerphq wrote:
> > Ultimately if I was the decision maker here I would be choosing terms
> > that are as workflow agnostic as I can find. "main", "master" and
> > "primary" are not workflow agnostic, they are if anything a bit
> > workflow opinionated. "trunk" on the other hand seems pretty
> > self-descriptive and doesn't have much baggage. It's bark is worse
> > than its byte however. :-)
>
> The most workflow agnostic name is "branch". it is so neutral that you want to
> change it ASAP :-).

I suppose I should have said "least confusing/ambiguous while most
workflow agnostic". :-)

Yves


-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
