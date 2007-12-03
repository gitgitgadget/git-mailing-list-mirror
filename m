From: Remi Vanicat <vanicat@debian.org>
Subject: [PATCH v3] Adding menus for Emacs git.el
Date: Mon, 03 Dec 2007 22:06:14 +0100
Message-ID: <87mysr32ux.dlv_-_@vanicat.homelinux.org>
References: <87mysvfr7e.dlv@vanicat.homelinux.org>
 <87fxylos4o.fsf@wine.dyndns.org> <877ijwfh6z.dlv@vanicat.homelinux.org>
 <87ir3f4s76.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Mon Dec 03 22:10:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzIYQ-00061T-9B
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 22:10:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbXLCVJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 16:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbXLCVJw
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 16:09:52 -0500
Received: from sp604003mt.neufgp.fr ([84.96.92.56]:45445 "EHLO smTp.neuf.fr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750709AbXLCVJv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 16:09:51 -0500
Received: from vanicat.homelinux.org ([77.198.160.187])
 by sp604003mt.gpm.neuf.ld
 (Sun Java System Messaging Server 6.2-5.05 (built Feb 16 2006))
 with ESMTP id <0JSH00EGRRYENJ10@sp604003mt.gpm.neuf.ld> for
 git@vger.kernel.org; Mon, 03 Dec 2007 22:06:30 +0100 (CET)
Received: from moi by vanicat.homelinux.org with local (Exim 4.68)
	(envelope-from <remi.vanicat@laposte.net>)	id 1IzIUY-00055j-3b; Mon,
 03 Dec 2007 22:06:14 +0100
In-reply-to: <87ir3f4s76.fsf@wine.dyndns.org>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: remi.vanicat@laposte.net
X-SA-Exim-Scanned: No (on vanicat.homelinux.org); SAEximRunCond expanded to
 false
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66957>

Adding three menus to the git-status-mode of git.el : One for marking
and unmarking, one for what you do when you have a conflict, and the
other one for all the rest.
---
Alexandre Julliard <julliard@winehq.org> writes:

> Remi Vanicat <vanicat@debian.org> writes:
>> +      ["Interctive Diff File" git-diff-file-idiff t]
>
> The typo is still here.

Pff, The typo was in two place, and I forgot to check this... 

This time, I have run a spell checker on every menu entries, to be
sure. 
 contrib/emacs/git.el |   48 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index e147da0..7fbea55 100644
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
+    "Git Menu." 
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
+      ["Interactive Diff File" git-diff-file-idiff t]
+      ["Log" git-log-file t]
+      "--------"
+      ["Quit" git-status-quit t]
+      "--------"
+      ["Show Uptodate" git-toggle-show-uptodate :style toggle :selected git-show-uptodate]
+      ["Show Ignored" git-toggle-show-ignored :style toggle :selected git-show-ignored]
+      ["Show Unknown" git-toggle-show-unknown :style toggle :selected git-show-unknown]))
+    
+)
 
 ;; git mode should only run in the *git status* buffer
 (put 'git-status-mode 'mode-class 'special)
-- 
1.5.3.6
