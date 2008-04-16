From: Jeff King <peff@peff.net>
Subject: Re: Friendly refspecs
Date: Tue, 15 Apr 2008 23:48:23 -0400
Message-ID: <20080416034823.GA11727@sigill.intra.peff.net>
References: <20080409101428.GA2637@elte.hu> <20080409145758.GB20874@sigill.intra.peff.net> <20080409200836.GA19248@mithlond> <20080409203453.GA10370@sigill.intra.peff.net> <20080409222500.GB19248@mithlond> <20080409225112.GB12103@sigill.intra.peff.net> <20080413093102.GC12107@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Wed Apr 16 06:32:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jlydy-0004XQ-AE
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 05:49:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754405AbYDPDs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 23:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754501AbYDPDsZ
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 23:48:25 -0400
Received: from [208.65.91.99] ([208.65.91.99]:4076 "EHLO peff.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754384AbYDPDsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 23:48:25 -0400
Received: (qmail 8728 invoked by uid 111); 16 Apr 2008 03:48:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 15 Apr 2008 23:48:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Apr 2008 23:48:23 -0400
Content-Disposition: inline
In-Reply-To: <20080413093102.GC12107@mithlond.arda.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79650>

On Sun, Apr 13, 2008 at 12:31:02PM +0300, Teemu Likonen wrote:

> There is still one thing (at least) that I don't quite understand. It's
> about "git push". When I do
> 
>   $ git push <remote> <branch>
> 
> the refs/heads/<branch> is updated or created on the remote side. But if
> I do
> 
>   $ git push <remote> <branch1>:<branch2>
> 
> the refs/heads/<branch2> is not automatically created. Why there is need
> to say "<branch1>:refs/heads/<branch2>" to make it work if <branch2>
> does not exist? The 'git push' manual says something vague about branch
> not matching (?). What does it mean?

This happens because "git push <remote> <branch>" is expanded locally to
"git push <remote> <branch>:<branch>", but <branch> is first expanded
into refs/heads/<branch>.

The latter uses the explicit refspec <branch2> which doesn't get
expanded, since it doesn't exist at all, and so we can't deduce the type
(e.g., refs/heads versus refs/tags).

ISTR some discussion in the past few months about using the type of
<branch1> to guess the type of <branch2>, but it seems not to have gone
anywhere.

Daniel, were you working on this?

-Peff
