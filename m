From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/6 (v2)] clone: test the new HEAD detection logic
Date: Mon,  1 Dec 2008 06:12:55 -0800
Message-ID: <1228140775-29212-7-git-send-email-gitster@pobox.com>
References: <1228140775-29212-1-git-send-email-gitster@pobox.com>
 <1228140775-29212-2-git-send-email-gitster@pobox.com>
 <1228140775-29212-3-git-send-email-gitster@pobox.com>
 <1228140775-29212-4-git-send-email-gitster@pobox.com>
 <1228140775-29212-5-git-send-email-gitster@pobox.com>
 <1228140775-29212-6-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 01 15:15:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L79YH-0007w7-I4
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 15:15:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674AbYLAONw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 09:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752657AbYLAONw
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 09:13:52 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46551 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642AbYLAONv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 09:13:51 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E0F1C17DEF
	for <git@vger.kernel.org>; Mon,  1 Dec 2008 09:13:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5EC3417DAA for
 <git@vger.kernel.org>; Mon,  1 Dec 2008 09:13:42 -0500 (EST)
X-Mailer: git-send-email 1.6.1.rc1.23.g38649f
In-Reply-To: <1228140775-29212-6-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 471C1D10-BFB2-11DD-916C-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102045>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5601-clone.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 78a3fa6..6d4665b 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -125,4 +125,15 @@ test_expect_success 'clone to destination with extra trailing /' '
 
 '
 
+test_expect_success 'clone from a repository with two identical branches' '
+
+	(
+		cd src &&
+		git checkout -b another master
+	) &&
+	git clone src target-3 &&
+	test "z$( cd target-3 && git symbolic-ref HEAD )" = zrefs/heads/another
+
+'
+
 test_done
-- 
1.6.0.4.864.g0f47a
