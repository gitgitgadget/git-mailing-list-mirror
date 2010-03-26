From: Brian Dilley <bdilley@estalea.com>
Subject: Git rebase/merge questions
Date: Fri, 26 Mar 2010 12:26:04 -0700
Message-ID: <7a489efb1003261226h51a9576fq7c2d5de306da4b32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 26 20:26:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvFAb-0007Wc-8z
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 20:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624Ab0CZT0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 15:26:08 -0400
Received: from mail-iw0-f196.google.com ([209.85.223.196]:40386 "EHLO
	mail-iw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab0CZT0F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 15:26:05 -0400
Received: by iwn34 with SMTP id 34so8433667iwn.15
        for <git@vger.kernel.org>; Fri, 26 Mar 2010 12:26:04 -0700 (PDT)
Received: by 10.231.150.205 with HTTP; Fri, 26 Mar 2010 12:26:04 -0700 (PDT)
Received: by 10.231.146.144 with SMTP id h16mr625120ibv.18.1269631564413; Fri, 
	26 Mar 2010 12:26:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143266>

    Recently i converted a very large CVS repository with a large
number of modules, branches and tags to Git as we have decided we're
going to migrate to Git.  At the same time there is some restructuring
that is going to be done.  We're actually splitting modules up into
separate Git repositories all together (not each module in it's own
repo, but grouping them a bit better).  Take these example CVS
modules:

Aproject1
Aproject2
Aproject3
Bproject1
Bproject2
Bproject3

They used to all be in the same repository but we're moving them into
their own repositories:

git repo for A:
Aproject1
Aproject2
Aproject3

git repo for B:
Bproject1
Bproject2
Bproject3

And furthermore we're renaming them:
git repo for A:
xxx-project1
xxx-project2
xxx-project3

git repo for B:
yyy-project1
yyy-project2
yyy-project3

There is also some other changes we're making that is more project
specific (upgrading from Maven 1 to Maven 2).  The plan has been:

1) create Git repo - note date/time
2) make rename/restructure changes
3) make build system updates (maven1->mave2)
4) copy all changes since step #1 from CVS into Git
5) cut over to Git completely

There are several active branches in place for each of these modules.
For each branch we planned on executing those steps in that order.  So
what I initially did was step 1.  Then step 2, 3 and 4 in "master".  I
then planned on merging these changes from master into each of the
branches one at a time, effectively completing step 2 and 3 at once.
This is where my problem lies.  I've tried the following on the
branches:

git rebase master
this results in a TONS of conflicts (why would there be conflicts?)

git merge master
same as above, TONS of conflicts

i've tried branching from master from the comment before i peformed
step #2 on it, removing everything but the ".git" directory, copying
everything from one of the branches (from another directory) into the
repo directory and rectifying the deltas by adding the differences and
new files and removing the removed files and then committing this
branch.  The theory being that it's a copy of master with all of the
changes from the other specific branch and then doing the rebase/merge
- still TONS of conflicts.

Most of the conflicts are (delete/modify) conflicts.  I expected a few
problems (10-20) but i'm getting hundred and thousands.  Any help
would be greatly appreciated!
