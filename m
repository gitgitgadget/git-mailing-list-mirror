Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6331420248
	for <e@80x24.org>; Tue,  9 Apr 2019 02:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfDICLo (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 22:11:44 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46921 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfDICLl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 22:11:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id 9so8717836pfj.13
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 19:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gVHhVDe9uQCF3KZJwQGfRNw4pZuqC6vf7lPIHK47hXM=;
        b=DPLQfh1Yqe3JSCfGC2fn685LTnXtyXwT7yv6KVBOoblhtOA1TAOaKr7m+wbmn/k7cL
         UXtBmHcOQbSBKHKk07EYmL53zwd3/CwbfYysvcEZ0bFnImJRKRIckACyT1IVJNuebASO
         6we2Brmiq73KyC0T+kpj0O238PdY0s9nZklr4uymuVWLfG8/cHd1MS8LxEb9lLZ51kBX
         1DyCBLQYO9id/Iy7XC8NF9t1OFsBGwi/rgbLeyeDedK5nm2GB82S+kIr/qwgSnZBovVc
         jVkeW+tN6mFV66Kmbb2DyB6KmftL/9x62ZuK5+t4Ii5KGATx8+YcVKMQtlgsOY1fpZ6G
         HgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gVHhVDe9uQCF3KZJwQGfRNw4pZuqC6vf7lPIHK47hXM=;
        b=DJ50EXMgpnrY+3tg1fVWX5IlEKzMf28V2LuqAyoKSTFtzDDFsugWgOZ+xJwRJxcVYb
         1ZAe1BqO2nxpU8P5+5uAU8D0omK0iQi4eMFFgkx7heV1+OTU2efj8wsxnAXcD9szr1uV
         8UHbHIWKTjIla4bz16MkBCL7E5f/apDxHVksgQ6781G9ytjxbNCQV4CNnMwh/z3kMbIU
         Ba18m24mhkG4gLWSXvX7AotMCheIvskyUOUc3p63s+X++G8lQ5LpOwb5OGuRjEtBIUBR
         318zCxbLWTD+WkMU/yS2+yjCCCl57nkfCJX6ytvh+684pc8NvXpNuae7myhMj8S3VwFh
         nrCg==
X-Gm-Message-State: APjAAAWJq3GHdhgNbFWoCLqk0FqDOj/uN5EpUqkjD6/rjLE3J+iAcO8A
        EMuzOhcVIhMmCY9r7SC5+a/dpw==
X-Google-Smtp-Source: APXvYqzOKSg/Fg1AYslWssvMXEM2TclHTKSeuoETr4b866gpxp7O2F4JUn2c9FQSRpv3CM6/cVyPDg==
X-Received: by 2002:a63:ed4f:: with SMTP id m15mr30930602pgk.387.1554775900738;
        Mon, 08 Apr 2019 19:11:40 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:d869:cd1a:616d:3c11])
        by smtp.gmail.com with ESMTPSA id x16sm66074014pge.27.2019.04.08.19.11.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 19:11:39 -0700 (PDT)
Date:   Mon, 8 Apr 2019 19:11:38 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 6/7] rev-list: let traversal die when --missing is not in
 use
Message-ID: <20190409021138.GD81620@Taylors-MBP.hsd1.wa.comcast.net>
References: <cover.1554435033.git.me@ttaylorr.com>
 <a3a80b4b2a988eb65d85a5acd54c584d047073c7.1554435033.git.me@ttaylorr.com>
 <20190405184111.GE2284@sigill.intra.peff.net>
 <20190406053648.GD37216@Taylors-MBP.hsd1.wa.comcast.net>
 <20190407134113.GA13417@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190407134113.GA13417@sigill.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Sun, Apr 07, 2019 at 09:41:13AM -0400, Jeff King wrote:
> On Fri, Apr 05, 2019 at 10:36:48PM -0700, Taylor Blau wrote:
>
> > > > Of those, I think (3) is probably the best path forward. However, this
> > > > patch does none of them. In the name of expediently fixing the
> > > > regression to a normal "rev-list --objects" that we use for connectivity
> > > > checks, this simply restores the pre-7c0fe330d5 behavior of having the
> > > > traversal die as soon as it fails to load a tree (when --missing is set
> > > > to MA_ERROR, which is the default).
> > >
> > > I think this is worth doing, as it restores the earlier behavior. But a
> > > few general thoughts (which I've shared already with you, but for the
> > > benefit of the list):
> >
> > I agree that it's worth doing. One question that I have is _when_ you
> > feel it's good to do. I'm happy to write it and include the change in
> > v2, but if others would be happy not to grow the series too much between
> > re-rolls, I'd be just as pleased to send it in a new series after this
> > one.
>
> I'm not sure what "it" is here.

Yes... as I read this email again after the weekend had passed, I found
myself a little confused, too.

> My earlier message was admittedly rambling, but I think I'm arguing
> that it's OK to continue to include this patch that you already have,
> and punt further changes to make "rev-list --objects" detect blob
> problems down the road. I.e., leave the two expect_failures in place
> that your v1 series ends with.

I believe that that was the "it" that I was talking about it. To be
explicit, I think I was suggesting that we should not change this patch
much or add more to the series, and rather address the blob checking in
a new series after this one.

> -Peff

Thanks,
Taylor
