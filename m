From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [FILE] Docs update
Date: Sun, 24 Apr 2005 14:44:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504241438280.15879@ppc970.osdl.org>
References: <426BF790.9070406@dgreaves.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 23:38:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPoo3-0002VO-Gf
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 23:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbVDXVnI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 17:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbVDXVnI
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 17:43:08 -0400
Received: from fire.osdl.org ([65.172.181.4]:15298 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262446AbVDXVmr (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 17:42:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3OLgfs4021344
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 24 Apr 2005 14:42:42 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3OLgfDL020155;
	Sun, 24 Apr 2005 14:42:41 -0700
To: David Greaves <david@dgreaves.com>
In-Reply-To: <426BF790.9070406@dgreaves.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 24 Apr 2005, David Greaves wrote:
> 
> And I've attached this as a file rather than a patch to make it easier 
> for people to read.

Suggestion: move "diff-tree" up above "diff-cache", since as it is now, 
you explain "diff-cache" in terms of diff-tree, before you've even 
explained diff-tree in the first place.

Also, the current diff-tree has an extension:

	################################################################
	diff-tree
	        diff-tree [-r] [-z] <tree/commit> <tree/commit> [pattern]*

	Compares the content and mode of the blobs found via two tree objects.

where the "pattern" arguments are the pathnames you are interested in 
seeing the differences of.

For example, if you're only interested in differences in some
architecture-specific files, you might do

	diff-tree -r <tree/commit> <tree/commit> arch/ia64 include/asm-ia64

and it will only show you what changed in those two directories.

Or if you are searching for what changed in just kernel/sched.c, just do

	diff-tree -r <tree/commit> <tree/commit> kernel/sched.c

and it will ignore all differences to other files.

The pattern is always the prefix, and is matched exactly (ie there are no
wildcards - although matching a directory, which it does support, can
obviously be seen as a "wildcard" for all the files under that directory).

		Linus
