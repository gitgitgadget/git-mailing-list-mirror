Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B8371F461
	for <e@80x24.org>; Wed,  4 Sep 2019 21:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfIDVVY (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 17:21:24 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42953 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfIDVVY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 17:21:24 -0400
Received: by mail-qt1-f194.google.com with SMTP id c9so178948qth.9
        for <git@vger.kernel.org>; Wed, 04 Sep 2019 14:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xeo0fVaD2MJ/BjOpkZrNpzjOF4URjgNj2B3OtBOWzOQ=;
        b=Unh8/vX1FZhUWKihi3d4TfPTOyaTcFH2AxADnRoWTEBxt7toa4cqLdH93u8BYlA9Kw
         XREGiD79Og1jQ/dxHJn7YpPS/yFgfoiUakGxWPvV6lwNjjQJFVqJO/6MChKCmqaomlCk
         Fj8VstSdQOFS3fnpKrtvAWsZdFYsZ82jeSNJBavYPzFt5Qni7BFp1ywKHynnkHxfAl6e
         MeTgkHZpmBflM15tRGJvlcmdEj0hyGfdEnbc4svBuTdPaOA20GYT7cjcdzgAS0nNOBg7
         pLiHXCrk/vw0jDe12WCQb1e0QEbtvCCyiOonFOBDAGel+6YumJzLIb3HMF81iwQkeXxC
         xcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xeo0fVaD2MJ/BjOpkZrNpzjOF4URjgNj2B3OtBOWzOQ=;
        b=t71cJS41zq+sY501WiWbwObLOqY35xyhr0+6k2Qy5xbILAzASWaLxD/tp9jc0dRQ0y
         xRh+Wr1Ok+V7M7FQp5cgXwLeQ2sRLzwE15K0QR8EBE3XvFAVpEbdtB3Cu9LT/rjlZL6B
         CLfQedIHNSUFZ4c6hqCOcrx+GFIDWvS4iVvUK0yOcNfTUKzxzLtXolc57MDjGVqhlgCI
         hAXfiicyElwHo2RHDq44XLEsPQ2nOq/2PkHZFtc7s67zM/Q3mvIHuvBKdYB7Ben16d4O
         q0E/APmcGvC5vivPiPlrlI6X0jFWDgb7EWHxNZck1JZzLEakZPzNlDt9WuQaNIlEe3a8
         4jhQ==
X-Gm-Message-State: APjAAAVtADmuUMgef3tMGHhw6kMFlP+B0zfdBAwQw12LD0TB2uT0MUTS
        7BhV36s7QBp4WVa3ztiYCWZGqg==
X-Google-Smtp-Source: APXvYqwTCMcufarj/Tw/NX1fq4OEUM+VLAQV58STemZjOxYN+X2dp8NPPq/FMBBap8DoI+NVb4qZ2g==
X-Received: by 2002:ad4:4772:: with SMTP id d18mr30447qvx.100.1567632083293;
        Wed, 04 Sep 2019 14:21:23 -0700 (PDT)
Received: from localhost ([50.49.245.163])
        by smtp.gmail.com with ESMTPSA id 21sm115738qkj.11.2019.09.04.14.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 14:21:22 -0700 (PDT)
Date:   Wed, 4 Sep 2019 17:21:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Garima Singh <garimasigit@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, stolee@gmail.com,
        git@vger.kernel.org, peff@peff.net
Subject: Re: [RFC PATCH 0/1] commit-graph.c: handle corrupt commit trees
Message-ID: <20190904212121.GB20904@syl.local>
References: <cover.1567563244.git.me@ttaylorr.com>
 <c5ba4eaa-f995-5f2e-4f0f-a8f59ba65fd3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c5ba4eaa-f995-5f2e-4f0f-a8f59ba65fd3@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Garima,

On Wed, Sep 04, 2019 at 02:25:55PM -0400, Garima Singh wrote:
>
> On 9/3/2019 10:22 PM, Taylor Blau wrote:
> > Hi,
> >
> > I was running some of the new 'git commit-graph' commands, and noticed
> > that I could consistently get 'git commit-graph write --reachable' to
> > segfault when a commit's root tree is corrupt.
> >
> > I have an extremely-unfinished fix attached as an RFC PATCH below, but I
> > wanted to get a few thoughts on this before sending it out as a non-RFC.
> >
> > In my patch, I simply 'die()' when a commit isn't able to be parsed
> > (i.e., when 'parse_commit_no_graph' returns a non-zero code), but I
> > wanted to see if others thought that this was an OK approach. Some
> > thoughts:
>
> I like the idea of completely bailing if the commit can't be parsed too.
> Only question: Is there a reason you chose to die() instead of BUG() like
> the other two places in that function? What is the criteria of choosing one
> over the other?

I did not call 'BUG' here because 'BUG' is traditionally used to
indicate an internal bug, e.g., an unexpected state or some such. On the
other side of that coin, 'BUG' is _not_ used to indicate repository
corruption, since that is not an issue in the Git codebase, rather in
the user's repository.

Though, to be honest, I've never seen that rule written out explicitly
(maybe if it were to be written somewhere, it could be stored in
Documentation/CodingGuidelines?). I think that this is some good
#leftoverbits material.

> >
> >    * It seems like we could write a commit-graph by placing a "filler"
> >      entry where the broken commit would have gone. I don't see any place
> >      where this is implemented currently, but this seems like a viable
> >      alternative to not writing _any_ commits into the commit-graph.
>
> I would rather we didn't do this cause it will probably kick open the can of
> always watching for that filler when we are working with the commit-graph.
> Or do we already do that today? Maybe @stolee can chime in on what we do in
> cases of shallow clones and other potential gaps in the walk

Yeah, I think that the consensus is that it makes sense to just die
here, which is fine by me.

> -Garima

Thanks,
Taylor
