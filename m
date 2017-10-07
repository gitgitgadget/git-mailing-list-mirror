Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4866E2036B
	for <e@80x24.org>; Sat,  7 Oct 2017 19:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751868AbdJGT3F (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Oct 2017 15:29:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:36382 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751421AbdJGT3F (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Oct 2017 15:29:05 -0400
Received: (qmail 14885 invoked by uid 109); 7 Oct 2017 19:29:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 07 Oct 2017 19:29:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3628 invoked by uid 111); 7 Oct 2017 19:29:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 07 Oct 2017 15:29:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Oct 2017 15:29:02 -0400
Date:   Sat, 7 Oct 2017 15:29:02 -0400
From:   Jeff King <peff@peff.net>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Todd Zullinger <tmz@pobox.com>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: "git rm" seems to do recursive removal even without "-r"
Message-ID: <20171007192902.ma4s47hn6edwldx5@sigill.intra.peff.net>
References: <alpine.LFD.2.21.1710071436140.14843@localhost.localdomain>
 <20171007190402.GH3382@zaya.teonanacatl.net>
 <alpine.LFD.2.21.1710071506210.15271@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1710071506210.15271@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 07, 2017 at 03:12:01PM -0400, Robert P. J. Day wrote:

>   ok, in that case, can you give me an example where "-r" makes a
> difference, given that the man page refers to "a leading directory
> name being given"? let's use as an example the linux kernel source,
> where there are a *ton* of files named "Makefile" under the drivers/
> directory.
> 
>   should there be a difference between:
> 
>   $ git rm drivers/Makefile
>   $ git rm -r drivers/Makefile
> 
> clearly, i have a "leading directory name" in both examples above ...
> what should happen differently?

Nothing, because there is nothing to recurse in the pathspecs you've
given.

Try:

  $ git rm drivers
  fatal: not removing 'drivers' recursively without -r

versus

  $ git rm -r drivers
  [...removes everything under drivers/...]

-Peff
