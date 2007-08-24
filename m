From: Jeff King <peff@peff.net>
Subject: Re: tracking perms/ownership [was: empty directories]
Date: Fri, 24 Aug 2007 06:05:24 -0400
Message-ID: <20070824100524.GA17348@coredump.intra.peff.net>
References: <1187716461.5986.71.camel@beauty> <20070821134030.b763e9d3.seanlkml@sympatico.ca> <1187817948.5986.159.camel@beauty> <alpine.LFD.0.999.0708221618510.30176@woody.linux-foundation.org> <1187905879.5986.199.camel@beauty> <Pine.LNX.4.64.0708241136301.16728@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josh England <jjengla@sandia.gov>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 24 12:06:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOW3D-0002s7-Pg
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 12:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765009AbXHXKF2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 06:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764827AbXHXKF2
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 06:05:28 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1664 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764681AbXHXKF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 06:05:27 -0400
Received: (qmail 10948 invoked by uid 111); 24 Aug 2007 10:05:25 -0000
X-Spam-Status: No, hits=-1.4 required=15.0
	tests=ALL_TRUSTED
X-Spam-Check-By: peff.net
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 24 Aug 2007 06:05:25 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Aug 2007 06:05:24 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708241136301.16728@wbgn129.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56569>

On Fri, Aug 24, 2007 at 11:38:13AM +0200, Johannes Schindelin wrote:

> I wonder why you do not just use the "smudge" and "clean" attributes, and 
> store the ownership _and_ the permissions in .gitacls.

Thinking about this more, are you proposing:

1. Clean and smudge every file, looking up the attributes in .gitacls.
In that case, I think they are not sufficient because the filter script
receives only the blob content on stdin, but never sees the filename.

or

2. Clean and smudge .gitacls, munging the file permissions as a side
effect. In this case, won't some git operations that write the files
break your permissions (i.e., if I update "foo" but not .gitacls, then
the .gitacls filter won't be run and I will be left with git's default
permissions).

-Peff
