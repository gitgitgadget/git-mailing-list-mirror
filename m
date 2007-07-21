From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gitk problems: can't unset "idinlist(...)"
Date: Fri, 20 Jul 2007 22:56:55 -0700
Message-ID: <7vfy3iwb88.fsf@assigned-by-dhcp.cox.net>
References: <alpine.LFD.0.999.0707201554540.27249@woody.linux-foundation.org>
	<20070721050912.GB20622@coredump.intra.peff.net>
	<alpine.LFD.0.999.0707202226130.27249@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jul 21 07:57:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IC7xd-00019O-0R
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 07:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757497AbXGUF46 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 01:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756466AbXGUF46
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 01:56:58 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:64194 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755259AbXGUF45 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 01:56:57 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070721055656.ZCML1358.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sat, 21 Jul 2007 01:56:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id S5ww1X0021kojtg0000000; Sat, 21 Jul 2007 01:56:56 -0400
In-Reply-To: <alpine.LFD.0.999.0707202226130.27249@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 20 Jul 2007 22:53:10 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53141>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> It seems to depend on the path limiter.
>
> With "arch/i386", I get the 7ed409 one, with "arch/i386 arch/x86_64" I get 
> a complaint about 57d1c91fa. In neither case do I see the reason.
>
> But I think I found a clue. One thing special about that 57d1c91fa is that 
> when you do
>
> 	git log --topo-order --parents --pretty=one arch/i386/ arch/x86_64/
>
> and search for it, it first shows up as a parent for commit 9fdb62af92: 
> and not just _one_ parent, but three! So it looks like the parent 
> simplification is broken, and maybe gitk is unhappy for that reason.

Yeah, I think if you limit the range at the bottom
(e.g. v2.6.21..)  the problem disappears.

> The same is true of 7ed40918a38, btw, so yeah, I think that's it.
>
> Junio, didn't we have some parent simplification patches recently?

We had a patch to remove duplicated parent or something, I
think.
