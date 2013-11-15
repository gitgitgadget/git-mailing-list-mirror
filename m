From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3 1/6] t6300 (for-each-ref): clearly demarcate setup
Date: Fri, 15 Nov 2013 16:29:03 +0530
Message-ID: <1384513148-22633-2-git-send-email-artagnon@gmail.com>
References: <1384513148-22633-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 15 12:08:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhHG2-0007F8-LK
	for gcvg-git-2@plane.gmane.org; Fri, 15 Nov 2013 12:08:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758286Ab3KOLIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Nov 2013 06:08:07 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:58660 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758147Ab3KOLIE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Nov 2013 06:08:04 -0500
Received: by mail-pa0-f49.google.com with SMTP id lf10so3494164pab.22
        for <git@vger.kernel.org>; Fri, 15 Nov 2013 03:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LBXhzgNsY52r7M4y59RTM5B/bV95Bn1Uf6NO+xIqAqw=;
        b=y9KoBbOX8Vl6UjG3Imi/bo0bqXWR4GtIGdo4cZ6IyvKhpsil+rAWBwvuO0r+WFXiVX
         y6OaJuXRVtXmpcNC0/PgEr6pY3HMqnKQWeDzj7TiBRaTjztb34DqhreNcgXLLFKnajy9
         +4FA2t8WV0odm4PD7/d3nJUoFNTCdaqa3X8g49pYfEdbM4xOUCqwAhB8W7jS5qHIkm9O
         jRX1D9xp/fsnojsaJ7h6Ze6KN2S9WqamVAoZ7NsDhKSrkxe4IkUNeefMwf5EDPkfzO8v
         ROn4Aiqy842GXMQ6ZlEsL7o7pPybyijnknRTSRH+vskt7xNtWyZswg+GsGc2lmBm2mC5
         suOA==
X-Received: by 10.68.231.105 with SMTP id tf9mr6389523pbc.4.1384513683808;
        Fri, 15 Nov 2013 03:08:03 -0800 (PST)
Received: from localhost.localdomain ([122.164.233.197])
        by mx.google.com with ESMTPSA id tu6sm3761840pbc.41.2013.11.15.03.08.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2013 03:08:03 -0800 (PST)
X-Mailer: git-send-email 1.8.5.rc0.6.gfd75b41
In-Reply-To: <1384513148-22633-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237900>

Condense the two-step setup into one step, and give it an appropriate
name.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t6300-for-each-ref.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 752f5cb..72d282f 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -18,16 +18,13 @@ setdate_and_increment () {
     export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
 }
 
-test_expect_success 'Create sample commit with known timestamp' '
+test_expect_success setup '
 	setdate_and_increment &&
 	echo "Using $datestamp" > one &&
 	git add one &&
 	git commit -m "Initial" &&
 	setdate_and_increment &&
 	git tag -a -m "Tagging at $datestamp" testtag
-'
-
-test_expect_success 'Create upstream config' '
 	git update-ref refs/remotes/origin/master master &&
 	git remote add origin nowhere &&
 	git config branch.master.remote origin &&
-- 
1.8.5.rc0.6.gfd75b41
