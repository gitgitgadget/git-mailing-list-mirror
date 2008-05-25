From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/3] bisect: use a detached HEAD to bisect
Date: Sat, 24 May 2008 20:37:56 -0400
Message-ID: <20080525003755.GA11019@sigill.intra.peff.net>
References: <20080523012857.acce6457.chriscool@tuxfamily.org> <7v3ao9twfa.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0805230823330.3081@woody.linux-foundation.org> <18487.62245.59892.442935@cargo.ozlabs.ibm.com> <alpine.LFD.1.10.0805240842360.3081@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun May 25 02:39:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K04GX-0007kS-Ej
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 02:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753829AbYEYAiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 20:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754075AbYEYAh7
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 20:37:59 -0400
Received: from peff.net ([208.65.91.99]:4505 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753829AbYEYAh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 20:37:59 -0400
Received: (qmail 14114 invoked by uid 111); 25 May 2008 00:37:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 24 May 2008 20:37:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 24 May 2008 20:37:56 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0805240842360.3081@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82842>

On Sat, May 24, 2008 at 09:14:21AM -0700, Linus Torvalds wrote:

> I actually like the red circle for "Local uncommitted changes". Maybe we 
> can use a similar visual clue for "currently checked out". You already 
> picked green for the "added to the index" case, so we have the three 
> primary RGB colors already used, but we could make it just be a deep 
> yellow.
>
> [...]
> 
> Here's a "make it yellow" patch.

I kind of expected this to color the _ref_, not the commit bubble. That
is, I think it is useful not just to see that "this commit is pointed to
by HEAD" but that "master is the currently checked out branch."

Of course in the case of detached HEAD, we would have only the commit to
color. But in that case a green box probably makes sense, since you
probably aren't going to have a bunch of other boxes pointing to it
(at most, a tag name or remote tracking branch name).

IOW,

  1. If head points to a ref, color the background of that ref box
     specially (yellow and green are taken. Red is probably a bit too
     danger-implying.  Blue?)
     ...
     Hmm, actually it looks like we already bold the refname in that
     case. I never noticed that until now. If I'm not the only one,
     then maybe that is an argument for making the differentiation more
     obvious.

  2. If head is detached, add a green 'HEAD' box.

-Peff
