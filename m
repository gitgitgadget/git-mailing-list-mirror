From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH 4/6] add a test for git-send-email for non-threaded mails
Date: Sun,  7 Jun 2009 23:40:55 +0200
Message-ID: <1244410857-920-5-git-send-email-markus.heidelberg@web.de>
References: <1244410857-920-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>,
	Michael Witten <mfwitten@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 23:41:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDQ7Y-0004bz-SW
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 23:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755679AbZFGVlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 17:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755926AbZFGVlH
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 17:41:07 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:33471 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754256AbZFGVlE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 17:41:04 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 2ED10104B5D93;
	Sun,  7 Jun 2009 23:41:06 +0200 (CEST)
Received: from [89.59.87.118] (helo=localhost.localdomain)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MDQ70-0007ZM-00; Sun, 07 Jun 2009 23:41:06 +0200
X-Mailer: git-send-email 1.6.3.2.221.g0ff2f
In-Reply-To: <1244410857-920-1-git-send-email-markus.heidelberg@web.de>
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19yPp9xEGSEzZVboW3Mzj14SCkvlYBFBmtFNhOE
	i8lBIcLLPN3X6yc/FHvaWI8nhKS68+HRbJtG8izPbILuh+6uLa
	7u01ys3gRLwg0tq7yA9g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121008>


Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 t/t9001-send-email.sh |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 41af35a..9cddd5f 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -621,6 +621,16 @@ test_expect_success 'in-reply-to but no threading' '
 	grep "In-Reply-To: <in-reply-id@example.com>"
 '
 
+test_expect_failure 'no in-reply-to and no threading' '
+	! git send-email \
+		--dry-run \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--nothread \
+		$patches $patches |
+	grep "In-Reply-To: "
+'
+
 test_expect_success 'threading but no chain-reply-to' '
 	git send-email \
 		--dry-run \
-- 
1.6.3.2.221.g0ff2f
