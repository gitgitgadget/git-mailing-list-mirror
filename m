From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git packs
Date: Fri, 9 Nov 2007 22:58:16 -0800 (PST)
Message-ID: <alpine.LFD.0.999.0711092254130.15101@woody.linux-foundation.org>
References: <F6DD8DCD-416B-4DDF-B384-7213C9ED5565@mac.com>
 <alpine.LFD.0.9999.0711100011150.21255@xanadu.home>
 <FC175E4F-D9BE-42CC-B0BB-561B2EDCD941@mac.com>
 <DF65F7E4-448A-4726-8B42-642776155A8F@vicaya.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: bob <kranki@mac.com>, git@vger.kernel.org
To: Luke Lu <git@vicaya.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 07:58:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqkIe-0004nR-KJ
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 07:58:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbXKJG6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 01:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751566AbXKJG6W
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 01:58:22 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41338 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751531AbXKJG6V (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2007 01:58:21 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAA6wHTU025618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 9 Nov 2007 22:58:19 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAA6wHXp027149;
	Fri, 9 Nov 2007 22:58:17 -0800
In-Reply-To: <DF65F7E4-448A-4726-8B42-642776155A8F@vicaya.com>
X-Spam-Status: No, hits=-2.439 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_64
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64313>



On Fri, 9 Nov 2007, Luke Lu wrote:
> 
> mmap(2), which git uses by default, is subject to vm limits (typically <2GB),
> regardless of large file support. file `which git` will probably tell you that
> it's a Mach-O executable i386 instead of x86_64. In order to get 64 bit
> binaries on Mactel boxes, you'll need the -m64 flag for gcc. I suspect that
> compiling with NO_MMAP option work as well.

Even with NO_MMAP, git will still want to read in source files in their 
entirety (just with regular reads). So you'll still be VM size-limited: 
the mmap() will just be replaced with a malloc+read in order to avoid 
some broken windows mmap() behaviour.

But hearing whether -m64 makes a difference would be interesting. I'm 
hoping OS X is LP64, not some insane half-way thing like Vista is.

		Linus
