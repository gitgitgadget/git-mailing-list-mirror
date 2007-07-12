From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Better handling of local changes in 'gitk'?
Date: Thu, 12 Jul 2007 13:43:41 -0700
Message-ID: <7vir8ptksi.fsf@assigned-by-dhcp.cox.net>
References: <alpine.LFD.0.999.0707121214420.20061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 12 22:43:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I95Vs-0006Dd-Pm
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 22:43:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757041AbXGLUno (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 16:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756165AbXGLUnn
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 16:43:43 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:43319 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753981AbXGLUnn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 16:43:43 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070712204342.ULC1399.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Thu, 12 Jul 2007 16:43:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Nkjh1X00U1kojtg0000000; Thu, 12 Jul 2007 16:43:42 -0400
In-Reply-To: <alpine.LFD.0.999.0707121214420.20061@woody.linux-foundation.org>
	(Linus Torvalds's message of "Thu, 12 Jul 2007 12:20:05 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52331>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I like how gitk shows the local changes as an unnamed commit at the top, 
> but what I *don't* like is how it just ignored the difference between 
> stuff that has been added to the index, and stuff that hasn't..
>
> It would be very nice to have *two* such commits (either or both of which 
> just disappear), where the top-most is the diff to the index, and the 
> second is the diff from the index to HEAD.
>
> That would not only be useful in general, it would be a wonderful way to 
> visually introduce people to the notion of what the staging area is all 
> about.

Interesting, as I was thinking about something similar when I
typed "git show stash" by mistake. I meant to say "git stash
show", but "git show stash" output actually was even closer to
what I wanted to see.

"git stash" internally creates two commits, based on your HEAD:

         .----W
        /    / 
    ---H----I

Here, W keeps the state of the working tree, I is the index
state and H is the HEAD.  Commit I is direct child of H, Commit
W is an evil merge between H and I, and that is what is kept as
refs/stash, so "git show stash" would end up showing that merge
in --cc format.
