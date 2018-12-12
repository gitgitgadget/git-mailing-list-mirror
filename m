Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_MIXED_ES shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DEBE20A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 07:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbeLLH1B (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 02:27:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37125 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbeLLH1B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 02:27:01 -0500
Received: by mail-wr1-f68.google.com with SMTP id j10so16549038wru.4
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 23:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=opexKs1wAWFAHtNrUl8fqeHDcgTSABHCTO1/vAEt/pM=;
        b=OmC45qEVmJ1wsXgtEiZx8aL3cXq3YkPOum8xFJXte5+wXQzL2QhNP2YWxx0oQQ9Ghc
         ycU6OWqphoY5FapbYPYzOiWWcSrPuCt/T+lpazbuEkmD+cGihAyYyG2pqE+2yR8dM5d8
         j23pIlcZY3nSwW2J3JXIAjUiBL7iQmz4YSNeMNJw1DEGnxB1ZNb+SYNRmg5WbmkgyWAa
         5D+EsY0XLFH0XB2xrDONZjTchMfrwfPPFi9ia9ZeJwULqRbgLbaQwbh0r3upZgPcs5kB
         trb0UFWeCfRt4yDOrvh0uoTgNT7Ae53/Di9ml9xDcXqzgHbBmE5o62/MdElH2nDUmD9X
         GynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=opexKs1wAWFAHtNrUl8fqeHDcgTSABHCTO1/vAEt/pM=;
        b=pP8Qqs0JeoldamVFUchu2bwkZzcfCrDFJURUmWLmsnVTyTVMP12Cb36t6hBD7YEQFQ
         Y5cVgLIijNo6ARG8pCCzWhfs8wS3tyE7YNLKN431dsgvn6u0DyPHB+1VccHqDW7tU82i
         Iw8ORGQftAhMGKZKYOY6visj4DFBLdYUrNyROWj89Vsmd53rEI1WwiZWkSFgDDt8E9Rw
         PSX2Vi7sXsPGnAq8+Z3DgzaMyn0LUlUmkZl5GjwtS8QFXfg4BiZjh3N/p++vzKcDrQkB
         HSuomk9Qfnh2eFZIalm562lFnxCi2uSX5FC/SnRoIZohAAws1bECVRWYNB3SmmveKhzw
         KXww==
X-Gm-Message-State: AA+aEWbAPUM53ZtzKVmmZwf8zXI0Q5nurC2sXrPbkincetNTssK+aOUG
        MLUUEkUPmXH3Sre5cCnepKM=
X-Google-Smtp-Source: AFSGD/UYdJxyDmGlk1jbMtS0ybLSSzfXFvLO0zm9CsUv6Kmn5NlH5zJ9WXzYcFhaHBEoAqmrpz2S5g==
X-Received: by 2002:adf:db01:: with SMTP id s1mr15662151wri.214.1544599618975;
        Tue, 11 Dec 2018 23:26:58 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w125sm2820713wmb.45.2018.12.11.23.26.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 23:26:58 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     git@vger.kernel.org, Junio C Hamano <jch2355@gmail.com>,
        Jeff King <peff@peff.net>, kernel-team@fb.com,
        Stefan Xenos <sxenos@google.com>
Subject: Re: [PATCHSET] git-reverse-trailer-xrefs: Reverse map cherry-picks and other cross-references
References: <20181211234909.2855638-1-tj@kernel.org>
Date:   Wed, 12 Dec 2018 16:26:57 +0900
In-Reply-To: <20181211234909.2855638-1-tj@kernel.org> (Tejun Heo's message of
        "Tue, 11 Dec 2018 15:49:04 -0800")
Message-ID: <xmqqo99rjjcu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tejun Heo <tj@kernel.org> writes:

> Some trailers refer to other commits.  Let's call them xrefs
> (cross-references).  For example, a cherry pick trailer points to the
> source commit.  It is sometimes useful to build a reverse map of these
> xrefs - ie. source -> cherry-pick instead of cherry-pick -> source.
>
> This, e.g, can answer which releases a commit ended up in on
> repositories which cherry-picks fixes back from the development
> branch.  Let's say the repository looks like the following.
>
> 	    D'---E'' release-B
> 	   /
> 	  C'      E' release-D
>        /       /
>   A---B---C---D---E master
>
> where the followings cherry-picks took place.
>
>   C -> C'
>   D -> D'
>   E -> E' -> E''
>
> Using the reverse-mapping in this patchset, we can get the following
> annotated log which succinctly shows which commit ended up where.
> ...

Thanks.  A few comments, after skimming the patches enough to get
the general feel of the design but before deeply reading them to see
how complete the implementation is.

The topic introduces two new hooks: one to run immediately after
cherry-picking so that the reverse mapping for a single src->dst
pair can be added, and another to run immediately after fetching so
that all new commits that have appeared over the wire can be scanned
to see if any of them is a cherry-pick of other commits.

They are good starting points, but for a complete solution I'd
imagine that you'd need to hook to many other places in the
workflow.  For example, you'd need to deal with the case where a
commit created by cherry-picking an original is further rewritten
with "commit --amend" or "rebase".  They may already trigger the
post rewrite hook, so you may not have to add a new hook, but in
[3/5], you'd need to describe in the documentaiton for the new
reverse-trailer command full set of hooks you expect the command to
be used to maintain the reverse mapping, as the hooks you give them
as examples in [5/5] are merely a part of a complete solution.

It also is not immediately obvious to me what your general strategy
to maintain this reverse mapping is, when new ways and codepaths to
cause new commits with "cherry-picked-from" trailer appear.  Do we
keep piling on new hooks?  Or is the reverse mapping information
allowed to be a bit stale and be completed immediately before it
gets used?  A totally different approach could be to record list of
commits, all commits behind which have been scanned for reverse
mapping, in the tip of the notes history, perhaps in the commit log
message (which is machine generated anyway).  Then, before you need
the up-to-date-to-the-last-second reverse mapping, you could run

	git rev-list --all --not $these_tips_recorded

and scan the commits, just like you scan what you fetched.  And when
you update the reverse mapping notes tree, the commit to record that
notes update can record the tip of the above traverseal.

I also wonder how this topic and the topic Stefan Xenos has been
working on (cf. <20181201005240.113210-1-sxenos@google.com>) can
benefit from each other by cross pollination.  Stefan's topic also
needs to answer, given a commit, what other commits were created out
of it by cherry-picking and then further amending the results, so
that when the original commit itself gets amended, the cherry-picked
ones that were created from the original can be easily identified
and get updated in the same way as necessary.  

The motivating workflow your topic's cover letter gives us is to
maintain the release branch that goes only forward, so in that
context, how a commit on the release branch that was created by
cherry-picking an original gets updated when the original commit
gets amended would be different (I am assuming that you cannot
affored to rebase the release branch to update a deeply buried
commit that was an earlier cherry-pick), but I would imagine that
both topics share the need for a good data structure to keep track
of (1) the relationship between the original and copy of the
cherry-pick and (2) the fact that the original of such a cherry-pick
is now stale and the copy might want to get updated.

Thanks.
