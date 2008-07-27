From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 1/3] git-gui: Adapt discovery of oguilib to execdir 'libexec/git-core'
Date: Sun, 27 Jul 2008 18:49:41 +0200
Message-ID: <1217177383-25272-2-git-send-email-prohaska@zib.de>
References: <1217177383-25272-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>,
	Steffen Prohaska <prohaska@zib.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jul 27 18:51:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KN9Sr-0003tv-Ug
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 18:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757326AbYG0QuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 12:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757127AbYG0QuX
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 12:50:23 -0400
Received: from mailer.zib.de ([130.73.108.11]:37021 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752611AbYG0QuW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 12:50:22 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m6RGnirU022149;
	Sun, 27 Jul 2008 18:49:53 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m6RGnhW1014519;
	Sun, 27 Jul 2008 18:49:44 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1217177383-25272-1-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90343>

The new execdir has is two levels below the root directory, while
the old execdir 'bin' was only one level below.  This commit
adapts the discovery of oguilib that uses relative paths
accordingly.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 git-gui/git-gui.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 940677c..baccd57 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -52,7 +52,9 @@ catch {rename send {}} ; # What an evil concept...
 set oguilib {@@GITGUI_LIBDIR@@}
 set oguirel {@@GITGUI_RELATIVE@@}
 if {$oguirel eq {1}} {
-	set oguilib [file dirname [file dirname [file normalize $argv0]]]
+	set oguilib [file dirname \
+	             [file dirname \
+	              [file dirname [file normalize $argv0]]]]
 	set oguilib [file join $oguilib share git-gui lib]
 	set oguimsg [file join $oguilib msgs]
 } elseif {[string match @@* $oguirel]} {
-- 
1.6.0.rc0.79.gb0320
