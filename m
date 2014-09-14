From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 2/2] t1503: use test_must_be_empty
Date: Sun, 14 Sep 2014 12:03:02 -0700
Message-ID: <1410721382-97751-2-git-send-email-davvid@gmail.com>
References: <1410721382-97751-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Fabian Ruch <bafain@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 21:03:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTF4v-0005k3-8j
	for gcvg-git-2@plane.gmane.org; Sun, 14 Sep 2014 21:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752742AbaINTDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2014 15:03:09 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:62059 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708AbaINTDH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2014 15:03:07 -0400
Received: by mail-pd0-f182.google.com with SMTP id w10so4834827pde.27
        for <git@vger.kernel.org>; Sun, 14 Sep 2014 12:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aufbCXlLJVbBlAqKNw2m++ZCCPaiz7hUqLgM4eaNVYE=;
        b=XJjUox466491vp/1USAS9Z/9EYUDDNBLWlcjMdLBCs/sfVFJ3mR/2lSgMji6In5buW
         eVO5/CHkFFdPygcYRbnXLyItWj1Hm/W0g5tdR3mZiZrJE0+VjW8+OHqqT1SVoB/mPzpm
         hH4Fao8nyk7m8WDRzbQ9wUNkM9HtuSIP3M1+tElEBmljR349CbbNpSKu+rUTaThUdoV1
         ZRLI5CkDnDsRld9jS6HF+3UmVjJN7crS2sW2Cax/zdpGPQBTYsHoW5voXnY1UCM+gAPC
         jwAZZYDwakHuUmWfRElqmAiJq7yTtBA7iyaKNXe+NoVZKcjIj6nCgu5J9WLqvo0QmjRC
         Y7xw==
X-Received: by 10.66.252.170 with SMTP id zt10mr5807039pac.111.1410721387228;
        Sun, 14 Sep 2014 12:03:07 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id x3sm9431337pdq.10.2014.09.14.12.03.05
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 14 Sep 2014 12:03:06 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.30.g05c535b.dirty
In-Reply-To: <1410721382-97751-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257024>

Use `test_must_be_be_empty <file>` instead of `test -z "$(cat <file>)"`.

Suggested-by: Fabian Ruch <bafain@gmail.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 t/t1503-rev-parse-verify.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index ab9878d..9ac4627 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -72,22 +72,22 @@ test_expect_success 'fails with any bad rev or many good revs' '
 
 test_expect_success 'fails silently when using -q' '
 	test_must_fail git rev-parse --verify --quiet 2>error &&
-	test -z "$(cat error)" &&
+	test_must_be_empty error &&
 	test_must_fail git rev-parse -q --verify foo 2>error &&
-	test -z "$(cat error)" &&
+	test_must_be_empty error &&
 	test_must_fail git rev-parse --verify -q HEAD bar 2>error &&
-	test -z "$(cat error)" &&
+	test_must_be_empty error &&
 	test_must_fail git rev-parse --quiet --verify baz HEAD 2>error &&
-	test -z "$(cat error)" &&
+	test_must_be_empty error &&
 	test_must_fail git rev-parse -q --verify $HASH2 HEAD 2>error &&
-	test -z "$(cat error)"
+	test_must_be_empty error
 '
 
 test_expect_success 'fails silently when using -q with deleted reflogs' '
 	git branch test &&
 	git reflog delete --updateref --rewrite test@{0} &&
 	test_must_fail git rev-parse -q --verify test@{0} >error 2>&1 &&
-	test -z "$(cat error)"
+	test_must_be_empty error
 '
 
 test_expect_success 'no stdout output on error' '
-- 
2.1.0.30.g05c535b.dirty
