From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH v2 1/3] git-merge-one-file: style cleanup
Date: Sun, 24 Mar 2013 14:26:23 +0200
Message-ID: <1364127985-13366-2-git-send-email-kevin@bracey.fi>
References: <CAJDDKr4swZzzv3e+Huz72CVmisFKU8T74jFj3-uGmZHReRGVBw@mail.gmail.com>
 <1364127985-13366-1-git-send-email-kevin@bracey.fi>
Cc: David Aguilar <davvid@gmail.com>, Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 24 13:37:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJkAZ-0006W4-V5
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 13:37:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753538Ab3CXMg2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 08:36:28 -0400
Received: from 9.mo4.mail-out.ovh.net ([46.105.40.176]:60512 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753482Ab3CXMg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 08:36:28 -0400
Received: from mail643.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id 29075104D343
	for <git@vger.kernel.org>; Sun, 24 Mar 2013 13:38:12 +0100 (CET)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 24 Mar 2013 14:25:49 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 24 Mar 2013 14:25:48 +0200
X-Ovh-Mailout: 178.32.228.4 (mo4.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.2.rc3.21.g744ac65
In-Reply-To: <1364127985-13366-1-git-send-email-kevin@bracey.fi>
X-Ovh-Tracer-Id: 17351243466199371999
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: 0
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrieeiucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeiuddrieeiucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218951>

Update style to match Documentation/CodingGuidelines.

Signed-off-by: Kevin Bracey <kevin@bracey.fi>
---
 git-merge-one-file.sh | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index 255c07a..2382b1f 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -27,7 +27,7 @@ SUBDIRECTORY_OK=Yes
 cd_to_toplevel
 require_work_tree
 
-if ! test "$#" -eq 7
+if test $# != 7
 then
 	echo "$LONG_USAGE"
 	exit 1
@@ -38,7 +38,8 @@ case "${1:-.}${2:-.}${3:-.}" in
 # Deleted in both or deleted in one and unchanged in the other
 #
 "$1.." | "$1.$1" | "$1$1.")
-	if [ "$2" ]; then
+	if test -n "$2"
+	then
 		echo "Removing $4"
 	else
 		# read-tree checked that index matches HEAD already,
@@ -48,7 +49,8 @@ case "${1:-.}${2:-.}${3:-.}" in
 		# we do not have it in the index, though.
 		exec git update-index --remove -- "$4"
 	fi
-	if test -f "$4"; then
+	if test -f "$4"
+	then
 		rm -f -- "$4" &&
 		rmdir -p "$(expr "z$4" : 'z\(.*\)/')" 2>/dev/null || :
 	fi &&
@@ -78,7 +80,8 @@ case "${1:-.}${2:-.}${3:-.}" in
 # Added in both, identically (check for same permissions).
 #
 ".$3$2")
-	if [ "$6" != "$7" ]; then
+	if test "$6" != "$7"
+	then
 		echo "ERROR: File $4 added identically in both branches,"
 		echo "ERROR: but permissions conflict $6->$7."
 		exit 1
@@ -123,7 +126,8 @@ case "${1:-.}${2:-.}${3:-.}" in
 	git merge-file "$src1" "$orig" "$src2"
 	ret=$?
 	msg=
-	if [ $ret -ne 0 ]; then
+	if test $ret != 0
+	then
 		msg='content conflict'
 	fi
 
@@ -132,18 +136,22 @@ case "${1:-.}${2:-.}${3:-.}" in
 	git checkout-index -f --stage=2 -- "$4" && cat "$src1" >"$4" || exit 1
 	rm -f -- "$orig" "$src1" "$src2"
 
-	if [ "$6" != "$7" ]; then
-		if [ -n "$msg" ]; then
+	if test "$6" != "$7"
+	then
+		if test -n "$msg"
+		then
 			msg="$msg, "
 		fi
 		msg="${msg}permissions conflict: $5->$6,$7"
 		ret=1
 	fi
-	if [ "$1" = '' ]; then
+	if test -z "$1"
+	then
 		ret=1
 	fi
 
-	if [ $ret -ne 0 ]; then
+	if test $ret != 0
+	then
 		echo "ERROR: $msg in $4"
 		exit 1
 	fi
-- 
1.8.2.rc3.21.g744ac65
