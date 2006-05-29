From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 0/10] re-based and expanded tree-walker cleanup patches
Date: Mon, 29 May 2006 12:15:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605291145360.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon May 29 21:15:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FknD3-0008EA-Ew
	for gcvg-git@gmane.org; Mon, 29 May 2006 21:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWE2TPR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 15:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWE2TPQ
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 15:15:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62680 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751165AbWE2TPP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 15:15:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4TJF42g014933
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 29 May 2006 12:15:05 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4TJF2dZ015380;
	Mon, 29 May 2006 12:15:03 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20955>


Ok, this is largely the same series as the previous 1..4 patches, but 
rebased on top of the current master tree because the cache-tree patches 
added some tree_entry_list walkers (which accounts for one extra patch in 
the series, and some trivial merge fixups).

Two new patches then clean up fsck-objects, which really didn't want the 
old tree_entry_list at all (and had added some hacks to the list entry 
just because fsck actually needed to check the raw data).

Another two new patches convert the last remnant of tree_entry_list in 
revision.c and fetch.c respectively to the new world order.

And the final patch then moves the "tree_entry_list" crud into the only 
remaining user, namely builtin-read-tree.c. That file is pretty messy and 
hard to convert, and I don't want to touch it right now, so I left it with 
the nasty compatibility functions. But now that's at least well-contained.

I think the series is all good, and should replace the old one in "next" 
(and cook there for a while just to make sure it's ok).

		Linus
