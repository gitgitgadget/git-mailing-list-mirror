From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: odd behavior with concurrent fetch/checkout
Date: Mon, 22 Oct 2007 15:46:38 -0400
Message-ID: <20071022194638.GN583@fieldses.org>
References: <20071022165125.GG583@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 22 21:47:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik3Es-0006HF-4D
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 21:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753656AbXJVTqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 15:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753742AbXJVTqk
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 15:46:40 -0400
Received: from mail.fieldses.org ([66.93.2.214]:49366 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753655AbXJVTqj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 15:46:39 -0400
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1Ik3EU-0000GB-6X
	for git@vger.kernel.org; Mon, 22 Oct 2007 15:46:38 -0400
Content-Disposition: inline
In-Reply-To: <20071022165125.GG583@fieldses.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62041>

On Mon, Oct 22, 2007 at 12:51:25PM -0400, J. Bruce Fields wrote:
> Just now I checked out a topic branch in my working repo:
> 
> 	git checkout server-xprt-switch
> 
> and while waiting for it to complete (I just started work and caches
> were all cold), I ran a
> 
> 	git fetch origin
> 
> in another window to update from Linus.  The git fetch gave a warning:
> 
> 	remote: Generating pack...
> 	remote: Counting objects: 7550
> 	remote: Done counting 12885 objects.
> 	remote: Result has 8400 objects.
> 	remote: Deltifying 8400 objects...
> 	remote:  100% (8400/8400) done
> 	Indexing 8400 objects...
> 	remote: Total 8400 (delta 7257), reused 5696 (delta 4586)
> 	 100% (8400/8400) done
> 	Resolving 7257 deltas...
> 	 100% (7257/7257) done
> 	* refs/remotes/origin/master: fast forward to branch 'master' of
> 	* git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
> 	  old..new: d85714d..55b70a0
> 	Cannot fetch into the current branch.

By the way, I should have said--this is with git version
1.5.3.4.208.gc990.

--b.

> 
> Why the warning?  Also, afterwards I was left with server-xprt-switch
> pointing to the tip of the branch I'd just switched from (another
> miscellaneous topic branch).  The working directory was in some
> completely different state--thanks to a quick reset --hard I don't know
> what it was.  Also, in the reflog for the checked-out branch:
> 
> 	commit bac1e7977eb4781e62cee7f1c7c3d13a9e5d8d74
> 	Reflog: server-xprt-switch@{0} (J. Bruce Fields <bfields@citi.umich.edu>)
> 	Reflog message: fetch origin: Undoing incorrectly fetched HEAD.
> 	Author: J. Bruce Fields <bfields@citi.umich.edu>
> 	Date:   Mon Oct 22 12:32:37 2007 -0400
> 	...
> 
> Why was a fetch into the remote fooling with HEAD or anything under
> refs/heads/?
> 
> --b.
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
