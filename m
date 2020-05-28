Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B28C433DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 19:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAA28208B8
	for <git@archiver.kernel.org>; Thu, 28 May 2020 19:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IRa4wapR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406230AbgE1TMg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 15:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406147AbgE1TMd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 15:12:33 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D708C08C5C6
        for <git@vger.kernel.org>; Thu, 28 May 2020 12:12:33 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id l3so13483578qvo.7
        for <git@vger.kernel.org>; Thu, 28 May 2020 12:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CVVoVsaa/lK9evItNWCUgTRv/84zh9vDtldSSe+yHyI=;
        b=IRa4wapRu8H8UvC66IWW4RC8vGrUlwXNIg95bCx0Uv1CKTYKgbKnMfNy4Gis8TaCw7
         svBQLfeuyiWCIvkxfnroRWWEZag+PEnozxabhenu4LIWeCyuY3RUqv10wEQsLUuv9h/m
         Hl7eSxOqhxEAU8H65dp+g8v9N87iNzWE9o5IDQp8UItgco0vnsSaR38tkBGOKuIKQ5Dy
         Kpj0yzP/mRPNVmfvXxcws/FBwBBXxkeEJL47XfKtOQK3XLZtClscnQfKWPm/5G+QCvG7
         oZErAApMUfFqiKqejCn2/cT3oBDMavE7pyCaKGriHoPwtt2Bsw1c1PBbk+4sdg3mYAGj
         0elg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CVVoVsaa/lK9evItNWCUgTRv/84zh9vDtldSSe+yHyI=;
        b=TVZAUMeDSjByFDmF/GXXaduvhJek9eP3Nhz0bF9excCscrHrkjauQJRkXwwpQ5hm2B
         qiZyfw4WQlqHLKBM+l1KZ8URUIFJxveuefKq77d2OudQxz5+ltPcTwroPtuofCxv/lio
         88PONJmarQypaTIfRuS2AIElR88zsxpoQcLj8h+LMVkwSnApSDB4t/L82GNhKfejj/i2
         NHCjrtaxLCNW+ggsVfk3sHvtHUhqsGeloX9DLmUPRNdmi0AXozYaBUXOrXnrBi/okAAu
         zkce7eZcV3VJZ9Y6XCHiqJoBY6CKopMY4XMjbYzQihLdhx0t2d4YHZ6KOEkNKiqqB67t
         xW8w==
X-Gm-Message-State: AOAM533w4j8UcujSsjx1YShWqkpXu5LeN+PdOc4wGTE0/T8H3ruP1Bss
        4JeBREnfbxQxXwg0Uth+iyAola2qIa4wP7lmmoaX81OA4/w=
X-Google-Smtp-Source: ABdhPJxShsuZV+83g7t7pcNcvONFDB/7uBedKYP7qmLEyI+0I6/+5mJ/uW5iKuvKxVotd7Q9Ofi8ATVxDfARI4tFgoc=
X-Received: by 2002:a05:6214:72a:: with SMTP id c10mr4475177qvz.189.1590693152022;
 Thu, 28 May 2020 12:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200528025359.20931-2-delphij@google.com> <xmqqsgfk3xtd.fsf@gitster.c.googlers.com>
 <20200528171924.GC58643@google.com>
In-Reply-To: <20200528171924.GC58643@google.com>
From:   Xin Li <delphij@google.com>
Date:   Thu, 28 May 2020 12:12:19 -0700
Message-ID: <CAOhzdugK7FQSnWruUrX8gQ98AF6kGvNWqPfHmE+qjGjBgzvmiQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] fetch: allow adding a filter after initial clone.
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 28, 2020 at 10:19 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Junio C Hamano wrote:
>
> > It would be safe to upgrade version 0 repository when there is *no*
> > existing configuration variable in the "extension" section,
>
> Yes, that makes sense (also for the case Brian mentioned where someone
> may try setting extension.objectFormat, see no effect, and then forget
> about it).

I see that's a good point

I found that the current code doesn't really check
repositoryformatversion for e.g. partialclone, so without setting
repositoryformatversion to 1, just setting extensions.partialclone =
origin will still make fetch --filter work and some test cases are
depending on this, do we want to keep this feature/bug?  I have added
some additional checks to my local git version and found that we would
also need to fix a lot of test cases for worktree, etc. if we would
enforce the check.
