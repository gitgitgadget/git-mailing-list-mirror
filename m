From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH 4/6] add a test for git-send-email for threaded mails without chain-reply-to
Date: Fri, 12 Jun 2009 12:51:40 +0200
Message-ID: <1244803902-8068-4-git-send-email-markus.heidelberg@web.de>
References: <1244803766-7785-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Michael Witten <mfwitten@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 12:52:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF4N2-0002Bm-CI
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 12:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759133AbZFLKvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 06:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933723AbZFLKvu
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 06:51:50 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:59889 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933612AbZFLKvq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 06:51:46 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate02.web.de (Postfix) with ESMTP id 3F60A102EB040;
	Fri, 12 Jun 2009 12:51:48 +0200 (CEST)
Received: from [89.59.124.123] (helo=localhost.localdomain)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MF4MO-00044V-00; Fri, 12 Jun 2009 12:51:48 +0200
X-Mailer: git-send-email 1.6.3.2.236.ge505d
In-Reply-To: <1244803766-7785-1-git-send-email-markus.heidelberg@web.de>
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+N2hlrqcog/M67NJKMKZ7ACJn/+v3TAkm/VmFv
	C0FJN4QZfSVLBYVOYKmkpCh6fKmkYrLesJJyUiJPriEQjbUB+J
	FVFlcDbAart9buTlO1Kg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121403>

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * To be applied on 'master'.

 t/t9001-send-email.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 2ce24cd..4f67de3 100755
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
+		$patches $patches >stdout &&
+	grep "In-Reply-To: " stdout
+'
+
 test_done
-- 
1.6.3.2.236.ge505d
