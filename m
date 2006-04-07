From: Peter Baumann <peter.baumann@gmail.com>
Subject: Can't export whole repo as patches
Date: Fri, 7 Apr 2006 20:47:01 +0200
Message-ID: <20060407184701.GA6686@xp.machine.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Apr 07 20:46:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRvyY-0000oj-6d
	for gcvg-git@gmane.org; Fri, 07 Apr 2006 20:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbWDGSq1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Apr 2006 14:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWDGSq1
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Apr 2006 14:46:27 -0400
Received: from matlock.hofmann.stw.uni-erlangen.de ([131.188.24.35]:35972 "HELO
	mail.hofmann.stw.uni-erlangen.de") by vger.kernel.org with SMTP
	id S964861AbWDGSq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Apr 2006 14:46:27 -0400
Received: (qmail 1096 invoked by uid 0); 7 Apr 2006 18:46:22 -0000
Received: from oed48.o.pppool.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@89.51.237.72)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 7 Apr 2006 18:46:22 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18501>

I'd like to export the whole history of a project of mine via patches
but I can't get the inital commit.

How can I get the inital commit as a patch?

That's what I tried:

  git --version
  git version 1.2.4				# debian sarge

  mkdir /tmp/testrepo && cd /tmp/testrepo
  git-init-db
  echo a > a_file.txt
  git-add a_file.txt
  git-commit -a -m "a_file added"
  echo b >> a_file.txt
  git-commit -a -m "a_file modifed"
  xp:/tmp/testrepo git-format-patch master~1
  0001-a_file-modified.txt
  cat 0001-a_file-modified.txt
  From nobody Mon Sep 17 00:00:00 2001
  From: Peter Baumann <peter.baumann@gmail.com>
  Date: Fri Apr 7 12:20:54 2006 +0200
  Subject: [PATCH] a_file modified

  ---

   a_file.txt |    1 +
   1 files changed, 1 insertions(+), 0 deletions(-)

  d8ceeed82a29004c066a98e0d390818e65fa9da7
  diff --git a/a_file.txt b/a_file.txt
  index 7898192..422c2b7 100644
  --- a/a_file.txt
  +++ b/a_file.txt
  @@ -1 +1,2 @@
   a
  +b
  --
  1.2.4


As you can see, there is only a patch of the second commit. But it seems that
this behaviour is correct, because I asked for the diff between master^..master

Obviously, I wanted a way to get the diff of master~2..master.

Trying harder:

  git-format-patch master~2
  Not a valid rev master~2 (master~2..HEAD)

Any hint to the correct way is appreciated.

</me thinking loudly>
The best would be if git would have an implicit tag or branch called "init"
(name doesn't really matter) which is the root of an empty repository. In that case
one can do git-format-patch root..master and it would the right thing.

Greetings,
  Peter Baumann
