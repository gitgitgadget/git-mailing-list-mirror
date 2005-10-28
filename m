From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: Re: [PATCH gitweb] Visually indicating patch size with horizontal bars
Date: Thu, 27 Oct 2005 20:50:29 -0400
Message-ID: <20051028005029.GA2654@pe.Belkin>
References: <20051027203945.GC1622@pe.Belkin> <7vfyqm1uvx.fsf@assigned-by-dhcp.cox.net> <20051027234813.GA512@pe.Belkin> <Pine.LNX.4.64.0510271709120.4664@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 28 02:50:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVIS2-00066n-Gd
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 02:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbVJ1Aub (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 20:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbVJ1Aub
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 20:50:31 -0400
Received: from eastrmmtao06.cox.net ([68.230.240.33]:19415 "EHLO
	eastrmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S965023AbVJ1Aua (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 20:50:30 -0400
Received: from localhost ([24.250.31.7]) by eastrmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051028004943.VGZW21663.eastrmmtao06.cox.net@localhost>;
          Thu, 27 Oct 2005 20:49:43 -0400
Received: from chris by localhost with local (Exim 4.43)
	id 1EVIRx-0001im-7y; Thu, 27 Oct 2005 20:50:29 -0400
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510271709120.4664@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10732>

On Thu, Oct 27, 2005 at 05:12:33PM -0700, Linus Torvalds wrote:
> Add the "-r" flag to do the recursive thing, ie
> 
> 	git-diff-tree -r --name-only
> 
> should do the right thing.

Ah, yes, it does.  Thanks.

> > True.  Maybe gitk and gitweb can share a cache containing the tree
> > diffs.  Or maybe git-core can cache tree diffs?
> 
> Creating them is fast enough if there is no IO. Make sure your project is 
> packed, and you should be ok.
> 
> The expensive part is the "-p" thing to create patches. If you avoid the 
> patch creation, you should be ok.

git-diff-tree -r --name-only is pretty quick and it actually does a
halfway reasonable job of representing damage-potential.

> > But, in general, is there interest in a visual indicator of commit
> > size and/or type in gitweb?
> 
> I kind of like it, but I'm not sure how useful it is, and maybe it does 
> really want the whole patch size (not just how many files it touches). 

Hard to say.  Neither one is going to be perfect, so I'm ok with
settling for the cheap one if it's halfway reasonable.  I think I'll
mock up the merge indicator and see if there's any value added there.

So, what's the best way to detect merges?  Maybe see if
'git-cat-file commit $hash | grep ^parent | wc -l' is greater than 1?

> That's where caching might save your *ss.

Ok, but that cache would live inside GIT_DIR an be shared with gitk,
right?

-chris
