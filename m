From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 5/5] test-lib-functions: adjust style to match CodingGuidelines
Date: Wed, 15 Oct 2014 01:35:21 -0700
Message-ID: <1413362121-17361-5-git-send-email-davvid@gmail.com>
References: <1413362121-17361-1-git-send-email-davvid@gmail.com>
 <1413362121-17361-2-git-send-email-davvid@gmail.com>
 <1413362121-17361-3-git-send-email-davvid@gmail.com>
 <1413362121-17361-4-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Charles Bailey <charles@hashpling.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 10:35:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeK3C-0004uI-07
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 10:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbaJOIfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 04:35:09 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:43003 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464AbaJOIfG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 04:35:06 -0400
Received: by mail-pd0-f180.google.com with SMTP id fp1so874581pdb.11
        for <git@vger.kernel.org>; Wed, 15 Oct 2014 01:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qAYYTqQcFq9MYc3c9Hky4xQFu7NeNfMkpt6m86AD8i8=;
        b=Ct35zt4PR7ZcWbFJZZ6ctX62ET9awlnvgOlvZNMFvXGi1sbs5OOfOTnWn4lZlDuQFD
         /h49c0H2er+GtT6lKsASIKEIETO8fOAPwYKyvBHDEiQHkMI0r7Evwqhz5ZVnVT3MxNzO
         HwDSKxev6PEKWRFzkNWdf6fzIUDizE69putCdETRfAFgXSEoOD+aiAuXG7S6t+88N3qi
         KzxdyVYYgvcl5FJ2L179O/G/Zja88lhgABXb3g/9cPTohGKPOHRcvqeXME6J8lliiGJo
         argsPs0f0jatzaloKJe7agxEit1Q/HexNmr+LcxI1cBN6t4t/OrhMtHVMEqgsxPBwH58
         Oq4w==
X-Received: by 10.70.36.76 with SMTP id o12mr10840970pdj.5.1413362105640;
        Wed, 15 Oct 2014 01:35:05 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id o4sm16371416pdh.56.2014.10.15.01.35.04
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 15 Oct 2014 01:35:04 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.453.g1b015e3
In-Reply-To: <1413362121-17361-4-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prefer "test" over "[ ]" for conditionals.
Prefer "$()" over backticks for command substitutions.
Avoid control structures on a single line with semicolons.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 t/test-lib-functions.sh | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index dafd6ad..fc77cc6 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -413,7 +413,7 @@ test_external () {
 		# test_run_, but keep its stdout on our stdout even in
 		# non-verbose mode.
 		"$@" 2>&4
-		if [ "$?" = 0 ]
+		if test "$?" = 0
 		then
 			if test $test_external_has_tap -eq 0; then
 				test_ok_ "$descr"
@@ -440,11 +440,12 @@ test_external_without_stderr () {
 	tmp=${TMPDIR:-/tmp}
 	stderr="$tmp/git-external-stderr.$$.tmp"
 	test_external "$@" 4> "$stderr"
-	[ -f "$stderr" ] || error "Internal error: $stderr disappeared."
+	test -f "$stderr" || error "Internal error: $stderr disappeared."
 	descr="no stderr: $1"
 	shift
 	say >&3 "# expecting no stderr from previous command"
-	if [ ! -s "$stderr" ]; then
+	if test ! -s "$stderr"
+	then
 		rm "$stderr"
 
 		if test $test_external_has_tap -eq 0; then
@@ -454,8 +455,9 @@ test_external_without_stderr () {
 			test_success=$(($test_success + 1))
 		fi
 	else
-		if [ "$verbose" = t ]; then
-			output=`echo; echo "# Stderr is:"; cat "$stderr"`
+		if test "$verbose" = t
+		then
+			output=$(echo; echo "# Stderr is:"; cat "$stderr")
 		else
 			output=
 		fi
@@ -474,7 +476,7 @@ test_external_without_stderr () {
 # The commands test the existence or non-existence of $1. $2 can be
 # given to provide a more precise diagnosis.
 test_path_is_file () {
-	if ! [ -f "$1" ]
+	if ! test -f "$1"
 	then
 		echo "File $1 doesn't exist. $*"
 		false
@@ -482,7 +484,7 @@ test_path_is_file () {
 }
 
 test_path_is_dir () {
-	if ! [ -d "$1" ]
+	if ! test -d "$1"
 	then
 		echo "Directory $1 doesn't exist. $*"
 		false
@@ -501,11 +503,12 @@ test_dir_is_empty () {
 }
 
 test_path_is_missing () {
-	if [ -e "$1" ]
+	if test -e "$1"
 	then
 		echo "Path exists:"
 		ls -ld "$1"
-		if [ $# -ge 1 ]; then
+		if test $# -ge 1
+		then
 			echo "$*"
 		fi
 		false
@@ -657,9 +660,12 @@ test_cmp_rev () {
 # similar to GNU seq(1), but the latter might not be available
 # everywhere (and does not do letters).  It may be used like:
 #
-#	for i in `test_seq 100`; do
-#		for j in `test_seq 10 20`; do
-#			for k in `test_seq a z`; do
+#	for i in $(test_seq 100)
+#	do
+#		for j in $(test_seq 10 20)
+#		do
+#			for k in $(test_seq a z)
+#			do
 #				echo $i-$j-$k
 #			done
 #		done
-- 
2.1.2.453.g1b015e3
