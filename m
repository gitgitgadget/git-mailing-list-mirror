From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Add a 'source' decorator for commits
Date: Tue, 28 Oct 2008 15:29:43 -0400
Message-ID: <20081028192942.GA752@sigill.intra.peff.net>
References: <alpine.LFD.2.00.0810271256470.3386@nehalem.linux-foundation.org> <alpine.LFD.2.00.0810271305500.3386@nehalem.linux-foundation.org> <alpine.LFD.2.00.0810271306230.3386@nehalem.linux-foundation.org> <20081028054539.GA23195@sigill.intra.peff.net> <alpine.LFD.2.00.0810280755570.3386@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Oct 28 20:33:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuuHN-0008M1-MZ
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 20:31:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427AbYJ1T3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 15:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753374AbYJ1T3r
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 15:29:47 -0400
Received: from peff.net ([208.65.91.99]:3070 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753244AbYJ1T3r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 15:29:47 -0400
Received: (qmail 23116 invoked by uid 111); 28 Oct 2008 19:29:45 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (216.239.45.19)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 28 Oct 2008 15:29:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Oct 2008 15:29:43 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0810280755570.3386@nehalem.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99313>

On Tue, Oct 28, 2008 at 08:17:02AM -0700, Linus Torvalds wrote:

> >   - Does it make sense to have this _in addition_ to --decorate (since
> >     for any commit with a --decorate field, it would likely be the same
> >     as --source)? Should it be a different type of decorate instead,
> >     like --decorate=source or --decorate=branch?
> 
> I think they are different. People who want --source generally have other 
> issues than people who want --decorate, and the two do actually work 
> together.

Sleeping on this and thinking about it some more, I think you are right
here, and all of the other complaints I had just go away.

I was thinking of it as "decorate commits with the likely branches they
were made on." But that's not what this is at all (though it happens to
come up with similar answers!). It's really about "show which ref, of
the refs which were requested to be shown, we started at to reach this
commit." Which is perhaps more limited, but obvoiusly is much faster to
compute.

And then the output of "git log --source HEAD" makes perfect sense, and
it makes sense not to worry about finding the "closest" ref. It is
really about annotating the traversal that you asked for.

So now my only complaint is the lack of documentation and tests. ;)

-Peff
