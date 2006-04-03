From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn and svn sw --relocate
Date: Mon, 3 Apr 2006 15:39:54 -0700
Message-ID: <20060403223954.GB16726@hand.yhbt.net>
References: <4430123E.5090605@iaglans.de> <20060402222100.GA17888@localdomain> <44314B41.3050902@iaglans.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 04 00:39:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQXiI-0006l6-0X
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 00:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWDCWjz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 18:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbWDCWjz
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 18:39:55 -0400
Received: from hand.yhbt.net ([66.150.188.102]:15085 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S964868AbWDCWjy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 18:39:54 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 122182DC01A; Mon,  3 Apr 2006 15:39:54 -0700 (PDT)
To: Nicolas Vilz 'niv' <niv@iaglans.de>
Content-Disposition: inline
In-Reply-To: <44314B41.3050902@iaglans.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18359>

Nicolas Vilz 'niv' <niv@iaglans.de> wrote:
> Eric Wong wrote:
> > Nicolas Vilz 'niv' <niv@iaglans.de> wrote:
> >>i have now my repository locally and i want to get it remotely on a
> >>server, in order to have a few collaborators...
> >>
> >>the steps on the svn-side are clear. But what do i have todo on the
> >>git-svn-side of this life?
> >>
> >>does a simple "svn sw --relocate" do the job in the git-svn meta-dir?
> > 
> > 
> > Yes, you'll need to do that in .git/git-svn/tree and also update
> > .git/git-svn/info/url by hand.
> 
> Will there be any other sha1-sums for that repository so that i have to
> merge them again and again? This issue occured to me the last time i
> encountered the git-svn-change with the external sources, where i had to
> repair my external git-svn-tree, which resulted in new sha1sums
> somehow... that was very unpleasant to my collegue..

sha1-sums for commits? or trees?  I'm not sure that I follow, git-svn
should make commits with at least two explicit parents (one being the
commit you're using and, and the other remote/git-svn) back to
remotes/git-svn.

The commit sha1s for the same svn tree do not necessary always match,
and ac7490506418e3ec495775e432b7040a17449fa9 acknowledges that:

    contrib/git-svn: allow rebuild to work on non-linear remote heads
    
    Because committing back to an SVN repository from different
    machines can result in different lineages, two different
    repositories running git-svn can result in different commit
    SHA1s (but of the same tree).  Sometimes trees that are tracked
    independently are merged together (usually via children),
    resulting in non-unique git-svn-id: lines in rev-list.

The tree sha1 should always match, however.  You can use the
--branch <refname/commit> option to do automatic branch joining
based on tree sha1 checksums to combine history.

-- 
Eric Wong
