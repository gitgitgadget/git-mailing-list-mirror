Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B005209B8
	for <e@80x24.org>; Thu, 14 Sep 2017 12:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751795AbdINMP5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 08:15:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:38530 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751701AbdINMP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 08:15:56 -0400
Received: (qmail 15321 invoked by uid 109); 14 Sep 2017 12:15:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Sep 2017 12:15:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26798 invoked by uid 111); 14 Sep 2017 12:16:31 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Sep 2017 08:16:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Sep 2017 08:15:54 -0400
Date:   Thu, 14 Sep 2017 08:15:54 -0400
From:   Jeff King <peff@peff.net>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: should "git tag" option of "-a" conflict with "-s", "-u"?
Message-ID: <20170914121553.mk4qksus2hqeqlh4@sigill.intra.peff.net>
References: <alpine.LFD.2.21.1709130741120.2766@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1709130741120.2766@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 14, 2017 at 06:08:10AM -0400, Robert P. J. Day wrote:

>   just noticed in "man git-tag":
> 
>   1)  "-a" explicitly claims to create an unsigned tag
>   2)  both "-s" and "-u" both claim to create signed tags
> 
> should that mean that it should be an error to try to use "-a" in
> combination with either of "-u" or "-s"? the synopsis does suggest
> that you can use only one of those at a time:
> 
>   git tag [-a | -s | -u <keyid>] ...
> 
> but i tested with (from memory) using both "-a" and "-s", and tag
> actually tried to do it, but failed simply because i had no key.
> clearly, though, it was making the attempt.
> 
>   can someone clarify this?

I think the documentation could be a little more clear. "-a" just asks
to create a tag object, rather than a "lightweight" tag. Using "-s" asks
for a signature, which requires having a tag object, and thus implies
"-a".

So there's no point in using the two together (since "-s" already
implies "-a"), but it also doesn't hurt to do so.

-Peff
