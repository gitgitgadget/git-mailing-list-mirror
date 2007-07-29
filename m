From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-diff: remove -r from --name-status example
Date: Sat, 28 Jul 2007 21:48:15 -0700
Message-ID: <7vbqdvolww.fsf@assigned-by-dhcp.cox.net>
References: <20070729002427.GA1566@coredump.intra.peff.net>
	<alpine.LFD.0.999.0707281905050.3442@woody.linux-foundation.org>
	<20070729041159.GA5544@coredump.intra.peff.net>
	<alpine.LFD.0.999.0707282119010.3442@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Jon Smirl <jonsmirl@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jul 29 06:48:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF0hY-0002yf-J1
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 06:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbXG2EsR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 00:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbXG2EsR
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 00:48:17 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:48189 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434AbXG2EsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 00:48:16 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070729044816.BMVB14885.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sun, 29 Jul 2007 00:48:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id VGoF1X00J1kojtg0000000; Sun, 29 Jul 2007 00:48:16 -0400
In-Reply-To: <alpine.LFD.0.999.0707282119010.3442@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sat, 28 Jul 2007 21:27:18 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54080>

Linus Torvalds <torvalds@linux-foundation.org> writes:

>> Does anybody else find this behavior confusing? I can understand why
>> diff-tree might not recurse by default, but I wonder if porcelain like
>> git-diff should try to be a little more consistent and always recurse.
>
> I do agree.
>
> The behaviour is obviously historical, and comes from "git diff" being 
> just a shell-script wrapper around the different versions of diffing trees 
> and indexes etc.
>
> So it makes sense in that historical setting (and realizing that the 
> "HEAD<->index" and "index<->files" cases were really a totally different 
> operations), but it makes no sense in the modern world where people don't 
> even *know* about "git diff-tree", but just use "git diff" for everything.
>
> So:
>
>> Something like:
>
> Ack. Patch looks fine, makes sense, and is obviously good.

That makes it two of us.  ... eh, excuse me, there is one issue
I mention at the end.

> It *is* a change in behaviour, though, so I can understand if Junio 
> doesn't think it's appropriate this late in the 1.5.3 series.

One minor objection I do have is that, just as a matter of
principle, in order to avoid setting precedence of making a
fundamental semantics change in late -rc stage in the game, we
should not swallow it.  I do not mind if this were clearly a
good change.

However, I think Jeff's patch always makes it recursive even
when the user asks for --raw, which makes it inappropriate for
inclusion whether before or after 1.5.3.
