From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: FEATURE suggestion git commit --amend <ref>
Date: Fri, 27 Feb 2009 11:30:38 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902271121590.6600@intel-tinevez-2-302>
References: <81bfc67a0902262345i63386076rbcf6d71ed88c29ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 11:33:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld01s-0001LN-RB
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 11:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757689AbZB0Kan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 05:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757709AbZB0Kan
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 05:30:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:54547 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759240AbZB0Kal (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 05:30:41 -0500
Received: (qmail invoked by alias); 27 Feb 2009 10:30:38 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp011) with SMTP; 27 Feb 2009 11:30:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/MCAhohcHMEL/sHc9CBNawJPP8/SV8fNaz9Aa0je
	bK0ZsQfGim7L9g
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <81bfc67a0902262345i63386076rbcf6d71ed88c29ac@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111657>

Hi,

On Fri, 27 Feb 2009, Caleb Cushing wrote:

> git rebase -i seems a little more tedious/unfriendly than I'd like if 
> all I want to do is edit HEAD~2 (assuming no merges) it's a bit of a 
> pain to do a rebase -i and then pick which patches to edit. might be 
> nice to be able to do stuff like git commit --amend <ref> and have that 
> call rebase (as I think not rebasing is impossible?) with edit only on 
> the ref I picked.
> 
> hopefully I've explained well enough.

Yes, but IMHO you did not consider the undesired side effects well enough.

For example: What about merges?

To be clear: amending a merge is not just a matter of "rebase -i 
<commit>^" with a custom script, and even worse, there could be merges 
between the commit you want to amend and the current HEAD.  That is a 
complete Pandora box right there.

Also, your amended changes could break reapplication of the later commits.  
So "git commit --amend <ref-other-than-HEAD>" is _semantically_ different 
from "git commit --amend".

Of course, there is also the problem that <ref> might not be an ancestor 
of HEAD to begin with.

And that the specified commit could be part of more than one branch, 
adding to user's confusion when it is only rewritten in the current 
branch.

But more fundamental: is this operation something we want to make _that_ 
easy?  After all, it is _not_ the common case, and it bears such a bunch 
of problems that the user should be made well aware of what she is doing.

All in all, as with many feature requests, I have to say that I see what 
you want, but the side effects are too horrible -- and you did not 
consider them, obviously, otherwise you would have put forward arguments 
as to why the side effects would not matter that much.

Ciao,
Dscho
