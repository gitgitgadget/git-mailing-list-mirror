From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 08/11] t6050-replace: check that -f option bypasses the
 type check
Date: Sat, 31 Aug 2013 21:12:11 +0200
Message-ID: <20130831191215.26699.37671.chriscool@tuxfamily.org>
References: <20130831190528.26699.33964.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 31 21:14:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFqcU-0001Jf-Ge
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 21:14:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754357Ab3HaTNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 15:13:38 -0400
Received: from [194.158.98.15] ([194.158.98.15]:48174 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754649Ab3HaTNf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 15:13:35 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id A9DF365;
	Sat, 31 Aug 2013 21:12:54 +0200 (CEST)
X-git-sha1: d159073251f40f5d8e29fa8bff3da75abcd5b1cc 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20130831190528.26699.33964.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233540>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6050-replace.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 05be228..0b07a0b 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -276,6 +276,12 @@ test_expect_success 'replaced and replacement objects must be of the same type'
 	grep "$BLOB. points to a replacement object of type .blob" err
 '
 
+test_expect_success '-f option bypasses the type check' '
+	git replace -f mytag $HASH1 2>err &&
+	git replace -f HEAD^{tree} HEAD~1 2>err &&
+	git replace -f HEAD^ $BLOB 2>err
+'
+
 test_expect_success 'replace ref cleanup' '
 	test -n "$(git replace)" &&
 	git replace -d $(git replace) &&
-- 
1.8.4.rc1.31.g530f5ce.dirty
