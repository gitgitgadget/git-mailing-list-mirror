From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 3/3] Diff overhaul, adding the other half of copy detection.
Date: Sat, 21 May 2005 10:25:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505211016140.2206@ppc970.osdl.org>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org> <7vzmuokjhg.fsf@assigned-by-dhcp.cox.net>
 <7vfywgkj90.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 19:22:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZXfx-0007ph-TB
	for gcvg-git@gmane.org; Sat, 21 May 2005 19:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbVEURXN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 13:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbVEURXN
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 13:23:13 -0400
Received: from fire.osdl.org ([65.172.181.4]:14499 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261757AbVEURXH (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 May 2005 13:23:07 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4LHN0jA006212
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 21 May 2005 10:23:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4LHMxY1006499;
	Sat, 21 May 2005 10:23:00 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfywgkj90.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 21 May 2005, Junio C Hamano wrote:
>
> This patch extends diff-cache and diff-files to report the
> unmodified files to diff-core as well when -C (copy detection)
> is in effect, so that the unmodified files can also be used as
> the source candidates.  The existing test t4003 has been
> extended to cover this case.

I love how I can just say "oh, keep in mind that we might want to.." and 
24 hours later you did it.

Applied and pushed out, and I enjoyed seeing the output of 

	git-whatchanged -C

and doing a "/^copy" that shows it figuring out (correctly) that 
git-resolve-script was based on git-pull-script. Very cool.

I'm also somewhat surprised by the fact that it even seems to be usable on
the kernel tree:

	diff --git a/include/asm-um/archparam-i386.h b/include/asm-um/elf-i386.h
	similarity index 89%
	copy from include/asm-um/archparam-i386.h
	copy to include/asm-um/elf-i386.h
	--- a/include/asm-um/archparam-i386.h
	+++ b/include/asm-um/elf-i386.h
	...

cool. 

			Linus
