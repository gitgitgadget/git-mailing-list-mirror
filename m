From: Tait <git.git@t41t.com>
Subject: Re: a few beginner git questions
Date: Fri, 5 Mar 2010 23:05:33 -0800
Message-ID: <20100306070533.GL2480@ece.pdx.edu>
References: <15b345f1003052242r7d812fe4q6ade253283696304@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Anderson <zelnaga@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 06 08:17:34 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnoGS-00085O-Ss
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 08:17:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111Ab0CFHRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 02:17:25 -0500
Received: from rcpt.cat.pdx.edu ([131.252.208.107]:48212 "EHLO
	rcpt.cat.pdx.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074Ab0CFHRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 02:17:16 -0500
X-Greylist: delayed 699 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Mar 2010 02:17:15 EST
Received: from nemo.ece.pdx.edu (root@nemo.ece.pdx.edu [131.252.209.162])
	by rcpt.cat.pdx.edu (8.14.2/8.14.2/Debian-2build1) with ESMTP id o2675XXs008446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 5 Mar 2010 23:05:33 -0800
Received: from nemo.ece.pdx.edu (tait@localhost [127.0.0.1])
	by nemo.ece.pdx.edu (8.13.6/8.13.1) with ESMTP id o2675XDi022639;
	Fri, 5 Mar 2010 23:05:33 -0800 (PST)
Received: (from tait@localhost)
	by nemo.ece.pdx.edu (8.13.6/8.12.6/Submit) id o2675Xix022627;
	Fri, 5 Mar 2010 23:05:33 -0800 (PST)
X-Authentication-Warning: nemo.ece.pdx.edu: tait set sender to git.git@t41t.com using -f
Content-Disposition: inline
In-Reply-To: <15b345f1003052242r7d812fe4q6ade253283696304@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (rcpt.cat.pdx.edu [131.252.208.107]); Fri, 05 Mar 2010 23:05:33 -0800 (PST)
X-Spam-Status: No, score=0.0 required=6.0 tests=none autolearn=failed
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on rcpt.cat.pdx.edu
X-Virus-Scanned: clamav-milter 0.95.2 at rcpt.cat.pdx.edu
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141607>

> 1. When do you commit changes and when do you stage changes?  Or maybe
> more to the point, what's the difference between doing "stage, commit,
> stage, commit" and "stage, stage, commit"?

Staging changes is a prerequisite to committing them. With stage, commit,
stage, commit you will have two commits in history. With stage, stage,
commit you will have only one commit in history. What you stage (or
neglect to stage) is not part of recorded history in the repository. What
you commit, is.

> 2. What's the difference between merging and pushing?  In CVS, you
> merge code by manually adding changes.  ie. the CVS client doesn't do
> the merging - you do.  Yet in Git Gui, there's a Merge menu button, as
> if it's now supposed to be somehow automated?

Merging is (sort-of) like merging in CVS. You are taking two separate lines
(branches) on the history graph and combining them together. Unlike CVS,
git keeps a record of the merge.

Push is simply copying changes in your local repository to another
repository. What configuration you've set and what arguments you give
to push control what gets copied.

> 3. Creating branches in Git Gui is easy enough but it's unclear to me
> how to switch back to the trunk once you've created a branch.

This depends on what you mean by "switch back". You can change the target
of your commits by using "git checkout".
	> git checkout master
	# Now new commits get added to the tip of master
	> git checkout -b newbranch
	# Now you created a new branch, "newbranch"
	# And you switched to it, so new commits are added
	# to newbranch instead of master
	> git checkout master
	# Now you're back on branch master and your commits
	# to newbranch aren't visible
	> git checkout newbranch
	# Back to newbranch again

If you meant "switch back" like "this branch is done, I'm going to stop
working on it" then you can merge it back into master or some other branch,
or leave it unmerged. Then you may wish to leave it rot or delete it,
perhaps depending on whether you think you'll ever revisit that branch
in the future (to fix a bug, maybe).

> 4. I clone git://github.com/symfony/symfony.git to c:\git\test\root
> and clone that to c:\git\test\clone.	I then blank
> c:\git\test\clone\README, stage it, commit it and push it and the
> change does not appear in c:\git\test\root\README.  I then reopen Git
> Gui and open root and there I see the blanked README as an uncommited
> state change.  I commit it and the change still does not appear in
> c:\git\test\root\README.  Is this what Git should be doing?

You shouldn't push into a non-bare repository (unless you know what you're
doing and really mean it). This:
	http://git.wiki.kernel.org/index.php/GitFaq#Why_won.27t_I_see_changes_in_the_remote_repo_after_.22git_push.22.3F
explains a bit more on the subject.

Tait
