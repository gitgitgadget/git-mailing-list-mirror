From: Eli Zaretskii <eliz@gnu.org>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 06:06:42 +0200
Message-ID: <u6419ja25.fsf@gnu.org>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org>
 <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
 <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site>
 <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site>
 <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org> <Pine.LNX.4.64.0710150039120.25221@racer.site>
Reply-To: Eli Zaretskii <eliz@gnu.org>
Cc: raa.lkml@gmail.com, ae@op5.se, tsuna@lrde.epita.fr,
	git@vger.kernel.org, make-w32@gnu.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 15 06:07:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhHEL-0007Jn-Ni
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 06:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbXJOEGu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 00:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbXJOEGu
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 00:06:50 -0400
Received: from heller.inter.net.il ([213.8.233.23]:14934 "EHLO
	heller.inter.net.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703AbXJOEGt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 00:06:49 -0400
Received: from HOME-C4E4A596F7 (IGLD-84-229-224-70.inter.net.il [84.229.224.70])
	by heller.inter.net.il (MOS 3.7.3a-GA)
	with ESMTP id DVY95366 (AUTH halo1);
	Mon, 15 Oct 2007 06:06:43 +0200 (IST)
In-reply-to: <Pine.LNX.4.64.0710150039120.25221@racer.site> (message from
	Johannes Schindelin on Mon, 15 Oct 2007 00:45:47 +0100 (BST))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60939>

> Date: Mon, 15 Oct 2007 00:45:47 +0100 (BST)
> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> cc: Alex Riesen <raa.lkml@gmail.com>, ae@op5.se, tsuna@lrde.epita.fr, 
>     git@vger.kernel.org, make-w32@gnu.org
> 
> The problem is that on Windows, you cannot keep a file open and delete it 
> at the same time.

That is no longer true, for quite some time.  NT4 and later versions
support that almost exactly like Posix filesystems.

> > > - no acceptable level of performance in filesystem and VFS (readdir,
> > >   stat, open and read/write are annoyingly slow)
> > 
> > With what libraries?  Native `stat' and `readdir' are quite fast. 
> > Perhaps you mean the ported glibc (libgw32c), where `readdir' is indeed 
> > painfully slow, but then you don't need to use it.
> 
> No, native.
> 
> Once you experienced the performance of git on Linux, then rebooted into 
> Windows on the same box, you will grow a beard while waiting for trivial 
> operations.

Maybe GIT assumes too much about `readdir' and `stat', and should
refactor its code into better abstractions.

> > > - it is the only OS in the world with multi-root (/a/b/c and /a/b/c
> > >   can be not the same, depending on what current "drive" is)
> > 
> > So what? on Unix "a/b/c" can be not the same.  Both cases are simply not 
> > complete file names, that's all.  No one said there must be a single 
> > root for all volumes, it's the Posix jingoism creeping in again.
> 
> I think Alex means this: you can have C:\a\b\c and D:\a\b\c.  So depending 
> on which drive you are, you mean one or the other.  Just comparing the 
> paths is not enough.

What _I_ meant is that the C: part is part of the full file name,
exactly like the leading / is on Unix.

> > > - No real "mmap" (which kills perfomance and complicates code)
> > 
> > You only need mmap because you are accustomed to use it on GNU/Linux.
> 
> Yes.  And we rely on the performance very much.

There's no need for mmap to get memory performance, except if sbrk and
friends are too slow.
