Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16FC11F42D
	for <e@80x24.org>; Thu, 31 May 2018 17:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755763AbeEaR3V (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 13:29:21 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:50860 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755719AbeEaR3V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 13:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
        Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3DHJygLID0GEfQvt04rwHJnsg3/lIG4N7hs+Ur+CjOU=; b=Q2RFvXlOqjCPY6rOKHCBSiVe7
        jH+GTXMVhQht5yMyCprWXMqVKgdekjJVx66cSZv7HGxLkbQNBEDiqBesGdAvssZIzgtLiGYGpqhFH
        pJQbjo1Ksga483df9/0A/AT4LOUYpsX2KSZ3zKEaIQrSB9Zdg5P9M6krZ/OlIPCUSqAlB1yZ/8Mbb
        64dZ7LQQ4iwJXTo0fTh+XP4Z/a2nUO4VYb0PfzFfZe+vSyhU8REDS93eAUQhpfsiZjOZKz9pl7Spl
        WJFLXo6GAEmijUGnB2l6mpQPcirvtPZ4B/RAzJbk0HY+/EWFdUX6fIw9nVwiRa4OyFIdNGMrhCeA0
        R9KuOmY6w==;
Received: from cpeac202e043973-cmac202e043970.cpe.net.cable.rogers.com ([174.112.22.87]:59864 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fORO2-004oTP-CN; Thu, 31 May 2018 13:29:19 -0400
Date:   Thu, 31 May 2018 13:27:20 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: is there a reason pre-commit.sample uses "git diff-index"?
In-Reply-To: <CACsJy8CP=1_bHAzs+mveaJvbOOzr9vny-2xz6kM4cEcCYWmOOw@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.1805311323220.17047@localhost.localdomain>
References: <alpine.LFD.2.21.1805311235410.15130@localhost.localdomain> <CACsJy8CP=1_bHAzs+mveaJvbOOzr9vny-2xz6kM4cEcCYWmOOw@mail.gmail.com>
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

On Thu, 31 May 2018, Duy Nguyen wrote:

> On Thu, May 31, 2018 at 6:38 PM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> >
> >   was going over some hooks and writing some tutorials for some of
> > the commit-related, client-side hooks, and was wondering (perhaps
> > stupidly) why the pre-commit.sample hook uses, as its last line:
> >
> >   exec git diff-index --check --cached $against --
> >            ^^^^^^^^^^
> >
> > as in, could this not be done equivalently with just git diff, not
> > git diff-index? i just did a quick test and it seems to do the
> > same thing, but i've never taken a close look at git diff-index
> > before so i may just be clueless about some important distinction.
>
> git diff-index is "plumbing", designed for writing scripts. "git
> diff" on the other hand is for users and its behavior may change
> even if it breaks backward compatibility.

  ah, this was a philosophical underpinning i was unaware of. i see
occasional explanations of git porcelain versus plumbing, but i don't
recall anyone simply stating that the plumbing is meant to have a
long-term stability that is not guaranteed for the porcelain.

  in any event, this does mean that, stability issues aside, "git
diff" would apparently have worked just fine for that hook.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
