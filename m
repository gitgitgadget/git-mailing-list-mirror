From: Nicolas Pitre <nico@cam.org>
Subject: Re: Horrible re-packing?
Date: Mon, 05 Jun 2006 19:13:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0606051900170.24152@localhost.localdomain>
References: <Pine.LNX.4.64.0606050951120.5498@g5.osdl.org>
 <Pine.LNX.4.64.0606051140530.5498@g5.osdl.org>
 <Pine.LNX.4.64.0606051155000.5498@g5.osdl.org>
 <Pine.LNX.4.64.0606051637490.24152@localhost.localdomain>
 <Pine.LNX.4.64.0606051432270.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 06 01:14:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnOGl-0002I7-Cw
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 01:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWFEXNn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 19:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWFEXNn
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 19:13:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:60588 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750805AbWFEXNl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jun 2006 19:13:41 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J0E002NWTUT7ED0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 05 Jun 2006 19:13:41 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0606051432270.5498@g5.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21349>

On Mon, 5 Jun 2006, Linus Torvalds wrote:

> 
> 
> On Mon, 5 Jun 2006, Nicolas Pitre wrote:
> > 
> > In other words, the pack shrunk to less than half the size of the 
> > previous one !
> 
> Ok, that's a bit more extreme than expected.
> 
> It's obviously great news, and says that the approach of sorting by 
> "reversed name" is a great heuristic, but at the same time it makes me 
> worry a bit that this thing that is supposed to be a heuristic ends up 
> being _so_ important from a pack size standpoint. I was happier when it 
> was more about saving a couple of percent.

Well... this is the repository that exhibited a repack regression a 
while ago, going from something like ~40MB to ~160MB when Junio 
initially added the directory in the name hash.  No other popular 
repositories had that problem.

Which is why I said this repo is particularly sensitive to heuristic 
changes.  So I wouldn't worry too much about your proposed patch making 
it too great in this case.  It certainly didn't cause any (significant) 
regression overall which is what matters.

We already have surprizing results when combining two heuristics 
together although if used separately they do worse.  So trying to have 
fallback/incremental heuristics is going to make things simply too 
complicated for when it breaks.  Better experiment with new ideas and 
adopt them when they do a better job universally.

... which your proposed hashing change does.


Nicolas
