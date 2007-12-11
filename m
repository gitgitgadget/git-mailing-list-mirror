From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] Adding menu for Emacs git.el
Date: Tue, 11 Dec 2007 14:02:00 +0100
Message-ID: <878x41idvb.fsf@wine.dyndns.org>
References: <87mysvfr7e.dlv@vanicat.homelinux.org>
	<87fxylos4o.fsf@wine.dyndns.org>
	<877ijwfh6z.dlv@vanicat.homelinux.org>
	<7vhciphh4k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Remi Vanicat <vanicat@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 14:02:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J24l9-0004Wf-E3
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 14:02:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbXLKNCO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Dec 2007 08:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbXLKNCN
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 08:02:13 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:34790 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803AbXLKNCM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Dec 2007 08:02:12 -0500
Received: from adsl-89-217-159-121.adslplus.ch ([89.217.159.121] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1J24kN-0004YL-A9; Tue, 11 Dec 2007 07:02:09 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 82F9A1E713B; Tue, 11 Dec 2007 14:02:00 +0100 (CET)
In-Reply-To: <7vhciphh4k.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 10 Dec 2007 22:36:59 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Spam-Score: -3.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67850>

Junio C Hamano <gitster@pobox.com> writes:

> Alex, what is the current status of this patch?

Patch v3 looked good but the patch file was corrupted. Here's the lates=
t
version, I have moved things around a bit to use only one menu and to b=
e
more similar to pcl-cvs.

=46rom 0a67dfc88a8bbf479c37ba76521ebe39fa67f577 Mon Sep 17 00:00:00 200=
1
=46rom: Alexandre Julliard <julliard@winehq.org>
Date: Tue, 11 Dec 2007 13:56:09 +0100
Subject: [PATCH] git.el: Added a menu for git-status-mode.
MIME-Version: 1.0
Content-Type: text/plain; charset=3Dutf-8
Content-Transfer-Encoding: 8bit

Originally written by R=C3=A9mi Vanicat, I just changed the layout a li=
ttle.

Signed-off-by: R=C3=A9mi Vanicat <vanicat@debian.org>
Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |   43 ++++++++++++++++++++++++++++++++++++++++++=
-
 1 files changed, 42 insertions(+), 1 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index e147da0..ae58f1c 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -49,6 +49,7 @@
 (eval-when-compile (require 'cl))
 (require 'ewoc)
 (require 'log-edit)
+(require 'easymenu)
=20
=20
 ;;;; Customizations
@@ -1297,7 +1298,47 @@ Return the list of files that haven't been handl=
ed."
     (define-key toggle-map "i" 'git-toggle-show-ignored)
     (define-key toggle-map "k" 'git-toggle-show-unknown)
     (define-key toggle-map "m" 'git-toggle-all-marks)
-    (setq git-status-mode-map map)))
+    (setq git-status-mode-map map))
+  (easy-menu-define git-menu git-status-mode-map
+    "Git Menu"
+    `("Git"
+      ["Refresh" git-refresh-status t]
+      ["Commit" git-commit-file t]
+      ("Merge"
+        ["Next Unmerged File" git-next-unmerged-file t]
+        ["Prev Unmerged File" git-prev-unmerged-file t]
+        ["Mark as Resolved" git-resolve-file t]
+        ["Interactive Merge File" git-find-file-imerge t]
+        ["Diff Against Common Base File" git-diff-file-base t]
+        ["Diff Combined" git-diff-file-combined t]
+        ["Diff Against Merge Head" git-diff-file-merge-head t]
+        ["Diff Against Mine" git-diff-file-mine t]
+        ["Diff Against Other" git-diff-file-other t])
+      "--------"
+      ["Add File" git-add-file t]
+      ["Revert File" git-revert-file t]
+      ["Ignore File" git-ignore-file t]
+      ["Remove File" git-remove-file t]
+      "--------"
+      ["Find File" git-find-file t]
+      ["View File" git-view-file t]
+      ["Diff File" git-diff-file t]
+      ["Interactive Diff File" git-diff-file-idiff t]
+      ["Log" git-log-file t]
+      "--------"
+      ["Mark" git-mark-file t]
+      ["Mark All" git-mark-all t]
+      ["Unmark" git-unmark-file t]
+      ["Unmark All" git-unmark-all t]
+      ["Toggle All Marks" git-toggle-all-marks t]
+      ["Hide Handled Files" git-remove-handled t]
+      "--------"
+      ["Show Uptodate Files" git-toggle-show-uptodate :style toggle :s=
elected git-show-uptodate]
+      ["Show Ignored Files" git-toggle-show-ignored :style toggle :sel=
ected git-show-ignored]
+      ["Show Unknown Files" git-toggle-show-unknown :style toggle :sel=
ected git-show-unknown]
+      "--------"
+      ["Quit" git-status-quit t])))
+
=20
 ;; git mode should only run in the *git status* buffer
 (put 'git-status-mode 'mode-class 'special)
--=20
1.5.3.7.959.gdf7e-dirty

--=20
Alexandre Julliard
julliard@winehq.org
