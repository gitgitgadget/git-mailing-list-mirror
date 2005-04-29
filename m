From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: More problems...
Date: Fri, 29 Apr 2005 22:57:53 +0100 (BST)
Message-ID: <Pine.LNX.4.60.0504292254430.25700@hermes-1.csi.cam.ac.uk>
References: <20050429170127.A30010@flint.arm.linux.org.uk>
 <20050429182708.GB14202@pasky.ji.cz> <20050429195055.GE1233@mythryan2.michonline.com>
 <Pine.LNX.4.58.0504291311320.18901@ppc970.osdl.org> <7vhdhp47hq.fsf@assigned-by-dhcp.cox.net>
 <20050429221903.F30010@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Ryan Anderson <ryan@michonline.com>,
	Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 23:54:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRdQN-0000Ab-VQ
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 23:53:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263016AbVD2V7I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 17:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263018AbVD2V7I
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 17:59:08 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:12461 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S263016AbVD2V7D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 17:59:03 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:39371)
	by ppsw-0.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.150]:25)
	with esmtpa (EXTERNAL:aia21) id 1DRdUf-0005b9-29 (Exim 4.51)
	(return-path <aia21@hermes.cam.ac.uk>); Fri, 29 Apr 2005 22:57:53 +0100
Received: from aia21 (helo=localhost) by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local-esmtp id 1DRdUf-0001FP-KT (Exim 4.43)
	(return-path <aia21@hermes.cam.ac.uk>); Fri, 29 Apr 2005 22:57:53 +0100
To: Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <20050429221903.F30010@flint.arm.linux.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 29 Apr 2005, Russell King wrote:
> On Fri, Apr 29, 2005 at 02:07:29PM -0700, Junio C Hamano wrote:
> > >>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:
> > LT> Absolutely. I use the same "git-pull-script" between two local directories 
> > LT> on disk...
> > LT> Of course, I don't bother with the linking. But that's the trivial part.
> > 
> > Would it be useful if somebody wrote local-pull.c similar to
> > http-pull.c, which clones one local SHA_FILE_DIRECTORY to
> > another, with an option to (1) try hardlink and if it fails
> > fail; (2) try hardlink and if it fails try symlink and if it
> > fails fail; (3) try hardlink and if it fails try copy and if it
> > fails fail?
> 
> What would be nice is if it finds an existing file for the one it's
> trying to hard link, it compares the contents (maybe - is this actually
> necessary?) and if identical, it removes the original file replacing
> it with a hard link.

Unless I have completely misunderstood things, you never need to compare 
the file contents.  Just compare the file names.  If they match, i.e. the 
SHA1 is the same, the contents must match by definition.  So you only need 
a stat(), rather than read&decompress&compare.

> This means that you'll always be trying to maintain the hard linked
> structure between various working trees in the background.
> 
> But maybe this should have an option to enable this behaviour.

There should definitely be an option to either enable or disable this as 
there are legitimate cases for not wanting hard links or indeed using 
file systems which do not support them.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
