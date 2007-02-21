From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: removing content from git history
Date: Wed, 21 Feb 2007 10:47:29 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702211041500.4043@woody.linux-foundation.org>
References: <20070221164527.GA8513@ginosko.local>
 <Pine.LNX.4.64.0702210904350.4043@woody.linux-foundation.org>
 <20070221183028.GA9088@ginosko.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Michael Hendricks <michael@ndrix.org>
X-From: git-owner@vger.kernel.org Wed Feb 21 19:47:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJwVM-0006ry-1t
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 19:47:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422791AbXBUSrb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 13:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422799AbXBUSra
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 13:47:30 -0500
Received: from smtp.osdl.org ([65.172.181.24]:37439 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422791AbXBUSr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 13:47:29 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1LIlRhB031480
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 21 Feb 2007 10:47:27 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1LIlQYI022623;
	Wed, 21 Feb 2007 10:47:27 -0800
In-Reply-To: <20070221183028.GA9088@ginosko.local>
X-Spam-Status: No, hits=-0.462 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40317>



On Wed, 21 Feb 2007, Michael Hendricks wrote:
> 
> What's a decent way to make a branch into a new repository?  My first
> inclination is to "cp -a" the existing repository, checkout the branch,
> delete all other branches and repack.  That seems to have worked in my
> quick test, but is there a better way?

That works.

As does just "clone repo, delete all unwanted branches, and prune" (of 
course, if you don't want the old repo, you can skip the "clone" part, and 
just do the "delete all unwanted branches and prune" thing).

In some ways, a more straightforward approach may be to just create a new 
repo, and populate it with just one branch (I say "more straightforward", 
not "easier", because I just think it's conceptually simpler):

	mkdir new-repo
	cd new-repo
	git init
	git pull old-repo <branch>

(add "--bare" and "--shared" to taste - with bare repos yu can also do it 
the other way by doing a push into it from outside after you've created 
it, which can be the "logical" way to do it if you want to just publish 
the end result on some shared site)

		Linus
