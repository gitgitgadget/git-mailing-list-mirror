From: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: Bizarre missing changes (git bug?)
Date: Wed, 30 Jul 2008 03:50:01 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0807300315280.6791@localhost.localdomain>
References: <alpine.LFD.1.10.0807261249430.4188@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807270049290.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807280141140.6791@localhost.localdomain>
 <alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org>
 <Pine.LNX.4.64.0807281241180.6791@localhost.localdomain>
 <20080729053108.GH26997@sigill.intra.peff.net>
 <Pine.LNX.4.64.0807291339580.6791@localhost.localdomain>
 <20080729125247.GC12069@sigill.intra.peff.net>
 <alpine.LFD.1.10.0807291006070.3334@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Tim Harper <timcharper@gmail.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jul 30 03:51:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO0r3-0005DA-QP
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 03:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173AbYG3Bux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 21:50:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751860AbYG3Bux
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 21:50:53 -0400
Received: from smtp-vbr4.xs4all.nl ([194.109.24.24]:2183 "EHLO
	smtp-vbr4.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbYG3Buw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 21:50:52 -0400
Received: from squid.home (linux-m68k.xs4all.nl [82.95.193.92])
	(authenticated bits=0)
	by smtp-vbr4.xs4all.nl (8.13.8/8.13.8) with ESMTP id m6U1o1bA044558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 30 Jul 2008 03:50:02 +0200 (CEST)
	(envelope-from zippel@linux-m68k.org)
X-X-Sender: roman@localhost.localdomain
In-Reply-To: <alpine.LFD.1.10.0807291006070.3334@nehalem.linux-foundation.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90724>

Hi,

On Tue, 29 Jul 2008, Linus Torvalds wrote:

> Now, do these three things
> 
> 	gitk
> 	gitk file
> 	gitk --full-history file
> 
> and compare them. They all show _different_ histories.
> 
> Which one is "correct"? They all are. It just depends on what you want to 
> see.
> 
> The "gitk file" history is the simplest one BY FAR, because it has very 
> aggressively simplified history to the point where it tried to find the 
> _simplest_ history that explains the current contents of 'file'[*]

It's "aggressively simplified" by not even bothering to look for more.
"simplified" implies there is something more complex beforehand, but all 
it does is simple scan through the history as fast possible without 
bothering looking left or right.
"simplified" implies to me it's something intentional, but this is more of 
an accidental optimization which happens to work in most situations and in 
the special cases it just picks a random change and hopes for the best.

"git-log --full-history file" at least produces the full change history, 
but it has an performance impact and it doesn't produce a complete graph 
usable for graphical front ends.

> >From a practical standpoint, and from having used this a long time, I'd 
> argue that the simple history is the one that you want 99.9% of all time. 
> But not _always_. Sometimes, the things that got simplified away actually 
> matter. It's rare, but it happens.
> 
> For example, maybe you had a bug-fix that you _know_ you did, and it it 
> doesn't show up in the simplified history. That really pisses you off, and 
> it apparently really pisses Roman off that it can happen. But the fact is, 
> that still doesn't mean that the simple history is "wrong" or even 
> "incomplete".

I gave more general examples. Tracking upstream source can produce this 
problem frequently. Another example are stable/unstable branches where the 
stable branch is occasionally merged into the unstable branch can produce 
this problem.

> No, it's actually meaningful data in itself. If the bug-fix doesn't show 
> in the simplified history, then that simply means that the bug-fix was not 
> on a branch that could _possibly_ have mattered for the current contents. 
> 
> So once you are _aware_ of history simplification and are mentally able to 
> accept it, the fact that history got simplified is actually just another 
> tool.

This is your _subjective_ interpretion of this problem, because it's not a 
problem for you, nobody else can possibly have this problem (or they just 
crazy).
Even if I know about this limitation it still doesn't solve the problem, 
that _none_ of the graphical interfaces can show me a useful history graph 
of these situations.

bye, Roman
