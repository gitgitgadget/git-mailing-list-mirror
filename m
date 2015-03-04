From: Max Kirillov <max@max630.net>
Subject: [PATCH v5 2/3] gitk: report file saving error
Date: Wed,  4 Mar 2015 05:58:17 +0200
Message-ID: <1425441498-29416-3-git-send-email-max@max630.net>
References: <1425441498-29416-1-git-send-email-max@max630.net>
Cc: git@vger.kernel.org, Max Kirillov <max@max630.net>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Mar 04 04:58:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT0SC-0000uj-Pt
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 04:58:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757999AbbCDD6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 22:58:30 -0500
Received: from p3plsmtpa09-10.prod.phx3.secureserver.net ([173.201.193.239]:53358
	"EHLO p3plsmtpa09-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757594AbbCDD61 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2015 22:58:27 -0500
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa09-10.prod.phx3.secureserver.net with 
	id zFyH1p00U5B68XE01FyS2o; Tue, 03 Mar 2015 20:58:27 -0700
X-Mailer: git-send-email 2.1.1.391.g7a54a76
In-Reply-To: <1425441498-29416-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264718>

Signed-off-by: Max Kirillov <max@max630.net>
---
 gitk | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/gitk b/gitk
index 5f09756..9404d5d 100755
--- a/gitk
+++ b/gitk
@@ -2811,7 +2811,7 @@ proc savestuff {w} {
 
     if {$stuffsaved} return
     if {![winfo viewable .]} return
-    catch {
+    if {[catch {
 	if {[file exists $config_file_tmp]} {
 	    file delete -force $config_file_tmp
 	}
@@ -2877,6 +2877,8 @@ proc savestuff {w} {
 	puts $f "}"
 	close $f
 	file rename -force $config_file_tmp $config_file
+    } err]} {
+        puts "Error saving config: $err"
     }
     set stuffsaved 1
 }
-- 
2.1.1.391.g7a54a76
