From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 5/9] bisect: replace existing calls to git checkout with bisect_checkout_with_ignore
Date: Sun, 24 Jul 2011 15:57:50 +1000
Message-ID: <1311487074-25070-6-git-send-email-jon.seymour@gmail.com>
References: <1311487074-25070-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 24 07:58:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qkrhy-0007mm-Ek
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 07:58:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041Ab1GXF60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 01:58:26 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:56778 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987Ab1GXF6T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 01:58:19 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so6276942pzk.1
        for <git@vger.kernel.org>; Sat, 23 Jul 2011 22:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=9hPCsK15qH0Ruyg2xQgsfotpNvuLOLEliuOFgBhQd5o=;
        b=aKLYaa4aRX93r7OSoCajt8JZZaWeFe6gGmCYJdlK3El9qftiJ0RofX0anMhLibJ8ij
         8OKOmkfuvZmv98B2Wp2m30PIgyWlc0FoUkunradXL7c5t5iKDD6BePICAQpqCL4M7Agi
         PIk8qI2gNU8PMeyuCb40NfTauwFopNiRnseWA=
Received: by 10.68.29.163 with SMTP id l3mr5296211pbh.425.1311487099408;
        Sat, 23 Jul 2011 22:58:19 -0700 (PDT)
Received: from localhost.localdomain ([124.169.157.32])
        by mx.google.com with ESMTPS id b4sm3359124pba.43.2011.07.23.22.58.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Jul 2011 22:58:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.347.g96e0b.dirty
In-Reply-To: <1311487074-25070-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177723>

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-bisect.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 486a860..ecbd5bf 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -76,7 +76,7 @@ bisect_start() {
 	then
 		# Reset to the rev from where we started.
 		start_head=$(cat "$GIT_DIR/BISECT_START")
-		git checkout "$start_head" -- || exit
+		bisect_checkout_with_ignore "$start_head"
 	else
 		# Get rev from where we start.
 		case "$head" in
@@ -359,7 +359,7 @@ bisect_reset() {
 	*)
 	    usage ;;
 	esac
-	if git checkout "$branch" -- ; then
+	if ( bisect_checkout_with_ignore "$branch" ) ; then
 		bisect_clean_state
 	else
 		die "$(eval_gettext "Could not check out original HEAD '\$branch'.
-- 
1.7.6.347.g96e0b.dirty
