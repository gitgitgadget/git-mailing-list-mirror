From: Petr Baudis <pasky@suse.cz>
Subject: Re: Better cooperation between checkouts and stashing
Date: Tue, 2 Feb 2010 02:36:47 +0100
Message-ID: <20100202013647.GM9553@machine.or.cz>
References: <4B67227A.7030908@web.de>
 <7vhbq0wuy6.fsf@alter.siamese.dyndns.org>
 <4B674E36.40708@web.de>
 <76c5b8581002011444t4f955fcdrd1f582f5c043f705@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Elfring <Markus.Elfring@web.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 02:36:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc7hJ-0008UB-Fv
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 02:36:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977Ab0BBBgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 20:36:51 -0500
Received: from w241.dkm.cz ([62.24.88.241]:41391 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751241Ab0BBBgu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 20:36:50 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 38F5186202A; Tue,  2 Feb 2010 02:36:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <76c5b8581002011444t4f955fcdrd1f582f5c043f705@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138672>

On Mon, Feb 01, 2010 at 05:44:25PM -0500, Eugene Sajine wrote:
> >
> > I imagine that this case is useful because of usual work interruptions
> >
> > in software development. A developer tries to bring various tasks
> >
> > forward in parallel. Branches will be switched often with unfinished
> >
> > work that needs to be kept before the reactivation of another task.
> >
> 
> Aren't this and similar statements based on a general problem of
> people being afraid to commit, because CVS/SVN taught them to be
> affraid? We are in progress of migrating from CVS to GIT and this is
> one of the things i'm desperately fighting with.
> In Git Commit doesn't equal Share (it does in CVS), so why not to
> commit and save your work in progress and switch branches painlessly?

There are various pressures pushing against each other and the balance
will be different for each individual and each project. One aspect is
that committing often is encouraged. However, greatly contradicting
force is the pressure to have "clean history" - that is, self-contained,
clearly separated cnd bisectable ommits which introduce independent
changes and are pretty to look at, frequently quite different to
chronological log of the performed work.

Of course you can ignore that and just commit away, or build up large
changes "in advance", then split them up at once. The resulting number
of commits will be about the same, but their quality _and_ the spent
effort will be quite different. Optimum lies in appropriate balance of
the processes, as usual.

There are several ways to achieve the latter process, moreover. One
possibility is to do all changes in the working tree, then carefulling
factoring out various aspects to separate commits using index
manipulation and heavy `git add -p` usage; you would then certainly need
`git stash` in case you wanted to switch the branch. The other way is
to commit regularly creating a history structure similar to the
"careless committer", _however_ before pushing out and publishing the
commits, the history gets cleaned up and rewritten by `git rebase -i`.

Choosing the appropriate method involves all kinds of subtle tradeoffs
and I wonder whether there is a single good answer, it is a matter of
taste. I do the former, but maybe that's because I just dislike rebase
for different reasons. ;-) One natural way would be to hack in the
working tree, splitting up your work to 1-3 commits in the index, then
reviewing your complete local changeset and tweaking it by rebase -i
before finally publishing your self-contained masterpiece.

For better or worse, There Is More Than One Way To Do It in Git. ;-)

-- 
				Petr "Pasky" Baudis
If you can't see the value in jet powered ants you should turn in
your nerd card. -- Dunbal (464142)
