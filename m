From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH v2] gitk: Use an external icon file on Windows
Date: Mon, 23 Jul 2012 08:28:22 +0200
Message-ID: <500CEF06.2030501@gmail.com>
References: <500C70AE.6050400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Pat Thoyts <patthoyts@gmail.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Jul 23 08:28:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StC8B-0006wK-Mz
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 08:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753125Ab2GWG2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 02:28:30 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:61667 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017Ab2GWG23 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 02:28:29 -0400
Received: by weyx8 with SMTP id x8so4004708wey.19
        for <git@vger.kernel.org>; Sun, 22 Jul 2012 23:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=5+Apg0TN1BiOiamSirKudK627I3uaif/8eUgzyParK8=;
        b=bT/ZLBox4P6xE0O25fg/QTo9ElI8xEIs6c1QEYWi9Cpu9rx9FXWexXNDSuyQ7VwnUv
         p7/LT4HFlWpENODp2dr3BwRjUtUM5o0ldR5lf8NCkj2F3FaeOKFYrcZQVdtuskOJ7X8T
         vg54SnhEKTPJKDer5dIlbgeh6xshJLDsqloEDF1TrtdDxt2hG8SAOqE/q81jWyhjasxV
         vjaUFuCqmBV2OpctVKAqyeXB5U3T/tAIrQvpnUGEyYQ3CSouZjbEXdpGhBy4vaM0zt6Y
         6ejzcvYD5ww07w/bZYppkygOHcu0GPGbBjR+16Kww8pWExvKMN4UAehjZY0HRt8PIpS6
         p6eA==
Received: by 10.180.98.69 with SMTP id eg5mr46180369wib.3.1343024907710;
        Sun, 22 Jul 2012 23:28:27 -0700 (PDT)
Received: from [192.168.178.22] (p5DDB0653.dip0.t-ipconnect.de. [93.219.6.83])
        by mx.google.com with ESMTPS id cu1sm15380671wib.6.2012.07.22.23.28.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 22 Jul 2012 23:28:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <500C70AE.6050400@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201908>

Git for Windows now ships with the new Git icon from git-scm.com. Use that
icon file instead of the old procedurally drawn one if it exists.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 gitk-git/gitk | 49 ++++++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 59693c0..5127e55 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -11664,7 +11664,6 @@ if { [info exists ::env(GITK_MSGSDIR)] } {
     set gitk_prefix [file dirname [file dirname [file normalize $argv0]]]
     set gitk_libdir [file join $gitk_prefix share gitk lib]
     set gitk_msgsdir [file join $gitk_libdir msgs]
-    unset gitk_prefix
 }
 
 ## Internationalization (i18n) through msgcat and gettext. See
@@ -11821,28 +11820,32 @@ if {[expr {[exec git rev-parse --is-inside-work-tree] == "true"}]} {
 set worktree [exec git rev-parse --show-toplevel]
 setcoords
 makewindow
-catch {
-    image create photo gitlogo      -width 16 -height 16
-
-    image create photo gitlogominus -width  4 -height  2
-    gitlogominus put #C00000 -to 0 0 4 2
-    gitlogo copy gitlogominus -to  1 5
-    gitlogo copy gitlogominus -to  6 5
-    gitlogo copy gitlogominus -to 11 5
-    image delete gitlogominus
-
-    image create photo gitlogoplus  -width  4 -height  4
-    gitlogoplus  put #008000 -to 1 0 3 4
-    gitlogoplus  put #008000 -to 0 1 4 3
-    gitlogo copy gitlogoplus  -to  1 9
-    gitlogo copy gitlogoplus  -to  6 9
-    gitlogo copy gitlogoplus  -to 11 9
-    image delete gitlogoplus
-
-    image create photo gitlogo32    -width 32 -height 32
-    gitlogo32 copy gitlogo -zoom 2 2
-
-    wm iconphoto . -default gitlogo gitlogo32
+if {$::tcl_platform(platform) eq {windows} && [file exists $gitk_prefix/etc/git.ico]} {
+    wm iconbitmap . -default $gitk_prefix/etc/git.ico
+} else {
+    catch {
+        image create photo gitlogo      -width 16 -height 16
+
+        image create photo gitlogominus -width  4 -height  2
+        gitlogominus put #C00000 -to 0 0 4 2
+        gitlogo copy gitlogominus -to  1 5
+        gitlogo copy gitlogominus -to  6 5
+        gitlogo copy gitlogominus -to 11 5
+        image delete gitlogominus
+
+        image create photo gitlogoplus  -width  4 -height  4
+        gitlogoplus  put #008000 -to 1 0 3 4
+        gitlogoplus  put #008000 -to 0 1 4 3
+        gitlogo copy gitlogoplus  -to  1 9
+        gitlogo copy gitlogoplus  -to  6 9
+        gitlogo copy gitlogoplus  -to 11 9
+        image delete gitlogoplus
+
+        image create photo gitlogo32    -width 32 -height 32
+        gitlogo32 copy gitlogo -zoom 2 2
+
+        wm iconphoto . -default gitlogo gitlogo32
+    }
 }
 # wait for the window to become visible
 tkwait visibility .
-- 
1.7.11.msysgit.2
