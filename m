From: Sean <seanlkml@sympatico.ca>
Subject: [PATCH] Convert some "apply --summary" users to "diff --summary".
Date: Sun, 14 May 2006 08:16:06 -0400
Message-ID: <BAYC1-PASMTP05387498CF43685EDCACE6AEA20@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun May 14 14:21:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfFbL-0008Ph-Rz
	for gcvg-git@gmane.org; Sun, 14 May 2006 14:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbWENMVd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 08:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWENMVd
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 08:21:33 -0400
Received: from bayc1-pasmtp05.bayc1.hotmail.com ([65.54.191.165]:62410 "EHLO
	BAYC1-PASMTP05.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751412AbWENMVc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 May 2006 08:21:32 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP05.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 14 May 2006 05:21:32 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 27347644C28
	for <git@vger.kernel.org>; Sun, 14 May 2006 08:21:31 -0400 (EDT)
To: git@vger.kernel.org
Message-Id: <20060514081606.1c764889.seanlkml@sympatico.ca>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 14 May 2006 12:21:32.0377 (UTC) FILETIME=[EF5FF490:01C67750]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>

---

10e6a3cba25ce956654e40d824da191e4e4d3062
 git-format-patch.sh |    2 +-
 git-merge.sh        |    3 +--
 git-request-pull.sh |    2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

10e6a3cba25ce956654e40d824da191e4e4d3062
diff --git a/git-format-patch.sh b/git-format-patch.sh
index c077f44..8a16ead 100755
--- a/git-format-patch.sh
+++ b/git-format-patch.sh
@@ -274,7 +274,7 @@ print "\n---\n\n";
 close FH or die "close $commsg pipe";
 ' "$keep_subject" "$num" "$signoff" "$headers" "$mimemagic" $commsg
 
-	git-diff-tree -p $diff_opts "$commit" | git-apply --stat --summary
+	git-diff-tree -p --stat --summary $diff_opts "$commit"
 	echo
 	case "$mimemagic" in
 	'');;
diff --git a/git-merge.sh b/git-merge.sh
index b834e79..af1f25b 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -55,8 +55,7 @@ finish () {
 
 	case "$no_summary" in
 	'')
-		git-diff-tree -p -M "$head" "$1" |
-		git-apply --stat --summary
+		git-diff-tree -p --stat --summary -M "$head" "$1"
 		;;
 	esac
 }
diff --git a/git-request-pull.sh b/git-request-pull.sh
index 2c48bfb..4319e35 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -30,4 +30,4 @@ echo "  $url"
 echo
 
 git log  $baserev..$headrev | git-shortlog ;
-git diff $baserev..$headrev | git-apply --stat --summary
+git diff --stat --summary $baserev..$headrev
-- 
1.3.2.gab2a
