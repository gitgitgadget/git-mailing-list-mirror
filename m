From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Commit-ish shortcut for immediate parent range
Date: Sun, 22 Oct 2006 20:33:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610222029390.3962@g5.osdl.org>
References: <200610221548.42048.andyparkins@gmail.com>
 <Pine.LNX.4.64.0610221017180.3962@g5.osdl.org> <200610222117.45766.andyparkins@gmail.com>
 <Pine.LNX.4.64.0610221331571.3962@g5.osdl.org> <ehgoii$1ap$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 05:33:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbqYq-00074A-9N
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 05:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWJWDdJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 23:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWJWDdI
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 23:33:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12260 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751134AbWJWDdF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Oct 2006 23:33:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9N3X1aX011294
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 22 Oct 2006 20:33:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9N3X0r4010014;
	Sun, 22 Oct 2006 20:33:01 -0700
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ehgoii$1ap$1@sea.gmane.org>
X-Spam-Status: No, hits=-0.479 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29814>



On Sun, 22 Oct 2006, Jakub Narebski wrote:
> 
> BTW. what does "recursive diff" mean (in git)?

For projects with subdirectories (and git itself has almost none), the 
default "raw, nonrecursive" diff looks something like this:

	f8829caee311207afbc882794bdc5aa0db5caf33
	:040000 040000 db7ae247da2ede4d0f932b86771424534d2960b8 9033be5eb62db6fd778793f9f51e28734bb3d9f8 M      arch
	:040000 040000 c96e5293819986ae7c13a8ef779c5f2066b9575f 5950afceabd99053964778b49df19ba794a21b75 M      include

while the same commit with "raw, recursive" looks like

	f8829caee311207afbc882794bdc5aa0db5caf33
	:100644 100644 88b72c9a84957f2ac787ccf83fa46c4dbb0818d2 2de4d3c367a2c2da9adb6bcf29b5105c46c01f78 M      arch/mips/mm/init.c
	:100644 100644 4bdaa05f485b446e0d66587015cbd8378abf4a69 4a61e624b0ecfcd921a560d426e92e1df2df1de2 M      arch/mips/mm/pgtable-32.c
	:100644 100644 44b5e97fff65f75286fdd15f33c2bcf40841082a 8d600d307d5ddb3f617ffc34929ea98d4613b4a7 M      arch/mips/mm/pgtable-64.c
	:100644 100644 9ab59e2bb23368530fa67c95af0d6ab2c4f7fe8f e3c9925876a3ce4eb80ec67937362cd7d014ad2f M      include/asm-mips/cacheflush.h
	:100644 100644 6959bdb59310b096ec7797e0a31c78fde5aa9afc 02c8a13fc894838b27336ae42fbb542f87132e01 M      include/asm-mips/fixmap.h

ie the "recursive" diff will recurse into subdirectories.

A _patch_ is always recursive (you cannot make a patch-like diff for just 
the "tree entry", only for actual blobs), so you can only see this 
difference for raw git SHA1 diffs.

		Linus
