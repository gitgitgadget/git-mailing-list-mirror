From: Jeff King <peff@peff.net>
Subject: Re: tracking perms/ownership [was: empty directories]
Date: Fri, 24 Aug 2007 16:58:20 -0400
Message-ID: <20070824205820.GA19152@coredump.intra.peff.net>
References: <1187716461.5986.71.camel@beauty> <20070821134030.b763e9d3.seanlkml@sympatico.ca> <1187817948.5986.159.camel@beauty> <alpine.LFD.0.999.0708221618510.30176@woody.linux-foundation.org> <1187905879.5986.199.camel@beauty> <Pine.LNX.4.64.0708241136301.16728@wbgn129.biozentrum.uni-wuerzburg.de> <20070824095217.GB16853@coredump.intra.peff.net> <1187970632.6357.108.camel@beauty>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Josh England <jjengla@sandia.gov>
X-From: git-owner@vger.kernel.org Fri Aug 24 22:58:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOgEd-0004rO-9l
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 22:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756992AbXHXU6Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 16:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756999AbXHXU6Y
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 16:58:24 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2271 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756978AbXHXU6X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 16:58:23 -0400
Received: (qmail 17280 invoked by uid 111); 24 Aug 2007 20:58:22 -0000
X-Spam-Status: No, hits=-1.4 required=15.0
	tests=ALL_TRUSTED,AWL
X-Spam-Check-By: peff.net
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 24 Aug 2007 16:58:22 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Aug 2007 16:58:21 -0400
Content-Disposition: inline
In-Reply-To: <1187970632.6357.108.camel@beauty>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56601>

On Fri, Aug 24, 2007 at 09:50:32AM -0600, Josh England wrote:

> > direction and not at least consider people storing actual ACLs (or even
> > other extended attributes). An already-standard format like that
> 
> Do you mean using acls through contrib/hooks/update-paranoid?  That is
> the only place I see any mention of them.  clean and smudge seem out
> because they are passed blob objects and have no notion of pathname.  I
> don't see how to use this for automatic storing/restoring of
> perms/ownership.

No, I mean filesystem ACLs. Your complaint is that git stores only the
file _content_, not some specific metadata that you want (owner, group,
permissions). My point is that there is _other_ metadata, too (such as
POSIX ACLs) that could be stored. Even if you don't want to store them,
if you are extending git's capabilities, it makes sense to at least
consider how to handle those cases, too.

But yes, clean and smudge don't get the pathname. It would be a fairly
trivial patch, though, so maybe I'll play with it.

-Peff
