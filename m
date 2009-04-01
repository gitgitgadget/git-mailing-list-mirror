From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 02/10] mergetool: use $( ... ) instead of `backticks`
Date: Wed,  1 Apr 2009 05:55:06 -0700
Message-ID: <1238590514-41893-3-git-send-email-davvid@gmail.com>
References: <1238590514-41893-1-git-send-email-davvid@gmail.com>
 <1238590514-41893-2-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com, charles@hashpling.org
X-From: git-owner@vger.kernel.org Wed Apr 01 14:58:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp01e-0004A8-Jr
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 14:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764673AbZDAMzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 08:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763147AbZDAMzh
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 08:55:37 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:13767 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763348AbZDAMzg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 08:55:36 -0400
Received: by rv-out-0506.google.com with SMTP id f9so29191rvb.1
        for <git@vger.kernel.org>; Wed, 01 Apr 2009 05:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=i0vKua4mUjIarUc1xpQeQEDAGxdjoiuJc2zp81apVVY=;
        b=F+g38KPeidb61TwxNh+/pAsCOtf1IDVXvoYiVpkUZobbmF2dju+fdz0wn9iejoKFz/
         8nvENdj/5JEU9o29pHRcbvxi8q6VHBIzQsITYaVr7DOuabEbpRXWR5L4Lk5FX/zl0xYs
         sazpdkjbHg4NquRnrn9kFrrMaGPkuySEkn9Pk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ALPmod7HCI5GYLcta+pZyQMSXTxOf+NnDsWEqOsX/WoehLbtnYXm4NDINI/AeQsKQl
         dKbPuia/Lhly3Koco2RLnR0+iZj6Apus3AJTJq0ZjJeNlhTrr6hWiN/C/Nq/ph7S49ME
         CP10oFzxoAjbFUDstxkovUtTjXyHPu6F65Aog=
Received: by 10.114.208.20 with SMTP id f20mr5188507wag.225.1238590533738;
        Wed, 01 Apr 2009 05:55:33 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id j34sm7212775waf.62.2009.04.01.05.55.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Apr 2009 05:55:33 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.423.g442d
In-Reply-To: <1238590514-41893-2-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115384>

This makes mergetool consistent with Documentation/CodingGuidelines.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-mergetool.sh |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 87fa88a..7c04031 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -137,7 +137,7 @@ checkout_staged_file () {
 merge_file () {
     MERGED="$1"
 
-    f=`git ls-files -u -- "$MERGED"`
+    f=$(git ls-files -u -- "$MERGED")
     if test -z "$f" ; then
 	if test ! -f "$MERGED" ; then
 	    echo "$MERGED: file not found"
@@ -156,9 +156,9 @@ merge_file () {
     mv -- "$MERGED" "$BACKUP"
     cp -- "$BACKUP" "$MERGED"
 
-    base_mode=`git ls-files -u -- "$MERGED" | awk '{if ($3==1) print $1;}'`
-    local_mode=`git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $1;}'`
-    remote_mode=`git ls-files -u -- "$MERGED" | awk '{if ($3==3) print $1;}'`
+    base_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==1) print $1;}')
+    local_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $1;}')
+    remote_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==3) print $1;}')
 
     base_present   && checkout_staged_file 1 "$MERGED" "$BASE"
     local_present  && checkout_staged_file 2 "$MERGED" "$LOCAL"
@@ -308,7 +308,7 @@ do
 	-t|--tool*)
 	    case "$#,$1" in
 		*,*=*)
-		    merge_tool=`expr "z$1" : 'z-[^=]*=\(.*\)'`
+		    merge_tool=$(expr "z$1" : 'z-[^=]*=\(.*\)')
 		    ;;
 		1,*)
 		    usage ;;
@@ -356,7 +356,7 @@ valid_tool() {
 }
 
 init_merge_tool_path() {
-	merge_tool_path=`git config mergetool.$1.path`
+	merge_tool_path=$(git config mergetool.$1.path)
 	if test -z "$merge_tool_path" ; then
 		case "$1" in
 			emerge)
@@ -387,7 +387,7 @@ prompt_after_failed_merge() {
 }
 
 if test -z "$merge_tool"; then
-    merge_tool=`git config merge.tool`
+    merge_tool=$(git config merge.tool)
     if test -n "$merge_tool" && ! valid_tool "$merge_tool"; then
 	    echo >&2 "git config option merge.tool set to unknown tool: $merge_tool"
 	    echo >&2 "Resetting to default..."
@@ -447,7 +447,7 @@ last_status=0
 rollup_status=0
 
 if test $# -eq 0 ; then
-    files=`git ls-files -u | sed -e 's/^[^	]*	//' | sort -u`
+    files=$(git ls-files -u | sed -e 's/^[^	]*	//' | sort -u)
     if test -z "$files" ; then
 	echo "No files need merging"
 	exit 0
-- 
1.6.1.3
