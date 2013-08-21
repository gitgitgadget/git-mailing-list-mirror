From: Max Kirillov <max@max630.net>
Subject: [PATCH] git-gui: right half window is paned
Date: Wed, 21 Aug 2013 06:38:40 +0300
Message-ID: <20130821033822.GB6156@wheezy.local>
References: <20130821032913.GA6092@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Wed Aug 21 05:38:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBzFv-0006UA-V1
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 05:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175Ab3HUDio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 23:38:44 -0400
Received: from m1plsmtpa01-01.prod.mesa1.secureserver.net ([64.202.165.173]:37600
	"EHLO m1plsmtpa01-01.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752085Ab3HUDin (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 23:38:43 -0400
Received: from wheezy.local ([89.27.29.195])
	by m1plsmtpa01-01.prod.mesa1.secureserver.net with 
	id FFec1m00c4CavkR01Feiu6; Tue, 20 Aug 2013 20:38:43 -0700
Content-Disposition: inline
In-Reply-To: <20130821032913.GA6092@wheezy.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232684>

For long descriptions it would be nice to be able to resize
the comment text field.

Signed-off-by: Max Kirillov <max@max630.net>
---
 git-gui/git-gui.sh | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 89f636f..e2e710e 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -3196,13 +3196,19 @@ unset i
 
 # -- Diff and Commit Area
 #
-${NS}::frame .vpane.lower -height 300 -width 400
+${NS}::panedwindow .vpane.lower -orient vertical
 ${NS}::frame .vpane.lower.commarea
-${NS}::frame .vpane.lower.diff -relief sunken -borderwidth 1
-pack .vpane.lower.diff -fill both -expand 1
-pack .vpane.lower.commarea -side bottom -fill x
+${NS}::frame .vpane.lower.diff -relief sunken -borderwidth 1 -height 500
+.vpane.lower add .vpane.lower.diff
+.vpane.lower add .vpane.lower.commarea
 .vpane add .vpane.lower
-if {!$use_ttk} {.vpane paneconfigure .vpane.lower -sticky nsew}
+if {$use_ttk} {
+	.vpane.lower pane .vpane.lower.diff -weight 1
+	.vpane.lower pane .vpane.lower.commarea -weight 0
+} else {
+	.vpane.lower paneconfigure .vpane.lower.diff -stretch always
+	.vpane.lower paneconfigure .vpane.lower.commarea -stretch never
+}
 
 # -- Commit Area Buttons
 #
-- 
1.8.4.rc3.902.g80a4b9e
