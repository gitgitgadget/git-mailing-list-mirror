From: =?us-ascii?Q?=3D=3Futf-8=3Fq=3FR=3DC3=3DA9mi=3D20Vanicat=3F=3D?= 
	<vanicat@debian.org>
Subject: [PATCH] Adding menu for Emacs git.el
Date: Fri, 30 Nov 2007 20:29:08 +0100
Message-ID: <87mysvfr7e.dlv@vanicat.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexandre Julliard <julliard@winehq.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 30 20:51:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyBt2-0003r7-Uv
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 20:50:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752972AbXK3Tuh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Nov 2007 14:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753205AbXK3Tuh
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 14:50:37 -0500
Received: from sp604005mt.neufgp.fr ([84.96.92.11]:40111 "EHLO smtp.Neuf.fr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752420AbXK3Tug convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Nov 2007 14:50:36 -0500
Received: from vanicat.homelinux.org ([77.198.160.187])
 by sp604005mt.gpm.neuf.ld
 (Sun Java System Messaging Server 6.2-5.05 (built Feb 16 2006))
 with ESMTP id <0JSC00HA94G6H750@sp604005mt.gpm.neuf.ld> for
 git@vger.kernel.org; Fri, 30 Nov 2007 20:50:31 +0100 (CET)
Received: from moi by vanicat.homelinux.org with local (Exim 4.68)
	(envelope-from <remi.vanicat@laposte.net>)	id 1IyBsb-0006yd-I2; Fri,
 30 Nov 2007 20:50:29 +0100
From: Remi Vanicat <vanicat@debian.org>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: remi.vanicat@laposte.net
X-SA-Exim-Scanned: No (on vanicat.homelinux.org); SAEximRunCond expanded to
 false
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66658>

Adding three menu to the git-status-mode of git.el : One for marking
and unmarking, one for every thing you need when you have a conflict,
and a last one for all the rest.

Signed-off-by: R=C3=A9mi Vanicat <vanicat@debian.org>
---
This use easymenu.

 contrib/emacs/git.el |   46 ++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 files changed, 45 insertions(+), 1 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index e147da0..f41b2ef 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -1297,7 +1297,51 @@ Return the list of files that haven't been handl=
ed."
     (define-key toggle-map "i" 'git-toggle-show-ignored)
     (define-key toggle-map "k" 'git-toggle-show-unknown)
     (define-key toggle-map "m" 'git-toggle-all-marks)
-    (setq git-status-mode-map map)))
+    (setq git-status-mode-map map))
+  (easy-menu-define git-menu-mark git-status-mode-map
+    "Git Merge Menu"
+    `("Merge"
+      ["Next Unmerged File" git-next-unmerged-file t]
+      ["Prev Unmerged File" git-prev-unmerged-file t]
+      ["Mark as Resolved" git-resolve-file t]
+      ["Interctive Merge File" git-find-file-imerge t]
+      ["Diff Against Common Base File" git-diff-file-base t]
+      ["Diff Combined" git-diff-file-combined t]
+      ["Diff Against Merge Head" git-diff-file-merge-head t]
+      ["Diff Against Mine" git-diff-file-mine t]
+      ["Diff Against Other" git-diff-file-other t]))
+  (easy-menu-define git-menu-mark git-status-mode-map
+    "Git Mark Menu"
+    `("Mark"
+      ["Mark File" git-mark-file t]
+      ["Mark All" git-mark-all t]
+      ["Unmark File" git-unmark-file t]
+      ["Unmark All" git-unmark-all t]
+      ["Toggle All Mark" git-toggle-all-marks t]))
+  (easy-menu-define git-menu git-status-mode-map
+    "Git Menu."=20
+    `("Git"
+      ["Refresh" git-refresh-status t]
+      ["Commit" git-commit-file t]
+      "--------"
+      ["Add File" git-add-file t]
+      ["Revert File" git-revert-file t]
+      ["Ignore File" git-ignore-file t]
+      ["Remove File" git-remove-file t]
+      "--------"
+      ["Find File" git-find-file t]
+      ["View File" git-view-file t]
+      ["Diff File" git-diff-file t]
+      ["Interctive Diff File" git-diff-file-idiff t]
+      ["Log" git-log-file t]
+      "--------"
+      ["Quit" git-status-quit t]
+      "--------"
+      ["Show Uptodate" git-toggle-show-uptodate :style toggle :selecte=
d git-show-uptodate]
+      ["Toggle Show Ignored" git-toggle-show-ignored :style toggle :se=
lected git-show-ignored]
+      ["Toggle Show Unknown" git-toggle-show-unknown :style toggle :se=
lected git-show-unknown]))
+   =20
+)
=20
 ;; git mode should only run in the *git status* buffer
 (put 'git-status-mode 'mode-class 'special)
--=20
1.5.3.6
