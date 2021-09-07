Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571EEC433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 18:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26B1B610F8
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 18:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345814AbhIGSVw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 14:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245718AbhIGSVw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 14:21:52 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F3BC061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 11:20:45 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id p17so6376313qvo.8
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 11:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hg8QhNlyjlBQIOaGkvNmlGh3jZz2Y5T8jlB4VuuKHDE=;
        b=N08NB7lwtAWVeIbDNR2/oFw6RGbRN27b5Xd4C9+zwV66YAHXh48fyuF6nZJwKbTX8t
         TnqB3XOH0mStIIa95x3CmTN75PqzgB7I/YKPS16rQuvKfdhPQ4FcziOGZjZdokpJxuRh
         mMfuaFzd8D+Wn/em8zItKaMrI5A4UV+3wHdXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hg8QhNlyjlBQIOaGkvNmlGh3jZz2Y5T8jlB4VuuKHDE=;
        b=ZRhEEtuAzstqIXqi/bBo9lYUqulkia37dDo05VmUhgkaeO1kmkUlbDSJIvFkdqmErj
         +6KDwvMElEoEaX1NdXcaBSZ512HOAyOPvdyOrUPTwPwT/1yjcS6dzRKzj2UYdT4E0d7Q
         tzXDytGXSxbJuODp4naHeEoZ51PrulHkeZEYpn3aaZOn0LUpFmK+YrqHU+KcJKF/sKnb
         AE83gf2bQEx5uMiEKmp0GwVl63uSCB1yNPO3MPZ/FQSZDM7fIFt4d/IzA6VMEcJymfj3
         2zxMzxJJnpXqi3DmyXECikfGgjji/SSIxTTBXF940VNmntwZz9MX+usjKHyKX77Wqfwk
         DVtw==
X-Gm-Message-State: AOAM531I9mqQj+VPGprvXScyfD0RtRzad/gj3DkHTR+1vX2jFQSmnCu4
        wQ7ZjNna3vzwgETeWxo8WQqdJA==
X-Google-Smtp-Source: ABdhPJzcMxGBQ1aiyQLgrEc+vvzMUIOyGq8voG4kXNoRfez0yBmqE4cWeGVh2pSWjV2R62R99UmkKA==
X-Received: by 2002:ad4:5a06:: with SMTP id ei6mr18708796qvb.21.1631038844873;
        Tue, 07 Sep 2021 11:20:44 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id s6sm9535085qkf.80.2021.09.07.11.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 11:20:44 -0700 (PDT)
Date:   Tue, 7 Sep 2021 14:20:42 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: expired key in junio-gpg-pub
Message-ID: <20210907182042.3ugoaicjt4e3h4fp@meerkat.local>
References: <YTerpXCxYx+f+8ws@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YTerpXCxYx+f+8ws@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 07, 2021 at 02:12:53PM -0400, Jeff King wrote:
> Have you extended the expiration on it? I wasn't able to find any
> updates on the keyservers I checked. But regardless, we should probably
> ship an updated one via the tag.

You can get it from here:
https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git/plain/keys/20D04E5A713660A7.asc

-K
