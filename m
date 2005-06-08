From: Linus Torvalds <torvalds@osdl.org>
Subject: gitk (was Re: Linux v2.6.12-rc6)
Date: Wed, 8 Jun 2005 16:16:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506081608450.2286@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506061104190.1876@ppc970.osdl.org>
 <20050607130535.GD16602@harddisk-recovery.com> <Pine.LNX.4.58.0506070820170.2286@ppc970.osdl.org>
 <17062.21286.601768.751853@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 09 01:11:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dg9hJ-0003FY-E8
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 01:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVFHXOx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 19:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVFHXOx
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 19:14:53 -0400
Received: from fire.osdl.org ([65.172.181.4]:47083 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261535AbVFHXOr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 19:14:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j58NEbjA001483
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 8 Jun 2005 16:14:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j58NEag0023619;
	Wed, 8 Jun 2005 16:14:37 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17062.21286.601768.751853@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Btw, Paul,
 one thing I end up missing in gitk is that looking at merges doesn't show 
any output, yet in many ways merges are actually the most interesting 
ones where you'd like to see where a file comes from..

Now, handling multi-way merges may be hard, but at least the normal 
two-way merges end up pretty straightforward, I think, and only have four 
cases for each file:
 - not touched by either side (ie it doesn't show up in either of 
   "git-diff-tree TREE PARENT1" or "git-diff-tree TREE PARENT2")
 - changed by PARENT1 only (ie it shows up in the git-diff-tree between 
   TREE and PARENT2)
 - changed by PARENT2 only
 - changed since both

and it would be cool if the "filename list" panel on the right side 
colorized the names by these things (only three cases - leave the "not 
touched" files off entirely, of course).

Also, it should actually possible to do a diff for these things with just
doing a "diff3" on the two parents and on the merge result (diff3 normally
expects the "original", but hey, the "original" might as well be the
result), and thus color a merge file by whether the lines came from one
side or the other or both (or neither, which would be a manual merge
fixup).

Maybe I'm crazy. But it _seems_ like a good idea that shouldn't be 
fundamentally hard.

		Linus
