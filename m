Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAA941FA21
	for <e@80x24.org>; Sun,  8 Oct 2017 18:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753398AbdJHSlC (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Oct 2017 14:41:02 -0400
Received: from imap.thunk.org ([74.207.234.97]:49528 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753236AbdJHSlB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2017 14:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=27aRD/uKyBhoVYpthRj0cHQZ7hoQOtJcJwW8SwgHedU=; b=pb5yKe3K/5LLagnpYh8dLkynXq
        zpszeOF+lRGc+0fQlz1gsy1dDg04ko3hIDyqLgOYjcQBMGLod31WKH58upS8qNWM30KKBDtnxXYSK
        MJ6YioCgKCwtcqbrEHaL/tHVk0ZoP1qprbranN6gGPI4pQMS5ONjcBXBRD5ClkP2zzGY=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1e1GVL-0000UL-2T; Sun, 08 Oct 2017 18:40:47 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 23BC4C00C17; Sun,  8 Oct 2017 14:40:46 -0400 (EDT)
Date:   Sun, 8 Oct 2017 14:40:46 -0400
From:   Theodore Ts'o <tytso@mit.edu>
To:     Paul Smith <paul@mad-scientist.net>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: "git rm" seems to do recursive removal even without "-r"
Message-ID: <20171008184046.uj7gcutddli54ic3@thunk.org>
References: <alpine.LFD.2.21.1710071436140.14843@localhost.localdomain>
 <20171007190402.GH3382@zaya.teonanacatl.net>
 <alpine.LFD.2.21.1710071506210.15271@localhost.localdomain>
 <20171007192902.ma4s47hn6edwldx5@sigill.intra.peff.net>
 <alpine.LFD.2.21.1710071531090.15738@localhost.localdomain>
 <20171007193805.a2mwzkweonb6ymdk@sigill.intra.peff.net>
 <alpine.LFD.2.21.1710071541430.15964@localhost.localdomain>
 <1507412674.8322.4.camel@mad-scientist.net>
 <alpine.LFD.2.21.1710071749240.16818@localhost.localdomain>
 <1507473160.8322.12.camel@mad-scientist.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1507473160.8322.12.camel@mad-scientist.net>
User-Agent: NeoMutt/20170609 (1.8.3)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 08, 2017 at 10:32:40AM -0400, Paul Smith wrote:
> Personally I don't use Git's magical globbing capabilities, and use "git
> rm" as if it were UNIX rm.  So in your request above I'd use:
> 
>    git rm $(find . -name Makefile)
> 
> which I find simpler.

I have to agree that git's magical globbing capabilities
are... strange.  (And apologies to Robert for my earlier post; I
didn't understand what he was complaining about.)  I don't use it
either, although I tend to use:

    find <find args> | xargs git rm

myself.

One thing which is interesting is that not only is the git's magical
globbing capabilities have somewhat unusual semantics, the how
globbing is done in .gitignore entries are completely different.

Shrug.  I put this in the same category as "tabs are significant in
Makefile's", "whitespace is significant in python", and "the many
varied different behaviours and uses of 'git reset'".

They are all idiosyncrancies of semantics of various highly popular
tools (which being highly popular, would make changing the details
quite difficult due to backwards compatibility concerns, even if we
wanted to change them).

						- Ted


