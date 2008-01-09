From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH] Fix the MacOS X compile of gitk by pinching po2msg.sh from git-gui
Date: Wed, 9 Jan 2008 13:29:53 +0000
Message-ID: <20080109132953.GA12489@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 14:30:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCb0p-0000t9-RL
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 14:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbYAINaD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 08:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbYAINaB
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 08:30:01 -0500
Received: from ptb-relay03.plus.net ([212.159.14.214]:45572 "EHLO
	ptb-relay03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920AbYAINaA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 08:30:00 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay03.plus.net with esmtp (Exim) id 1JCb0H-0007N3-Qz
	for git@vger.kernel.org; Wed, 09 Jan 2008 13:29:58 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m09DTssQ012811
	for <git@vger.kernel.org>; Wed, 9 Jan 2008 13:29:54 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m09DTsDx012810
	for git@vger.kernel.org; Wed, 9 Jan 2008 13:29:54 GMT
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69988>

Make the behaviour of a top level make NO_MSGFMT=Yes consistent when
performing the subdirectory builds in gitk-git and git-gui.

Signed-off-by: Charles Bailey <charles@hashpling.org>
---
 gitk-git/Makefile                   |    7 ++++++-
 {git-gui => gitk-git}/po/.gitignore |    0 
 {git-gui => gitk-git}/po/po2msg.sh  |    0 
 3 files changed, 6 insertions(+), 1 deletions(-)
 copy {git-gui => gitk-git}/po/.gitignore (100%)
 copy {git-gui => gitk-git}/po/po2msg.sh (100%)

diff --git a/gitk-git/Makefile b/gitk-git/Makefile
index 6158504..ae2b80b 100644
--- a/gitk-git/Makefile
+++ b/gitk-git/Makefile
@@ -18,7 +18,12 @@ TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
 
 ## po-file creation rules
 XGETTEXT   ?= xgettext
-MSGFMT     ?= msgfmt
+ifdef NO_MSGFMT
+	MSGFMT ?= $(TCL_PATH) po/po2msg.sh
+else
+	MSGFMT ?= msgfmt
+endif
+
 PO_TEMPLATE = po/gitk.pot
 ALL_POFILES = $(wildcard po/*.po)
 ALL_MSGFILES = $(subst .po,.msg,$(ALL_POFILES))
diff --git a/git-gui/po/.gitignore b/gitk-git/po/.gitignore
similarity index 100%
copy from git-gui/po/.gitignore
copy to gitk-git/po/.gitignore
diff --git a/git-gui/po/po2msg.sh b/gitk-git/po/po2msg.sh
similarity index 100%
copy from git-gui/po/po2msg.sh
copy to gitk-git/po/po2msg.sh
-- 
1.5.4.rc2.60.gb2e62
