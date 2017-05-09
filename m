Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87EB92018D
	for <e@80x24.org>; Tue,  9 May 2017 22:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751009AbdEIWwX (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 18:52:23 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34478 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750987AbdEIWwW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 18:52:22 -0400
Received: by mail-pg0-f50.google.com with SMTP id u28so6764986pgn.1
        for <git@vger.kernel.org>; Tue, 09 May 2017 15:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J3a8ZVtmPkrRQ9FNwx7CzMnY6JMbXSdRmqJPEWB0q2o=;
        b=gkSL505uDkth2B5kvHdnlvKQyg38ZPaEqVB+a9YOyx8m+nXIgunWqYC9nrQGOi4geR
         B4IuzPIHQXwFInNjPFnccKpZTSjD9DeY1Aj7z9kWxrNXzflCzbZ8oOuMBLuOuWidOa3z
         FIAcQvK2npTiwqZyD7OOBs8i6J9E8cIqZ1GvzwrOD//JJigcgU03IClkVkWLd7V4BKBZ
         OOQbZK5xkUftzIAIjb2cYyHtTBq2oT4eInigC+8mo6ZuG2X6Xhz+6Sjb9WZ7lw5Pw4me
         ipJn/7oyGB18VzwkI83vO1ccETYjugHPLLE2p3dO46uTvG5RhR6+lZVOvJJ430xw7V+w
         gIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J3a8ZVtmPkrRQ9FNwx7CzMnY6JMbXSdRmqJPEWB0q2o=;
        b=cjELlqZUO/mQ23XxfaJ3azVTbefWMACU6Ifpfwm7Zw91PSz+k7f8yJDGZJJ8DKGWNI
         Dd3Sq+PqJEfF3TMojEOCS71Zc6ip5+lU97ZotZIiBsC+DX+xDjjl4mSaK9WZ+vNaspas
         sRO2T0SkXGZRHFj+TKL6p6iFyrBD88oO+EFte/iZIbnxO8m4F+ZaJbash1rOLfkqJsuG
         WoRTh9bfxS0bfA0Ur7N+yqgqmItiSu38GGngGCG6Rs+gWumKSC/o71rtVqN8DkbwOIWJ
         TZs95CYNO83VkyHDUlD9BpMEpd9XG5fK54O3boNaO0CzG7nJ75mN5W6YX+f2tVZlU9CZ
         gncA==
X-Gm-Message-State: AODbwcBW3GYHM/PV/d/pQ8FmZsn9arO4FnJkGzup2dDPbSG02dPpiGIw
        7AzO/q2MoQyzeLTP
X-Received: by 10.99.101.130 with SMTP id z124mr2883190pgb.8.1494370341967;
        Tue, 09 May 2017 15:52:21 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:b127:d26b:19a3:378d])
        by smtp.gmail.com with ESMTPSA id p68sm1694117pga.6.2017.05.09.15.52.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 May 2017 15:52:21 -0700 (PDT)
Date:   Tue, 9 May 2017 15:52:19 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] :(attr) pathspecs can die("BUG") in the tree-walker
Message-ID: <20170509225219.GB106700@google.com>
References: <20170509222432.3dxt7osjt2zjtaiw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170509222432.3dxt7osjt2zjtaiw@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/09, Jeff King wrote:
> I was playing with the new :(attr) pathspecs in the upcoming v2.13
> today, and noticed:
> 
>   $ git ls-files -- ':(attr:-diff)'
>   t/t0110/url-1
>   t/t0110/url-10
>   [etc]
> 
> So far so good.
> 
>   $ git ls-tree HEAD -- ':(attr:-diff)'
>   fatal: :(attr:-diff): pathspec magic not supported by this command: 'attr'
> 
> Bummer, but I understand that sometimes the options need to be plumbed
> through to work everywhere.
> 
>   $ git log HEAD -- ':(attr:-diff)'
>   fatal: BUG:tree-walk.c:947: unsupported magic 40
> 
> Whoops. This is presumably ls-tree is protected, but I think we are
> missing a GUARD_PATHSPEC call somewhere.
> 
> This isn't a huge deal, as the correct behavior is probably to die like
> ls-tree does, but we probably shouldn't be hitting BUG assertions as a
> general rule.
> 
> -Peff

The die("BUG: ..."); is from a GAURD_PATHSPEC call.  What really needs
to happen is to update the magic_mask passed into the parse_pathspec
call which initializes the pathspec object.  Its this magic_mask which
catches unsupported magic and prints a better message.

I guess this means I (or someone else :D) should audit all the
parse_pathspec calls and ensure that 'attr' magic is turned off until we
won't run into these GAURD_PATHSPEC die's.

-- 
Brandon Williams
