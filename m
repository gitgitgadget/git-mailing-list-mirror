Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C392CC433E0
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 10:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D57464EAF
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 10:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhBSKVh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 05:21:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbhBSKVd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 05:21:33 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5658FC061574
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 02:20:53 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id s3so1464936otg.5
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 02:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D/R3jzjVcEYBo/K5bznfSK6WiA9y4jMG3VEZErXfz2A=;
        b=T5tP1Ft+IzgEmIaBajbQSEmLBiTSjBs4zSAGGIzmFTjSux+A2gKyUPDknu9G/H7h2O
         H+TxJP43If3DXdgzExWzgukTyC7xskow4vsETZi0mSKZ58e2PZEKa2+W/xAEe3Z1Olp/
         LsvzmYNJ1idW/lb2BKkJyYZIwTjxn4xW2QmL8ir10jmn7fXTLT09MxjoSLIZJLkuGjA0
         /AlsRE3Aadq/qFBhvBG+LjBx+1XfpmR6F/YYxUY02wxKZWKhvDdo4X7J07fph8YNSjdM
         jjZSIlLuLzaFtfKjGZLOc1AzYlNhPjBbR8lLYtMgw1Yr+knJGdpYYyCm6PqLl1vWDhA3
         TUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D/R3jzjVcEYBo/K5bznfSK6WiA9y4jMG3VEZErXfz2A=;
        b=ALmlTCcZs5gWjUk5VFU9dNN5IRLmtKC2Hae2X+8liFbZnhGpJpELSufZ/mRq4jW5/3
         hrVhEq8FSdgVN1FTXL8JvBEeGFOa4oZ2TrmvaXnmhVtVbhpNJ7vGplhwuHCJbnggBUeq
         Aj/TM/JucIsA58Z79QiGa9xuE1H1+Ld6jTOFNbYc6ceXZL/jjsN6Op4fsPpTnzoGWz5p
         wGTZ40SlbP2CkBiC+eBNbCsue91v6nQuRf1yq1Z2RPg/9PQsLW+TZoxmiZ7+vNI0dHpA
         TBt9wtpAvJCkP2t2YHbQkX1ayqmn1EiQxXB1mztA+ocRpFBQE1OEVbwHP5WrrXT9UMDa
         8kpg==
X-Gm-Message-State: AOAM531g0k0gtrrXDBB2G+zu5OcrQRI3hT4jQs1v7fQ7j4WTpdkL5HLX
        bKj4Or9EtSNsR1MOAOQnL18rmAH6SMeSUi92jaURWFyiGe8tC00O
X-Google-Smtp-Source: ABdhPJxUdR1jrGMplpW6bQewo/wfUEVww1xWQJ786aOjyWsL6ETQX+/C3M5ct3OrsJZrtBH4Uo1JhUQL9vqYGBASv9E=
X-Received: by 2002:a9d:b85:: with SMTP id 5mr6395144oth.281.1613730052416;
 Fri, 19 Feb 2021 02:20:52 -0800 (PST)
MIME-Version: 1.0
References: <20352639-deaa-0e3f-c99e-9bde937d67f9@gmail.com>
 <CAP8UFD1VaOBWcf3RQTc6OdmkUZCOOOO0mubRoWAvao6uNtNkgQ@mail.gmail.com>
 <CA+CkUQ97+Afr9TUtKnb4LE1tK8z=UfSkJY2JYb5RJKTMJXQ-Bg@mail.gmail.com> <CAP8UFD3ivxTzrUxCARopyFBsarvxTSdTeQpdQahDDtsELjy1AA@mail.gmail.com>
In-Reply-To: <CAP8UFD3ivxTzrUxCARopyFBsarvxTSdTeQpdQahDDtsELjy1AA@mail.gmail.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Fri, 19 Feb 2021 15:50:41 +0530
Message-ID: <CA+CkUQ-nu2K-7WTpm8mhr4gA2bateYAMp+qpxHk5=shnO2iFSQ@mail.gmail.com>
Subject: Re: Git in GSoC 2021 ?
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Feb 19, 2021 at 2:17 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi,
>
> On Fri, Feb 19, 2021 at 7:01 AM Hariom verma <hariom18599@gmail.com> wrote:
> >
> > I just saw the "Use ref-filter formats in `git cat-file`" in the ideas list.
> > I would love to co-mentor this one, if possible.
>
> Yeah, great! I just added you as a "possible mentor" on the page.

Awesome, Thanks.

I noticed some text is missing in the project description in
SOC-2021-ideas page. I guess it's due to the angle brackets.
I created a [PR](https://github.com/git/git.github.io/pull/478) for
that. Please take a look.

Thanks,
Hariom.
