From: Jeff King <peff@peff.net>
Subject: Re: git-checkout sometimes silently fails
Date: Tue, 6 May 2008 20:19:19 -0400
Message-ID: <20080507001919.GA8633@sigill.intra.peff.net>
References: <20080506122256.04ca7d77.akpm@linux-foundation.org> <20080506215049.GC4647@steel.home> <20080506171052.340d643e.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed May 07 02:20:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtXOB-0006r6-W8
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 02:20:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752446AbYEGATU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 20:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752588AbYEGATU
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 20:19:20 -0400
Received: from peff.net ([208.65.91.99]:3099 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751529AbYEGATT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 20:19:19 -0400
Received: (qmail 7310 invoked by uid 111); 7 May 2008 00:19:18 -0000
Received: from lawn-128-61-20-83.lawn.gatech.edu (HELO sigill.intra.peff.net) (128.61.20.83)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 06 May 2008 20:19:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 May 2008 20:19:19 -0400
Content-Disposition: inline
In-Reply-To: <20080506171052.340d643e.akpm@linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81390>

On Tue, May 06, 2008 at 05:10:52PM -0700, Andrew Morton wrote:

> > > y:/usr/src/git26> git-checkout master
> > > Switched to branch "master"
> > > y:/usr/src/git26> cat kernel/*.c|sum
> > > 34439  2057
> > > y:/usr/src/git26> git-checkout linux-next
> > > Switched to branch "linux-next"
> > > y:/usr/src/git26> cat kernel/*.c|sum     
> > > 34439  2057
> > 
> > This is not a good indication of a failed checkout (they could point
> > to the same commit, for one).
> 
> How could they?  linux-next includes a directory called ./Next and a file
> in that directory called ./Next/Trees, and that is not present after the
> `git-checkout linux-next'.

But you don't show us that in your example. There is nothing in your
example to indicate that they are not simply pointing at the same
commit...

> > Try "gitk master...linux-next" (or "git
> > log master..linux-next", "git diff master linux-next")
> 
> These come up empty.  But there is a 12.4MB diff between mainline and
> linux-next.

And if these all come up empty, then they _are_ pointing to the same
commit. When you say "but there is a 12.4MB diff..." do you mean "there
_should_ be such a diff?" In that case, it seems that your linux-next
ref is pointing to an unexpected commit.

So the problem is not with git-checkout, but rather that you are not
checking out what you think you are checking out. And so we need to
figure out how you got into that state.

What command did you use to create the linux-next branch? Have you used
git-reset to move the branch tip around?

-Peff
