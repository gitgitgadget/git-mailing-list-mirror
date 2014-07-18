From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] fast-import: use hashcmp() for SHA1 hash comparison
Date: Fri, 18 Jul 2014 18:00:51 +0200
Message-ID: <53C944B3.5080106@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 18 18:01:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8Aau-0004z4-RN
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 18:01:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762058AbaGRQBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2014 12:01:08 -0400
Received: from mout.web.de ([212.227.15.4]:56954 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757115AbaGRQBH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2014 12:01:07 -0400
Received: from [192.168.178.27] ([79.250.167.186]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MPH2u-1XCaR53lcu-004PVD; Fri, 18 Jul 2014 18:01:03
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Provags-ID: V03:K0:UZRCMWk+ev8aJgJ/5HCPML9G50KQ4QmneKxjvEj1pOtvXkzeQB8
 2m7dWswIIMYgypyTMNBAnnnItNfHJ8OA5KNqllfgEBzOfmjNmkPdFeht+3CeUh9zAwxsULp
 CgZxy1pBCnNfbL9g6rJjhFzHHc2XltZ/VI2sJ/h3cMWqt2tw26dEAc2rA+31opfDAisQKQ5
 9jE/cqKB9MJmEuiwJIMIA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253824>

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 fast-import.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fast-import.c b/fast-import.c
index fa635f7..d73f58c 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2324,7 +2324,7 @@ static void file_change_m(const char *p, struct branch *b)
 	}
 
 	/* Git does not track empty, non-toplevel directories. */
-	if (S_ISDIR(mode) && !memcmp(sha1, EMPTY_TREE_SHA1_BIN, 20) && *p) {
+	if (S_ISDIR(mode) && !hashcmp(sha1, EMPTY_TREE_SHA1_BIN) && *p) {
 		tree_content_remove(&b->branch_tree, p, NULL, 0);
 		return;
 	}
-- 
2.0.2
