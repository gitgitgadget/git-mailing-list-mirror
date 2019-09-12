Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 192E61F463
	for <e@80x24.org>; Thu, 12 Sep 2019 02:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbfILCIv (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 22:08:51 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45772 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfILCIv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 22:08:51 -0400
Received: by mail-qt1-f194.google.com with SMTP id r15so27792545qtn.12
        for <git@vger.kernel.org>; Wed, 11 Sep 2019 19:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pEA7/OyWtmTMkfGSvDPnoSiFK5Jpl9V9F1Mg00wHftQ=;
        b=nd1786+fVMucQNJPHqgRb8qs3xkA8UKSV55QiaCd8Z0WgTyDDrf8h7vxYz94E8+jQ9
         GICibAXPLNVaYcoYublWPHL3e2r64yYFrQEvxElJEI9P6CO/eAYvLzFQfpoDxeJknOxp
         1wTeRxknqHzV7tUZdC1mDvzHk0nrW1YMWMCrNG+1WjZAI6RUG2aVMUPies7gqqfNn8qy
         j+Bo+raedhJ1VzJRx09yv0wmnakhaclUde7Y9PYwkfNGWlXFZBSjQc1G42//Mrs626ms
         VHLDrlgj0qtR6zyM//XAurF5xn2SW8BmcuaI7GvECiP057jhjMR9X8V1zgw2tEmRb6/h
         TDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pEA7/OyWtmTMkfGSvDPnoSiFK5Jpl9V9F1Mg00wHftQ=;
        b=KtRo557XVQTx5PtEKMp5wHBlevAOlLp2gHwn5wFBZLZcEgCc5tLWjB/hxo+6TpkT2K
         Zh1CjPlb3cIhbPl8ukMY7NJ2qCyDfSI0LzwjcDiH0ThZXANxkfUEeAdQ7MkIlQ5S2I4v
         aPFDiqAdKeKZzq/V7WPnmSt1X4eByHr8LDcj8WQgfjhCRcnvkBc4cGkccBh8D9Dk1UTA
         ck1W/3IUXm6+yj9SFxfM6X1KvLngBl0iTpIKpj06R/+a8/YzswNFPbbpD2xqReEnwg2g
         Gr6vnxGIWG6/Rvjf4iZ3e4gGV4lUs4F3czq8q0WAnrAyoLM7wOMF2ptOq2BwnS3FUMxX
         CV0A==
X-Gm-Message-State: APjAAAUWM+/PPYpSW4kAmjalKjiRWFW6ekfWcE6FY/rqlQ2Tv9j+rJiL
        6hfPaCWqcFqlFJmeTHUViCYoLA==
X-Google-Smtp-Source: APXvYqw86aflDY1fdP66nhg6/UFGYjiUPamnbcLXXzDsnuVJJM3NIhcHIVvQpfSUGJVm1nMgt+vaMg==
X-Received: by 2002:ad4:4772:: with SMTP id d18mr25299153qvx.100.1568254129257;
        Wed, 11 Sep 2019 19:08:49 -0700 (PDT)
Received: from localhost ([2605:9480:205:dfe1:501f:b6cb:9c99:ccf3])
        by smtp.gmail.com with ESMTPSA id d133sm10420687qkg.31.2019.09.11.19.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 19:08:48 -0700 (PDT)
Date:   Wed, 11 Sep 2019 22:08:48 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] upload-pack: disable commit graph more gently for
 shallow traversal
Message-ID: <20190912020848.GB76228@syl.lan>
References: <20190912000414.GA31334@sigill.intra.peff.net>
 <20190912001846.GA31370@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190912001846.GA31370@sigill.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 11, 2019 at 08:18:46PM -0400, Jeff King wrote:
> On Wed, Sep 11, 2019 at 08:04:14PM -0400, Jeff King wrote:
>
> > When the client has asked for certain shallow options like
> > "deepen-since", we do a custom rev-list walk that pretends to be
> > shallow. Before doing so, we have to disable the commit-graph, since it
> > is not compatible with the shallow view of the repository. That's
> > handled by 829a321569 (commit-graph: close_commit_graph before shallow
> > walk, 2018-08-20). That commit literally closes and frees our
> > repo->objects->commit_graph struct.
>
> A few notes and curiosities on my patch and this general area.
>
> The test suite passes with my patch both with and without
> GIT_TEST_COMMIT_GRAPH=1. But to my surprise, it also passes if I delete
> the close_commit_graph() line added by 829a321569!
>
> So it's not clear to me whether this whole thing is truly unnecessary
> (and Stolee was just being overly cautious because the code is related
> to shallow-ness, even though it is OK doing a true-parent traversal
> itself), or if we just don't have good test coverage for the case that
> requires it.
>
> If it _is_ necessary, I'm a little worried there are other problems
> lurking. The whole issue is that we've seen and parsed some commits
> before we get to this shallow deepen-since code-path. So just disabling
> commit-graphs isn't enough. Even without them, we might have parsed some
> commits the old-fashioned way and filled in their parent pointers. Is
> that a problem?

I am, too, but I don't think we should hold this patch up which is
obviously improving the situation in the meantime while we figure that
out.

> [snip]

Thanks,
Taylor
