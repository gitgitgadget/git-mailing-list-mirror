From: davetron5000 <davetron5000@gmail.com>
Subject: Getting git-svn to recognize branchpoints?
Date: Fri, 6 Jun 2008 12:07:30 -0700 (PDT)
Message-ID: <a12182cd-2cd3-42a6-b3b4-f99907576741@d77g2000hsb.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 21:08:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4hIZ-0006pY-MS
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 21:08:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756464AbYFFTHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 15:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755332AbYFFTHe
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 15:07:34 -0400
Received: from yw-out-2122.google.com ([74.125.46.25]:2683 "EHLO
	yw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753376AbYFFTHe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 15:07:34 -0400
Received: by yw-out-2122.google.com with SMTP id 1so771440ywp.1
        for <git@vger.kernel.org>; Fri, 06 Jun 2008 12:07:30 -0700 (PDT)
Received: by 10.150.49.2 with SMTP id w2mr4051ybw.18.1212779250906; Fri, 06 
	Jun 2008 12:07:30 -0700 (PDT)
X-IP: 98.218.223.189
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-US; 
	rv:1.8.1.14) Gecko/20080404 Firefox/2.0.0.14,gzip(gfe),gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84099>

I was given a branch in an SVN repo to work on.  My plan is to merge
it with trunk in Git to indicate how much easier it would be to use
Git.

Unfortunately, Git doesn't seem to realize that my branch is a branch
from SVN's trunk.  For example, I have made no changes to file foo.c

The main trunk has changes to foo.c

When I merge, those changes show up as conflicts.

gitk doesn't show any branch points, and I'm thinking that Git just
doesn't see the branches as they are in SVN.

The sha-1 of the branch commit from SVN shows up in gitk when I've
checked out my branch, but not if I have the trunk checked out (though
a git log DOES show it).

Here's what I did to initially set this up (I'm working on $SVNROOT/
branches/FOO):

git-svn init ssh://www.theirrepo.com/svnroot
git-checkout -b local-trunk trunk
git-branch local-foo FOO
git-checkout local-foo

git-svn dcommit on local-foo sends changes to FOO, if on local-trunk,
they are sent to trunk in SVN
git-svn rebase gets changes from FOO or trunk, as appropriate

Here's my .git/config:

[core]
    repositoryformatversion = 0
    filemode = true
    bare = false
    logallrefupdates = true
[svn-remote "svn"]
    url = svn+ssh://davec@svn.theirrepo.com/svnroot
    fetch = trunk:refs/remotes/trunk
    branches = branches/*:refs/remotes/*
    tags = tags/*:refs/remotes/tags/*

Any ideas?
