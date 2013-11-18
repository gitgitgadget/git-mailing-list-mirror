From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v4 1/6] t6300 (for-each-ref): clearly demarcate setup
Date: Mon, 18 Nov 2013 23:09:08 +0530
Message-ID: <1384796353-18701-2-git-send-email-artagnon@gmail.com>
References: <1384796353-18701-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 18 18:48:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViSwE-00046v-SF
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 18:48:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300Ab3KRRsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Nov 2013 12:48:36 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:41880 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521Ab3KRRse (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Nov 2013 12:48:34 -0500
Received: by mail-pa0-f45.google.com with SMTP id kp14so1255081pab.4
        for <git@vger.kernel.org>; Mon, 18 Nov 2013 09:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/FNZQEd4X4kN0NKh0QyaMDV1rVYzVxLdlF4KH/ogFHk=;
        b=oqiBInX4UVZSHYSQrN6g3chTkSncmtHgobhV/t83DRgJtuEhDwOIyIlfuKfPssGJpI
         LQMwjuTjkCbisJoD6K/GyJpG3JnL5VTvW00yGwin7euPy0vUi2y6oJN/OZboue6JH9SN
         axkNAmr2gSF0vAN5ZeAl1z6lMrC8yR1gbYf0X9KSihK+WOibFirAVr/pQh17yA+WxNkD
         noI+bi1eXjKPbAOyI+Rxan637pfvrI04iFPGPGbRxE+MQX7d3z61OFXodDrq13XZ6Bdk
         oPkLCqWrVtYhzQG+GsC4P/WFb846zKgQRyL4zN4pwps3cFlZ/vDyrdIKKoH7aDiGSh+Y
         czSw==
X-Received: by 10.68.248.33 with SMTP id yj1mr21783834pbc.45.1384796913800;
        Mon, 18 Nov 2013 09:48:33 -0800 (PST)
Received: from localhost.localdomain ([122.164.173.226])
        by mx.google.com with ESMTPSA id hu10sm24836183pbc.11.2013.11.18.09.48.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2013 09:48:33 -0800 (PST)
X-Mailer: git-send-email 1.8.5.rc0.5.g70ebc73.dirty
In-Reply-To: <1384796353-18701-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237996>

Condense the two-step setup into one step, and give it an appropriate
name.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t6300-for-each-ref.sh | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 752f5cb..64301e7 100755
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
-	git tag -a -m "Tagging at $datestamp" testtag
-'
-
-test_expect_success 'Create upstream config' '
+	git tag -a -m "Tagging at $datestamp" testtag &&
 	git update-ref refs/remotes/origin/master master &&
 	git remote add origin nowhere &&
 	git config branch.master.remote origin &&
-- 
1.8.5.rc0.5.g70ebc73.dirty
