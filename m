Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3A291F403
	for <e@80x24.org>; Tue, 19 Jun 2018 18:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030530AbeFSSuk (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 14:50:40 -0400
Received: from mail-pl0-f47.google.com ([209.85.160.47]:47048 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030450AbeFSSuh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 14:50:37 -0400
Received: by mail-pl0-f47.google.com with SMTP id 30-v6so310747pld.13
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 11:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yr9E01U6dt6FMqj4WdntxXJ/Xh0AdSaDVvbWg1K4dw8=;
        b=rrQxj9AhecXzx/UDR8080AypgQrqtbKC143a2cK9PvEemkihXVpKnAhM3lcYg/sx0w
         Qds9dYZY0HHP8fOVJRjP6sM6WQ4EwXB9LzqgYJp5I6w4PvE0nK5L3MVCIX6IinZB4Es9
         dVT99dFuzWgnEeTSPaXS05eBFHZmYVc6YznJwCZlSHieIyTpYb1lxTUtgNiNQmcBH9z9
         jCiNoMrogrGJGjBLmT2VHJROOvkKa40q8uFHVVH/R4Qhwmu0RDViNVOwjQ31EM4vhr1P
         tIXCiGmQi4TC9q2KCAbTjrOTydocbWh/VqykSvGE+cgg133AQ44SokGzUPnZFtUIjJFa
         4VhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yr9E01U6dt6FMqj4WdntxXJ/Xh0AdSaDVvbWg1K4dw8=;
        b=Lr1FRnOzKtJpyH77UwNUPpN4Xe/uDhonPD9GWF8e1OzRnqJoeqejj+OAFrLrNgXhks
         yRklok1OZSZATatsEjvciL+gbWaTDUT0bT+AkjHmSjC7XAh/slnKiQ0DMUkbe2/5lUdo
         Zqj4f0+5Fcb4aJImIpdbyFnTeOfVHqVyuF4Q+3ohkSCTJhbqim6cJ3vx47ATj0MtHZNA
         vjRM+2lD0V4JKFHXjeuO0F4UhgJNeIu3Q9CkB26XY6U7haLLmy5ypXaPNnzx/ra8nbaN
         pL3eJ4J7hKQnOMtxFaPn2JCI0s1+c9ahYAc0imilj4qQVPb/Ouu1qPofc7iLrEhpuwq1
         GUvA==
X-Gm-Message-State: APt69E089JDlPr3h52QjzPexAYEIu0hCUXeo+LUVv5IU8rgPyn92i3tO
        5gI8dd/N57ey3f5iOM3ndFV8Lg==
X-Google-Smtp-Source: ADUXVKLzpIIS70ZVNfTzcoxZphnmwKt6Ir8qS5k0wdX3BwvFQxho5m7wAKMYc4oQ0yejjkrSlPYMRw==
X-Received: by 2002:a17:902:650a:: with SMTP id b10-v6mr20370336plk.45.1529434236685;
        Tue, 19 Jun 2018 11:50:36 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id l85-v6sm537283pfk.79.2018.06.19.11.50.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 11:50:34 -0700 (PDT)
Date:   Tue, 19 Jun 2018 11:50:33 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v2 2/8] upload-pack: implement ref-in-want
Message-ID: <20180619185033.GC199585@google.com>
References: <20180605175144.4225-1-bmwill@google.com>
 <20180613213925.10560-1-bmwill@google.com>
 <20180613213925.10560-3-bmwill@google.com>
 <xmqq602jzriy.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq602jzriy.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/15, Junio C Hamano wrote:
> The story would be different if your request were 
> 
> 	git fetch refs/heads/*:refs/remotes/origin/*
> 
> in which case, you are not even saying "I want this and that ref";
> you are saying "all refs in refs/heads/* whoever ends up serving me
> happens to have".  You may initially contact one of my friends and
> learn that there are 'master' and 'bo' branches (and probably
> others), and after conversation end up talking with me who is stale
> and lack 'bo'.  In such a case, I agree that it is not sensible for
> me to fail the request as a whole and instead serve you whatever
> branches I happen to have.  I may lack 'bo' branch due to mirroring
> lag, but I may also have 'extra' branch that others no longer have
> due to mirroring lag of deletion of that branch!
> 
> But then I think your "git fetch refs/heads/*:refs/remotes/origin/*"
> should not fail not just because I do not have 'bo', but you also
> should grab other old branches I have, which you didn't hear about
> when you made the initial contact with my friend in the mirror pool.
> 
> So, given that, would it make sense for 'want-ref <ref>' request to
> name "a particular ref" as the above document says?  I have a
> feeling that it should allow a pattern to be matched at the server
> side (and it is not an error if the pattern did not match anything),
> in addition to asking for a particular ref (in which case, lack of
> that ref should be a hard failure, at least for the mirror that ends
> up serving the packfile and the final "here are the refs your
> request ended up fetching, with their values").

After some more in-office discussion about this I think I should revert
back to making it a hard failure when a client requests a ref which
doesn't exist on the server.  This makes things more consistent with
what happens today if I request a non-existent ref (Although that error
is purely on the client).  Its no worse than we have today and even with
this solution not solving the issues of new/deleted refs (which are rare
operations wrt updates) we still can get the benefit of not failing due
to a ref updating.  This is also very valuable for the servers which
have to to ACL checks on individual ref names.

I also think that we should keep this first implementation of
ref-in-want simple and *not* include patterns, even if that's what we
may want someday down the road.  Adding a new capability in the future
for support of such patterns would be relatively simple and easy.  The
reason why I don't think we should add pattern support just yet is due
to a request for "want-ref refs/tags/*" or a like request resulting in a
larger than expected packfile every time "fetch --tags" is run.  The
issue being that in a fetch request "refs/tags/*" is too broad of a
request and could be requesting 100s of tags when all we really wanted
was to get the one or two new tags which are present on the remote
(because we already have all the other tags present locally).

So I think the best way is to limit these patterns to the ls-refs
request where we can then discover the few tags we're missing and then
request just those tags explicitly, keeping the resulting packfile
smaller.

Thoughts?

-- 
Brandon Williams
