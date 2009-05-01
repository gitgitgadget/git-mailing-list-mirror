From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: question about a merge result
Date: Fri, 1 May 2009 12:27:36 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0905011210140.2147@iabervon.org>
References: <38b2ab8a0904300521m9e31867j7848135acfae0faa@mail.gmail.com>  <49F99AE3.5090406@gmx.net>  <20090430142635.GB23550@coredump.intra.peff.net> <38b2ab8a0904300805j5ce19617mdda3254c37d06d38@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Michael Gaber <Michael.Gaber@gmx.net>,
	git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 01 18:28:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzvbD-0002VJ-GR
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 18:28:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754463AbZEAQ1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 12:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753072AbZEAQ1h
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 12:27:37 -0400
Received: from iabervon.org ([66.92.72.58]:34784 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752520AbZEAQ1h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 12:27:37 -0400
Received: (qmail 17011 invoked by uid 1000); 1 May 2009 16:27:36 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 1 May 2009 16:27:36 -0000
In-Reply-To: <38b2ab8a0904300805j5ce19617mdda3254c37d06d38@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118083>

On Thu, 30 Apr 2009, Francis Moreau wrote:

> But the question was more about if the cortectness of the end result:
> should 'B' removed after the merge.
> 
> IOW if someone works on its own branch remove B file and thought it
> was a bad idea and restore it whereas another person remove B file but
> miss the fact that it was a bad idea, does the merge should silently
> remove B file ?

Consider that deciding to remove a file can happen for a variety of 
reasons. Maybe one branch wiped it out accidentally and restored it, while 
the other did a bunch of work to make it obsolete and then removed it 
intentionally. There's no reason to think that the reason behind reverting 
the delete on one branch applies to the other delete.

Now, if the "b1" branch had gotten the delete from "master" by merging the 
same commit, and had reverted the commit that deleted the file, then git 
should (and does) include the file in the merge result, because then some 
user saw that particular deletion and decided it was wrong and reverted 
it. (Of course, git doesn't actually consider this in its merge algorithm, 
but, for clever mathematical reasons, what it does is equivalent.)

	-Daniel
*This .sig left intentionally blank*
