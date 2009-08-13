From: Chris Marshall <christopher.marshall@merchantlink.com>
Subject: merging individual files
Date: Thu, 13 Aug 2009 20:16:52 +0000 (UTC)
Message-ID: <loom.20090813T192334-7@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 13 22:24:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbgqH-00081p-It
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 22:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbZHMUUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 16:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755755AbZHMUUI
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 16:20:08 -0400
Received: from main.gmane.org ([80.91.229.2]:41921 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755680AbZHMUUH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 16:20:07 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1MbgmI-0005gc-LL
	for git@vger.kernel.org; Thu, 13 Aug 2009 20:20:02 +0000
Received: from 206.253.186.24 ([206.253.186.24])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 20:20:02 +0000
Received: from christopher.marshall by 206.253.186.24 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 20:20:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 206.253.186.24 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.11) Gecko/2009060215 Firefox/3.0.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125868>

Suppose that merging branch dev1 into master would result in three files, f1,
f2, and f3 being changed, and that I only want to merge the changes for f1 and
f2 and not the changes for f3 currently.  Later on, I want to accept the f3
changes.  Suppose further that the changes to f1, f2, and f3 occurred in a
single commit to branch dev1.

What is the simplest way to use git to achieve that effect?

More generally, I need a way to accept the changes for one or two files while
rejecting the changes for a potentially large number of files, then later on 
accepting the changes for the large number of files.

I work at a company where perforce is currently used for all development and am
trying to work out the git equivalents to all of the perforce flows we use. 
This workflow is the only one that I am stumped on.

One solution that occurs to me is to create a temporary branch off of the (most
recent) common ancestor of master and br1, let's say br2, checkout the files
from br1 that I want to merge into master and commit those to br2, then merge
br2 into master:

git checkout common_ancestor_commit
git checkout -b br2
git checkout br1 f1 f2
git commit
git checkout master
git merge br2
git branch -d br2

This strikes me as not too bad of a procedure, as long as there is a graceful
way of determining the most recent common ancestor of br1 and master.  What's
the simplest way of doing that?
