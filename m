From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] commit: use commit_list_append() instead of duplicating its
 code
Date: Thu, 10 Jul 2014 11:47:47 +0200
Message-ID: <53BE6143.1000507@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 10 11:48:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5AxP-0001In-3g
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 11:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752183AbaGJJr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 05:47:59 -0400
Received: from mout.web.de ([212.227.17.12]:53151 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751987AbaGJJr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 05:47:58 -0400
Received: from [192.168.178.27] ([79.253.174.99]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0Lx7Ab-1WYVpF1DJp-016f4g; Thu, 10 Jul 2014 11:47:56
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Provags-ID: V03:K0:aq7/vWqHMQm6474LE/jR73loWW8U/8SeFDQambg1aNLpHxAU9pM
 loF9MEBo7JLh90KUSavLjxVNqnqdu9pdM0y6RSst7BYCL4E4RcO2D1bQziD2STBIv/PgRn0
 hHgIifFywmr4Nsjf9ZO3D8y1AiuHSLIydOx8nbBoLoMDS3Vp1E605uMO6VjM9vPIJfiOUzR
 ZVlUY7s+EBot4F8yIz4Zg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253183>

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 commit.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/commit.c b/commit.c
index fb7897c..61d2e13 100644
--- a/commit.c
+++ b/commit.c
@@ -447,12 +447,7 @@ struct commit_list *copy_commit_list(struct commit_list *list)
 	struct commit_list *head = NULL;
 	struct commit_list **pp = &head;
 	while (list) {
-		struct commit_list *new;
-		new = xmalloc(sizeof(struct commit_list));
-		new->item = list->item;
-		new->next = NULL;
-		*pp = new;
-		pp = &new->next;
+		pp = commit_list_append(list->item, pp);
 		list = list->next;
 	}
 	return head;
-- 
2.0.0
