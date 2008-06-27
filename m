From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [RFC/PATCH] Documentation: Don't assume git-sh-setup
 and git-parse-remote are in the PATH
Date: Fri, 27 Jun 2008 15:10:01 -0500 (CDT)
Message-ID: <20080627151001.BIA19424@m4500-01.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 27 22:11:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCKHt-0005yB-6n
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 22:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759788AbYF0UKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 16:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759623AbYF0UKG
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 16:10:06 -0400
Received: from smtp00.uchicago.edu ([128.135.12.76]:36195 "EHLO
	smtp00.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759592AbYF0UKF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 16:10:05 -0400
Received: from m4500-01.uchicago.edu (m4500-01.uchicago.edu [128.135.249.211])
	by smtp00.uchicago.edu (8.13.8/8.13.8) with ESMTP id m5RKA4mY008418
	for <git@vger.kernel.org>; Fri, 27 Jun 2008 15:10:06 -0500
Received: (from m4500-01.uchicago.edu [128.135.249.215])
	by m4500-01.uchicago.edu (MOS 3.8.5-GA)
	with HTTP/1.1 id BIA19424 (AUTH jrnieder@uchicago.edu);
	Fri, 27 Jun 2008 15:10:01 -0500 (CDT)
X-Mailer: Mirapoint Webmail Direct 3.8.5-GA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86627>

Starting with Git 1.5.4, use of dashed forms of git commands in
scripts without "PATH=$(git --exec-path):$PATH" was deprecated. Thus
we generally advertise the non-dashed forms of commands. git-sh-setup
and git-parse-remote do not have non-dashed forms because they are
meant to be sourced from a script using .; thus the only recommended
way to use them is by updating PATH first. This patch changes the
documentation accordingly.

This does not matter as much for releases before 1.6.0, because
by default the GIT_EXEC_PATH is in the PATH already.

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
---

 I wrote:

 > I wanted to just change the ". git-sh-setup" line to ". git sh-setup",
 > but of course that will not work. Am I missing something?

 Yes, I am.

 I do not have asciidoc installed, so this patch is completely untested.

 Documentation/git-parse-remote.txt |    2 ++
 Documentation/git-sh-setup.txt     |    3 ++-
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-parse-remote.txt b/Documentation/git-parse-remote.txt
index 951dbd6..56d0505 100644
--- a/Documentation/git-parse-remote.txt
+++ b/Documentation/git-parse-remote.txt
@@ -8,6 +8,8 @@ git-parse-remote - Routines to help parsing remote repository access
 
 SYNOPSIS
 --------
+[verse]
+'PATH=$(git --exec-path):$PATH'
 '. git-parse-remote'
 
 DESCRIPTION
diff --git a/Documentation/git-sh-setup.txt b/Documentation/git-sh-setup.txt
index c543170..95b0c13 100644
--- a/Documentation/git-sh-setup.txt
+++ b/Documentation/git-sh-setup.txt
@@ -7,7 +7,8 @@ git-sh-setup - Common git shell script setup code
 
 SYNOPSIS
 --------
-'git-sh-setup'
+'PATH=$(git --exec-path):$PATH'
+'. git-sh-setup'
 
 DESCRIPTION
 -----------
-- 
1.5.5.GIT
