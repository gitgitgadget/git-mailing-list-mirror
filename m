From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH 1/6] add a test for git-send-email for non-threaded mails
Date: Fri, 12 Jun 2009 12:51:37 +0200
Message-ID: <1244803902-8068-1-git-send-email-markus.heidelberg@web.de>
References: <1244803766-7785-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Michael Witten <mfwitten@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 12:52:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF4N1-0002Bm-4L
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 12:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933707AbZFLKvq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 06:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933621AbZFLKvp
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 06:51:45 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:32865 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760305AbZFLKvo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 06:51:44 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id C3211FFA03FE;
	Fri, 12 Jun 2009 12:51:46 +0200 (CEST)
Received: from [89.59.124.123] (helo=localhost.localdomain)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MF4MM-00044V-00; Fri, 12 Jun 2009 12:51:46 +0200
X-Mailer: git-send-email 1.6.3.2.236.ge505d
In-Reply-To: <1244803766-7785-1-git-send-email-markus.heidelberg@web.de>
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/F4QMCqMjrGrcShBlcLD3PaP8XgwGZaSXYvqFJ
	lyeBZDSH1JK8xLQyKOFYXkGlmyje/jeMDk0c/CYcytrhId3eqU
	JuKM6ZZKRZ3cmOnVL+8w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121401>

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * To be applied on 'maint'.

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
1.6.3.2.236.ge505d
