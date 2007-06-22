From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: use "blame -w -C -C" for "where did it come from, originally?"
Date: Thu, 21 Jun 2007 23:34:57 -0400
Message-ID: <20070622033456.GB17393@spearce.org>
References: <200706162226.l5GMQBss004492@mi0.bluebottle.com> <7vk5tx5333.fsf@assigned-by-dhcp.pobox.com> <20070621050117.GF8477@spearce.org> <alpine.LFD.0.98.0706211237220.3593@woody.linux-foundation.org> <alpine.LFD.0.98.0706211243400.3593@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jun 22 05:35:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1ZvO-0004Nj-5L
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 05:35:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbXFVDfE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 23:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbXFVDfE
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 23:35:04 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45456 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbXFVDfC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 23:35:02 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I1Zv4-0005Ev-Nk; Thu, 21 Jun 2007 23:34:46 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8BFAA20FBAE; Thu, 21 Jun 2007 23:34:57 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0706211243400.3593@woody.linux-foundation.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50669>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> On Thu, 21 Jun 2007, Linus Torvalds wrote:
> > 
> > I'd personally rather *not* have git-gui make the -w/-M/-C choice for me. 
> > Why don't you just allow the user to say? Sometimes I might want to see 
> > who introduced broken whitespace. Let me say
> > 
> > 	git gui blame -w filename.c
> > 
> > please? Instead of making that choice for me, and then blaming git for 
> > something that wasn't git's problem.
> 
> Side note - this ended up being one reason why "gitk" is so good. It just 
> passed down the arguments to "git-rev-list", and it allowed me to improve 
> on the original gitk without gitk ever even _realizing_ it was improved 
> upon. All the pathname filtering etc was done without gitk ever learning 
> about it - it "just worked".

Hmm.  Good point about gitk.  We all know you would rather not hack
Tcl to enhance tools, because you would prefer to work directly in C.

A lot of the stuff rev-list does in pure C does translate
directly into gitk, and its one of the features that I also love
most about gitk.  Except --reverse; gitk doesn't really like to do
`gitk --reverse --all`.  But it can be extremely amusing to run if
you are bored and have time to waste.

However.  The new blame viewer supports two columns, and runs two
blame passes to obtain the information for them.  I like that,
because it offers up a lot of information in a single compact view.
Which column do I send the option(s) to?  Do I let the user specify
which column to apply the options onto?

  git gui blame --left='-C -C' --right=   filename.c    ;# default
  git gui blame --left=-w      --right=-M filename.c    ;# not default

? Or do I only show one column if the user supplies command line
options?  Doesn't that limit the tool?

-- 
Shawn.
