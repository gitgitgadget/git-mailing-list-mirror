From: David Brown <git@davidb.org>
Subject: Help breaking up a large merge.
Date: Thu, 18 Sep 2008 08:21:55 -0700
Message-ID: <20080918152154.GA27019@linode.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 18 17:24:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgLML-0006QI-Uj
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 17:23:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754592AbYIRPV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 11:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755527AbYIRPV4
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 11:21:56 -0400
Received: from linode.davidb.org ([72.14.176.16]:55176 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754293AbYIRPVz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 11:21:55 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.69 #1 (Debian))
	id 1KgLKN-0007K3-0R
	for <git@vger.kernel.org>; Thu, 18 Sep 2008 08:21:55 -0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96201>

Say we have a tree that we've been working on for a few months.  An
outside vendor has also been working on the same tree during this
time, and we need to merge with their work.

The difficulty I'm having is that there are a lot of conflicts
resulting from the merge (expected), and it would be nice to somehow
be able to work on a smaller set of these conflicts at a time.

Some of the conflicts are caused by a single change in the other tree.
This is easy to cherry-pick into my tree, resolve, and then test those
changes independently.

But other conflicts are caused by groups of commits that are
interleaved with others.

Ideally, I'd like to be able to divide this conflict resolution work
up among a small group of people, have everybody work on part, test
their part, and then I could bring all of the resolved versions
together, test that, and make that the actual merge commit in our
repo.  I've had a few ideas, but none really seem to work all that
well.

   - Do "git merge -s ours their-tree".  Then, in another branch try
     the merge, and resolve a group of files that go together.  Put
     these into the 'ours' tree and ammend these changes to the merge
     commit.  The problem here is that this misses all of the merges
     that would happen automatically.

   - "git branch -b tmp $(git merge-base our-head their-tree)", and
     then: "git checkout their-tree filenames" for a small group of
     conflicting files.  Commit this, then in my regular tree, cherry
     pick this change and resolve the conflict.  Then, when finally
     doing the merge with their tree, these files can be resolved by
     just using our version.  This still requires doing some tracking.

Any other ideas?

In the future, we're going to try and work more closely with the
vendor, but we have to get to the point of having something common to
start that.

Thanks,
David
