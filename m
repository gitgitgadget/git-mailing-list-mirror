From: freku045@student.liu.se
Subject: [PATCH 4/25] git-cherry: Print the usage message if we get an unknown option.
Date: Sat, 10 Dec 2005 20:37:57 +0100
Message-ID: <11342434771080-git-send-email-freku045@student.liu.se>
References: <1134243476675-git-send-email-freku045@student.liu.se>
Reply-To: freku045@student.liu.se
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Sat Dec 10 20:38:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElAXy-0002Gb-W6
	for gcvg-git@gmane.org; Sat, 10 Dec 2005 20:38:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161044AbVLJTiJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 14:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161032AbVLJTiI
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 14:38:08 -0500
Received: from [85.8.31.11] ([85.8.31.11]:13773 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S965044AbVLJTiG (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Dec 2005 14:38:06 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 613034114; Sat, 10 Dec 2005 20:48:14 +0100 (CET)
Received: from c165 ([127.0.0.1])
	by c165 with smtp (Exim 3.36 #1 (Debian))
	id 1ElAXd-0006yu-00; Sat, 10 Dec 2005 20:37:57 +0100
In-Reply-To: <1134243476675-git-send-email-freku045@student.liu.se>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13446>

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 git-cherry.sh |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

10b829123619b4b3c398398726c830db87f7525a
diff --git a/git-cherry.sh b/git-cherry.sh
index 867522b..c21cf65 100755
--- a/git-cherry.sh
+++ b/git-cherry.sh
@@ -5,7 +5,8 @@
 
 . git-sh-setup
 
-usage="usage: $0 "'[-v] <upstream> [<head>]
+usage () {
+    die "usage: $0 "'[-v] <upstream> [<head>]
 
              __*__*__*__*__> <upstream>
             /
@@ -18,8 +19,19 @@ compared against the change each commit 
 it is shown on the standard output with prefix "+".  Otherwise
 it is shown with prefix "-".
 '
+}
 
-case "$1" in -v) verbose=t; shift ;; esac 
+while [ "$#" != "0" ]; do
+    case "$1" in
+        "-v")
+            verbose=t;
+            shift
+            ;;
+        -*)
+            usage
+            ;;
+    esac
+done
 
 case "$#,$1" in
 1,*..*)
@@ -35,7 +47,7 @@ case "$#" in
 2) upstream=`git-rev-parse --verify "$1"` &&
    ours=`git-rev-parse --verify "$2"` || exit
    ;;
-*) echo >&2 "$usage"; exit 1 ;;
+*) usage ;;
 esac
 
 # Note that these list commits in reverse order;
-- 
0.99.9.GIT
