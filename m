From: <esskov@oncable.dk>
Subject: git-svn producing "invalid author/committer line"
Date: Thu, 02 Jul 2009 11:09:00 +0200
Message-ID: <sbqo45dgejpcnt58cam2tfkeon4is2v4ur@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 11:17:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMIPE-0004Yt-QN
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 11:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752693AbZGBJQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 05:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752690AbZGBJQ0
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 05:16:26 -0400
Received: from mx04.stofanet.dk ([212.10.10.14]:36970 "EHLO mx04.stofanet.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752219AbZGBJQZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jul 2009 05:16:25 -0400
X-Greylist: delayed 448 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Jul 2009 05:16:25 EDT
Received: from 56344c10.rev.stofanet.dk ([86.52.76.16] helo=eclipse2)
	by mx03.stofanet.dk (envelope-from
	<esskov@oncable.dk>)
	with esmtpa id 1MMIHr-000248-29
	for git@vger.kernel.org; Thu, 02 Jul 2009 11:08:59 +0200
X-Mailer: Forte Agent 4.2/32.1118
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122631>

	Hi,

We have an SVN repository with a number of projects in its /trunk.
Different people have r/w-access to different subsets of these projects. 

When I "git-svn fetch" this repo's trunk there will be some revisions that
I don't have access to. In SVN log they show up as empty change-sets with
unspecified author. 
In the resulting git repo, git-fsck says "error in commit
92cf6ec3a55fbbfbf5aea7f0937e4b49470b9112: invalid author/committer line",
and - as a consequence I guess - git-gc aborts.

$ git show 92cf6
commit 92cf6ec3a55fbbfbf5aea7f0937e4b49470b9112
Author: (no author) <(no author)@xxxx>
Date:   Thu Jan 1 00:00:00 1970 +0000

I tried to run "git filter-branch --prune-empty -- --all", to simply
discard these empty commits, but the problem remains. 

After some googling I found a possible work-around, using the
--authors-file option of git-svn to map the "no author" into something
less invalid, but I suppose that would require the list to contain every
other committer as well?

Could I somehow make "git-svn fetch" skip these empty commits,
corresponding to revisions that the SVN user doesn't have access to?


Cheers,

	Esben
