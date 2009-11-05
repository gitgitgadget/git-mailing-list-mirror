From: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
Subject: git pull -s subtree doesn't work properly
Date: Thu, 5 Nov 2009 18:09:05 +0000
Message-ID: <20091105180905.GP17628@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 05 19:35:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N67BS-0004F6-Uy
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 19:35:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758223AbZKESfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 13:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758218AbZKESfg
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 13:35:36 -0500
Received: from mhs.swan.ac.uk ([137.44.1.33]:38853 "EHLO mhs.swan.ac.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758192AbZKESff (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 13:35:35 -0500
X-Greylist: delayed 1594 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Nov 2009 13:35:35 EST
Received: from [137.44.2.59] (helo=cs-svr1.swan.ac.uk)
	by mhs.swan.ac.uk with esmtp (Exim 4.69)
	(envelope-from <O.Kullmann@swansea.ac.uk>)
	id 1N66ld-00077V-Qx; Thu, 05 Nov 2009 18:09:05 +0000
Received: from cs-wsok.swansea.ac.uk (cs-wsok [137.44.2.227])
	by cs-svr1.swan.ac.uk (Postfix) with ESMTP id 34728DAC1C;
	Thu,  5 Nov 2009 18:09:05 +0000 (GMT)
Received: by cs-wsok.swansea.ac.uk (Postfix, from userid 3579)
	id 259037420C; Thu,  5 Nov 2009 18:09:05 +0000 (GMT)
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132232>

Hello,

using

IntroductionJava> git remote add -f CSM41 /home/kullmann/csoliver/UofT/Java0910/ProgrammingJava/CS-M41_Programs
IntroductionJava> git merge -s ours --no-commit CSM41/master
IntroductionJava> git read-tree --prefix=Artikel/Skripte/IntroductionJava/CS_M41/ -u CSM41/master
IntroductionJava> git commit -m "Einfuegen des CS-M41-Projektes als Verzeichnis CS_M41"

I have imported repository "CS-M41_Programs" into another repository. Later then
I replaced in the config-file the old url /home/kullmann/csoliver/UofT/Java0910/ProgrammingJava/CS-M41_Programs
by the new one

[remote "CSM41"]
	url = git://github.com/OKullmann/CS-M41-Programming-in-Java.git
	fetch = +refs/heads/*:refs/remotes/CSM41/*

But now

IntroductionJava> git pull -s subtree CSM41 master

doesn't work anymore: In the CSM41 repository just one file index.html was changed,
and apparently the merge strategy recognises that the other files haven't
been changed, while index.html is placed just as if the relative path would
start from the root of the repository.

IntroductionJava> git pull -s subtree CSM41 master
remote: Counting objects: 7, done.
remote: Compressing objects: 100% (3/3), done.
remote: Total 4 (delta 1), reused 0 (delta 0)
Unpacking objects: 100% (4/4), done.
From git://github.com/OKullmann/CS-M41-Programming-in-Java
 * branch            master     -> FETCH_HEAD
CONFLICT (delete/modify): Artikel/LaTeX/SystemStile/Html/index.html deleted in HEAD a
nd modified in 38b11a96fa009a5b2c24cfc94c0268ab9ca7ce39. Version 38b11a96fa009a5b2c24
cfc94c0268ab9ca7ce39 of Artikel/LaTeX/SystemStile/Html/index.html left in tree.
Automatic merge failed; fix conflicts and then commit the result.

IntroductionJava> git status
# On branch master
# Unmerged paths:
#   (use "git reset HEAD <file>..." to unstage)
#   (use "git add <file>..." to mark resolution)
#
#       deleted by us:      ../../LaTeX/SystemStile/Html/index.html
#
no changes added to commit (use "git add" and/or "git commit -a")

The path of index.html is Artikel/Skripte/IntroductionJava/CS_M41/Html/index.html.
Why git thinks that index.html should be placed into another directory Artikel/LaTeX/SystemStile/Html/
I have no clue (this directory doesn't exist).

Is it possible to tell "git pull" where the subtree really is, or is that
not really the cause of the problem?

Thanks for your consideration!

Oliver
