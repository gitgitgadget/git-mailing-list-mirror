From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 5/6] pull: add --merge option
Date: Mon,  2 Sep 2013 17:17:57 -0500
Message-ID: <1378160278-14872-6-git-send-email-felipe.contreras@gmail.com>
References: <1378160278-14872-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 03 00:23:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGcWb-00015U-Ij
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 00:23:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759131Ab3IBWXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 18:23:05 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:46519 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759122Ab3IBWXD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 18:23:03 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so5004535obc.6
        for <git@vger.kernel.org>; Mon, 02 Sep 2013 15:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BxuqkjON86b7RwmLlue9/LOpcpWnw3GyzVih+CXtttM=;
        b=GLt037ucufMNjuRuCP/WIs9eqMQvIF9RGnIcwovZ+s+Z/dC4udcw+b9ZS6zyDCLcoM
         AWxvDngkfR56BFfuK5eszOhD4sBi21CjaJabP1ClPm6o29dztaXwkF62T9mSD275wF2w
         0Q0JjbpKh/meaZl6KiTEtuoF/dwb5vQcsApSeRQcEv1TLrfZnGW6t/w4rykd/T9mGWNZ
         nfiIAljMH1W/IU8tlLoNjtZJ2NzUq92QXg70hTrWT9LkRBIYCWpI+Mxn9W4H8UcD3xja
         kT87KiarkvwnYXIAuM3Pv3WmPxJQjZiC9ogeSk4tL/ynykyBt8M5vYNLYgk2wg9d+bIF
         zNpA==
X-Received: by 10.182.76.98 with SMTP id j2mr17556269obw.106.1378160582594;
        Mon, 02 Sep 2013 15:23:02 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s14sm15924447oeo.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 02 Sep 2013 15:23:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-338-gefd7fa6
In-Reply-To: <1378160278-14872-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233670>

Also, deprecate --no-rebase since there's no need for it any more.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-pull.txt | 8 ++++++--
 git-pull.sh                | 6 +++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 991352f..e09f004 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -119,8 +119,12 @@ It rewrites history, which does not bode well when you
 published that history already.  Do *not* use this option
 unless you have read linkgit:git-rebase[1] carefully.
 
---no-rebase::
-	Override earlier --rebase.
+-m::
+--merge::
+	Force a merge.
++
+See `pull.mode`, `branch.<name>.pullmode` in linkgit:git-config[1] if you want
+to make `git pull` always use `--merge`.
 
 Options related to fetching
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/git-pull.sh b/git-pull.sh
index f53d193..fbb8a9b 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -127,8 +127,12 @@ do
 	-r|--r|--re|--reb|--reba|--rebas|--rebase)
 		mode=rebase
 		;;
+	-m|--m|--me|--mer|--merg|--merge)
+		mode=merge
+		;;
 	--no-r|--no-re|--no-reb|--no-reba|--no-rebas|--no-rebase)
-		mode=
+		mode=merge
+		echo "--no-rebase is deprecated, please use --merge instead"
 		;;
 	--recurse-submodules)
 		recurse_submodules=--recurse-submodules
-- 
1.8.4-338-gefd7fa6
