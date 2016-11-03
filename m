Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDBD62021E
	for <e@80x24.org>; Thu,  3 Nov 2016 18:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759450AbcKCSC1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 14:02:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:38192 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756863AbcKCSC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 14:02:27 -0400
Received: (qmail 4643 invoked by uid 109); 3 Nov 2016 18:02:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Nov 2016 18:02:26 +0000
Received: (qmail 15098 invoked by uid 111); 3 Nov 2016 18:02:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Nov 2016 14:02:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Nov 2016 14:02:24 -0400
Date:   Thu, 3 Nov 2016 14:02:24 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Blake Burkhart <bburky@bburky.com>
Subject: Re: [PATCH] transport: add core.allowProtocol config option
Message-ID: <20161103180224.7mhpziotpinmd3tr@sigill.intra.peff.net>
References: <1478125247-62372-1-git-send-email-bmwill@google.com>
 <20161103002225.GA13369@google.com>
 <20161103143806.hce4msk3dhxtgpre@sigill.intra.peff.net>
 <20161103172515.GA182568@google.com>
 <CAGZ79kbvs+ryGRjCkHYO=3iNK4tPPhBhYjRMZaH7rP0QMrULhg@mail.gmail.com>
 <20161103175131.GB182568@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161103175131.GB182568@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 03, 2016 at 10:51:31AM -0700, Brandon Williams wrote:

> > > I don't know if I'm sold on a 'user' state just yet, perhaps that's just
> > > because I view a whitelist or blacklist as well black and white and
> > > having this user state adds in a gray area.
> > 
> > Well the "user" state is to differentiate between the
> > * "I consciously typed `git clone ...` (and e.g. I know what happens as
> >   I know the server admin and they are trustworthy.)
> > * a repository contains a possible hostile .gitmodules file such
> >   that I am not aware of the network connection.
> 
> This is still a gray area to me.  I think that if we have a whitelist of
> protocols then it should be a true whitelist and not have some means of
> going around it.  It just seems like something that could be exploited.

How do you implement:

  git clone --recursive trusted:foo.git

and use your ssh keys for the "trusted" server, but not for any servers
mentioned in .gitmodules?

You need some way of distinguishing between the two contexts (and
setting policy for each).

-Peff
