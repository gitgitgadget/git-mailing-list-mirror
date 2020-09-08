Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0531EC43461
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 19:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3F6220757
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 19:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXNgaoVd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731417AbgIHTBv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731292AbgIHTBk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 15:01:40 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD83C061573
        for <git@vger.kernel.org>; Tue,  8 Sep 2020 12:01:39 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id c127so3901713vsc.1
        for <git@vger.kernel.org>; Tue, 08 Sep 2020 12:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=91oPyfKAG+c0UuwomrRGfk+WxfBB4lrVqlCulgmdvhs=;
        b=eXNgaoVdF97vont+ZZd6QA31/Zkm9S+qs++eQ3JqAgvvV80pOI+n4kb77eoh12JPPj
         TaYES6RceIFd6GbH1wtcBACcx4qYINSeQQSYKIfsckbB+ltuw6re11Z7AhsZbM5FqoaB
         mhhy5y9ONe/xB04GpOgj4YSXnd43pGYWjhzOB+WV9WT6rLreAosSSFItMDGBmlI7JO+v
         pWkeASd1lLw4Alvfy5+XcYG4DtTnKynbxirV23walMVgYIBz/sdXahdq2K4/FB0hYfxJ
         HoHe9mINIq5dJiqrf+bcER5+lKcHWK5AXC7ZP02aesJnkiPBcBRzy8Zq1P/+RAS1JysR
         TtoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=91oPyfKAG+c0UuwomrRGfk+WxfBB4lrVqlCulgmdvhs=;
        b=t7A0QtZNJj0O8pyiTC76EWHt0wvFhQK/YPGkt9BXlMC/oxjB4uzNIGiHAhIDcRbT0g
         nniqAyt2835oR/0lZQV11+yuhfsfVlxWYGxKAR30ulXQOlVkhdR2wtqCGgACaMyeM53n
         doLDpnpXl9neoOGqLhrfq+mbzGuW7CvqMJO67flxifuOrg6iU2JuoPHGmsHMQ6okgHxn
         q4CKpHrS0VbgemsExY9ARLc62Js7zbJ28eeddP3JEX8/dTgSWDOxdpnPGvx/4BK1BX1w
         Mf0sWh7NHyiWIzb6PwyGHsMd9ijH6AxbKBR2YXtpQ/xPa0Z4POt/5ZMPemRSF87sXuaR
         vjLg==
X-Gm-Message-State: AOAM5336DhF7SVv0Tp1mDWrQpgySpYYy7y2K9z5JS9MYOEhqk3vcmQt+
        Hsa9X+ErGQLwInw/VqHVDbrZYCvF+jTTshiuLNE=
X-Google-Smtp-Source: ABdhPJzSE3/F8ZdTqg30g23L/flHSSSaMRWMMI85yXMCIlb3EAyaMjw9483reXA3rcPO9ugbLR7V7DSZ8yDaouiq4h0=
X-Received: by 2002:a67:7d52:: with SMTP id y79mr441299vsc.34.1599591699029;
 Tue, 08 Sep 2020 12:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAMRL+qb0YC1EOTM-LDfMpJ=AJJ014LT5ufBcs0v77byN74A0vw@mail.gmail.com>
 <20200908011756.GG241078@camp.crustytoothpaste.net> <xmqq5z8p12ds.fsf@gitster.c.googlers.com>
 <xmqq4ko8yxp9.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq4ko8yxp9.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 8 Sep 2020 21:01:26 +0200
Message-ID: <CAN0heSqJDbMB5=p+OBd7ucph3-XCb+WSi4HR41pVa_0AMsGPWA@mail.gmail.com>
Subject: Re: [Bug report] git status doesn't escape paths of untracked files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Patrick Fong <patrickf3139@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 8 Sep 2020 at 19:44, Junio C Hamano <gitster@pobox.com> wrote:
> I see some mixed use of stdout and s->fp in the vicinity together
> with "fprintf(stdout, ...)". We may want to clean them up someday,
> by the way.

I noticed the same thing. I've come up with a few patches to address
that and some other minor things I saw on the way. I'll need to test
some more before posting, so this is mostly a heads-up for now in case
others are thinking about jumping on this.

Will try to post it tomorrow. There's nothing there that needs to block
any fixes to the escaping, obviously.

Martin
