From: Jeff King <peff@peff.net>
Subject: Re: Properties of trees referencing commit objects (mode 160000)?
Date: Sun, 20 Mar 2016 00:18:04 -0400
Message-ID: <20160320041803.GC18312@sigill.intra.peff.net>
References: <20160319221348.GA5247@x>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Sun Mar 20 05:18:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahUol-000832-0x
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 05:18:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbcCTESJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 00:18:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:34739 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750707AbcCTESH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 00:18:07 -0400
Received: (qmail 17392 invoked by uid 102); 20 Mar 2016 04:18:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 20 Mar 2016 00:18:06 -0400
Received: (qmail 24289 invoked by uid 107); 20 Mar 2016 04:18:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 20 Mar 2016 00:18:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Mar 2016 00:18:04 -0400
Content-Disposition: inline
In-Reply-To: <20160319221348.GA5247@x>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289331>

On Sat, Mar 19, 2016 at 03:13:48PM -0700, Josh Triplett wrote:

> I'm building some tools to track commit objects, and I'm thinking of
> using submodule-style references to commit objects in tree objects (mode
> 160000) to do so.  I'm trying to figure out some of the properties of
> that.
> 
> Can a commit object referenced that way live in the same repository,
> rather than some external repository?

Yes, it can be in the same repository, but...

> Will git treat such a reference as keeping the commit object (and
> everything recursively referenced by it) live and reachable?  If that
> commit object is only reachable by the tree, and not by following the
> parents of any commit directly referenced from refs/*, will git discard
> it as unreachable?

No, we do not follow "gitlinks" like this for reachability. Neither for
pruning, nor for object transfer via push/fetch. So you'd need to have a
separate reference to it (or history containing it).

-Peff
