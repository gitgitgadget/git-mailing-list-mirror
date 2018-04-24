Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3BEF1F424
	for <e@80x24.org>; Tue, 24 Apr 2018 22:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751285AbeDXW7v (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 18:59:51 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:34779 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbeDXW7v (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 18:59:51 -0400
Received: by mail-pg0-f54.google.com with SMTP id p10so11925425pgn.1
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 15:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lW1N0QzhB452Pfapc6wfdwyM1doY/LmuKCtbfu76SUo=;
        b=Pb6s/rFTq8igxnuWTVHt+ic27vB4+yr1ec88T2BoL7bKZGrytBsuFvWADYxGmy6ra5
         UTi+bPwN4OPZukvGbYl95CGRRIOf7tuJK4lE0+TvRF6YrUGPRiG+5JNKYO0U3a7UWZJL
         jIQTobneGzKwE2SaJ2mNSEiibNg2MXs6wlhtcW/EWyKmCF3tXI+LoKEomNlz6bCwM4pm
         x39498I5ZVSeczjBS8pbPr+mgwpG3/1I8EejCmlQBFQQT5aCw/g84OJdVT7sV6L06aPG
         F53FGqEkVkkXsgI5MR1sv3L68d2Q5ez11QEh251zVHGJRO3o7nh4W/003ZCfpOzaOe3x
         IZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lW1N0QzhB452Pfapc6wfdwyM1doY/LmuKCtbfu76SUo=;
        b=Z+4KBBceOwBv8fl6x0O6DgXnpNKf0cPt3AvkSFP2Sdm987UoctrgYo2ElpskVSMXrh
         gD/VImrbMH1nwCtPLT9PMTe0CK/e7AHC9mfOdyFXCPOMAA9PduwOJbLh+NND3XWs5wKj
         H9QySh5jd43nD0yORPUQEST1SKWJQg7GZbAqb59zFLLGSJxqnicz7un8usRIIPm5DWXv
         /FdNW/g8lLCtjNVHfasMH7zpZOQ1m5u9x93xO/ipVsivGBt3wMeRsVRg5lkdyq4Ewxzx
         dVFm/Vh/83nuK9HX8k61kzdHSpYvHz3dTGpd/07az+NUdeXrsEAJ1xlKB/g31jGBiiKG
         wBPg==
X-Gm-Message-State: ALQs6tAWIFg1FOvOAUemOF7ybNSVjUywqZxzBTRov1ySTrhDONGDpudQ
        aDSsrzlH4Q87roUZT+1Hla64lQ==
X-Google-Smtp-Source: AIpwx48o6VpI3+zGf2Hb0RguOmimRUXoHKwKKDbzY4XtUXdDWs2fNix9RM90wFlBLc+DzP0QkyvCvg==
X-Received: by 2002:a17:902:760c:: with SMTP id k12-v6mr26873688pll.338.1524610790428;
        Tue, 24 Apr 2018 15:59:50 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id m7sm34753540pga.46.2018.04.24.15.59.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 15:59:49 -0700 (PDT)
Date:   Tue, 24 Apr 2018 15:59:48 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Simon Ruderich <simon@ruderich.org>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 5/7] diff.c: add a blocks mode for moved code detection
Message-Id: <20180424155948.e37a0d12fdf0e2fdafde153d@google.com>
In-Reply-To: <CAGZ79ka9Tdk=ijbw6Hyxs9OsBMK9O69_3_cY8oX2j=wRc_F5-g@mail.gmail.com>
References: <20180424210330.87861-1-sbeller@google.com>
        <20180424210330.87861-6-sbeller@google.com>
        <20180424145050.e0ad29d4f304216441656057@google.com>
        <CAGZ79ka9Tdk=ijbw6Hyxs9OsBMK9O69_3_cY8oX2j=wRc_F5-g@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 24 Apr 2018 15:37:51 -0700
Stefan Beller <sbeller@google.com> wrote:

> These can be combined independently, so would
> you expect the user to expect two options for them?
> For example "--color-moved=zebra" could be split
> into  "--skip-small --alternate-blocks"

Yes, this is a good explanation. Reusing your terms below, --skip-small
controls the algorithm, and --alternate-blocks controls the presentation
layer.

> So instead of building blocks we rather want to split into algorithms
> and presentation layer?
> 
> The presentation layer would be things like:
> * use a different color for moved things
> * alternate colors for adjacent blocks
> * paint border of a block (dimmed zebra)
> 
> The algorithm side would be
> * detect moves
> * detect moves as blocks
> * skip small heuristic

Yes.

This was just brainstorming, though - this might not be the direction we
want to take in this patch. (The right solution might just be to always
use blocks - thereby simplifying the algorithm aspect.)
