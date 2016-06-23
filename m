Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D87A1FF40
	for <e@80x24.org>; Thu, 23 Jun 2016 13:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246AbcFWNIe (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 09:08:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:59014 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752053AbcFWNId (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 09:08:33 -0400
Received: (qmail 18639 invoked by uid 102); 23 Jun 2016 13:08:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 09:08:32 -0400
Received: (qmail 10290 invoked by uid 107); 23 Jun 2016 13:08:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jun 2016 09:08:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jun 2016 09:08:29 -0400
Date:	Thu, 23 Jun 2016 09:08:29 -0400
From:	Jeff King <peff@peff.net>
To:	Simon Courtois <scourtois@cubyx.fr>
Cc:	git@vger.kernel.org
Subject: [PATCH 0/2] more ANSI attributes
Message-ID: <20160623130828.GA25209@sigill.intra.peff.net>
References: <etPan.576bcdfa.7aee6fa4.9bf5@cubyx.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <etPan.576bcdfa.7aee6fa4.9bf5@cubyx.fr>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 23, 2016 at 01:54:34PM +0200, Simon Courtois wrote:

> I was looking for a way to use italics in my git log. I ended-up
> looking at the code dealing with colors and style and noticed that the
> italic code was skipped when defining the list (color.c:128 if I'm not
> mistaken).
> 
> I'd love to propose a contribution but I'm sadly not very well versed
> with C.

My first suggestion was going to be that you can feed arbitrary numbers
yourself, without git having to have a name for it. But that is true
only of colors, not attributes. So it does need a patch.

Here is one, along with a minor cleanup. I think the attributes we don't
support now are:

  - 6; rapid blink (not supported by xterm)
  - 8; conceal (supported, but why would you want it?)
  - 9; crossed-out (supported, and at least plausible to want?)

We also don't support font-selection (10-19, or 20 for Fraktur) which
are not supported by xterm (of course xterm support is not the defining
criterion, if people have other terms that do support it. My point is
mostly "nobody is asking for it, and it is not even in xterm").

  [1/2]: color: fix max-size comment
  [2/2]: color: support "italic" attribute

-Peff
