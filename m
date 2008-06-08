From: "Sverre Rabbelier" <sverre@rabbelier.nl>
Subject: [PATCH 2/3] A simple script to parse the results from the testcases
Date: Sun,  8 Jun 2008 16:04:34 +0200
Message-ID: <1212933875-29947-2-git-send-email-sverre@rabbelier.nl>
References: <1212933875-29947-1-git-send-email-sverre@rabbelier.nl>
Cc: Miklos Vajna <vmiklos@frugalware.org>
To: "Git list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 08 16:32:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5LwC-0004Rw-53
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 16:32:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756164AbYFHOau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 10:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756156AbYFHOat
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 10:30:49 -0400
Received: from olive.qinip.net ([62.100.30.40]:58496 "EHLO olive.qinip.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756066AbYFHOap (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 10:30:45 -0400
Received: from localhost.localdomain (h8922088209.dsl.speedlinq.nl [89.220.88.209])
	by olive.qinip.net (Postfix) with ESMTP id 5D9AAFBE3;
	Sun,  8 Jun 2008 16:04:14 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1.214.g82ce2.dirty
In-Reply-To: <1212933875-29947-1-git-send-email-sverre@rabbelier.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84271>

From: Miklos Vajna <vmiklos@frugalware.org>

This is a simple script that aggregates key:value pairs in a file.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 t/aggregate-results.sh |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)
 create mode 100755 t/aggregate-results.sh

diff --git a/t/aggregate-results.sh b/t/aggregate-results.sh
new file mode 100755
index 0000000..9e4322c
--- /dev/null
+++ b/t/aggregate-results.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+
+input="test-results"
+
+fixed=0
+success=0
+failed=0
+broken=0
+total=0
+
+while read type value
+do
+	case $type in
+	'')
+		continue ;;
+	fixed)	
+		fixed=$(($fixed + $value)) ;;
+	success)	
+		success=$(($success + $value)) ;;
+	failed)	
+		failed=$(($failed + $value)) ;;
+	broken)	
+		broken=$(( $broken + $value)) ;;
+	total)	
+		total=$(( $total + $value)) ;;
+	esac
+done < $input
+
+printf "%-8s%d\n" fixed $fixed
+printf "%-8s%d\n" success $success
+printf "%-8s%d\n" failed $failed
+printf "%-8s%d\n" broken $broken
+printf "%-8s%d\n" total $total
-- 
1.5.5.1.214.g82ce2.dirty
