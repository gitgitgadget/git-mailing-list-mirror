From: John Goerzen <jgoerzen@complete.org>
Subject: git-rebase dirty index and email address bug?
Date: Sat, 1 Mar 2008 14:40:24 -0600
Message-ID: <slrnfsjfpo.3fl.jgoerzen@katherina.lan.complete.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 21:41:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVYWa-0006oA-Cu
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 21:41:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157AbYCAUk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 15:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753254AbYCAUk5
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 15:40:57 -0500
Received: from main.gmane.org ([80.91.229.2]:54170 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751635AbYCAUk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 15:40:56 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JVYVi-0003he-Is
	for git@vger.kernel.org; Sat, 01 Mar 2008 20:40:46 +0000
Received: from 63-245-179-205.kitusa.com ([63.245.179.205])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 Mar 2008 20:40:46 +0000
Received: from jgoerzen by 63-245-179-205.kitusa.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 01 Mar 2008 20:40:46 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 63-245-179-205.kitusa.com
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75699>

Hi folks,

I have checked out a remote git repo.  I have hacked on my local copy
for the last two days.  I have performed no merges or anything elese
odd.  Today I git fetched the remote, and then I tried to git rebase
upstream/master.  I had committed all outstanding changes first.  My
index was clean.  It displayed:

First, rewinding head to replay your work on top of it...
HEAD is now at 77f1a60... Merge branch 'trunk'
Dirty index: cannot apply patches (dirty: public/dispatch.fcgi)

Tthat particular file was one that I added.  It did not exist upstream
either at my initial checkout, nor was it added upstream at any point
since.

git status shows:

# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       new file:   public/dispatch.fcgi
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       .dotest/

So I tried the git reset command on public/dispatch.fcgi, and also
then deleted that file.  I then tried git-rebase --continue, which
displayed:

sed: can't read .dotest/info: No such file or directory
sed: can't read .dotest/info: No such file or directory
sed: can't read .dotest/info: No such file or directory
Patch does not have a valid e-mail address.

I have no idea what sed is complaining about, but that last line is
interesting.  The upstream git repo I am monitoring was itself
converted from an svn repo using, presumably, git-svn or
git-svnimport.  It lies at
git://gitorious.org/redmine-git/mainline.git

Most patches have an author like this:

Author: jplang <jplang@e93f8b46-1217-0410-a6f0-8f06a7374b81>

Could one of the git tools be trying to parse this for some odd
reason?

Or is something else going on here?


