Return-Path: <SRS0=p0jH=64=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55447C433E0
	for <git@archiver.kernel.org>; Thu, 14 May 2020 21:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 328DE2065C
	for <git@archiver.kernel.org>; Thu, 14 May 2020 21:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589490645;
	bh=GPEMwbRbQM7tkcnskn68otTFpaxl/j1YQo7azEGj0ys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0RrJOjiItxWSU7u54dfF2c8/OrYVekRKcnUJ1wthitNwmb9eSILybZmH6fqvc8JJ+
	 Q0sagYiN+ujc3Pq8qCpAg+pSvxCF0QPR7v6NKPIx0huC/jDoqMIqw44A904CllXLXz
	 biOMBOpvLC1/u3rvPs83Etmd8f7dlGeUOawo7bLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbgENVKo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 May 2020 17:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727811AbgENVKn (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 14 May 2020 17:10:43 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA21CC061A0C
        for <git@vger.kernel.org>; Thu, 14 May 2020 14:10:43 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id l1so140848qtp.6
        for <git@vger.kernel.org>; Thu, 14 May 2020 14:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=ahSA1nbChwi3PEZW63+kXqIKRLaVXJrnpzDnWr8PhTk=;
        b=WMXaddWHvN6jfYHHsnEANoSnr1+KtfT8AQWK9ywBZXAw3ex064djHb88JaLj1I10kp
         5R/v3TQyG6D8bch2kexnIWGYGMDyjxpZls4ZPVRj8oY45CYn3mIxQ3qDcHT5EhT1/df7
         KBBn8WSdo7B+Bwaoa3KvoI9e26NEEzGvBGgbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=ahSA1nbChwi3PEZW63+kXqIKRLaVXJrnpzDnWr8PhTk=;
        b=PBHraLCgzH21IkbMJcViAPljoS4YENHLmCpIWWam+pHeXN6zGl3XQOsVa5U5A5vRli
         pww+vAylLtPSfRtPOz/IN6fXAKZQWzOa6up3GdlAr0ItsJOm4Gb/tYjWiAhRxYYZp31S
         C38RjPXAf634SyRnfkoKGBKcisOX4JvqVQ4NCw+cGrJIEy4vustUcWWHz7mb8TUfrOtT
         WLwbuphYeI1TXP6r6jXy55NnmQdgZBVCnjTHxUKQg6700Ngl36FMpm1JZvxamwD//GSb
         Z5ifTx1xxqFGXtBI4exRsdiY7hR7ufowMaYnsBiD0zB5R17j/3YonxYkbvc8fbPgkOAh
         XE3Q==
X-Gm-Message-State: AOAM532no9pAJ5wtumrSA75SBngHgoylk0qPhdKgIEj56CYG3OsnPS5i
        AYMf+V4oJ4H/1l83VDt+yQggQYosvXZAjw==
X-Google-Smtp-Source: ABdhPJyk7+OjzsaNfQAsWLK8IoZHBeIjmZGkDBrmamlPPpPcW9LM5jnuuNFuXWzuyTcasaSXTlo+pg==
X-Received: by 2002:ac8:543:: with SMTP id c3mr174166qth.8.1589490642784;
        Thu, 14 May 2020 14:10:42 -0700 (PDT)
Received: from i7.mricon.com (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id q62sm76887qke.22.2020.05.14.14.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 14:10:42 -0700 (PDT)
Received: by i7.mricon.com (sSMTP sendmail emulation); Thu, 14 May 2020 17:10:40 -0400
Date:   Thu, 14 May 2020 17:10:40 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Caleb Gray <hey@calebgray.com>, git@vger.kernel.org
Subject: Re: Add a "Flattened Cache" to `git --clone`?
Message-ID: <20200514211040.a7hrirdzgkphx3la@chatter.i7.local>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Caleb Gray <hey@calebgray.com>, git@vger.kernel.org
References: <CAGjfG9a-MSg7v6+wynR1gL0zoe+Kv8HZfR8oxe+a3r59cGhEeg@mail.gmail.com>
 <20200514203326.2aqxolq5u75jx64q@chatter.i7.local>
 <20200514210501.GY1596452@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200514210501.GY1596452@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 14, 2020 at 05:05:01PM -0400, Theodore Y. Ts'o wrote:
> > 
> > I don't think it's a common workflow for someone to repeatedly clone 
> > linux.git. Automated processes like CI would be doing it, but they tend 
> > to blow away the local disk between jobs, so they are unlikely to 
> > benefit from any native git local cache for something like this (in 
> > fact, we recommend that people use clone.bundle files for their CI 
> > needs, as described here: 
> > https://www.kernel.org/best-way-to-do-linux-clones-for-your-ci.html).
> 
> If the goal is a git local cache, we have this today.  I'm not sure
> this is what Caleb was asking for, though:

Right, I think I misunderstood his request -- I'd assumed we were 
talking about local cache, whereas it's about server-side or proxy-side 
cache.

I think something like git-caching-proxy would be a neat project, 
because it would significantly improve mirroring for CI deployments 
without requiring that each individual job implements clone.bundle 
prefetching.

-K
