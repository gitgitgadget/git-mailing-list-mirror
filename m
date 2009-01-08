From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Comments on Presentation Notes Request.
Date: Wed, 7 Jan 2009 19:28:17 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901071914490.19665@iabervon.org>
References: <c115fd3c0901061433i78bf3b26v77e5981aada6728e@mail.gmail.com> <20090107063629.GB22616@coredump.intra.peff.net> <alpine.LNX.1.00.0901071654530.19665@iabervon.org> <200901071640.06288.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Thu Jan 08 01:29:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKimN-0003B2-HL
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 01:29:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117AbZAHA2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 19:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752050AbZAHA2U
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 19:28:20 -0500
Received: from iabervon.org ([66.92.72.58]:39022 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640AbZAHA2T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 19:28:19 -0500
Received: (qmail 29805 invoked by uid 1000); 8 Jan 2009 00:28:17 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 Jan 2009 00:28:17 -0000
In-Reply-To: <200901071640.06288.bss@iguanasuicide.net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104856>

On Wed, 7 Jan 2009, Boyd Stephen Smith Jr. wrote:

> On Wednesday 2009 January 07 16:30:04 Daniel Barkalow wrote:
> > Git is clever about finding [...]
> > the common ancestor of commits that don't have a common ancestor.
> 
> *confused*
> 
> Please elaborate.

I meant to say "a *unique* closest common ancestor". The clever trick is 
that, if there are multiple common ancestors which aren't closer than each 
other, you can merge those ancestors (based, recursively, on their common 
ancestors) to generate a new commit with merge conflicts in it. You then 
pretend that this commit is the unique common ancestor for 3-way merge. 
This works because the merge conflicts in the commit all seem to have been 
replaced in each branch, and the conflict region is some arbitrary chunk 
of text in between other context, and the 3-way merge output doesn't show 
the original text (which would be weird junk in this case: a merge 
conflict that didn't really happen in the middle of other merge 
conflicts), but only the text from the two sides being merged, so it's not 
necessary to resolve the old merge that didn't happen.

I think all of the other systems, if you have crossing history such that 
there isn't a unique common ancestor do one of: (a) give up, (b) generate 
conflicts between your change as it stayed in your branch and the same 
change as it went out and came back, or (c) mishandle some cases involving 
reverts.

	-Daniel
*This .sig left intentionally blank*
