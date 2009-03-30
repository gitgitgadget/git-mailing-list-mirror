From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 2/8] mergetool: use $( ... ) instead of `backticks`
Date: Sun, 29 Mar 2009 22:03:42 -0700
Message-ID: <1238389428-69328-3-git-send-email-davvid@gmail.com>
References: <1238389428-69328-1-git-send-email-davvid@gmail.com>
 <1238389428-69328-2-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 30 07:06:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo9h7-0004he-FZ
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 07:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865AbZC3FEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 01:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751020AbZC3FEL
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 01:04:11 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:12124 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753865AbZC3FEK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 01:04:10 -0400
Received: by qw-out-2122.google.com with SMTP id 8so2354643qwh.37
        for <git@vger.kernel.org>; Sun, 29 Mar 2009 22:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=MTJjlBKy2Sf71L6O0ql0NS/gTCsK2f1UUx18CrI5aoM=;
        b=VK6KXectw2LSPITl8zPTkK/6Q9+pe+uPooM2DSfqcWZeUTsknmh5H9f54g+bJVYbqb
         A7vJwR/S9R8t5kfsTFL/tIkA5ynLGLMfIwshld9gnVqx8/ramcnldWpMbUq17gcqrTGR
         uTc6oR7WGqZoyVplaM1WYW7mnPK9UMbWwhuR4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rf3FwnKJJelXJR09NQt29H3922a4lZivIvKc0cAByINVkQxh5pzP1JBCPqm3AEbet0
         6d1G8z6i91e1MkfPIrpb7g90x2E20xHaCXXpJFZ5tXU8m6TkNQX6DcG3u2gqdhxRaiEw
         9ks1fZxUHMUcv4IqJrJv9zZ6cCjsqoqb6mf9I=
Received: by 10.224.45.134 with SMTP id e6mr3397813qaf.41.1238389448035;
        Sun, 29 Mar 2009 22:04:08 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 8sm5352925qwj.56.2009.03.29.22.04.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Mar 2009 22:04:07 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.404.gb0085
In-Reply-To: <1238389428-69328-2-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115070>

This makes mergetool consistent with Documentation/CodingGuidelines.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-mergetool.sh |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index cfee28e..5ea126c 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -138,7 +138,7 @@ checkout_staged_file () {
 merge_file () {
 	MERGED="$1"
 
-	f=`git ls-files -u -- "$MERGED"`
+	f=$(git ls-files -u -- "$MERGED")
 	if test -z "$f" ; then
 		if test ! -f "$MERGED" ; then
 			echo "$MERGED: file not found"
@@ -157,9 +157,9 @@ merge_file () {
 	mv -- "$MERGED" "$BACKUP"
 	cp -- "$BACKUP" "$MERGED"
 
-	base_mode=`git ls-files -u -- "$MERGED" | awk '{if ($3==1) print $1;}'`
-	local_mode=`git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $1;}'`
-	remote_mode=`git ls-files -u -- "$MERGED" | awk '{if ($3==3) print $1;}'`
+	base_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==1) print $1;}')
+	local_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $1;}')
+	remote_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==3) print $1;}')
 
 	base_present   && checkout_staged_file 1 "$MERGED" "$BASE"
 	local_present  && checkout_staged_file 2 "$MERGED" "$LOCAL"
@@ -322,7 +322,7 @@ do
 	-t|--tool*)
 		case "$#,$1" in
 		*,*=*)
-			merge_tool=`expr "z$1" : 'z-[^=]*=\(.*\)'`
+			merge_tool=$(expr "z$1" : 'z-[^=]*=\(.*\)')
 			;;
 		1,*)
 			usage ;;
@@ -371,7 +371,7 @@ valid_tool() {
 }
 
 init_merge_tool_path() {
-	merge_tool_path=`git config mergetool.$1.path`
+	merge_tool_path=$(git config mergetool.$1.path)
 	if test -z "$merge_tool_path" ; then
 		case "$1" in
 			emerge)
@@ -401,7 +401,7 @@ prompt_after_failed_merge() {
 }
 
 if test -z "$merge_tool"; then
-	merge_tool=`git config merge.tool`
+	merge_tool=$(git config merge.tool)
 	if test -n "$merge_tool" && ! valid_tool "$merge_tool"; then
 		echo >&2 "git config option merge.tool set to unknown tool:" "$merge_tool"
 		echo >&2 "Resetting to default..."
@@ -461,7 +461,7 @@ last_status=0
 rollup_status=0
 
 if test $# -eq 0 ; then
-	files=`git ls-files -u | sed -e 's/^[^	]*	//' | sort -u`
+	files=$(git ls-files -u | sed -e 's/^[^	]*	//' | sort -u)
 	if test -z "$files" ; then
 		echo "No files need merging"
 		exit 0
-- 
1.6.1.3
