From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 08/11] t6050-replace: check that -f option bypasses the
 type check
Date: Tue, 03 Sep 2013 09:10:22 +0200
Message-ID: <20130903071026.29838.23234.chriscool@tuxfamily.org>
References: <20130903070551.29838.43576.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 09:17:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGks4-0008IL-FE
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 09:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555Ab3ICHRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 03:17:40 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:45667 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932536Ab3ICHRU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 03:17:20 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id B686344;
	Tue,  3 Sep 2013 09:17:19 +0200 (CEST)
X-git-sha1: 79fe155489351e8af829a3106e7150397c57d863 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20130903070551.29838.43576.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233694>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6050-replace.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 05be228..622b751 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -276,6 +276,12 @@ test_expect_success 'replaced and replacement objects must be of the same type'
 	grep "$BLOB. points to a replacement object of type .blob" err
 '
 
+test_expect_success '-f option bypasses the type check' '
+	git replace -f mytag $HASH1 &&
+	git replace -f HEAD^{tree} HEAD~1 &&
+	git replace -f HEAD^ $BLOB
+'
+
 test_expect_success 'replace ref cleanup' '
 	test -n "$(git replace)" &&
 	git replace -d $(git replace) &&
-- 
1.8.4.rc1.31.g530f5ce.dirty
