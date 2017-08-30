Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24590208DB
	for <e@80x24.org>; Wed, 30 Aug 2017 21:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750968AbdH3VGH (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 17:06:07 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:37156 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbdH3VGG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 17:06:06 -0400
Received: by mail-pg0-f51.google.com with SMTP id 83so23061329pgb.4
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 14:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vHRoLvP4Af1XRVT93EbFOXfa1CncFnK30d6/aVV2gxE=;
        b=M2rn2J+VEUzX2KadwjMDVZ7UD9IA3tv75nHS3SfHkXnYe1MJkkHBSE2a10q+aKUlCP
         ytzWxHgIa9A6CwHHkXNakutJ6ZayIwvCD2UU20Iw+xFsXbjlHtTSuHuanCKSoFGjM2sj
         pp9rIX0kdJwk8M4BiTWbBK091pBzMJiZhflAlnVAc6nLIvNFwQxvtJ97tDS9s1dlz59X
         Lb9G5fOZ4iQX+0N6UqmgB+QXnjMunuLGdSL7A+LBqpkxppYXdht9UTyxecZl54275Zpx
         v/XAyHqjXMuJ+UGI0sg67tzUn3p4d6njtD8GpXhIZFTmnxFbZpDEUSgnHg1Ie/4eBhR5
         ksuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vHRoLvP4Af1XRVT93EbFOXfa1CncFnK30d6/aVV2gxE=;
        b=GRQyxltHFDSXnYhWXYt1QB1ZwHaW6R+OjGx5uRlOtSVgoGBc26YOK29uUMA+tt+tb3
         aNwlxl6q8Rd3xBAf8/j0UYdCp7/jIZfA4Vri65EGyNdIPOawuvHVuFxXyXJ6c8abEMTd
         5/zE9lDBhhMVbQs7sM0S3y9/NQEekinkc5mWQTNoXT0Pa+yN6xiX8ua73t8B/wUssWlJ
         DO40eO/7XvVIxeVz3S/XjG7UxtZNmLET9D6Qy2fktLfE1RvfbLuvJA8uLlh0dea4n0Cx
         yyf/qrfAds/Eu3HucOwg9P4oUhxQK4qp41I/M6iTHmU/QL0H+P/q2K8wxdewwOhmmNR3
         stng==
X-Gm-Message-State: AHYfb5hPUyBm6LuLTKbpEtRXX04Ft9JWIY3s573AtH6yzPsFqiu1SFvC
        bzsSOjvaDlEajhSJ
X-Google-Smtp-Source: ADKCNb6quZcUSgKTmbbZtGVBQ0UfVg2IR2xqavO6B+RNnzrgAgt/rfuz1ljrsxV3S/1XENLhBebpaQ==
X-Received: by 10.84.224.197 with SMTP id k5mr3556802pln.430.1504127165327;
        Wed, 30 Aug 2017 14:06:05 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:81c4:afb0:c46d:bc75])
        by smtp.gmail.com with ESMTPSA id o18sm11823636pgd.15.2017.08.30.14.06.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Aug 2017 14:06:04 -0700 (PDT)
Date:   Wed, 30 Aug 2017 14:06:02 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Lars Schneider <larsxschneider@gmail.com>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] config: use a static lock_file struct
Message-ID: <20170830210602.GC50018@google.com>
References: <20170829185850.tfmjoa5u5sfuwpgi@sigill.intra.peff.net>
 <20170829190928.GD131745@google.com>
 <20170829191217.dt65wazf7qh5qs3k@sigill.intra.peff.net>
 <01375356-5d39-99af-9e91-35083ed03f42@alum.mit.edu>
 <20170830043147.culn63luzdsbpuuw@sigill.intra.peff.net>
 <20170830045555.27xczwo3ql7q4bg3@sigill.intra.peff.net>
 <3e632fd3-7db9-4c38-c524-b56a06cfaa87@alum.mit.edu>
 <20170830195320.27w5mhnrcd2uosvz@sigill.intra.peff.net>
 <20170830195731.GB50018@google.com>
 <20170830201132.kmtp5mfu6qotn5s7@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170830201132.kmtp5mfu6qotn5s7@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/30, Jeff King wrote:
> On Wed, Aug 30, 2017 at 12:57:31PM -0700, Brandon Williams wrote:
> 
> > > And I think we're fine there even with a doubly-linked list. It's still
> > > the single update of the "next" pointer that controls that second
> > > traversal.
> > 
> > I know it was mentioned earlier but if this is a critical section, and
> > it would be bad if it was interrupted, then couldn't we turn off
> > interrupts before attempting to remove an item from the list?
> 
> If we have to, that's an option. I mostly didn't want to get into the
> portability headaches of signal-handling if we can avoid it.
> 
> Right now sigchain uses plain old signal(). We do use sigaction() in a
> few places, but in a vanilla way. So the portability questions are:
> 
>   - can we rely on using more interesting bits of sigaction like
>     sa_mask?  Probably.
> 
>   - which flags should we be setting in sa_flags to get the same
>     behavior we've been getting with signal()? Or alternatively, which
>     behavior do we want?
> 
> On Linux and BSD systems, at least, signal() defers repeat instances of
> the handled signal. So getting two quick SIGTERMs will not interrupt the
> handler to deliver the second. But getting SIGTERM followed by SIGINT would.
> 
> We could extend that protection by having sigchain_push_common() set
> sa_mask to cover all of the related signals. On Linux and BSD the
> current code using signal() also implies SA_RESTART. We could add that
> to our flags, though I suspect in practice it doesn't matter. Whenever
> we establish a handler like this our intent is to never return from it.
> 
> That just protects us from calling the _same_ handler from itself. But
> that's probably enough in practice, and means handlers don't have to
> worry about "critical sections". The other alternative is sigprocmask()
> to block signals entirely during a section. I'm not sure if there are
> portability questions there (it looks like we have a mingw wrapper
> there, but it's a complete noop).

Yeah there's a lot about signals that I'm not very clear on.  I do know
that Eric helped me out on the fork-exec series I worked on earlier in
the year and I believe it was to turn on/off signals during process
launches in 45afb1ca9 (run-command: block signals between fork and
execve, 2017-04-19).  Though that bit of code is strictly for unix so I
wouldn't know how that would work on windows machines.  Portability does
seem to always be a challenging problem.

-- 
Brandon Williams
