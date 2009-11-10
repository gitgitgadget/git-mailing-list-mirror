From: rocketraman@fastmail.fm
Subject: [PATCHv2] Update gitworkflows man page to include release workflow
Date: Tue, 10 Nov 2009 11:08:59 -0500
Message-ID: <1257869339-15999-2-git-send-email-rocketraman@fastmail.fm>
References: <1257869339-15999-1-git-send-email-rocketraman@fastmail.fm>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 10 17:16:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7tO2-0006qj-Ow
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 17:16:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757099AbZKJQPp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 11:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756939AbZKJQPn
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 11:15:43 -0500
Received: from smtp127.rog.mail.re2.yahoo.com ([206.190.53.32]:33395 "HELO
	smtp127.rog.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756967AbZKJQPi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Nov 2009 11:15:38 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Nov 2009 11:15:37 EST
Received: (qmail 75801 invoked from network); 10 Nov 2009 16:09:02 -0000
Received: from CPE000db9166236-CM00186845d2ae.cpe.net.cable.rogers.com (rocketraman@99.224.155.40 with login)
        by smtp127.rog.mail.re2.yahoo.com with SMTP; 10 Nov 2009 08:09:02 -0800 PST
X-Yahoo-SMTP: 5CKRlKeswBAtrcX.EVB04BFKSgZiN0yKOK0iylIm064Zdzo-
X-YMail-OSG: E35NlQQVM1mA2k_ZIULHgwgCh3fAJvQ5F0hSCWa5gyHKUHnDPp44rrI7LBiKVD8WCQ--
X-Yahoo-Newman-Property: ymail-3
Received: from localhost (localhost.localdomain [127.0.0.1])
	by apollo.rocketraman.com (Postfix) with ESMTP id 91B5621C05CA
	for <git@vger.kernel.org>; Tue, 10 Nov 2009 11:09:01 -0500 (EST)
X-Virus-Scanned: amavisd-new at rocketraman.com
Received: from apollo.rocketraman.com ([127.0.0.1])
	by localhost (apollo.rocketraman.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JLDnTBwfd+RS for <git@vger.kernel.org>;
	Tue, 10 Nov 2009 11:09:01 -0500 (EST)
Received: from zeus (zeus.rocketraman.com [192.168.1.5])
	by apollo.rocketraman.com (Postfix) with SMTP id 58CB321C05C8
	for <git@vger.kernel.org>; Tue, 10 Nov 2009 11:09:00 -0500 (EST)
Received: by zeus (sSMTP sendmail emulation); Tue, 10 Nov 2009 11:09:00 -0500
X-Mailer: git-send-email 1.6.2
In-Reply-To: <1257869339-15999-1-git-send-email-rocketraman@fastmail.fm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132572>

From: Raman Gupta <raman@rocketraman.com>

The gitworkflows man page currently provides an overview of the workflows
used by git.git itself to serve as inspiration for people to use when
designing their own workflows. The current man page does a reasonable
job at describing the development process, but it does not contain any
guidance as to the workflow used for releases. Now add a basic
introduction to the branch management required for a release, so that a
reader may understand how the maint, master, next, and topic branches are
affected.
---
 Documentation/gitworkflows.txt |   97 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 97 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
index 2b021e3..69b789a 100644
--- a/Documentation/gitworkflows.txt
+++ b/Documentation/gitworkflows.txt
@@ -348,6 +348,103 @@ in patches to figure out the merge base.  See linkgit:git-am[1] for
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
+=====================================
+`git tag -s -m "GIT X.Y.Z" vX.Y.Z master`
+=====================================
+
+
+Maintenance branch update
+~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Maintenance fixes for the current feature release are tracked on the
+'maint' branch.
+
+
+In order to track maintenance
+fixes to the current release, the maintainer uses a branch called
+'maint'.
+
+
+The current maintenance branch is optionally copied to another branch
+named with the older release version number (e.g. maint-X.Y.(Z-1)
+where X.Y.Z is the previous release). This allows for further
+maintenance releases on the older codebase.
+
+If the current tip of 'maint' corresponds to the previous release
+tag (i.e. that there are no fixes already pending on 'maint' that are
+intended for a maintenance release on the older codebase), then
+creating the 'maint' branch for the older codebase can also be done
+later, if it is needed.
+
+.Copy maint
+[caption="Recipe: "]
+=====================================
+`git branch maint-X.Y.(Z-1) maint`
+=====================================
+
+'maint' should now updated to the new release code so that maintenance
+fixes can be merged for the current version:
+
+.Update maint to new release
+[caption="Recipe: "]
+=====================================
+* `git checkout maint`
+* `git merge master`
+=====================================
+
+This updates 'maint' from 'master', while preserving the 'maint'
+reflog.
+
+An alternative approach to updating the 'maint' branch is to run
+
+  $ git branch -f maint master
+
+This will create a new 'maint' branch based on 'master'. If 'maint'
+already exists, it will be deleted before the new branch is created.
+Any commits on 'maint' that were not previously merged to master will
+therefore be lost and the 'maint' reflog will be reset. However, the
+branch history is "clean" and may be easier to understand.
+
+
+Update next branch
+~~~~~~~~~~~~~~~~~~
+
+The 'next' branch may be rewound and rebuilt from the tip of 'master'
+using the surviving topics on 'next'.
+
+This step is optional. If it is done by the maintainer, then a public
+announcement will be made indicating that 'next' was rewound and
+rebuilt.
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
