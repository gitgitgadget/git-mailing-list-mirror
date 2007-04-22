From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFH] plumber's puzzle
Date: Sun, 22 Apr 2007 13:43:02 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704221341080.9964@woody.linux-foundation.org>
References: <7v647ombi6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 22 22:43:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hfitv-0003nS-VY
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 22:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030948AbXDVUnJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 16:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030950AbXDVUnJ
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 16:43:09 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:58588 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030948AbXDVUnI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Apr 2007 16:43:08 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3MKh3iE029105
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 22 Apr 2007 13:43:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3MKh2YF001147;
	Sun, 22 Apr 2007 13:43:03 -0700
In-Reply-To: <7v647ombi6.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-3.539 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45273>



On Sun, 22 Apr 2007, Junio C Hamano wrote:
> 
> This shows the single "diff --git" header line without anything,
> to show that the path is not stat-clean, but the contents are
> unchanged, which is what is expected.

Actually, I think the "good" case is the broken one.

Do an "strace -f" on the two cases, and you'll see an EBADF in the case 
that you think is good: the missing output *is* there, it's just that you 
closed the file descriptor so you don't see it.

So if the output you want is with the close(1) (ie with the output 
discarded), then you have some other bug there.

		Linus
