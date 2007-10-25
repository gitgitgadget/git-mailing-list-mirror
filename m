From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 5/6] Do linear-time/space rename logic for exact renames
Date: Thu, 25 Oct 2007 15:43:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710251522190.7345@iabervon.org>
References: <alpine.LFD.0.999.0710251112120.30120@woody.linux-foundation.or
 g> <alpine.LFD.0.999.0710251120590.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Oct 25 21:44:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il8cd-0000KA-0x
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 21:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719AbXJYTnt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 15:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752477AbXJYTnt
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 15:43:49 -0400
Received: from iabervon.org ([66.92.72.58]:44355 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752719AbXJYTnt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 15:43:49 -0400
Received: (qmail 10604 invoked by uid 1000); 25 Oct 2007 19:43:46 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Oct 2007 19:43:46 -0000
In-Reply-To: <alpine.LFD.0.999.0710251120590.30120@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62359>

> +/*
> + * Insert a new hash entry pointer into the table.
> + *
> + * If that hash entry already existed, return the pointer to
> + * the existing entry (and the caller can create a list of the
> + * pointers or do anything else). If it didn't exist, return
> + * NULL (and the caller knows the pointer has been inserted).
> + */

Creating a list of the pointers doesn't work correctly with the grow 
implementation, because growing the hash may turn a collision into a 
non-collision, at which point items other than the first cannot be found 
(since they're listed inside a bucket that's now wrong for them). AFAIK, 
resizing a hash table requires being able to figure out what happened with 
collisions.

	-Daniel
*This .sig left intentionally blank*
