From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH] test-lib.sh: move error line after error() declaration
Date: Sat, 10 Nov 2007 15:17:25 +0100
Message-ID: <200711101517.25322.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 15:12:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqr4k-00041o-Gn
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 15:12:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbXKJOM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 09:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbXKJOM1
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 09:12:27 -0500
Received: from slim-3a.inet.it ([213.92.5.124]:63684 "EHLO slim-3a.inet.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750695AbXKJOM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 09:12:27 -0500
Received: from host80-56-static.104-80-b.business.telecomitalia.it ([::ffff:80.104.56.80]) by slim-3a.inet.it via I-SMTP-5.4.4-547
	id ::ffff:80.104.56.80+Pw7OSBY7LB8T; Sat, 10 Nov 2007 15:12:19 +0100
User-Agent: KMail/1.9.7
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64353>

This patch removes a spurious "command not found" error
and actually makes the "Test script did not set test_description."
string follow the command line option "--no-color".

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---

This is for the master branch.

 t/test-lib.sh |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 603a8cd..90b6844 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -66,9 +66,6 @@ esac
 	tput sgr0 >/dev/null 2>&1 &&
 	color=t
 
-test "${test_description}" != "" ||
-error "Test script did not set test_description."
-
 while test "$#" -ne 0
 do
 	case "$1" in
@@ -77,8 +74,7 @@ do
 	-i|--i|--im|--imm|--imme|--immed|--immedi|--immedia|--immediat|--immediate)
 		immediate=t; shift ;;
 	-h|--h|--he|--hel|--help)
-		echo "$test_description"
-		exit 0 ;;
+		help=t; shift ;;
 	-v|--v|--ve|--ver|--verb|--verbo|--verbos|--verbose)
 		verbose=t; shift ;;
 	-q|--q|--qu|--qui|--quie|--quiet)
@@ -124,6 +120,15 @@ say () {
 	say_color info "$*"
 }
 
+test "${test_description}" != "" ||
+error "Test script did not set test_description."
+
+if test "$help" = "t"
+then
+	echo "$test_description"
+	exit 0
+fi
+
 exec 5>&1
 if test "$verbose" = "t"
 then
-- 
1.5.3.5
