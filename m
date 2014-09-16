From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v4 1/3] t1503: use test_must_be_empty
Date: Mon, 15 Sep 2014 20:24:08 -0700
Message-ID: <1410837850-5169-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jon Seymour <jon.seymour@gmail.com>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Fabian Ruch <bafain@gmail.com>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 05:24:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTjNM-0000ef-MB
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 05:24:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380AbaIPDYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 23:24:17 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:56544 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbaIPDYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 23:24:16 -0400
Received: by mail-pd0-f180.google.com with SMTP id ft15so7679118pdb.39
        for <git@vger.kernel.org>; Mon, 15 Sep 2014 20:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=QMonaZzfYfgKmnJaaM6sdwVQkvaXgFbbvVytUT/oRb8=;
        b=f4x4I3ARTSG8qFZT3ULXVxIwGKoYTdGeuNKpz9MIDplgYFQMm1xVnUJkFiZEcSiAzO
         EmwezrjnRVh6bbXzCd2uiCiRjw341Ac4dC2ra5ZxfYvIRl9VRf5MFZab5rebBTkGVL4B
         KpLl6VFMgotqUi60+Nvre2QT8V6Dy/EwroVTa/SB+b1wn6Fq1AubAhh44UWUZk97JCyc
         nfqH4yMD0xWd0j5lagqvOwvjuEwqzf6MVVwLzMozmyPwOI19tTDYPlfezAL4h5TcjGSU
         CuZlcbjEvZHAUr/D4TV4xjNqWQLzwPc902vKJ8CUMVoMeculHsV5S2HJQXOW5R4OBBPd
         v2bg==
X-Received: by 10.70.41.201 with SMTP id h9mr39797930pdl.55.1410837855985;
        Mon, 15 Sep 2014 20:24:15 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id v1sm12633581pdp.76.2014.09.15.20.24.13
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 15 Sep 2014 20:24:15 -0700 (PDT)
X-Mailer: git-send-email 2.1.0.30.g05c535b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257124>

Use `test_must_be_be_empty <file>` instead of `test -z "$(cat <file>)"`.

Suggested-by: Fabian Ruch <bafain@gmail.com>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
This patch should probably be applied on top of the
da/rev-parse-verify-quiet which is currently in pu
and contains the rev-parse documentation patch.

This patch has been rebased to be 1/3.

 t/t1503-rev-parse-verify.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index 813cc1b..d1f93b3 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -72,15 +72,15 @@ test_expect_success 'fails with any bad rev or many good revs' '
 
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
 
 test_expect_success 'no stdout output on error' '
-- 
2.1.0.30.g05c535b.dirty
