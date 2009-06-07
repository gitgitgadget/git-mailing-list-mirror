From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH 2/6] add a test for git-send-email for threaded mails without chain-reply-to
Date: Sun,  7 Jun 2009 23:40:53 +0200
Message-ID: <1244410857-920-3-git-send-email-markus.heidelberg@web.de>
References: <1244410857-920-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>,
	Michael Witten <mfwitten@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 23:41:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDQ7X-0004bz-FN
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 23:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756070AbZFGVlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 17:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755645AbZFGVlG
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 17:41:06 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:33454 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753814AbZFGVlD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 17:41:03 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 39AF0104B5D88;
	Sun,  7 Jun 2009 23:41:05 +0200 (CEST)
Received: from [89.59.87.118] (helo=localhost.localdomain)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MDQ6z-0007ZM-00; Sun, 07 Jun 2009 23:41:05 +0200
X-Mailer: git-send-email 1.6.3.2.221.g0ff2f
In-Reply-To: <1244410857-920-1-git-send-email-markus.heidelberg@web.de>
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18OGvtOT3viHIilpQ/0ZrZl/N52o0miEcW2OX67
	m0GKK3gUK7lgL543Xy/mXqIBeFfiYwpLx71uy+15LyRP9df47k
	Lmph7VffrVp+ghu9pigw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121007>


Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
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
1.6.3.2.221.g0ff2f
