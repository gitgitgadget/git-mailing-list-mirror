From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: using git directory cache code in darcs?
Date: Sat, 16 Apr 2005 15:43:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504161531470.7211@ppc970.osdl.org>
References: <20050416132231.GJ2551@abridgegame.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, darcs-devel@darcs.net
X-From: git-owner@vger.kernel.org Sun Apr 17 00:37:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMvv1-0008Sh-BG
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 00:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVDPWlT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 18:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVDPWlT
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 18:41:19 -0400
Received: from fire.osdl.org ([65.172.181.4]:4043 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261169AbVDPWlM (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 18:41:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3GMf5s4016536
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 16 Apr 2005 15:41:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3GMf4Gt029923;
	Sat, 16 Apr 2005 15:41:05 -0700
To: David Roundy <droundy@abridgegame.org>
In-Reply-To: <20050416132231.GJ2551@abridgegame.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 16 Apr 2005, David Roundy wrote:
> 
> I've been thinking about the possibility of using the git "current
> directory cache" code in darcs.

Go wild. The license is GPLv2, with the limitation that I really do want
to see v3 before I re-license anything at all, so if you take it into
darcs, you'd need to add that as a per-file comment (I just doing it in
the LICENSE file - I hate cluttering up individual files with tons of
commentary).

> So my questions are:
> 
> 1) Would this actually be a good idea? It seems good to me, but there may
> be other considerations that I haven't thought of.

I really don't know how well the git index file will work with darcs, and 
the main issue is that the index file names the "stable copy" using the 
sha1 hash. If darcs uses something else (and I imagine it does) you'd need 
to do a fair amount of surgery, and I suspect merging changes won't be 
very easy.

So it might well make sense to wait a bit, until the git thing has calmed
down some more. For example, I made some rather large changes
(conceptually, if not in layout of the physical file) to the index file
just yesterday, since git now uses it for merging too.

In git, the index file isn't just a speedup, it's the "work" file _and_
the merge entity. It's not just a floor wax, it's a dessert topping too!

> 2) Will a license be chosen soon for git? Or has one been chosen, and I
> missed it? I can't really include git code in darcs without a license.  I'd
> prefer GPLv2 or later (since that's how darcs is licensed), but as long as
> it's at least compabible with GPLv2, I'll be all right.

Yup, GPL, with the same "v2 by default" that the kernel uses).

> 3) Is it likely that git will switch to not using global variables for
> active_cache, active_nr and active_alloc?

I wouldn't hate it, although for the intent of git, the global approach 
actually makes sense (dammit, I want the basic plumbing to be so small 
that trying to abstract it out more is a waste of time). There's simply 
not a lot of code that should even work at that level.

But if you wait a while, and bide your time, and then spring a clean patch 
on me, I don't see any reason to be difficult about it either.

> 4) Would there be interest in creating a libgit? I've been imagining taking
> git source files and including them directly in darcs' code, but in the
> long run it would be easier if there were a standard git API we could use.

I think libgit might make sense, but again, not quite yet. Maybe the new
merge model was my last smart thought even on the subject of SCM's (I kind
of hope so), but maybe it's not.

My gut _feel_ is that the basic git low-level architecture is done, and
you can certainly start looking around and see if it matches darcs at all. 

			Linus
