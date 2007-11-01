From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH] rebase: standardize on $() for command substitution
Date: Wed, 31 Oct 2007 23:50:08 -0500
Message-ID: <1193892608-31322-1-git-send-email-dpmcgee@gmail.com>
Cc: Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 01 05:50:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InS0m-0004cN-Hw
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 05:50:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835AbXKAEuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 00:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbXKAEuQ
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 00:50:16 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:39072 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbXKAEuP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 00:50:15 -0400
Received: by py-out-1112.google.com with SMTP id u77so710460pyb
        for <git@vger.kernel.org>; Wed, 31 Oct 2007 21:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=KR0F9Ku144U1OwWy1VbZ2RShJEFeXwKV8RvMKaU+lVQ=;
        b=JHte0Cy9/3GsjqcHoU1+aEktU72Exr5wqrcnmcwE6t01tigexx/2JNhedBY6g6+G8ppzPYkt1pML7r8CKGCP0yys0rtiFc47G+HgZ88Sgr1KOGN9qu9TtkW8kIXmgSVtGFsPdzn57NUVT+lII1ZuwvmttXR924LwagWRTpKPZ7g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=SOZex9RmIPjjXXPw3hCBswiC6RC1qfv73wop4m2MnL06N1K4peo3cHgTGAUw6/1npda0fp6q4Vi3D6+fLOX4erXw39TNJ12gdud/wVaogy8poqaLaILJ1SdQsf6Q6/n7wYm0kZYpWl9j2TQzMUixmSpfYQ4EoaE1afuiW+cj9AE=
Received: by 10.35.91.10 with SMTP id t10mr219533pyl.1193892614704;
        Wed, 31 Oct 2007 21:50:14 -0700 (PDT)
Received: from localhost ( [76.197.214.134])
        by mx.google.com with ESMTPS id n63sm3496620pyh.2007.10.31.21.50.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 31 Oct 2007 21:50:11 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62915>

Commit 889a50e909dba5f4416049afc5eeae601fe133bc changed several `` to $()
format for command substitution, so we should standardize on one format
for clarity.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 git-rebase.sh |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 224cca9..63dea56 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -59,7 +59,7 @@ continue_merge () {
 		die "$RESOLVEMSG"
 	fi
 
-	cmt=`cat "$dotest/current"`
+	cmt=$(cat "$dotest/current")
 	if ! git diff-index --quiet HEAD
 	then
 		if ! git-commit -C "$cmt"
@@ -74,7 +74,7 @@ continue_merge () {
 	fi
 	git rev-list --pretty=oneline -1 "$cmt" | sed -e 's/^[^ ]* //'
 
-	prev_head=`git rev-parse HEAD^0`
+	prev_head=$(git rev-parse HEAD^0)
 	# save the resulting commit so we can read-tree on it later
 	echo "$prev_head" > "$dotest/prev_head"
 
@@ -203,7 +203,7 @@ do
 	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
 		case "$#,$1" in
 		*,*=*)
-			strategy=`expr "z$1" : 'z-[^=]*=\(.*\)'` ;;
+			strategy=$(expr "z$1" : 'z-[^=]*=\(.*\)'` ;)
 		1,*)
 			usage ;;
 		*)
@@ -265,7 +265,7 @@ esac
 
 # The upstream head must be given.  Make sure it is valid.
 upstream_name="$1"
-upstream=`git rev-parse --verify "${upstream_name}^0"` ||
+upstream=$(git rev-parse --verify "${upstream_name}^0") ||
     die "invalid upstream $upstream_name"
 
 # Make sure the branch to rebase onto is valid.
@@ -288,9 +288,9 @@ case "$#" in
 	git-checkout "$2" || usage
 	;;
 *)
-	if branch_name=`git symbolic-ref -q HEAD`
+	if branch_name=$(git symbolic-ref -q HEAD)
 	then
-		branch_name=`expr "z$branch_name" : 'zrefs/heads/\(.*\)'`
+		branch_name=$(expr "z$branch_name" : 'zrefs/heads/\(.*\)')
 	else
 		branch_name=HEAD ;# detached
 	fi
@@ -343,11 +343,11 @@ fi
 mkdir -p "$dotest"
 echo "$onto" > "$dotest/onto"
 echo "$onto_name" > "$dotest/onto_name"
-prev_head=`git rev-parse HEAD^0`
+prev_head=$(git rev-parse HEAD^0)
 echo "$prev_head" > "$dotest/prev_head"
 
 msgnum=0
-for cmt in `git rev-list --reverse --no-merges "$upstream"..ORIG_HEAD`
+for cmt in $(git rev-list --reverse --no-merges "$upstream"..ORIG_HEAD)
 do
 	msgnum=$(($msgnum + 1))
 	echo "$cmt" > "$dotest/cmt.$msgnum"
-- 
1.5.3.5
