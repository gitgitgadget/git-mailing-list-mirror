From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: why does git perpetually complain about
 include/asm-blackfin/macros.h?
Date: Mon, 2 Jul 2007 08:36:35 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0707020834310.9434@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0707020800010.1972@localhost.localdomain>
 <4688EF9B.8020405@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: "Robert P. J. Day" <rpjday@mindspring.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Mon Jul 02 17:36:51 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5NxK-0006G4-RN
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 17:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473AbXGBPgs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 11:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752281AbXGBPgr
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 11:36:47 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43951 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752204AbXGBPgr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Jul 2007 11:36:47 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l62Faeep027527
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 2 Jul 2007 08:36:41 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l62FaZx1023602;
	Mon, 2 Jul 2007 08:36:35 -0700
In-Reply-To: <4688EF9B.8020405@garzik.org>
X-Spam-Status: No, hits=-2.645 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51375>



On Mon, 2 Jul 2007, Jeff Garzik wrote:

> Robert P. J. Day wrote:
> >   for the umpteenth time, after doing a pull, i see this:
> > 
> > $ git diff
> > diff --git a/include/asm-blackfin/macros.h b/include/asm-blackfin/macros.h
> > deleted file mode 100644
> > index e69de29..0000000
> > $
> 
> I have the same problem.  git 1.5.0.6 on Fedora Core 5 or 6.
> 
> I even tried a completely fresh clone, but the problem still appears.

Git complains for a very simple reason: that file is an empty file, and 
"make clean" removes all zero-sized files.

So whenever anybody does a "make clean" (maybe it's "make distclean", I 
forget), you will have removed the empty file, and git will show it as a 
diff.

We probably should just remove the file from the kernel archive.

		Linus
