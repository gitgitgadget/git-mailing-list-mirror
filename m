From: Linus Torvalds <torvalds@osdl.org>
Subject: Kernel nightly snapshots..
Date: Wed, 4 May 2005 17:28:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505041639130.2328@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Anvin <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu May 05 02:20:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTU6J-00037R-1q
	for gcvg-git@gmane.org; Thu, 05 May 2005 02:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261971AbVEEA0u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 20:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVEEA0u
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 20:26:50 -0400
Received: from fire.osdl.org ([65.172.181.4]:38084 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261971AbVEEA0q (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2005 20:26:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j450QdU3017175
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 4 May 2005 17:26:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j450QcLg025325;
	Wed, 4 May 2005 17:26:38 -0700
To: Git Mailing List <git@vger.kernel.org>,
	David Woodhouse <dwmw2@infradead.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


I forget who it is that used to do the nightly snapshots for the BK
kernels, but I _think_ it was David Woodhouse (every time I've blamed it
on somebody, I've blamed the wrong person, so I'm probably off on this one
too, but maybe I finally got it right).

I was wondering how to get that re-started.. It should be technically
pretty easy, except I realized that my tree doesn't even have plain 2.6.11
in it. But I just fixed that in the tree, since I need such a baseline 
myself for my next release..

Anyway, I just pushed out a kernel tree that contains a tag of a _tree_ 
that points to the tree at the point of 2.6.11. I also had to teach 
fsck-cache about the fact that you can give it any kind of object to start 
your references at, and to make fsck-cache happy, you need to

	git-fsck-cache --unreachable HEAD v2.6.11

to tell it that the kernel tree now has an unconnected tree (described by
the tag "v2.6.11-tree", and I made the appropriate entry for it in
.git/refs/tags).

I also updated git-prune-script to not remove these kinds of things.

With this, it should be trivial to create snapshots with

	git-diff-tree -p v2.6.11 HEAD

or similar.

		Linus
