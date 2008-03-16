From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Don't update unchanged merge entries
Date: Sun, 16 Mar 2008 17:10:34 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803161700430.19665@iabervon.org>
References: <alpine.LFD.1.00.0803161055510.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803161123260.3020@woody.linux-foundation.org> <alpine.LFD.1.00.0803161136060.3020@woody.linux-foundation.org> <alpine.LNX.1.00.0803161548250.19665@iabervon.org>
 <alpine.LFD.1.00.0803161338100.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Mar 16 22:11:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jb08R-0005xP-6Z
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 22:11:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752373AbYCPVKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 17:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752524AbYCPVKf
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 17:10:35 -0400
Received: from iabervon.org ([66.92.72.58]:46157 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752353AbYCPVKf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 17:10:35 -0400
Received: (qmail 10095 invoked by uid 1000); 16 Mar 2008 21:10:34 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Mar 2008 21:10:34 -0000
In-Reply-To: <alpine.LFD.1.00.0803161338100.3020@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77383>

On Sun, 16 Mar 2008, Linus Torvalds wrote:

> On Sun, 16 Mar 2008, Daniel Barkalow wrote:
> > 
> > While you're at it, you should at least fix the comment. I actually think 
> > it would be better to have update start out 0 and be set to CE_UPDATE 
> > after verify_uptodate() and verify_absent(), since those checks are what 
> > verifies that using CE_UPDATE is okay.
> 
> Well, I just made it match the old behavior. It used to be that the 
> copy_cache_entry() would clear the CE_UPDATE bit in the target 'merge' 
> entry, so I just cleared "update" there, the way we used to do it.
> 
> So now we actually *do* match the comment again - the bug was that we 
> didn't match it before due to it all being a bit too subtle.

Well, the top part of the comment suggests that this is just an 
optimization (don't bother to write out a file that you know is 
unchanged), when it's actually necessary for correctness (since we don't 
know if the working tree matches the old index).

	-Daniel
*This .sig left intentionally blank*
