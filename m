Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0C4C20248
	for <e@80x24.org>; Tue,  5 Mar 2019 13:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbfCENQx (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 08:16:53 -0500
Received: from cpanel4.indieserve.net ([199.212.143.9]:46252 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbfCENQx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 08:16:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QV8jRTT9HuuRnX40gKQi2bf9Dwe1nDXWLROOeSqY3gw=; b=tjaXQaAQZSGhzad6vpTIwd+5I
        i6z8zgzh/Lg7VOuVmoMMZek2tYFu3rABX9PUXfY3tfnuJ0F7gj6wQgnwor2hv8j+pzzqMp1tLID/D
        OX6S3gGfD7bHhu/1wTnHUDvgaltzJSkTPlQUiz3u1uFVspDh5lqSZWXH50FN0kvgMiAwF5SRYKahy
        bt8h020XpbIlF9FcIKOf39ltmjfpuLoWEXVaDUc/DvKG6I+WdQNu6q5+xTLdKvYT4DUbcp1VOcK7+
        CXoUhp72v/s3D8G2DNKCzKnfhfEmfkxAnxFa44fql4HDJyEU2J+h3RjpnsmGoYbrN2Bw9lVaumaIo
        KPiXkitUw==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:56832 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1h19w9-00Gyt4-D2; Tue, 05 Mar 2019 08:16:50 -0500
Date:   Tue, 5 Mar 2019 08:16:48 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Junio C Hamano <gitster@pobox.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: worth enhancing "man git-rebase" to show non-HEAD examples?
In-Reply-To: <xmqqef7lv53z.fsf@gitster-ct.c.googlers.com>
Message-ID: <alpine.LFD.2.21.1903050816130.28986@localhost.localdomain>
References: <alpine.LFD.2.21.1903040955540.16666@localhost.localdomain> <xmqqef7lv53z.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 5 Mar 2019, Junio C Hamano wrote:

> "Robert P. J. Day" <rpjday@crashcourse.ca> writes:
>
> >   one of the things i've noticed about the examples in "man
> > git-rebase" is that they invariably show rebasing relative to a
> > branch point that has not moved. for example, there's this example:
> >
> >        o---o---o---o---o  master
> >             \
> >              o---o---o---o---o  next
> >                               \
> >                                o---o---o  topic
> >
> > with subsequent sample command:
> >
> >   $ git rebase --onto master next topic
> >
> > sure, that works, but there seem to be no examples that show that this
> > is a valid starting point as well:
> >
> >
> >        o---o---o---o---o  master
> >             \
> >              o---o---o---o---o  next
> >                       \
> >                        o---o---o  topic
>
> You mean that the 'topic' forked from 'next', and it is OK for 'next'
> to acquire further commits since 'topic' forked from it, for you to
> rebase 'topic' on another history?
>
> The very first example in Documentation/git-rebase.txt shows a
> 3-commit topic A-B-C, forked from the master branch at E in 4-commit
> D-E-F-G sequence, gets rebased.  Those F and G are in the same place
> as those rightmost two commits you have on 'next' in the above
> picture.
>
> > as in, the examples in that man page could potentially suggest to an
> > inexperienced reader that the *only* valid situations are rebasing as
> > long as the other branch has not developed any further. (yes, i
> > realize that, if you read carefully, it *should* make it clear, but i
> > think it would be helpful to at least graphically show that
> > happening.)
> >
> >   thoughts?
>
> So, we have both pictures, and I do not see there is much to add.
>
> By the way, I sense a mis-perception that led you to say "... has
> not developed any further".  In the topology in your second
> illustration, there is nothing to say that the rightmost two commits
> on the 'next' branch were created _after_ topic has forked from
> 'next'.  It is not just possible but also often is sensible to fork
> a topic closer to what it needs to build on top of, limiting its
> dependency as small as possible, so the 'topic' could have been
> forked from the middle of 'next' branch when it was originally
> created.

  yes, i see your point.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
