From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 03/11] tests: at-combinations: improve nonsense()
Date: Tue,  7 May 2013 16:55:03 -0500
Message-ID: <1367963711-8722-4-git-send-email-felipe.contreras@gmail.com>
References: <1367963711-8722-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 07 23:57:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZpsq-0008Tb-9R
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 23:57:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796Ab3EGV4v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 17:56:51 -0400
Received: from mail-gh0-f172.google.com ([209.85.160.172]:36419 "EHLO
	mail-gh0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190Ab3EGV4r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 17:56:47 -0400
Received: by mail-gh0-f172.google.com with SMTP id r18so217741ghr.3
        for <git@vger.kernel.org>; Tue, 07 May 2013 14:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=JN7WBt0Lj4l3LJOF5VST1/a6koKLmVkZjtJfcahpeb0=;
        b=BQd3qismCEqGW3XzWEsB2vbZCcWxCNlBunefNqFCYIGHh7Xcn7V11bCEUGgl2RYe65
         CKm9eROigyfG+DOJVU237PFIW9OhD2hn3LFA7vf2vuqi3iVX5ese2kVnt8kFECkZYYmD
         kqUYrY1dPJx47AlO7rTyckXX9lutcOIMQ8GFwKVK9+nssijOEUOHB/skUWRYz8GTe0rF
         phbzxtbt7IdYYB85oM6G0zVjKFeUm5saZiyR7BMwDUVijd+UErkFBXftgQlAbPp3EsWp
         MoS31vPTbEE44oaXj+ic8fy+GB4DRvP/rnDF83zawRTrYP6lrPGEEJ+a3R2MVAa/8Fm6
         Hrzg==
X-Received: by 10.236.199.103 with SMTP id w67mr3755469yhn.144.1367963807215;
        Tue, 07 May 2013 14:56:47 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id i44sm58402937yhk.17.2013.05.07.14.56.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 07 May 2013 14:56:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.401.g45bba44
In-Reply-To: <1367963711-8722-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223608>

In some circumstances 'git log' might fail, but not because the @
parsing failed. For example: 'git rev-parse' might succeed and return a
bad object, and then 'git log' would fail.

The layer we want to test is revision parsing, so let's test that
directly.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t1508-at-combinations.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index bd2d2fe..2ea735e 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -17,7 +17,7 @@ test_expect_${4:-success} "$1 = $3" "
 }
 nonsense() {
 test_expect_${2:-success} "$1 is nonsensical" "
-	test_must_fail git log -1 '$1'
+	test_must_fail git rev-parse '$1'
 "
 }
 fail() {
-- 
1.8.3.rc0.401.g45bba44
