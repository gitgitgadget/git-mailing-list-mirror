From: Robert Smith <wolf1boy79@yahoo.com>
Subject: Newbie using git -- need a little help
Date: Sun, 17 Jun 2007 11:55:52 -0700 (PDT)
Message-ID: <42118.74778.qm@web57410.mail.re1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 17 21:01:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I000I-0006yx-Cd
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 21:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757952AbXFQTBh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 15:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757261AbXFQTBh
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 15:01:37 -0400
Received: from n8a.bullet.mail.re3.yahoo.com ([68.142.236.46]:37663 "HELO
	n8a.bullet.mail.re3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757716AbXFQTBg (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jun 2007 15:01:36 -0400
X-Greylist: delayed 343 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Jun 2007 15:01:36 EDT
Received: from [68.142.237.88] by n8.bullet.re3.yahoo.com with NNFMP; 17 Jun 2007 18:55:53 -0000
Received: from [66.196.101.132] by t4.bullet.re3.yahoo.com with NNFMP; 17 Jun 2007 18:55:53 -0000
Received: from [127.0.0.1] by rrr3.mail.re1.yahoo.com with NNFMP; 17 Jun 2007 18:55:53 -0000
X-Yahoo-Newman-Property: ymail-5
X-Yahoo-Newman-Id: 178212.15665.bm@rrr3.mail.re1.yahoo.com
Received: (qmail 75265 invoked by uid 60001); 17 Jun 2007 18:55:53 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Message-ID;
  b=L+X2iIWdpvkMajTpiEvkWd6qLpWrPRPKaR0nix48On5tGM84yox5YiXVDQNS0USJK6FPINlHetn94p9Za3DKW8Kax91+UY6GSMUuDA4szrk6som7/u04K5y04cyZky63NL8+cDynzvIRvRcmbwWJv6Ww0Nvzeo+rCkb+L/whxeQ=;
X-YMail-OSG: A5aMunkVM1lWclD8Olikn_EmGqaX2d2S8SIC1REyoUQEUK2s_3cELe_Sq.4E9YBUNThSiYdqadJbyz1m.5Hr8paD5wWRs2kUEuAL1ntbIQmNqIu66IBHNz7wNY5X5AyD
Received: from [216.252.108.191] by web57410.mail.re1.yahoo.com via HTTP; Sun, 17 Jun 2007 11:55:53 PDT
X-Mailer: YahooMailRC/651.29 YahooMailWebService/0.7.41.16
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50364>

Hi,

I apologize right off the bat for the stupid newbie questions.  I've read over the documentation (the full manual) numerous times and must admit it's slightly overwhelming.  What I'm trying to do is pretty basic, though, so hopefully someone can help me out.  Please forgive me for the long post (I'm going to try to describe exactly what I'm doing so that someone can point me to what I'm doing wrong).

I have both a desktop computer, a laptop, and a server where I host my git repository.  The goal for having this public repository is for me to be able to
program on my desktop, then push the changes to the server, and then
continue development on, say, my laptop later on grabbing the newer tree.  Here's what I've done so far:

On the server, I've put all my programming projects.  Then I did a:

git init && git add . && git commit -a

in one of my project directories.

I have a git-daemon running on this server so that people (me, for the most part :)) can pull my tree.

So on one of my two machines (desktop/laptop), I then clone the tree:

git clone git://my.server.com/project

It downloads the tree just fine.  Then I go into the directory and start making changes.  Here's an example:

---------------

>> on the desktop <<

~/temp rsmith$ git clone git://my.server.com/testing 
Initialized empty Git repository in /home/rsmith/temp/testing/.git/
remote: Generating pack...
Done counting 3 objects.
Deltifying 3 objects...
remote: /3) done
Total 3 (delta 0), reused 0 (delta 0)
Indexing 3 objects.
 100% (3/3) done

~/temp rsmith$ cd testing/

~/temp/testing rsmith$ ls
testing

~/temp/testing rsmith$ cat testing 
This is a file that was created on the repository (server) machine...

~/temp/testing rsmith$ echo "I put this line in using the client (cloned) tree...  I want to push this change up to the server that has the repo." >> testing 

~/temp/testing rsmith$ cat testing 
This is a file that was created on the repository (server) machine...
I put this line in using the client (cloned) tree...  I want to push this change up to the server that has the repo.

~/temp/testing rsmith$ git commit -a
Created commit bae2b3e9a8d939cc3982b9ab398eb398eb29a13
 1 files changed, 1 insertions(+), 0 deletions(-)

~/temp/testing rsmith$ git show
commit bae2b3e9a8d939cc3982b9ab398eb398eb29a13
Author: Robert Smith <wolf1boy79@yahoo.com>
Date:   Sun Jun 17 13:54:59 2007 -0400

    Added an extra line to the file...

diff --git a/testing b/testing
index ae22fbe..bae5e8f 100644
--- a/testing
+++ b/testing
@@ -1 +1,2 @@
 This is a file that was created on the repository (server) machine...
+I put this line in using the client (cloned) tree...  I want to push this change up to the server that has the repo.

---------------

Now I push the tree up to my repository...

>> on the desktop <<

~/temp/testing rsmith$ git push ssh://my.server.com/scm/git/testing master
Password: 
updating 'refs/heads/master'
  from b39be3baa3b29eb39e98bd92b3ab39bee3b3a291
  to   bae2b3e9a8d939cc3982b9ab398eb398eb29a13
Generating pack...
Done counting 5 objects.
Result has 3 objects.
Deltifying 3 objects.
 100% (3/3) done
Writing 3 objects.
 100% (3/3) done
Total 3 (delta 0), reused 0 (delta 0)
Unpacking 3 objects
refs/heads/master: b39be3baa3b29eb39e98bd92b3ab39bee3b3a291 -> bae2b3e9a8d939cc3982b9ab398eb398eb29a13

---------------

Now, on the SERVER (the machine with the repository that I pushed my tree to), I can see the changes by doing a "git show"...

~/scm/git/testing rsmith$ git show
commit bae2b3e9a8d939cc3982b9ab398eb398eb29a13
Author: Robert Smith <wolf1boy79@yahoo.com>
Date:   Sun Jun 17 14:22:26 2007 -0400

    Added an extra line to the file...

diff --git a/testing b/testing
index ae22fbe..bae5e8f 1206be
--- a/testing
+++ b/testing
@@ -1 +1,2 @@
 This is a file that was created on the repository machine...
+I put this line in using the client (cloned) tree...  I want to push this change up to the server that has the repo.
lines 1-13/13 (END)


HOWEVER, the testing file still doesn't show the change...  (look below)

~/scm/git/testing rsmith$ cat testing 
This is a file that was created on the repository machine...


So I figure I'll go ahead and commit the changes (since "git show" shows that the change has been pushed from the desktop to the server)...  I go ahead and do a "git commit -a" on the SERVER...

commit b3eebe298b2399238a3becc9823b3982109ebea
Author: Robert Smith <wolf1boy79@yahoo.com>
Date:   Sun Jun 17 14:34:11 2007 -0400

    Testing.

diff --git a/testing b/testing
index b3ab382..3b32098a 102415
--- a/testing
+++ b/testing
@@ -1,2 +1 @@
 This is a file that was created on the repository machine...
-I put this line in using the client (cloned) tree...  I want to push this change up to the server that has the repo.

---------------

I'm not sure what I'm doing wrong.  I see the change once the tree is pushed to the server (from the desktop), but it is undone automatically with a git commit -a.  According to the documentation, everything up to the "push" step seems to be correct...  But what do I do once I pushed the tree up to the public repo?  How do I get those changes to be reflected on the public repo (the server?) without a git commit -a undoing those changes I've made?

Any ideas/help would be greatly appreciated.

- robert -




 
____________________________________________________________________________________
Be a PS3 game guru.
Get your game face on with the latest PS3 news and previews at Yahoo! Games.
http://videogames.yahoo.com/platform?platform=120121
