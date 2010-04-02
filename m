From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH 3/4] t7508: add test for "git status" refreshing the index
Date: Fri,  2 Apr 2010 14:27:20 +0200
Message-ID: <1270211241-10795-4-git-send-email-markus.heidelberg@web.de>
References: <1270211241-10795-1-git-send-email-markus.heidelberg@web.de>
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 02 14:26:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nxfx0-0003SR-5Y
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 14:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754644Ab0DBMZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 08:25:57 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:51494 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787Ab0DBMZo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 08:25:44 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 6AA1315B2B6E7;
	Fri,  2 Apr 2010 14:25:43 +0200 (CEST)
Received: from [91.19.8.199] (helo=localhost.localdomain)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #4)
	id 1NxfwV-0001ud-02; Fri, 02 Apr 2010 14:25:43 +0200
X-Mailer: git-send-email 1.7.0.4.300.gc535b
In-Reply-To: <1270211241-10795-1-git-send-email-markus.heidelberg@web.de>
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/ufWaIsFLuBokNis+VfDYcUJ/Y6MpnjooMYbDJ
	9WpYIXRiztKoJZGTCeA7rOuKa/4fv9BiPRUvQeGX8Z6Ijzvmg0
	NR9d3JoQKOmB0uwkXNiw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143811>


Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---
 t/t7508-status.sh |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 556d0fa..086ec3a 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -496,6 +496,16 @@ test_expect_success 'dry-run of partial commit excluding new file in index' '
 	test_cmp expect output
 '
 
+cat >expect <<EOF
+:100644 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0000000000000000000000000000000000000000 M	dir1/modified
+EOF
+test_expect_failure 'status refreshes the index' '
+	touch dir2/added &&
+	git status &&
+	git diff-files >output &&
+	test_cmp expect output
+'
+
 test_expect_success 'setup status submodule summary' '
 	test_create_repo sm && (
 		cd sm &&
-- 
1.7.0.4.300.gc535b
