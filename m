From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Subproject status
Date: Mon, 26 Mar 2007 20:04:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0703261920070.6485@iabervon.org>
References: <Pine.LNX.4.64.0703251304280.6485@iabervon.org>
 <20070326093906.GF22773@admingilde.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Tue Mar 27 02:05:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVzBT-0000L6-6g
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 02:05:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933834AbXC0AFC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 20:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933836AbXC0AFB
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 20:05:01 -0400
Received: from iabervon.org ([66.92.72.58]:4019 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933834AbXC0AFA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 20:05:00 -0400
Received: (qmail 20822 invoked by uid 1000); 26 Mar 2007 20:04:59 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Mar 2007 20:04:59 -0400
In-Reply-To: <20070326093906.GF22773@admingilde.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43213>

On Mon, 26 Mar 2007, Martin Waitz wrote:

> You can try to play with my prototype:
> git.admingilde.org/tali/git.git, branch module2
> (to get an example of how to use it, look at the test script in
> t/t7500-submodule.sh).

I tried that yesterday, but I fail reading comprehension; I lost the 
"module2" bit by the time I actually fetched. I'll look into this.

> The core operations should work, but not all the user interface is
> adapted to support submodules.  E.g. git-status will not show if a
> submodule has dirty changes, it will only show submodule changes which
> are already commited to the submodule but not yet to the supermodule.
> But at least simple merges do work with submodules.
> 
> I abondoned this branch (no further work, only occasionally pulling in
> updates from upstream git.git) as it has scalability problems with
> large projects.

That's what I remember. But it's only an issue with super-scale projects 
(i.e., where your subprojects are full-sized projects in their own right, 
and you've got a hundred of them), right? I'm working on the other end 
(factoring out the common bit from a bunch of similar small projects), so 
I should be fine with respect to scalability of the implementation.

Would you guess that a patch series to complete the module2 user interface 
adaptation would also apply to module3 and therefore be useful in the 
future?

> The objects created by the module2 and module3 branches are the same,
> module3 only moves those belonging to the submodule to another location.
> So If you start using module2 branch now you should be able to upgrade
> later.  But to be extra sure, we should have some discussion about the
> object format here.  (There is nothing new here, really: Just one more
> tree entry file mode which says that this is not a file or directory
> entry, but a submodule, represented by one commit.)

So, I had the nutty idea that it would be convenient if I could make 
different files in a single directory come from different projects. But I 
can't think of a sane user interface, so I think that this isn't 
practical from that direction, so it's probably not worth worrying about 
from the data structure end, either. (Answer for the usecase: 
"ln -s make/Makefile Makefile; git add Makefile", and mock systems that 
don't handle symlinks).

But, just to be clear, the semantics of having a commit abcd at a path foo 
are, with respect to the tree this represents, that abcd:* appears at 
foo/*. Right?

Are there any standards we should discuss with respect to refs related to 
subprojects?

I've updated the wiki page with this information.

	-Daniel
*This .sig left intentionally blank*
