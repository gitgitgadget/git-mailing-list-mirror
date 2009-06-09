From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH 1/2] add a test for git-send-email for non-threaded mails
Date: Tue,  9 Jun 2009 09:11:30 +0200
Message-ID: <1244531491-21312-1-git-send-email-markus.heidelberg@web.de>
References: <200906090905.58446.markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 09:12:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDvV5-0006i9-4v
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 09:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758271AbZFIHLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 03:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758079AbZFIHLj
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 03:11:39 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:47381 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758167AbZFIHLi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 03:11:38 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 45ABC10243BD9;
	Tue,  9 Jun 2009 09:11:40 +0200 (CEST)
Received: from [89.59.118.0] (helo=localhost.localdomain)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MDvUi-00040F-00; Tue, 09 Jun 2009 09:11:40 +0200
X-Mailer: git-send-email 1.6.3.2.8.g055bf
In-Reply-To: <200906090905.58446.markus.heidelberg@web.de>
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+VFggEZLTHnYp6/gjH+gsTsWFa+J6zPQy3RcsX
	2ece3l0J7WypCUPXVwZ/qULxqYMZZixxrrubE+mTGTQ5cGxWte
	vhoiIh2GNma0FeJ+3h0Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121144>


Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 t/t9001-send-email.sh |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index ce26ea4..5bfa36e 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -621,4 +621,14 @@ test_expect_success 'in-reply-to but no threading' '
 	grep "In-Reply-To: <in-reply-id@example.com>"
 '
 
+test_expect_failure 'no in-reply-to and no threading' '
+	git send-email \
+		--dry-run \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--nothread \
+		$patches $patches >stdout &&
+	! grep "In-Reply-To: " stdout
+'
+
 test_done
-- 
1.6.3.2.8.g055bf
