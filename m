From: rocketraman@fastmail.fm
Subject: [PATCH 2/2] Add feature release instructions to gitworkflows man page
Date: Wed, 25 Mar 2009 21:56:15 -0400
Message-ID: <1238032575-10987-2-git-send-email-rocketraman@fastmail.fm>
References: <1238032575-10987-1-git-send-email-rocketraman@fastmail.fm>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 02:57:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmeqw-0001rC-23
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 02:57:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753764AbZCZB4X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 21:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751992AbZCZB4W
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 21:56:22 -0400
Received: from smtp122.rog.mail.re2.yahoo.com ([206.190.53.27]:26667 "HELO
	smtp122.rog.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751204AbZCZB4V (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 21:56:21 -0400
Received: (qmail 94523 invoked from network); 26 Mar 2009 01:56:19 -0000
Received: from unknown (HELO apollo.rocketraman.com) (rocketraman@99.224.155.40 with login)
  by smtp122.rog.mail.re2.yahoo.com with SMTP; 26 Mar 2009 01:56:19 -0000
X-YMail-OSG: o5oz4cAVM1nfAnG2UWa_wNi0MZudmyBmSUE_2GDrJ1kDjE8Nu3R.Bldz5TuMzNwGsQ--
X-Yahoo-Newman-Property: ymail-3
Received: from localhost (localhost.localdomain [127.0.0.1])
	by apollo.rocketraman.com (Postfix) with ESMTP id E098F21C051A
	for <git@vger.kernel.org>; Wed, 25 Mar 2009 21:56:17 -0400 (EDT)
X-Virus-Scanned: amavisd-new at rocketraman.com
Received: from apollo.rocketraman.com ([127.0.0.1])
	by localhost (apollo.rocketraman.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GI8bYIDNYYfe for <git@vger.kernel.org>;
	Wed, 25 Mar 2009 21:56:17 -0400 (EDT)
Received: from zeus (zeus.rocketraman.com [192.168.1.5])
	by apollo.rocketraman.com (Postfix) with SMTP id B78CD21C051B
	for <git@vger.kernel.org>; Wed, 25 Mar 2009 21:56:16 -0400 (EDT)
Received: by zeus (sSMTP sendmail emulation); Wed, 25 Mar 2009 21:56:16 -0400
X-Mailer: git-send-email 1.6.2
In-Reply-To: <1238032575-10987-1-git-send-email-rocketraman@fastmail.fm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114703>

From: Raman Gupta <raman@rocketraman.com>

Based on a mailing list discussion, add a description of the workflow,
and associated commands, for creating a feature release.

Signed-off-by: Raman Gupta <raman@rocketraman.com>
---
 Documentation/gitworkflows.txt |   69 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
index 2b021e3..1796878 100644
--- a/Documentation/gitworkflows.txt
+++ b/Documentation/gitworkflows.txt
@@ -348,6 +348,75 @@ in patches to figure out the merge base.  See linkgit:git-am[1] for
 other options.
 
 
+RELEASE WORKFLOW
+----------------
+
+The maintainer may use the following release workflow:
+
+He first tags the tip of 'master' with a release tag, then he updates
+the 'maint' branch to the current tip of 'master' for managing future
+maintenance fixes on the current release, and lastly he optionally
+rebuilds 'next' from the tip of 'master'.
+
+
+Release Tagging
+~~~~~~~~~~~~~~~
+
+The new feature release is tagged on 'master' with a tag matching
+vX.Y.Z, where X.Y.Z is the new feature release version.
+
+.Release tagging
+[caption="Recipe: "]
+==========================================
+`git tag -s -m GIT "vX.Y.Z" vX.Y.Z`
+==========================================
+
+
+Maintenance branch update
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The current maintenance branch is optionally tracked with the older
+release version number to allow for further maintenance releases on
+the older codebase.
+
+.Track maint
+[caption="Recipe: "]
+=====================================
+`git branch maint-X.Y.(Z-1) maint`
+=====================================
+
+'maint' is now updated to the new release code so that maintenance
+fixes can be merged for the current version.
+
+.Update maint to new release
+[caption="Recipe: "]
+=====================================
+* `git checkout maint`
+* `git merge master`
+=====================================
+
+This is equivalent to deleting maint and recreating it from master,
+but it preserves the maint reflog.
+
+Update next branch
+~~~~~~~~~~~~~~~~~~
+
+The 'next' branch may be rebuilt from the tip of 'master' using the
+surviving topics on 'next'.
+
+This step is optional. If it is done by the maintainer, then a public
+announcement will be made indicating that 'next' was rebased.
+
+.Update maint to new release
+[caption="Recipe: "]
+=====================================
+* `git branch -f next master`
+* `git merge ai/topic_in_next1`
+* `git merge ai/topic_in_next2`
+* ...
+=====================================
+
+
 SEE ALSO
 --------
 linkgit:gittutorial[7],
-- 
1.6.2
