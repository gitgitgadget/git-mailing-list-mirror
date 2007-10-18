From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on afs
Date: Thu, 18 Oct 2007 15:47:00 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710181543380.26902@woody.linux-foundation.org>
References: <20071018203106.GA13518@fries.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: "Todd T. Fries" <todd@fries.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 00:48:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iie9o-0000ds-9k
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 00:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757550AbXJRWrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 18:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753668AbXJRWrt
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 18:47:49 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:45934 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751768AbXJRWrs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Oct 2007 18:47:48 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9IMl5Uu014441
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Oct 2007 15:47:06 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9IMl0g1002426;
	Thu, 18 Oct 2007 15:47:04 -0700
In-Reply-To: <20071018203106.GA13518@fries.net>
X-Spam-Status: No, hits=-2.716 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61569>



On Thu, 18 Oct 2007, Todd T. Fries wrote:
> 
> 2) git presumes that DTYPE(de) != DT_DIR .. means the dirent is not a dir
>    this is not true for afs

That's a major bug, and has nothing to do with AFS. Oops. 

If you look just a bit lower, you'll see that just a few lines down, git 
handles DT_UNKNOWN correctly, and just does a lstat() on it as required. I 
guess that logic should be moved up, or alternatively the exclude logic 
should be moved down.

Your patch looks ok, but at the same time, I don't think it's really the 
right thing to do, since it now does that lstat() twice.

		Linus
