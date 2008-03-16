From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Don't update unchanged merge entries
Date: Sun, 16 Mar 2008 13:40:33 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803161338100.3020@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0803161055510.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803161123260.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803161136060.3020@woody.linux-foundation.org> <alpine.LNX.1.00.0803161548250.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Mar 16 21:41:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jazg0-0006RF-L3
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 21:41:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752373AbYCPUlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 16:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752376AbYCPUlN
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 16:41:13 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53333 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752353AbYCPUlM (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Mar 2008 16:41:12 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2GKfdWl008307
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 16 Mar 2008 13:41:40 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2GKeXfx012466;
	Sun, 16 Mar 2008 13:40:33 -0700
In-Reply-To: <alpine.LNX.1.00.0803161548250.19665@iabervon.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-5.305 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77380>



On Sun, 16 Mar 2008, Daniel Barkalow wrote:
> 
> While you're at it, you should at least fix the comment. I actually think 
> it would be better to have update start out 0 and be set to CE_UPDATE 
> after verify_uptodate() and verify_absent(), since those checks are what 
> verifies that using CE_UPDATE is okay.

Well, I just made it match the old behavior. It used to be that the 
copy_cache_entry() would clear the CE_UPDATE bit in the target 'merge' 
entry, so I just cleared "update" there, the way we used to do it.

So now we actually *do* match the comment again - the bug was that we 
didn't match it before due to it all being a bit too subtle.

		Linus
