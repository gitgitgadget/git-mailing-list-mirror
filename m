Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED05BC4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 07:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99333205F4
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 07:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qBrHyyKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgJEHcH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 03:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgJEHcH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 03:32:07 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EC3C0613CE
        for <git@vger.kernel.org>; Mon,  5 Oct 2020 00:32:05 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id i2so1743928pgh.7
        for <git@vger.kernel.org>; Mon, 05 Oct 2020 00:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DcQy6blphhmWsLRHeF8toRO/A6huUkXrRbUme3zrNuE=;
        b=qBrHyyKrTV4upsDMBaK3BYrbrsiqt2448LmmipKQPTFG/2mr+79GNs4r6ixPNkhhAc
         lUlM+F7TXSYuBvvvX8jKJEILQOtpGnXNIj506aruwGBROLl59KinMItmrpXgWjenfbuX
         f+WQMNtdlp0BvCMJCE4PluP9mvtrfvCHhCfM1fUfdBoJHy3ndd9n7AbKMKMfA+PmwAEZ
         ztew5xF9RYn+Tpezt9CATZUzSM263Vrp5F3A4rs4jhoX+G/FuTJUAnjk3v/X8gb/IM3v
         tKC11mQzCYQFdbuRzcHJkWtd+Tb8taVWrrtl2MifybuTYVBP7+Fo7nRcrNxPI4HSsbAs
         /PBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DcQy6blphhmWsLRHeF8toRO/A6huUkXrRbUme3zrNuE=;
        b=Hz0Bg2WJM5GL6HlHRRWIGCKQh83P770+gNQpPB7lQPb3vcPBTZsrnhNUHwV3zAgXOZ
         XhlBuL4t9sgLklGl3008yrpkXrUaaYnULdXo00auUEV5wabA2qdzF53EZO7pU5FHIxSi
         7jUTT/AvE8RMjbeASBsQQueub+zDew9Uru81dsQTd1nZIAvGwFsTzC7xFCc3RupRetzZ
         9mY2/LqMw1uM0NF1BKQKK00J3pYLEnK/qkCmodBopwvGtMr/tfYPpN1xxReRyf49b/MZ
         BVuUbU7RDAZeSj0JUifUc4UIpEJ6nczXqsvQazY39ZclrlyVxJcFBBxEQ4zywebFvdmS
         Y+hw==
X-Gm-Message-State: AOAM530dpf8rtToqrrHIJ5gWTzfDNV626oRYoRd0UOe97Rtj21u7j7vs
        NfuSkwmqEWkQ2sb4mU9yJG3xwODP3sg=
X-Google-Smtp-Source: ABdhPJzLgnAF63XSqSIymsNdyp44EuU+sFg9KCc3nAecjrD4KS3Q+TNJ6gOK3b31i1bADgsr1U2UaA==
X-Received: by 2002:a62:8106:0:b029:152:1277:b5b7 with SMTP id t6-20020a6281060000b02901521277b5b7mr15718256pfd.1.1601883125077;
        Mon, 05 Oct 2020 00:32:05 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id gb19sm9573717pjb.38.2020.10.05.00.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 00:32:04 -0700 (PDT)
Date:   Mon, 5 Oct 2020 00:32:02 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/7] forbidding symlinked .gitattributes and .gitignore
Message-ID: <20201005073202.GC1166820@google.com>
References: <20201005071751.GA2290770@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005071751.GA2290770@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> About 2 years ago as part of a security release we made it illegal to
> have a symlinked .gitmodules file (refusing it both in the index and via
> fsck). At the time we discussed (on the security list) outlawing
> symlinks for other .git files in the same way, but we decided not to do
> so as part of the security release, as it wasn't strictly necessary.
>
> We publicly revisited the topic in:
>
>   https://lore.kernel.org/git/20190114230902.GG162110@google.com/
>
> but there were a few fixes needed, and it got forgotten. So here it is
> again, with those fixes:

Oh!  I'm excited --- at $DAYJOB we've been carrying that patch since
then; I'll be happy to drop it. :)

Jonathan
