Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEAAC4741F
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 23:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90C4220867
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 23:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GYeSYJ+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730774AbgKDXCD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 18:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgKDXCD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 18:02:03 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F3CC0613CF
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 15:02:03 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id e7so18550722pfn.12
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 15:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=izVTN+hnzs6ZOIILe6YRejwuoRD1jFsNwopoESnzpjM=;
        b=GYeSYJ+thryhffyq9EUNzmxOaNpXrno/O/gdzkYJ32vvanFg+6cZ18D+pCookJy+7l
         FAqEwpRorUgaJ+Qxs3TEWEb7j+sbWnRFl4OuAqCvP6KP2QTR+KXAaozlkJFqlhbokHKQ
         R0HX1gT/Fb5TeERaMfOZqjoKN6dzOxUxyvVwnLm6HlX0wumBVfrswF3n9o/DPPGyi6WW
         IxcadQ9j5IP7E6E9GlzslwYLTy1mjzkalsntyQUGuKGsSN48HYhWBeUFzvh2U0JsN9uM
         R275Xpk0ofOsOQvykd21fommj8qiKaB4demPr18MAleaeEDVISqxKk4TE+CIPFxF7bZx
         d+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=izVTN+hnzs6ZOIILe6YRejwuoRD1jFsNwopoESnzpjM=;
        b=FVC2jV+M599u41vLQdcWb4N9XUQZafu+14f7943oLYLhhwhJkXqj6KR/zyhnlc3Eht
         fliGOKjp7esSpvkyybU1THU0p/0bCAJA48eGqFcKTVqniBQ5pNcykvyUZXz8+gPQeJZ3
         jypDT7OxZ1rHKNxyOauxjjrfzRdvh4RIkiQTJgC3yjkN835aasJy9dSj2SbO3xnXhZsZ
         84HnAizYsurPfu7OtAA57zFCaFlES88Ei75DzjAnjYs80WQfk8mmXyeIzRzu8bzdVrVO
         kMQRy0cSGznfEsGf13+On0t8VhAFnP8jj/Az08Rn8+7tGBUl3uezavXvGxaHPvOTnePY
         PtZQ==
X-Gm-Message-State: AOAM530P6qCGtB+mnZ7gXcFRTPCYczKVm9xg0vZJSFdajP6I9e93z7Aa
        UTfx+2KnltqoR1i3/UlQPRC/sQ==
X-Google-Smtp-Source: ABdhPJz0KV4TOxVa4HhofrPosxzgaqHJxgr6fGCOxu3GWTpPS8twS+SsWBhLreousg00K0a94yFhGg==
X-Received: by 2002:a62:f901:0:b029:160:b5d:fc40 with SMTP id o1-20020a62f9010000b02901600b5dfc40mr76782pfh.55.1604530922722;
        Wed, 04 Nov 2020 15:02:02 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id z12sm3578568pfg.123.2020.11.04.15.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 15:02:02 -0800 (PST)
Date:   Wed, 4 Nov 2020 15:01:57 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 0/2] rev-parse options for absolute or relative paths
Message-ID: <20201104230157.GH2774782@google.com>
References: <20201009191511.267461-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009191511.267461-1-sandals@crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hiya, we took a look in the review club, but I'll try to keep it simple.

On Fri, Oct 09, 2020 at 07:15:09PM +0000, brian m. carlson wrote:
> 
> There are a bunch of different situations in which one would like to
> have an absolute and canonical or a relative path from Git.

I think specifically you are interested in this situation:
https://github.com/git-lfs/git-lfs/issues/4012

I think this would have been useful to see in the cover letter :) There
was a lot of "but why" during the review club meeting.

Looking at the git-lfs issue in question, the problem seems to be "how
to make sure the path Git gives me will match the path Go gives me" -
and like you mentioned in the issue, there are two ways to fix it.

Also, there was some brief wondering: if this option is useful in 'git
rev-parse', would it be useful in other commands too? I thought maybe it
would be more useful as an arg to 'git' itself, but on inspection, not
really - because you wouldn't be able to switch the format in the middle
of a bunch of args, like you can now. The way it's written here,
though, should mean a smooth transition to something like OPT__VERBOSE
or OPT__QUIET if we discover lots of folks would find use.

Thanks for sending it. I'll try and do a detailed review of the patches
themselves. To me, the concept seems sound.

 - Emily
