From: "Robin H\. Johnson" <robbat2@gentoo.org>
Subject: [PATCH 2/2] Add testcase for format-patch --subject-prefix (take 3)
Date: Wed, 11 Apr 2007 16:58:08 -0700
Message-ID: <11763358881541-git-send-email-robbat2@gentoo.org>
References: <11763358884124-git-send-email-robbat2@gentoo.org> <1176335888349-git-send-email-robbat2@gentoo.org>
Cc: junkio@cox.net, Robin@orbis-terrarum.net,
	H.Johnson@orbis-terrarum.net, <robbat2@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 12 01:58:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hbmhh-0007j8-Fl
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 01:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbXDKX6O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 19:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbXDKX6O
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 19:58:14 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:40819 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932247AbXDKX6M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 19:58:12 -0400
Received: (qmail 26199 invoked from network); 11 Apr 2007 23:58:11 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Wed, 11 Apr 2007 23:58:11 +0000
Received: (qmail 15432 invoked from network); 11 Apr 2007 16:58:35 -0700
Received: from buck-int.local.orbis-terrarum.net (HELO buck-int.orbis-terrarum.net) (172.16.9.3)
  by curie-int-1.local.orbis-terrarum.net with SMTP; 11 Apr 2007 16:58:35 -0700
Received: (nullmailer pid 26915 invoked by uid 0);
	Wed, 11 Apr 2007 23:58:08 -0000
X-Mailer: git-send-email 1.5.1
In-Reply-To: <1176335888349-git-send-email-robbat2@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44283>

From: Robin H. Johnson <robbat2@gentoo.org>

Add testcase for format-patch --subject-prefix support.

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
---
 t/t4013-diff-various.sh                            |    1 +
 ...tdout_--subject-prefix=TESTCASE_initial..master |  164 ++++++++++++++++++++
 2 files changed, 165 insertions(+), 0 deletions(-)
 create mode 100644 t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..master

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 488e075..8f4c29a 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -241,6 +241,7 @@ format-patch --attach --stdout initial..master
 format-patch --inline --stdout initial..side
 format-patch --inline --stdout initial..master^
 format-patch --inline --stdout initial..master
+format-patch --inline --stdout --subject-prefix=TESTCASE initial..master
 
 diff --abbrev initial..side
 diff -r initial..side
diff --git a/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..master b/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..master
new file mode 100644
index 0000000..a8093be
--- /dev/null
+++ b/t/t4013/diff.format-patch_--inline_--stdout_--subject-prefix=TESTCASE_initial..master
@@ -0,0 +1,164 @@
+$ git format-patch --inline --stdout --subject-prefix=TESTCASE initial..master
+From 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44 Mon Sep 17 00:00:00 2001
+From: A U Thor <author@example.com>
+Date: Mon, 26 Jun 2006 00:01:00 +0000
+Subject: [TESTCASE] Second
+MIME-Version: 1.0
+Content-Type: multipart/mixed; boundary="------------g-i-t--v-e-r-s-i-o-n"
+
+This is a multi-part message in MIME format.
+--------------g-i-t--v-e-r-s-i-o-n
+Content-Type: text/plain; charset=UTF-8; format=fixed
+Content-Transfer-Encoding: 8bit
+
+
+This is the second commit.
+---
+ dir/sub |    2 ++
+ file0   |    3 +++
+ file2   |    3 ---
+ 3 files changed, 5 insertions(+), 3 deletions(-)
+ delete mode 100644 file2
+--------------g-i-t--v-e-r-s-i-o-n
+Content-Type: text/x-patch; name="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+Content-Transfer-Encoding: 8bit
+Content-Disposition: inline; filename="1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44.diff"
+
+diff --git a/dir/sub b/dir/sub
+index 35d242b..8422d40 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -1,2 +1,4 @@
+ A
+ B
++C
++D
+diff --git a/file0 b/file0
+index 01e79c3..b414108 100644
+--- a/file0
++++ b/file0
+@@ -1,3 +1,6 @@
+ 1
+ 2
+ 3
++4
++5
++6
+diff --git a/file2 b/file2
+deleted file mode 100644
+index 01e79c3..0000000
+--- a/file2
++++ /dev/null
+@@ -1,3 +0,0 @@
+-1
+-2
+-3
+
+--------------g-i-t--v-e-r-s-i-o-n--
+
+
+
+From 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0 Mon Sep 17 00:00:00 2001
+From: A U Thor <author@example.com>
+Date: Mon, 26 Jun 2006 00:02:00 +0000
+Subject: [TESTCASE] Third
+MIME-Version: 1.0
+Content-Type: multipart/mixed; boundary="------------g-i-t--v-e-r-s-i-o-n"
+
+This is a multi-part message in MIME format.
+--------------g-i-t--v-e-r-s-i-o-n
+Content-Type: text/plain; charset=UTF-8; format=fixed
+Content-Transfer-Encoding: 8bit
+
+---
+ dir/sub |    2 ++
+ file1   |    3 +++
+ 2 files changed, 5 insertions(+), 0 deletions(-)
+ create mode 100644 file1
+--------------g-i-t--v-e-r-s-i-o-n
+Content-Type: text/x-patch; name="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+Content-Transfer-Encoding: 8bit
+Content-Disposition: inline; filename="9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0.diff"
+
+diff --git a/dir/sub b/dir/sub
+index 8422d40..cead32e 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -2,3 +2,5 @@ A
+ B
+ C
+ D
++E
++F
+diff --git a/file1 b/file1
+new file mode 100644
+index 0000000..b1e6722
+--- /dev/null
++++ b/file1
+@@ -0,0 +1,3 @@
++A
++B
++C
+
+--------------g-i-t--v-e-r-s-i-o-n--
+
+
+
+From c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a Mon Sep 17 00:00:00 2001
+From: A U Thor <author@example.com>
+Date: Mon, 26 Jun 2006 00:03:00 +0000
+Subject: [TESTCASE] Side
+MIME-Version: 1.0
+Content-Type: multipart/mixed; boundary="------------g-i-t--v-e-r-s-i-o-n"
+
+This is a multi-part message in MIME format.
+--------------g-i-t--v-e-r-s-i-o-n
+Content-Type: text/plain; charset=UTF-8; format=fixed
+Content-Transfer-Encoding: 8bit
+
+---
+ dir/sub |    2 ++
+ file0   |    3 +++
+ file3   |    4 ++++
+ 3 files changed, 9 insertions(+), 0 deletions(-)
+ create mode 100644 file3
+--------------g-i-t--v-e-r-s-i-o-n
+Content-Type: text/x-patch; name="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+Content-Transfer-Encoding: 8bit
+Content-Disposition: inline; filename="c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a.diff"
+
+diff --git a/dir/sub b/dir/sub
+index 35d242b..7289e35 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -1,2 +1,4 @@
+ A
+ B
++1
++2
+diff --git a/file0 b/file0
+index 01e79c3..f4615da 100644
+--- a/file0
++++ b/file0
+@@ -1,3 +1,6 @@
+ 1
+ 2
+ 3
++A
++B
++C
+diff --git a/file3 b/file3
+new file mode 100644
+index 0000000..7289e35
+--- /dev/null
++++ b/file3
+@@ -0,0 +1,4 @@
++A
++B
++1
++2
+
+--------------g-i-t--v-e-r-s-i-o-n--
+
+
+$
-- 
1.5.1
