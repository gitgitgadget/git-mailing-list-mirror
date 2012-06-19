From: Chris Webb <chris@arachsys.com>
Subject: Editing the root commit
Date: Tue, 19 Jun 2012 10:16:58 +0100
Message-ID: <20120619091657.GA28005@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 19 11:37:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgusB-0006lb-Sy
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 11:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282Ab2FSJhK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 05:37:10 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:49952 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154Ab2FSJhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 05:37:09 -0400
X-Greylist: delayed 1210 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jun 2012 05:37:09 EDT
Received: from [81.2.114.212] (helo=arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1SguYU-0003Xs-Pe
	for git@vger.kernel.org; Tue, 19 Jun 2012 10:16:59 +0100
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200189>

I've recently been polishing up some private code for release, using git
rebase --interactive to expand on some commit messages.

In a couple of cases, I wanted to edit the root commit. (Adding a COPYING
file, for example.) I've been successfully doing this with an explicit

  ROOT=$(git log --pretty=format:%H | tail -n 1)
  git checkout $ROOT
  git commit --amend --message='Initial import modified' # for example
  git rebase --onto HEAD $ROOT master

However, this brought two questions to mind.

The first is whether there's a clever symbolic way to refer to the root of
the current branch, rather than tailing git log output? gitrevisions(7)
doesn't obviously suggest one.

The second question is whether it's possible to use git rebase --interactive
to edit the root commit along with some subsequent ones in one fell swoop?

My fingers half-remember doing something like

  git checkout --orphan rewritten
  git rm -rf
  git rebase --interactive --root --onto rewritten master

a year or so ago, but this now fails (on git 1.7.10) with the somewhat
surprising error

  $ git rebase --root --onto rewritten master
  fatal: Needed a single revision
  Does not point to a valid commit: master

Am I misremembering the recipe here, or has the behaviour changed? It seems
to fail identically with or without --interactive.

Best wishes,

Chris.
