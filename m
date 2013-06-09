From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 43/45] t3406: modernize style
Date: Sun,  9 Jun 2013 11:40:55 -0500
Message-ID: <1370796057-25312-44-git-send-email-felipe.contreras@gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:45:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulijs-0007i7-5A
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631Ab3FIQoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:44:55 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:65135 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565Ab3FIQow (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:44:52 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so8804308obc.6
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=cdEerWD2K4cX+NkRKbs6y6vLcE4eMu0DY22C0oo2mSI=;
        b=BfsG8DcHwZbQCUcUMjj3ZSDCt+ZowZ0MVI6Pakas9aF7prbaxZtKyFOUKt/faG/nuf
         5vlXDcY+5HpK1abZCwRUnInxDnlCSCJLElicWWNfb4hqr55+VdE6Wej+5D7QKhT73Rhv
         qeDI3AHxB5+HwdpbeqPi1yUfokf4uri0J+9Erc8Lxzc+eOEyPt/544wYnf6VNNxcb5IO
         HfeT+Lr/lc2RzPGsjzvjlFHCGMA2soRIdBYUX6jnsQiHMd2ZDBvW7GoRcWH7RMTzfuKT
         q4H/SlG53GeYO67Dj5vA/G//h+g50D7rt7OdqtFrTtpJWJfdPtEF7W2w4G+++6VpeNKL
         /sfA==
X-Received: by 10.182.241.194 with SMTP id wk2mr5209106obc.77.1370796292423;
        Sun, 09 Jun 2013 09:44:52 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id w7sm14897803obx.9.2013.06.09.09.44.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:44:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227013>

From: Martin von Zweigbergk <martinvonz@gmail.com>

Update the following:

 - Quote 'setup'
 - Remove blank lines within test case body
 - Use test_commit instead of custom quick_one
 - Create branch "topic" from tag created by test_commit

Signed-off-by: Martin von Zweigbergk <martinvonz@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>

Conflicts:
	t/t3406-rebase-message.sh
---
 t/t3406-rebase-message.sh | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 37d19c5..7f48d0f 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -4,27 +4,17 @@ test_description='messages from rebase operation'
 
 . ./test-lib.sh
 
-quick_one () {
-	echo "$1" >"file$1" &&
-	git add "file$1" &&
-	test_tick &&
-	git commit -m "$1"
-}
-
-test_expect_success setup '
-	quick_one O &&
-	git branch topic &&
-	quick_one X &&
-	quick_one A &&
-	quick_one B &&
-	quick_one Y &&
-
-	git checkout topic &&
-	quick_one A &&
-	quick_one B &&
-	quick_one Z &&
+test_expect_success 'setup' '
+	test_commit O fileO &&
+	test_commit X fileX &&
+	test_commit A fileA &&
+	test_commit B fileB &&
+	test_commit Y fileY &&
+
+	git checkout -b topic O &&
+	git cherry-pick A B &&
+	test_commit Z fileZ &&
 	git tag start
-
 '
 
 test_expect_success 'rebase --stat' '
-- 
1.8.3.698.g079b096
