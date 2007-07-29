From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-diff: remove -r from --name-status example
Date: Sun, 29 Jul 2007 02:36:23 -0700
Message-ID: <7vwswjmu08.fsf@assigned-by-dhcp.cox.net>
References: <20070729002427.GA1566@coredump.intra.peff.net>
	<alpine.LFD.0.999.0707281905050.3442@woody.linux-foundation.org>
	<20070729041159.GA5544@coredump.intra.peff.net>
	<alpine.LFD.0.999.0707282119010.3442@woody.linux-foundation.org>
	<7vbqdvolww.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Jon Smirl <jonsmirl@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jul 29 11:36:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF5CO-0003FN-Hv
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 11:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760984AbXG2JgZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 05:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760971AbXG2JgZ
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 05:36:25 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:43198 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760986AbXG2JgY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 05:36:24 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070729093625.HHBE1393.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sun, 29 Jul 2007 05:36:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id VMcP1X00F1kojtg0000000; Sun, 29 Jul 2007 05:36:24 -0400
In-Reply-To: <7vbqdvolww.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 28 Jul 2007 21:48:15 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54100>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> ...
>> Ack. Patch looks fine, makes sense, and is obviously good.
>
> That makes it two of us.  ... eh, excuse me, there is one issue
> I mention at the end.
>
>> It *is* a change in behaviour, though, so I can understand if Junio 
>> doesn't think it's appropriate this late in the 1.5.3 series.
>
> One minor objection I do have is that, just as a matter of
> principle, in order to avoid setting precedence of making a
> fundamental semantics change in late -rc stage in the game, we
> should not swallow it.  I do not mind if this were clearly a
> good change.
>
> However, I think Jeff's patch always makes it recursive even
> when the user asks for --raw, which makes it inappropriate for
> inclusion whether before or after 1.5.3.

Actually, I would like to take this back.  The highest level UI
"git-diff" is for the end-users, and most of them typically do
not seem to want non recursive "birds-eye" view of changes.

The top-level non-recursive behaviour is not always useful as a
birds-eye view.  Even in Linux kernel context, when you are
interested in one area e.g. i386, the answer the non recursive
behaviour gives us would not show what you typically want to see
(i.e. include/asm-i386 and arch/i386), but it stops at the
"toplevel", i.e. include and arch.

In addition, it is not like our tree diff is too slow and not
recursing into lower level makes it usable.

In short, I think recursive behaviour by default makes sense for
"git diff".

When people want to use lower level git-diff-* family, I think
the traditional behaviour is fine.  We _might_ want to default
the --name-status and --name-only to recursive behaviour as
well, but (1) that is an independent topic, and (2) we should
re-examine what the appropriate recursiveness for the other
options.
