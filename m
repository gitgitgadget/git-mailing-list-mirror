Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3320D2047F
	for <e@80x24.org>; Mon, 18 Sep 2017 19:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751513AbdIRT6o (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 15:58:44 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:56561 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbdIRT6n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2017 15:58:43 -0400
Received: by mail-pf0-f174.google.com with SMTP id g65so766664pfe.13
        for <git@vger.kernel.org>; Mon, 18 Sep 2017 12:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=brhx5ESFp3R1lecZgNqNf5oOcMn4e3FCSNUbQ2V8g7s=;
        b=BXQ2Ma03E7ZTzUbEIVPeZOR7kEfrcqQXQKMznJyO19j+8SnZJogmnt7L/ByWtwURIq
         Fx1LW9at7DL7yrTj6PD7xyKQoUdLC99ruUs+2znYYOJVrsRc5rdL0p9NIHNcTltmt4vD
         HIOwhlzSVnjZGT0MHrgdKOTbOD9rXQty3f8BTR3+AxkRqa4/u66G2QjW3twfNraD44sj
         XOIKRwTZYCLy9BegrF//FQ9yclLQJ9BbHFPm/VLkbjvJ3NQIwwlhlF/L1bxFo2pFu+ry
         J4h/4dyWUEyJABOMTe3RmGLWYBNVjEnOWNybSEfQt1l0PMTpzGR/5rMO6CogcccOrBX1
         q5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=brhx5ESFp3R1lecZgNqNf5oOcMn4e3FCSNUbQ2V8g7s=;
        b=D56X01kD26rLZbYH/r/Mnt22A5mKgH0KNir/VLxNK/k400J1WszV6oN/VfaKbp/TGU
         FXY3BGfgyDw1Fq2abljFtBzbTay4KYYvuw8iAV7XTV//AHrr9OnmmGXMH2AEgEZufx7l
         60/jl2p5j78/wuHJkCjW65z1BXy4DyiAeeBVZo+xEvbeDVw7hXqNWx16lK+L5L4AIIjQ
         aE6g9cPKQLJnfIuQdiBFepJWtlA7bO5DHfKCW8AoYAbb4rhtCtgL2g3T+jn8IFoSbKgG
         il49eo1OYi79FGC6XsNB0VjIPEYOCjl9OxwUfYAaUK3X9ifiSqzgwIXJDsQAtgf91c1v
         UKpA==
X-Gm-Message-State: AHPjjUgFFa8SkhMj25geUQ2buW80++WWnT6olyL9+QIQ1JJtbf0SPCBj
        Cy1d9difOsGkQA9alH2Fsg==
X-Google-Smtp-Source: AOwi7QCGr5dN5YDhWJoO/LuDWwVl4tDBj55XyJYk0Fz1AEAPS3N2qQZIyGGLNrmHR/VAVbttNfO39g==
X-Received: by 10.159.218.75 with SMTP id x11mr13011283plv.92.1505764722960;
        Mon, 18 Sep 2017 12:58:42 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c140:486c:cfb0:5862])
        by smtp.gmail.com with ESMTPSA id w9sm193601pfg.129.2017.09.18.12.58.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 18 Sep 2017 12:58:42 -0700 (PDT)
Date:   Mon, 18 Sep 2017 12:58:40 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 2/8] protocol: introduce protocol extention mechanisms
Message-ID: <20170918195840.GG144331@google.com>
References: <20170913215448.84674-1-bmwill@google.com>
 <20170913215448.84674-3-bmwill@google.com>
 <CAGZ79kaeWsWdhoC7VDy-YkL1wVWqaQ9=TQUti9HfwjbT2poQdw@mail.gmail.com>
 <20170918170207.GF144331@google.com>
 <CAGZ79kYQGguodnaiNfT_vWWDQdDdXwZmTi7JnqOmz+Po+FL1+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kYQGguodnaiNfT_vWWDQdDdXwZmTi7JnqOmz+Po+FL1+Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/18, Stefan Beller wrote:
> >> From a users POV this may be frustrating as I would imagine that
> >> people want to run
> >>
> >>   git config --global protocol.version 2
> >>
> >> to try it out and then realize that some of their hosts do not speak
> >> 2, so they have to actually configure it per repo/remote.
> >
> > The point would be to be able to set this globally, not per-repo.  Even
> > if a repo doesn't speak v2 then it should be able to gracefully degrade
> > to v1 without the user having to do anything.  The reason why there is
> > this escape hatch is if doing the protocol negotiation out of band
> > causing issues with communicating with a server that it can be shut off.
> 
> In the current situation it is easy to assume that if v1 (and not v0)
> is configured, that the users intent is "to try out v1 and fallback
> gracefully to v0".
> 
> But this will change over time in the future!
> 
> Eventually people will have the desire to say:
> "Use version N+1, but never version N", because N has
> performance or security issues; the user might not want
> to bother to try N or even actively want to be affirmed that
> Git will never use version N.
> 
> In this future we need a mechanism, that either contains a
> white list or black list of protocols. To keep it simple (I assume
> there won't be many protocol versions), a single white list will do.
> 
> However transitioning from the currently proposed "try the new
> configured thing and fallback to whatever" to "this is the exact list
> of options that Git will try for you" will be hard, as we may break people
> if we do not unconditionally fall back to v0.
> 
> That is why I propose to start with an explicit white list as then we
> do not have to have a transition plan or otherwise work around the
> issue. Also it doesn't hurt now to use
> 
>     git config --global protocol.version v1,v0
> 
> instead compared to the proposed configuration above.
> (Even better yet, then people could play around with "v1 only"
> and see how it falls apart on old servers)

Except we can't start with an explicit whitelist because we must
fallback to v0 if v1 isn't supported otherwise we would break people.

That is unless we have the semantics of: If not configured v0 will be
used, otherwise only use the configured protocol versions.

-- 
Brandon Williams
