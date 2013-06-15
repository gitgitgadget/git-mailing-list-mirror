From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 3/5] stash: simplify option parser for create
Date: Sat, 15 Jun 2013 18:43:24 +0530
Message-ID: <1371302006-29775-4-git-send-email-artagnon@gmail.com>
References: <1371302006-29775-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 15 15:15:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnqKd-0007oc-EB
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 15:15:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754444Ab3FONPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 09:15:41 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:37453 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754408Ab3FONP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 09:15:27 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc8so1394002pbc.18
        for <git@vger.kernel.org>; Sat, 15 Jun 2013 06:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=PJxqc/46oNLSQHQpMOmeEJUJIFmIdEprmUh22bxdM5g=;
        b=z9ajmDuk0C7Qu/A3XXnB0NCr829cwfjgCz6YiHxwmxis86nuITAW/zo3QWpMyFR8tq
         8sJQwonb7ZizFblTeu8Pd5UAkkKaRd8TsLps3bTDuWePGsGA6W8//V8TAmCnas/Gyc31
         JN4SLXbxUOag/skSj+2DSsPAxPxgRwMWu294GP5l0AbmCXeICCnZSn5KWQlJ5IzEagzY
         iDjZEKwgN6NN3+Qfqc/lr2tmOsIgai8tKYd6Y9xoJg4KMGZvpwuLhju6WPu89pPXjVqN
         RXK23UO1vEV9oZp5L62JB3j9Ye28AubBUktMey3e+k/5Y+D7Cin4W8kfEGtOGsMsQWD8
         JEgQ==
X-Received: by 10.66.232.9 with SMTP id tk9mr5304539pac.20.1371302127186;
        Sat, 15 Jun 2013 06:15:27 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id pe9sm6239122pbc.35.2013.06.15.06.15.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Jun 2013 06:15:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.441.gd7d6b72.dirty
In-Reply-To: <1371302006-29775-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227952>

The option parser for create unnecessarily checks "$1" inside a case
statement that matches "$1" in the first place.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-stash.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index bbefdf6..64800b8 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -546,10 +546,7 @@ clear)
 	clear_stash "$@"
 	;;
 create)
-	if test $# -gt 0 && test "$1" = create
-	then
-		shift
-	fi
+	shift
 	create_stash "$*" && echo "$w_commit"
 	;;
 drop)
-- 
1.8.3.1.441.gd7d6b72.dirty
