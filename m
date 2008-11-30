From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] clone: test the new HEAD detection logic
Date: Sun, 30 Nov 2008 01:57:28 -0800
Message-ID: <1228039053-31099-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 10:59:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6j5O-00010i-Vy
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 10:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbYK3J5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 04:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbYK3J5p
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 04:57:45 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40401 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbYK3J5o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 04:57:44 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 104FB8246C
	for <git@vger.kernel.org>; Sun, 30 Nov 2008 04:57:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 730E68246B for
 <git@vger.kernel.org>; Sun, 30 Nov 2008 04:57:34 -0500 (EST)
X-Mailer: git-send-email 1.6.0.4.850.g6bd829
X-Pobox-Relay-ID: 54BDB19C-BEC5-11DD-A56B-465CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101956>

This demonstrates the new HEAD detection mechanism based on the
symbolic-ref protocol extension.

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
1.6.0.4.850.g6bd829
