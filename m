From: "martin f. krafft" <madduck@madduck.net>
Subject: [PATCH] clarify need for init in git-submodules documentation
Date: Thu, 16 Aug 2007 20:10:02 +0200
Message-ID: <11872878021267-git-send-email-madduck@madduck.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 16 20:10:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILjnz-00026Y-GQ
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 20:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761355AbXHPSKO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 14:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761383AbXHPSKO
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 14:10:14 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:45817 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760761AbXHPSKM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 14:10:12 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id AEE85895D99
	for <git@vger.kernel.org>; Thu, 16 Aug 2007 20:10:04 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 20542-09 for <git@vger.kernel.org>;
	Thu, 16 Aug 2007 20:10:04 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 4B143895D8B
	for <git@vger.kernel.org>; Thu, 16 Aug 2007 20:10:04 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 565FF9F171
	for <git@vger.kernel.org>; Thu, 16 Aug 2007 20:10:03 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id A293743F9; Thu, 16 Aug 2007 20:10:02 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.rc5.1.g44065
In-Reply-To: 200708161553.10991.Josef.Weidendorfer@gmx.de
References: 200708161553.10991.Josef.Weidendorfer@gmx.de
In-Reply-To: <200708161553.10991.Josef.Weidendorfer@gmx.de>
References: <200708161553.10991.Josef.Weidendorfer@gmx.de>
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56027>

As per the discussion in this thread:

  http://marc.info/?t=118721709500008&r=1&w=2

this patch updates the git-submodules documentation to make the situation a bit clearer.

Signed-off-by: martin f. krafft <madduck@madduck.net>
---
 Documentation/git-submodule.txt |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 2c48936..b1a4f95 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -32,15 +32,17 @@ status::
 	repository. This command is the default command for git-submodule.
 
 init::
-	Initialize the submodules, i.e. register in .git/config each submodule
-	name and url found in .gitmodules. The key used in .git/config is
-	`submodule.$name.url`. This command does not alter existing information
-	in .git/config.
+	Initialize the submodules, i.e. register in $GIT_DIR/config each
+	submodule name and url found in .gitmodules. The key used in
+	$GIT_DIR/config is `submodule.$name.url`. This command does not alter
+	existing information in $GIT_DIR/config, it only serves to initialise
+	the local configuration from the defaults in .gitmodules.
 
 update::
-	Update the registered submodules, i.e. clone missing submodules and
-	checkout the commit specified in the index of the containing repository.
-	This will make the submodules HEAD be detached.
+	Update the submodules registered in $GIT_DIR/config, i.e. clone
+	missing submodules and checkout the commit specified in the index of
+	the containing repository. This will make the submodules HEAD be
+	detached.
 
 
 OPTIONS
@@ -64,9 +66,14 @@ FILES
 -----
 When initializing submodules, a .gitmodules file in the top-level directory
 of the containing repository is used to find the url of each submodule.
-This file should be formatted in the same way as $GIR_DIR/config. The key
+This file should be formatted in the same way as $GIT_DIR/config. The key
 to each submodule url is "submodule.$name.url".
 
+The file .gitmodules serves default configuration data to users who cloned the
+repository. In order to work with submodules, these data need to be copied to
+$GIT_DIR/config with `git-submodule init`. Only the data in $GIT_DIR/config
+are used for `git-submodule update`.
+
 
 AUTHOR
 ------
-- 
1.5.3.rc5.1.g44065
