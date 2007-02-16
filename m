From: Jeff King <peff@peff.net>
Subject: Re: Dangers of working on a tracking branch
Date: Fri, 16 Feb 2007 10:52:51 -0500
Message-ID: <20070216155251.GA7183@coredump.intra.peff.net>
References: <17876.51013.561979.431717@lisa.zopyra.com> <Pine.LNX.4.64.0702151557410.1757@xanadu.home> <17876.52962.662946.582507@lisa.zopyra.com> <17876.53654.426022.454712@lisa.zopyra.com> <er333i$787$1@sea.gmane.org> <17877.51730.418633.750922@lisa.zopyra.com> <20070216152130.GA7086@coredump.intra.peff.net> <17877.52593.509791.685008@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Fri Feb 16 16:53:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HI5OO-0004S6-1l
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 16:53:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945945AbXBPPw5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 10:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945953AbXBPPw4
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 10:52:56 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3126 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1945945AbXBPPw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 10:52:56 -0500
Received: (qmail 32079 invoked from network); 16 Feb 2007 10:53:01 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 16 Feb 2007 10:53:01 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Feb 2007 10:52:51 -0500
Content-Disposition: inline
In-Reply-To: <17877.52593.509791.685008@lisa.zopyra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39922>

On Fri, Feb 16, 2007 at 09:27:45AM -0600, Bill Lear wrote:

> Ok, fair enough, but then I guess I'm back to my original question:
> how can I give a concrete demonstration to our developers that this is
> a bad thing?

I think it will always work with the example you gave, because you are
simultaneously fetching into the tracking branch (which fails) and
merging from FETCH_HEAD (which succeeds) into that same tracking branch.

At best, though, the tracking branch you have is pointless (since you
immediately overwrite it anyway).  The point of a tracking branch
generally is to allow you to do operations against your peer's idea of
the branch (e.g., diffing against upstream's version of "topic"). But
you can't do that, because "topic" always contains your topic, not
upstream's. In effect, your pull becomes one without a tracking branch
at all.

This will also get you on a push, where there is no merging at all, just
a fast-forward (or failure). IIRC, you ran into problems before because
you were trying to push into your public repo from your private, but the
two had divergent branches. So I think to illustrate the problem you had
before, you actually need an intermediate repo which has you fetch from
and push to.

-Peff
