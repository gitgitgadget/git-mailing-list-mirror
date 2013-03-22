From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] wt-status: fix possible use of uninitialized variable
Date: Fri, 22 Mar 2013 12:15:41 -0400
Message-ID: <20130322161540.GF3083@sigill.intra.peff.net>
References: <20130321110338.GA18552@sigill.intra.peff.net>
 <20130321110527.GA18819@sigill.intra.peff.net>
 <20130321194949.GG29311@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 22 17:16:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ4de-0008KC-Fl
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 17:16:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933680Ab3CVQPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 12:15:50 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:35835 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754313Ab3CVQPt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 12:15:49 -0400
Received: (qmail 2012 invoked by uid 107); 22 Mar 2013 16:17:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Mar 2013 12:17:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Mar 2013 12:15:41 -0400
Content-Disposition: inline
In-Reply-To: <20130321194949.GG29311@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218815>

On Thu, Mar 21, 2013 at 12:49:50PM -0700, Jonathan Nieder wrote:

> > We could also convert the flag to an enum, which would
> > provide a compile-time check on the function input.
> 
> Unfortunately C permits out-of-bounds values for enums.

True, although I would think that most compilers take the hint for
switch() statements that handling all defined constants for an enum is
enough (certainly gcc does it with the "some enum constants not handled"
warning, but I did not actually check whether it does so in the
uninitialized-warning control flow checker).

Still, I'm happy enough with the die("BUG") that I posted, so we don't
need to worry about it.

-Peff
