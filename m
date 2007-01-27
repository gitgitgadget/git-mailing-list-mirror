From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: More precise tag following
Date: Sat, 27 Jan 2007 09:36:39 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701270925080.25027@woody.linux-foundation.org>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org>
 <Pine.LNX.4.63.0701271352170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45BB5888.9020608@fs.ei.tum.de> <epfulr$787$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 27 18:37:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HArUE-00018l-Qs
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 18:37:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752287AbXA0Rgo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 12:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752290AbXA0Rgn
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 12:36:43 -0500
Received: from smtp.osdl.org ([65.172.181.24]:57986 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752287AbXA0Rgm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 12:36:42 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0RHae1m014740
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 27 Jan 2007 09:36:40 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0RHaduP013213;
	Sat, 27 Jan 2007 09:36:39 -0800
In-Reply-To: <epfulr$787$1@sea.gmane.org>
X-Spam-Status: No, hits=-0.509 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37975>



On Sat, 27 Jan 2007, Jakub Narebski wrote:
> 
> On the other hand IIRC Mercurial, due to its repository structure, has some
> problems with file copying and renames

This is not a hg-only problem.

This is the SAME and FUNDAMENTAL problem that you have any time you think 
"file identity" matters.

Yes, it's what makes "blame/annotate" fast. But I have tried, over and 
over again, to explain why it's fundamentally broken (regardless of any 
blame thing).

So I will  just say once again: don't try to make "blame" faster. You can 
only do so by introducing MUCH MORE serious problems in other parts.

This was a very early design decision in git. It was discussed within 
hours of me releasing the first version of git. Yes, "git blame" is 
relatively slow, and it is very very fundamental. It's fundamental exactly 
because git avoids the mistake that *everybody* else has done.

The upside? I just sent a patch that should make it possible to do a "cool 
blame" that doesn't feel slow, and in fact allows some nice eyecandy 
effects (well, it would allow it, if I just knew tcl/tk or something like 
that: it needs a canvas to draw the existing file into, and then filling 
in the incremental data as git-blame finds it).

It's going to be tons more fun to watch than any CVS/SVN annotate has ever 
been. Trust me. I bet that you'll feel that "git blame" is *too* fast, and 
you'll want the graphical viewer to have a "slow down" flag, just so that 
you can appreciate the blame building up!

[ Ok, that may not be true for everybody, but having played with "git 
   blame --incremental" a bit I really think it would be a bit cool to 
   have that "slow down" mode, and start things with a really tiny font 
   so you could see the blame build up over a file!

   I'm not kidding you. Eyecandy! And it literally would need git to slow 
   down to make it more human-friendly! ]

The other upside? EVERYTHING ELSE IS FASTER. And I really mean 
*everything*. Yes, "git blame" is slower than SVN. It will remain so, 
unless somebody either overrides my objections, or some alien intelligence 
comes up with something _really_ clever. But look at it this way: blame 
may take a few seconds, but that's a big part of why you can do merges of 
things that have tens of thousands of files in half a second.

Things that you would need to go brew a cup of coffee for in some other 
environments are basically _instantaneous_. 

			Linus
