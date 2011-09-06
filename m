From: Wang Hui <Hui.Wang@windriver.com>
Subject: [PATCH v2 1/5] sha1_file cleanup: remove redundant variable check
Date: Tue, 6 Sep 2011 18:24:01 +0800
Message-ID: <1315304645-12009-2-git-send-email-Hui.Wang@windriver.com>
References: <1315304645-12009-1-git-send-email-Hui.Wang@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
To: <gitster@pobox.com>, <git@vger.kernel.org>, <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Tue Sep 06 12:24:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0spJ-00044q-RR
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 12:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754129Ab1IFKYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 06:24:11 -0400
Received: from mail.windriver.com ([147.11.1.11]:61506 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754092Ab1IFKYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 06:24:09 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p86ANorq005019
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 6 Sep 2011 03:23:50 -0700 (PDT)
Received: from localhost.localdomain (128.224.163.220) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
 14.1.255.0; Tue, 6 Sep 2011 03:23:50 -0700
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1315304645-12009-1-git-send-email-Hui.Wang@windriver.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180789>

From: Hui Wang <Hui.Wang@windriver.com>

This variable check is always true, so it is redundant and need to be
removed.

We can't remove the init value for this variable, since removing
it will introduce building warning:
'base_len' may be used uninitialized in this function.

Signed-off-by: Hui Wang <Hui.Wang@windriver.com>
---
 sha1_file.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index f7c3408..d12a675 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -255,8 +255,7 @@ static int link_alt_odb_entry(const char * entry, int len, const char * relative
 
 	if (!is_absolute_path(entry) && relative_base) {
 		/* Relative alt-odb */
-		if (base_len < 0)
-			base_len = strlen(relative_base) + 1;
+		base_len = strlen(relative_base) + 1;
 		entlen += base_len;
 		pfxlen += base_len;
 	}
-- 
1.6.3.1
