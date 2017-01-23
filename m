Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09D4320A17
	for <e@80x24.org>; Mon, 23 Jan 2017 18:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751511AbdAWSIO (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 13:08:14 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35402 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751206AbdAWSIN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 13:08:13 -0500
Received: by mail-pf0-f170.google.com with SMTP id f144so42917107pfa.2
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 10:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M6NxlyPEkUFSHD22RcdYB5jjvK/JjiPZWsKGqbbLz20=;
        b=jS9XSH2u8yp+e/Gdzon+pj8uWpf9QJJSnhh6/PA6CpJRaP3aMmLBhYnr966KPpa6B3
         9/28FsQNUP/oO60L32hgY8IW4B2vE5bSGTVV5HOdr7IKIAp42nRDRSZ/rmAw3R4zw0dr
         sPPodmpCuo33R+R6U3KiChGNYVKBe/qgrm1LF99Aby12uIgmt7WIyUf4QYDADPgsKCpr
         91tD7fkEvVY5T0YsfryJ2FVcijz2m7f1Nx3CpkakpLizI/ZOHa4w0eey15LPDSDXUuGJ
         SrnCa9W86DMVzUvZNB/gsBNzOyhdn1tyZeW9A0EI21qsoliN8Sma52CUKMmjPHBfvato
         S2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M6NxlyPEkUFSHD22RcdYB5jjvK/JjiPZWsKGqbbLz20=;
        b=BICtBjeBTY3oLxuXB/Hev99WSMa5UlEXMOlz4VUz9M9kL4EC+9VymksS+plzIJYS0G
         g3m6o5rxGcshKOJ6luX2O/ymnlkhQ2HzRV+aO2r+PUgbD8PyCWMCLR+p6H5kinC0J/mx
         D+ObrWae3E3yZJhX/Vb8QH64IzFLccJ991DFZgF0Uoc29c9cCqty7csBJS/Xj02Yva6t
         2wveBKQHqMZnCKEUZGuabMJi/w1qBoHRKvq+wteHg6Af83Q2USyFkLVyCXUP3fb3YAAp
         uiXD0SbXRrqbseTiI5opCxWPvghCDIT4t+/ssnpkWsFSuRcbBVXx6yp6rKhrWLKl9DPX
         3TkQ==
X-Gm-Message-State: AIkVDXKfmU03OdbU/zIh56J5mUIndoQkE/RDa5LJ4YNff7GoozhKEKuj/tgZcjLMIx73zayn
X-Received: by 10.84.231.9 with SMTP id f9mr45367241plk.28.1485194887394;
        Mon, 23 Jan 2017 10:08:07 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:f7:6fe:c32:4f4a])
        by smtp.gmail.com with ESMTPSA id c11sm38601755pfk.14.2017.01.23.10.08.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 23 Jan 2017 10:08:05 -0800 (PST)
Date:   Mon, 23 Jan 2017 10:08:04 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com, sbeller@google.com
Subject: Re: [PATCH 25/27] attr: store attribute stacks in hashmap
Message-ID: <20170123180804.GA92260@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
 <20170112235354.153403-26-bmwill@google.com>
 <xmqqshomejwt.fsf@gitster.mtv.corp.google.com>
 <20170118203440.GB10641@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170118203440.GB10641@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/18, Brandon Williams wrote:
> On 01/13, Junio C Hamano wrote:
> > Brandon Williams <bmwill@google.com> writes:
> > 
> > > The last big hurdle towards a thread-safe API for the attribute system
> > > is the reliance on a global attribute stack that is modified during each
> > > call into the attribute system.
> > >
> > > This patch removes this global stack and instead a stack is retrieved or
> > > constructed locally.  Since each of these stacks is only used as a
> > > read-only structure once constructed, they can be stored in a hashmap
> > > and shared between threads.
> > 
> > Very good.
> > 
> > The reason why the original code used a stack was because it wanted
> > to keep only the info read from releavant files in-core, discarding
> > ones from files no-longer relevant (because the traversal switched
> > to another subdirectory of the same parent directory), to avoid the
> > memory consumption grow unbounded.  It probably was a premature
> > "optimization" that we can do without, so keeping everything we have
> > read so far in a hashmap (which is my understanding of what is going
> > on in this patch) is probably OK.
> > 
> > I suspect that this hashmap may eventually need to become per
> > attr_check if we want to follow through the optimization envisioned
> > by patch 15/27.
> > 
> > Inside fill(), path_matches() is called for the number of match_attr
> > in the entire attribute stack but it is wasteful to check if the
> > path matches with the a.u.pat if none of the a.state[] entries talk
> > about attributes and macros that are eventually get used by the
> > caller of check_attr().  By introducing a wrapping structure, 15/27
> > wanted to make sure that we have a place to store a "reduced"
> > attribute stack that is kept per attr_check that has only entries
> > from the files that talk about the attributes the particular
> > attr_check wants to learn about.
> > 
> > I need to think about this a bit more, but I do not offhand think
> > that it makes future such enhancement to make it per-check harder to
> > move from a global stack to a global hashmap, i.e. the above is not
> > an objection to this step.
> 
> If we want to continue through and do the optimization you originally
> envisioned then I may need to rethink this patch.  One thing we did talk
> about offline was doing another check prior to the path_match() function
> call which looks through the list of state structs to see if one of
> those states would actually have an affect on the array being used to
> collect attributes.  Though that may be an optimization which can be
> done in addition to creating a reduced stack.
> 
> The one difficulty (which you pointed out in comment form) is if we have
> a reduced attribute stack that is stored per attr_check then handling
> the cleanup when the direction is changed may be messy.

After thinking about this some more I'm going to redo this patch in the
series and instead of storing all of the frames in a shared hashmap,
we'll have an attribute stack stored per attr_check instance like you
originally envisioned.  I think that having a hashmap of all the stack
frames may make it more difficult to do optimizations in the future.  At
least this way (simply pushing the stack into the attr_check) makes it
more straight forward to do optimizations and doesn't have the potential
for memory to grow unbounded.

I'll try to get out a v2 later today.

-- 
Brandon Williams
