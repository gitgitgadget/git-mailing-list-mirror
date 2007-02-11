From: Sergey Vlasov <vsu@altlinux.ru>
Subject: gitk: Fix restoring of pane sizes
Date: Sun, 11 Feb 2007 19:58:32 +0300
Message-ID: <117121311393-git-send-email-vsu@altlinux.ru>
References: <20070211195643.b1f548f2.vsu@altlinux.ru>
Cc: git@vger.kernel.org, Sergey Vlasov <vsu@altlinux.ru>
To: Mark Levedahl <mdl123@verizon.net>,
	Junio C Hamano <junkio@cox.net>,
	Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Feb 11 17:59:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGI2o-0004LP-2F
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 17:59:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbXBKQ6r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 11:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbXBKQ6r
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 11:58:47 -0500
Received: from master.altlinux.org ([62.118.250.235]:2040 "EHLO
	master.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbXBKQ6p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 11:58:45 -0500
Received: by master.altlinux.org (Postfix, from userid 584)
	id 8C642E3F5D; Sun, 11 Feb 2007 19:58:44 +0300 (MSK)
X-Mailer: git-send-email 1.5.0.rc4.50.g403de
In-Reply-To: <20070211195643.b1f548f2.vsu@altlinux.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39295>

At least on Linux with Tk 8.4.13 gitk always came up with default pane
sizes, even though they were previously saved in ~/.gitk.  Apparently
setting width and height of frames in these panes when creating them
is not enough, and an explicit paneconfigure call is needed.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
---
 gitk |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index df1ce8c..7e6ee56 100755
--- a/gitk
+++ b/gitk
@@ -577,6 +577,7 @@ proc makewindow {} {
     pack .tf.bar -in .tf -side bottom -fill x
     pack .tf.histframe -fill both -side top -expand 1
     .ctop add .tf
+    .ctop paneconfigure .tf -height $geometry(topheight)
 
     # now build up the bottom
     panedwindow .pwbottom -orient horizontal
@@ -638,6 +639,7 @@ proc makewindow {} {
     $ctext tag conf found -back yellow
 
     .pwbottom add .bleft
+    .pwbottom paneconfigure .bleft -width $geometry(botwidth)
 
     # lower right
     frame .bright
-- 
1.5.0.rc4.50.g403de
