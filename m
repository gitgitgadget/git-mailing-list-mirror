From: Rogan Dawes <lists@dawes.za.net>
Subject: git-svn and renames
Date: Tue, 10 Jul 2007 15:11:48 +0200
Message-ID: <46938594.2010607@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jul 10 15:12:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8FW2-0002uQ-6o
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 15:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754113AbXGJNM0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 09:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbXGJNM0
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 09:12:26 -0400
Received: from sd-green-bigip-81.dreamhost.com ([208.97.132.81]:54792 "EHLO
	spunkymail-a11.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751443AbXGJNMZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jul 2007 09:12:25 -0400
Received: from [192.168.201.103] (dsl-146-24-230.telkomadsl.co.za [165.146.24.230])
	by spunkymail-a11.g.dreamhost.com (Postfix) with ESMTP id 3DAF7B84EF;
	Tue, 10 Jul 2007 06:12:21 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (Windows/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52062>

Hi folks,

I am trying to push my local changes to an imported SVN project back to 
the SVN repo. For anyone who cares, this is the WebGoat repository which 
you can find at http://dawes.za.net/rogan/webgoat/webgoat.git/

I am trying to push it back to the primary GoogleCode repo. I have 
successfully managed to push 20 or so commits, but I am now running up 
against a problem with a renamed/moved file.

I moved a file from a directory to a subdirectory, and made minimal 
changes to this file so that it remained a valid Java class. i.e. I 
changed the package, and a few other minor things. As can be seen at 
<http://dawes.za.net/gitweb.cgi?p=rogan/webgoat/webgoat.git;a=commitdiff;h=486416188a3e49d60e1510166ac197e5e66cc4d2>, 
  git detects the rename with 93% similarity.

However, when I try to push this change to the Google repo, git-svn dies 
with the following error:

$ git svn dcommit
RA layer request failed: PROPFIND request failed on '/svn/trunk/ 
webgoat/main/project/JavaSource/org/owasp/webgoat/lessons/DefaultLessonAction.java': 
PROPFIND of '/svn/trunk/ 
webgoat/main/project/JavaSource/org/owasp/webgoat/lessons/DefaultLessonAction.java': 
400 Bad Request (https://webgoat.googlecode.com) at 
/home/rdawes/bin/git-svn line 400

[Yes, those paths have a space in them, however this does not seem to 
have prevented me from committing the previous 20 or so changes.]

I noted the following in the git-svn documentation, with regards to 
handling renames. However, I am not renaming a directory, only a couple 
of files.

---- quote ----
BUGS
----

We ignore all SVN properties except svn:executable.  Any unhandled
properties are logged to $GIT_DIR/svn/<refname>/unhandled.log

Renamed and copied directories are not detected by git and hence not
tracked when committing to SVN.  I do not plan on adding support for
this as it's quite difficult and time-consuming to get working for all
the possible corner cases (git doesn't do it, either).  Committing
renamed and copied files are fully supported if they're similar enough
for git to detect them.
---- end quote ----

This is using the latest git as of today:

$ git --version
git version 1.5.3.rc0.81.g1ed84

Any ideas?

Thanks

Rogan
