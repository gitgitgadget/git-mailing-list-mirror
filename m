Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1754E2047F
	for <e@80x24.org>; Tue,  1 Aug 2017 18:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751931AbdHASSX (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 14:18:23 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34958 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbdHASSX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 14:18:23 -0400
Received: by mail-pf0-f176.google.com with SMTP id t86so10878255pfe.2
        for <git@vger.kernel.org>; Tue, 01 Aug 2017 11:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mTtgbZaDgMr60BBTWxzXEf0OCgSdn6eCrN8FjXGhU3M=;
        b=XAU5DPTCKNtEKbIeoyN0CEgAQuZpIwl+sLlhk6S2tc7tPVFpcFB7qB3IAN7rZgcUQo
         DVCT8tfo43IlYJxAY7phOJZIVH8K+0EIGF6k/Lb18k4Bl/ckZj3vvpeAucBGH82hOR1M
         AIhSYeDrJn7USbpWFmjWuVH8AzqkuzBej5rcdT5hgFr4uTFpIZf3x6Dwo6h4XvMJU1nh
         WVHad0Stg3/PARSBkKebFU15G2lOAv7GQ0U8c97muA5PeulgVBVtwYCbkOELyzmEMzrN
         TNY6fWP4th7bghevT0kN9F5XC9jrJkMTh8rDZayWKblDSXOUzNv8mYy8P59ePIm5TRy2
         Vp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mTtgbZaDgMr60BBTWxzXEf0OCgSdn6eCrN8FjXGhU3M=;
        b=WqDTrNyPDZq8IYwTKFcgEOkEZIldNGcKylhPpmWcs86h4nyISk9Nd2aNEgGu7taAju
         NNdAI7o1JWDIbQ9Hjty+6kWFZB+sH4qljlv8QrZU7vagk/fVB5K/4+p/u/+169gtU09A
         AXEZ6KgMK+cCE38VA6o6fzBdTtwkyJdODAXX1r1p9t2TGRWhaWq/r6Rwo4ro0Nci14nm
         7MRgrSfHHTLRvWugppfV8/jhkWrQYin8vG+wtF2+grjqcIJiRlVc/QI19SKCAjKZVlIE
         Zez9SbY4fl+ToRTdoaaIqK2JV5E9xLSw/cJPz5DvxLvOVFg5hv6MXJm6T6LbWgh+6E+T
         NEgA==
X-Gm-Message-State: AIVw11107nhi+RAqxI2P09JGlmqs/aV2WUl6c3SmnxOudSv8Zb4JnAYx
        iVP53+s8f3sehpE1
X-Received: by 10.99.97.6 with SMTP id v6mr20245766pgb.254.1501611502451;
        Tue, 01 Aug 2017 11:18:22 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:b8e2:744f:de6d:a74e])
        by smtp.gmail.com with ESMTPSA id t8sm56816018pgq.68.2017.08.01.11.18.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 01 Aug 2017 11:18:21 -0700 (PDT)
Date:   Tue, 1 Aug 2017 11:18:20 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Paul Jolly <paul@myitcv.io>
Cc:     gitster@pobox.com, git@vger.kernel.org, jacob.keller@gmail.com
Subject: Re: [PATCH 3/2] ls-files: only recurse on active submodules
Message-ID: <20170801181820.GA110646@google.com>
References: <xmqqefwpdx9x.fsf@gitster.mtv.corp.google.com>
 <20170512162109.49752-1-paul@myitcv.io>
 <20170512172657.GA98586@google.com>
 <CACoUkn5fyk054BJ5e+C8KynYMJg=EkMLOTiZya8KTNZh+=u5dQ@mail.gmail.com>
 <20170512181950.GE98586@google.com>
 <CACoUkn7i76dEsQa3eoN+7WR8QmsD1pWsRQ0dvhkxzFN0sxTmRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACoUkn7i76dEsQa3eoN+7WR8QmsD1pWsRQ0dvhkxzFN0sxTmRQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/01, Paul Jolly wrote:
> >
> > > Thanks for the quick response.
> >
> > Course, let me know if you find anything else! :D
> >
> 
> Brandon - doesn't look like this change has made it's way into master:
> 
> https://github.com/git/git/blob/master/builtin/ls-files.c
> 
> Is there a plan to merge it?
> 
> Thanks

It looks like it was merged to master.  This should be the relevant
commit: 188dce131 (ls-files: use repository object, 2017-06-22).

-- 
Brandon Williams
