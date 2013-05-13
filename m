From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] git-svn: clarify explanation of --destination argument
Date: Mon, 13 May 2013 14:32:34 -0700
Message-ID: <20130513213234.GG3657@google.com>
References: <CA+7g9Jxd3mhbra34f+MiJRt36Lb6gVHi1nOCP8Zo5y-G9jB3qA@mail.gmail.com>
 <20111217100521.GA12610@elie.hsd1.il.comcast.net>
 <CA+7g9JzatFYViMk302uU-X=YQGF2wEsmASkLPm0tDfQvpL_-vQ@mail.gmail.com>
 <20111220012236.GB20979@elie.hsd1.il.comcast.net>
 <20130513213055.GE3657@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nathan Gray <n8gray@n8gray.org>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon May 13 23:32:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc0MN-0008Au-JZ
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 23:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755116Ab3EMVcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 17:32:39 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:41564 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754413Ab3EMVcj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 17:32:39 -0400
Received: by mail-pa0-f44.google.com with SMTP id jh10so4956278pab.31
        for <git@vger.kernel.org>; Mon, 13 May 2013 14:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=VX9WmrjQrAlpZxWfj543qA5hcmOtY4YUOp2wIh6eIxM=;
        b=EA9ms9hB5ISSvKJHBPvr8rLdroPLCGDkHEQcBf11H+4ICaJ+3wIf39z+sP9mjQTqfw
         aVQkEHunEx9vmIdDoTt8122tz4vDF7B2ttSo6A2QK1NQpyi5BE07gOXfc/gqGfW7UnRz
         KwtXPMdemNJX1V+Zv7FKI8FRnAJ2SedGZdt4lpQfVyT/TBTqKiuwtE1tQMs2Q+hhZUTO
         bj04zg0bYawsGm8uPYIcP1x3ulI6MpbTlbg4abNy5oqHtoGDJuuHrFj8CbaroOplTdVo
         MxzeiPIhgVKYsRRsA8JxHiMy1/Khi7joPFI9uUi/0QG/WTjqs3gHvxL5MqWWilCuuSLD
         tPyw==
X-Received: by 10.66.155.39 with SMTP id vt7mr31191952pab.99.1368480758657;
        Mon, 13 May 2013 14:32:38 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id br2sm15310084pbc.46.2013.05.13.14.32.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 14:32:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130513213055.GE3657@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224212>

Date: Mon, 19 Dec 2011 19:24:30 -0600

The existing documentation for "-d" does not make it obvious whether
its argument is supposed to be a full svn path, a partial svn path,
the glob from the config file, or what.  Clarify the text and add an
example to get the reader started.

Reported-by: Nathan Gray <n8gray@n8gray.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks for reading.

 Documentation/git-svn.txt | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 6c0988e..68c706d 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -271,13 +271,15 @@ first have already been pushed into SVN.
 	Create a tag by using the tags_subdir instead of the branches_subdir
 	specified during git svn init.
 
--d;;
---destination;;
+-d<path>;;
+--destination=<path>;;
+
 	If more than one --branches (or --tags) option was given to the 'init'
 	or 'clone' command, you must provide the location of the branch (or
-	tag) you wish to create in the SVN repository.  The value of this
-	option must match one of the paths specified by a --branches (or
-	--tags) option.  You can see these paths with the commands
+	tag) you wish to create in the SVN repository.  <path> specifies which
+	path to use to create the branch or tag and should match the pattern
+	on the left-hand side of one of the configured branches or tags
+	refspecs.  You can see these refspecs with the commands
 +
 	git config --get-all svn-remote.<name>.branches
 	git config --get-all svn-remote.<name>.tags
@@ -1044,6 +1046,13 @@ Multiple fetch, branches, and tags keys are supported:
 	tags = tags/server/*:refs/remotes/project-a/tags/*
 ------------------------------------------------------------------------
 
+Creating a branch in such a configuration requires disambiguating which
+location to use using the -d or --destination flag:
+
+------------------------------------------------------------------------
+$ git svn branch -d branches/server release-2-3-0
+------------------------------------------------------------------------
+
 Note that git-svn keeps track of the highest revision in which a branch
 or tag has appeared. If the subset of branches or tags is changed after
 fetching, then .git/svn/.metadata must be manually edited to remove (or
-- 
1.8.3.rc1
