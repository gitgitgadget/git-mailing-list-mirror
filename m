From: Remi Vanicat <vanicat@debian.org>
Subject: Re: [PATCH] Adding menu for Emacs git.el
Date: Mon, 03 Dec 2007 07:03:32 +0100
Message-ID: <877ijwfh6z.dlv@vanicat.homelinux.org>
References: <87mysvfr7e.dlv@vanicat.homelinux.org>
 <87fxylos4o.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Mon Dec 03 07:04:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz4Pj-0005Sp-Ko
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 07:04:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbXLCGDu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Dec 2007 01:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbXLCGDu
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 01:03:50 -0500
Received: from sp604001mt.neufgp.fr ([84.96.92.60]:45625 "EHLO Smtp.neuf.fr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751479AbXLCGDt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Dec 2007 01:03:49 -0500
Received: from vanicat.homelinux.org ([77.198.160.187])
 by sp604001mt.gpm.neuf.ld
 (Sun Java System Messaging Server 6.2-5.05 (built Feb 16 2006))
 with ESMTP id <0JSG00EY8M5XOWO1@sp604001mt.gpm.neuf.ld> for
 git@vger.kernel.org; Mon, 03 Dec 2007 07:03:33 +0100 (CET)
Received: from moi by vanicat.homelinux.org with local (Exim 4.68)
	(envelope-from <remi.vanicat@laposte.net>)	id 1Iz4Oy-0003xA-Oj; Mon,
 03 Dec 2007 07:03:32 +0100
In-reply-to: <87fxylos4o.fsf@wine.dyndns.org>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: remi.vanicat@laposte.net
X-SA-Exim-Scanned: No (on vanicat.homelinux.org); SAEximRunCond expanded to
 false
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66869>


Adding three menus to the git-status-mode of git.el : One for marking
and unmarking, one for what you do when you have a conflict, and the
other one for all the rest.

Signed-off-by: R=C3=A9mi Vanicat <vanicat@debian.org>
---

Alexandre Julliard <julliard@winehq.org> writes:

> "=3D?utf-8?q?R=3DC3=3DA9mi=3D20Vanicat?=3D" <vanicat@debian.org>, Rem=
i Vanicat
> <vanicat@debian.org> writes:
>
>> Adding three menu to the git-status-mode of git.el : One for marking
>> and unmarking, one for every thing you need when you have a conflict=
,
>> and a last one for all the rest.
>>
>> Signed-off-by: R=C3=A9mi Vanicat <vanicat@debian.org>
>
> It looks good to me. A couple of minor details:

Here is the corrected patch
[...]

> BTW do you have a copyright assignment for Emacs?
No, should I seek one ?

 contrib/emacs/git.el |   48 ++++++++++++++++++++++++++++++++++++++++++=
++++--
 1 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index e147da0..1db7698 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -49,7 +49,7 @@
 (eval-when-compile (require 'cl))
 (require 'ewoc)
 (require 'log-edit)
-
+(require 'easymenu)
=20
 ;;;; Customizations
 ;;;; ------------------------------------------------------------
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
+      ["Interactive Merge File" git-find-file-imerge t]
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
+      ["Show Ignored" git-toggle-show-ignored :style toggle :selected =
git-show-ignored]
+      ["Show Unknown" git-toggle-show-unknown :style toggle :selected =
git-show-unknown]))
+   =20
+)
=20
 ;; git mode should only run in the *git status* buffer
 (put 'git-status-mode 'mode-class 'special)
--=20
1.5.3.6
