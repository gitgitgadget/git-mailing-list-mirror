From: Jeff King <peff@peff.net>
Subject: Re: What is the default refspec for fetch?
Date: Sat, 8 Nov 2014 05:52:21 -0500
Message-ID: <20141108105221.GA20750@peff.net>
References: <CAENte7inZ5fm2SzNPq=HNPKnPco9tM4T_es5Dphnpbia-uiLdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git <git@vger.kernel.org>
To: Christian Halstrick <christian.halstrick@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 08 11:52:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xn3d6-0007JF-Oz
	for gcvg-git-2@plane.gmane.org; Sat, 08 Nov 2014 11:52:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606AbaKHKwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2014 05:52:25 -0500
Received: from cloud.peff.net ([50.56.180.127]:37925 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753580AbaKHKwY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2014 05:52:24 -0500
Received: (qmail 2906 invoked by uid 102); 8 Nov 2014 10:52:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 08 Nov 2014 04:52:24 -0600
Received: (qmail 3239 invoked by uid 107); 8 Nov 2014 10:52:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 08 Nov 2014 05:52:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Nov 2014 05:52:21 -0500
Content-Disposition: inline
In-Reply-To: <CAENte7inZ5fm2SzNPq=HNPKnPco9tM4T_es5Dphnpbia-uiLdg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 07, 2014 at 04:31:08PM +0100, Christian Halstrick wrote:

> In a repo where no remote.<name>.fetch config parameter is set what
> should a "git fetch" do? My experiments let me think it's
> "HEAD:FETCH_HEAD". Right?

Basically, yes. We always write FETCH_HEAD, regardless of the refspec.
We choose "HEAD" if no other refspec was provided. So it is really more
like

  git fetch $remote HEAD

This is what makes one-off bare-url pulls work, like:

  git pull git://...

It runs fetch under the hood, which writes into FETCH_HEAD, and then we
merge that.

-Peff
