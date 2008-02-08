From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH] remove "nohup" from git-help--browse
Date: Fri,  8 Feb 2008 23:36:22 +0300
Message-ID: <1202502982-6822-1-git-send-email-dpotapov@gmail.com>
References: <7vhcgkm7yy.fsf@gitster.siamese.dyndns.org>
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 21:38:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNZyx-0004Bd-9t
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 21:37:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755228AbYBHUga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 15:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762015AbYBHUg3
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 15:36:29 -0500
Received: from smtp07.mtu.ru ([62.5.255.54]:61300 "EHLO smtp07.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755228AbYBHUg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 15:36:26 -0500
Received: from smtp07.mtu.ru (localhost.mtu.ru [127.0.0.1])
	by smtp07.mtu.ru (Postfix) with ESMTP id 0155E70814D;
	Fri,  8 Feb 2008 23:36:21 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-191-38.pppoe.mtu-net.ru [85.141.191.38])
	by smtp07.mtu.ru (Postfix) with ESMTP id 01B1B7080C7;
	Fri,  8 Feb 2008 23:36:20 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JNZxO-0001mN-SA; Fri, 08 Feb 2008 23:36:22 +0300
X-Mailer: git-send-email 1.5.4
In-Reply-To: <7vhcgkm7yy.fsf@gitster.siamese.dyndns.org>
X-DCC-STREAM-Metrics: smtp07.mtu.ru 10002; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73138>

There is no good reason to run GUI browsers using "nohup". It does not
solve any real problem but creates annoying "nohup.out" files in every
directory where git help -w is run.

This patch removes "nohup" from git-help--browse.sh

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
It seems that everyone is agree that there is no good reason to
keep "nohup" in git-help--browse. So here is the patch.

 git-help--browse.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-help--browse.sh b/git-help--browse.sh
index 10b0a36..adc4d37 100755
--- a/git-help--browse.sh
+++ b/git-help--browse.sh
@@ -122,7 +122,7 @@ case "$browser" in
 	vers=$(expr "$($browser_path -version)" : '.* \([0-9][0-9]*\)\..*')
 	NEWTAB='-new-tab'
 	test "$vers" -lt 2 && NEWTAB=''
-	nohup "$browser_path" $NEWTAB $pages &
+	"$browser_path" $NEWTAB $pages &
 	;;
     konqueror)
 	case "$(basename "$browser_path")" in
@@ -136,7 +136,7 @@ case "$browser" in
 		eval "$browser_path" newTab $pages
 		;;
 	    *)
-	        nohup "$browser_path" $pages &
+	        "$browser_path" $pages &
 		;;
 	esac
 	;;
@@ -144,6 +144,6 @@ case "$browser" in
 	eval "$browser_path" $pages
 	;;
     dillo)
-	nohup "$browser_path" $pages &
+	"$browser_path" $pages &
 	;;
 esac
-- 
1.5.4
