From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH gitweb] Visually indicating patch size with horizontal
 bars
Date: Thu, 27 Oct 2005 17:12:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510271709120.4664@g5.osdl.org>
References: <20051027203945.GC1622@pe.Belkin> <7vfyqm1uvx.fsf@assigned-by-dhcp.cox.net>
 <20051027234813.GA512@pe.Belkin>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 28 02:13:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVHrQ-0003SF-Tf
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 02:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932678AbVJ1AMm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 20:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932677AbVJ1AMm
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 20:12:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16846 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932678AbVJ1AMl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Oct 2005 20:12:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9S0CaFC012034
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 27 Oct 2005 17:12:36 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9S0CYfM007132;
	Thu, 27 Oct 2005 17:12:35 -0700
To: Chris Shoemaker <c.shoemaker@cox.net>
In-Reply-To: <20051027234813.GA512@pe.Belkin>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10731>



On Thu, 27 Oct 2005, Chris Shoemaker wrote:
> > 
> > * do we really want to know the number of lines?  sometimes the
> >   number of pahts that are affected is more useful than number
> >   of lines when assessing the damage, which can be done with
> >   'git-diff-tree --name-only'.
> 
> That only shows the top-level names, so when 100s of files changes in
> a subdir it looks just like one entry.  It's ok when there's no
> subdirs, but it just doesn't work when 95% of the code is under,
> e.g. src/.

Add the "-r" flag to do the recursive thing, ie

	git-diff-tree -r --name-only

should do the right thing.

> True.  Maybe gitk and gitweb can share a cache containing the tree
> diffs.  Or maybe git-core can cache tree diffs?

Creating them is fast enough if there is no IO. Make sure your project is 
packed, and you should be ok.

The expensive part is the "-p" thing to create patches. If you avoid the 
patch creation, you should be ok.

> But, in general, is there interest in a visual indicator of commit
> size and/or type in gitweb?

I kind of like it, but I'm not sure how useful it is, and maybe it does 
really want the whole patch size (not just how many files it touches). 
That's where caching might save your *ss.

		Linus
