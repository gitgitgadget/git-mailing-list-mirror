From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH v2] add a test case for threaded mails without chain-reply-to
Date: Sun,  7 Jun 2009 19:12:30 +0200
Message-ID: <1244394750-30189-1-git-send-email-markus.heidelberg@web.de>
References: <1244388019-12763-1-git-send-email-markus.heidelberg@web.de>
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org,
	Markus Heidelberg <markus.heidelberg@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 19:12:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDLvK-0008Qr-O6
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 19:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754197AbZFGRMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 13:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753748AbZFGRMg
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 13:12:36 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:59122 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520AbZFGRMf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 13:12:35 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 874FA104B1AA9;
	Sun,  7 Jun 2009 19:12:37 +0200 (CEST)
Received: from [89.59.87.118] (helo=localhost.localdomain)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MDLvB-0003lZ-00; Sun, 07 Jun 2009 19:12:37 +0200
X-Mailer: git-send-email 1.6.3.2.216.g24c61.dirty
In-Reply-To: <1244388019-12763-1-git-send-email-markus.heidelberg@web.de>
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+ouWGzWcJmTE7sQG891o+x1qxrMSJLFx8ptWLq
	o2XAny4grsqf7RA+bqyk5UaQsP7TMnArt2NZZQYENQrZZ3/tjD
	6UimIRC2QpIdAY306XIA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120987>

---

--nochain-reply-to instead of
--no-chain-reply-to

see commits 3fee1fe8 and 84eeb687:
t9001: use older Getopt::Long boolean prefix '--no' rather than '--no-'

 t/t9001-send-email.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index ce26ea4..4ccca44 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -621,4 +621,15 @@ test_expect_success 'in-reply-to but no threading' '
 	grep "In-Reply-To: <in-reply-id@example.com>"
 '
 
+test_expect_failure 'threading but no chain-reply-to' '
+	git send-email \
+		--dry-run \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--thread \
+		--nochain-reply-to \
+		$patches $patches |
+	grep "In-Reply-To: "
+'
+
 test_done
-- 
1.6.3.2.216.g24c61.dirty
