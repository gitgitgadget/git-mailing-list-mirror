From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: removing content from git history
Date: Wed, 21 Feb 2007 11:56:36 -0500
Message-ID: <20070221165636.GH25559@spearce.org>
References: <20070221164527.GA8513@ginosko.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Hendricks <michael@ndrix.org>
X-From: git-owner@vger.kernel.org Wed Feb 21 17:56:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJulr-0002Ys-Dv
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 17:56:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422681AbXBUQ4n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 11:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422684AbXBUQ4n
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 11:56:43 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42485 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422681AbXBUQ4m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 11:56:42 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HJuld-0007Wj-5V; Wed, 21 Feb 2007 11:56:33 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 25F7920FBAE; Wed, 21 Feb 2007 11:56:37 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070221164527.GA8513@ginosko.local>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40303>

Michael Hendricks <michael@ndrix.org> wrote:
> Is it possible to remove content entirely from git's history?

No, not once it has been published around to another repository.
Since every developer has a copy of the repository its very difficult
to remove something, as it must be removed from every developer's
repository, and each developer must perform an action to agree to
that removal.  So just one hold-out will keep the bad content around.

> I have a
> client who does not use git for version control.  A couple months ago
> they committed some sensitive client information which should never have
> been committed.  Recently, they realized the mistake and now want to
> remove all traces of the mistake from history.
> 
> I would like to migrate them to git at some point.  However, if they had
> been using git for version control already, I'm not sure how I would
> solved this particular problem.  Any suggestions?

The *only* way to do this in Git is to completely recreate every
commit after that point.  This changes all commit IDs and basically
forks the project into two completely different histories: the
one with the bad thing in it, and the one without the bad thing.
Users who have the bad thing will continue to have the bad thing
until they take explicit action to throw away all of that history
and switch to the other one.

Now this is actually not a huge deal if you do it on your local
repository and go "whoops, I should not have committed that".  If you
have not yet pushed the commit to another repository (and someone
has not yet fetched it from you either) you can use git-rebase to
discard it.  But once its been pushed/fetched the genie is out of
the bottle, and its not going back in.

-- 
Shawn.
