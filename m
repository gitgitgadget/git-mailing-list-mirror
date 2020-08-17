Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8660C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 17:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B41902063A
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 17:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TS06ACwc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389268AbgHQRbN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389167AbgHQQ5w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 12:57:52 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B53EC061342
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 09:57:51 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id e11so13965321otk.4
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 09:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a6hlqvyOHsRd2UQSiHfzY3nPQMlFWOZIIb1bpLTSpnw=;
        b=TS06ACwcy1Z9cr9dpYK7f5lRaY6vSmcFZsogfkzUlsmJgyQKOAMV/H8f6FWFHUDz6x
         61N5Iq3U27ZtDKHzsmJckc4ytwAsYkIW7g9gHA4P0Y+FheAN0ia6DwG9dH3UNwTubqrY
         bxmdnJV3goQWnXu0PBH3nOmPyw4E1rpGG/dwLUOw0VBPCNE3mU764FqauuJBvvCXjMny
         kh6rk3KcffOyWjmchoyQ6QEzdT7adYH/8m8sBfhgiwqGORCmuGsbdbI4Sk6kQJBwYZqf
         amiqDM4JilYZLY0Vq44jEEJAUJ0vXpBxkMmtJQWzXb3bzkG2DQyuadhLgSL5SH8Oz3VN
         0jdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a6hlqvyOHsRd2UQSiHfzY3nPQMlFWOZIIb1bpLTSpnw=;
        b=JCwEubZrcsCpRuz/OEp5WCTnOdCcXis8YCBuaPk14cI28sYbvj8XdwH0t/5Z/PEEar
         ZmCuHBprrwKwA7RCFzJIC7KdCB5ZqEXwEFwN8ZPxSAg6gWDy9jP5O/vaV/2xaZDZQ2nV
         S6V4oaQNnxoaThuBimrj3PncVSEtI9+jCiCOmUwmMiw4QV10Ubr1/cmmBgaG3fJ4hQIP
         nvy/6rAYh0l2q6jGDaqaMPQTG3hB4gG70Y/faRwcX9XD2RInTbwwha4cIqtTriT45wEK
         JO56TOJa+1kdGomk8+gKBB3TDPuNsE+taEeasiHMyTNzNVgE+1KrN9uW1o6fv9955noQ
         Q2hw==
X-Gm-Message-State: AOAM532W4yH+PopcKB0dWYoQRHqDvGS7InUZmZ3lCKGJt4+F0V+T2cDu
        wSR2Pk6PNNfJ2EbOvtFkE10zPet3zABg+XvZDAs=
X-Google-Smtp-Source: ABdhPJylu+VbFxNwh4xXFdHjBZsq1b17XIllHpX02dfjCv7H0tO9/HU70qo2vNgdhSfymMStLZQDgxsKpWNUdDwKZOg=
X-Received: by 2002:a05:6830:22c8:: with SMTP id q8mr12119755otc.345.1597683469859;
 Mon, 17 Aug 2020 09:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <pull.831.git.git.1597561152.gitgitgadget@gmail.com>
 <932741d7598ca2934dbca40f715ba2d3819fcc51.1597561152.git.gitgitgadget@gmail.com>
 <20200816084328.GA1221900@coredump.intra.peff.net>
In-Reply-To: <20200816084328.GA1221900@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 17 Aug 2020 09:57:39 -0700
Message-ID: <CABPp-BFBcMaPTvxE_PYqpHzo5zUG=Lv7Y+Oq2yCRYxRTgRQgLA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dir: fix leak of parent_hashmap and recursive_hashmap
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 16, 2020 at 1:43 AM Jeff King <peff@peff.net> wrote:
>
> On Sun, Aug 16, 2020 at 06:59:09AM +0000, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Commit 96cc8ab531 ("sparse-checkout: use hashmaps for cone patterns",
> > 2019-11-21) added a parent_hashmap and recursive_hashmap to each struct
> > pattern_list and initialized these in add_patterns_from_buffer() but did
> > not make sure to add necessary code to clear_pattern_list() to free
> > these new structures.  Call hashmap_free_() on each to plug this memory
> > leak.
>
> Beat you to it. :)
>
> See: https://lore.kernel.org/git/20200814111049.GA4101811@coredump.intra.peff.net/

Doh!  However, you do need to take care to free the hash table in
addition to the hash entries, or you'll still have a leak (I actually
made the same mistake)...  I'll add those comments on your patch,
though.
