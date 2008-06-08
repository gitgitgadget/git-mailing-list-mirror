From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] A simple script to parse the results from the testcases
Date: Sun,  8 Jun 2008 02:18:11 +0200
Message-ID: <1212884291-13847-1-git-send-email-vmiklos@frugalware.org>
References: <1210584832-16402-3-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>, dsymonds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 08 02:19:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K58cl-0004eX-Ig
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 02:19:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754978AbYFHASO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 20:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754937AbYFHASO
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 20:18:14 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:57583 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754871AbYFHASM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 20:18:12 -0400
Received: from vmobile.example.net (catv-5062e605.catv.broadband.hu [80.98.230.5])
	by yugo.frugalware.org (Postfix) with ESMTP id 3B4FC1DDC5B;
	Sun,  8 Jun 2008 02:18:10 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id B11AE18E2A7; Sun,  8 Jun 2008 02:18:11 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc0.dirty
In-Reply-To: <1210584832-16402-3-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84233>

This is a simple script that aggregates key:value pairs in a file.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Mon, May 12, 2008 at 11:33:51AM +0200, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> This is a simple script that aggregates key:value pairs in a file.

Here is a shell version. Just to avoid python.

 t/key_value_parser.sh |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)
 create mode 100755 t/key_value_parser.sh

diff --git a/t/key_value_parser.sh b/t/key_value_parser.sh
new file mode 100755
index 0000000..db568fe
--- /dev/null
+++ b/t/key_value_parser.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+
+input="/tmp/git-test-results"
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
1.5.6.rc0.dirty
