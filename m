From: Ross Lagerwall <rosslagerwall@gmail.com>
Subject: [PATCH] stash: use eval_gettextln correctly
Date: Sat, 14 Apr 2012 14:37:29 +0200
Message-ID: <1334407049-20614-1-git-send-email-rosslagerwall@gmail.com>
Cc: Ross Lagerwall <rosslagerwall@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 14 14:38:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJ2F6-0006Zz-Fp
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 14:38:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201Ab2DNMiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 08:38:11 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:60405 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734Ab2DNMiL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 08:38:11 -0400
Received: by wibhj6 with SMTP id hj6so7280366wib.1
        for <git@vger.kernel.org>; Sat, 14 Apr 2012 05:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=pIDM4baxyODosrynbg8tycA2RgVVepFwZ2YfNBrKmJE=;
        b=ylQINscWaStkPfiqaDOFbNkzqoWxPkhv0AVFQD6bxIKzLp5xLErp29l9pO+OdxGGgH
         mwsmwnShzSUkEY+IqW0iyZv+ULYUVv5HXIDMsgLU8qgcYMC8Uaoo6+F4SpgcGRm45wde
         qfCW2Y72PUZsebKuE/NuY9actKSerxizLHzFPY0ppVAEdoUgRmM0lc2uadox7nipQxZf
         s9rQdqJeq+sms8x0bYhn8dv2fLnR+lZJKymrKlYrEb1D0okFtUYDh+LBbZ2VRogH7oT7
         Ohn7K/oCNWxvUFxDHXWsnEf61OWiG7a41QadfnzJOqpSYZlX7JqX4IgJQMrvKG4SyIaa
         nQYA==
Received: by 10.180.73.143 with SMTP id l15mr3970357wiv.11.1334407089821;
        Sat, 14 Apr 2012 05:38:09 -0700 (PDT)
Received: from localhost.localdomain (41-135-191-151.dsl.mweb.co.za. [41.135.191.151])
        by mx.google.com with ESMTPS id ff2sm6875906wib.9.2012.04.14.05.38.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 14 Apr 2012 05:38:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195488>

Otherwise, passing an invalid option, git stash -v, gave:

git-stash: line 204: $'error: unknown option for \'stash save\':
$option\n       To provide a message, use git stash save -- \'$option\'':
command not found

Signed-off-by: Ross Lagerwall <rosslagerwall@gmail.com>
---
 git-stash.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index fe4ab28..4e2c7f8 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -199,8 +199,8 @@ save_stash () {
 			#    $ git stash save --blah-blah 2>&1 | head -n 2
 			#    error: unknown option for 'stash save': --blah-blah
 			#           To provide a message, use git stash save -- '--blah-blah'
-			eval_gettextln "$("error: unknown option for 'stash save': \$option
-       To provide a message, use git stash save -- '\$option'")"
+			eval_gettextln "error: unknown option for 'stash save': \$option
+       To provide a message, use git stash save -- '\$option'"
 			usage
 			;;
 		*)
-- 
1.7.10
