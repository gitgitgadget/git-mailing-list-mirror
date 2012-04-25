From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/3] commit: remove commit_list_reverse()
Date: Wed, 25 Apr 2012 22:35:54 +0200
Message-ID: <4F98602A.7020404@lsrfire.ath.cx>
References: <CANV9Rr_ev+34Wd030cps0UbgjRYD0=L2DQhbrCOkBVWG-2xaug@mail.gmail.com> <20120425111435.GA21579@sigill.intra.peff.net> <4F985D0A.9020100@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Michael Mueller <mmueller@vigilantsw.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 25 22:36:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SN8wl-0002Es-CH
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 22:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758875Ab2DYUgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Apr 2012 16:36:14 -0400
Received: from india601.server4you.de ([85.25.151.105]:57259 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758830Ab2DYUgN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2012 16:36:13 -0400
Received: from [192.168.2.105] (p4FFDBB95.dip.t-dialin.net [79.253.187.149])
	by india601.server4you.de (Postfix) with ESMTPSA id 1D6742F808E;
	Wed, 25 Apr 2012 22:36:12 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120420 Thunderbird/12.0
In-Reply-To: <4F985D0A.9020100@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196337>

The function commit_list_reverse() is not used anymore; delete it.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 commit.c |   15 ---------------
 commit.h |    1 -
 2 files changed, 16 deletions(-)

diff --git a/commit.c b/commit.c
index 8361acb..9ed36c7 100644
--- a/commit.c
+++ b/commit.c
@@ -361,21 +361,6 @@ struct commit_list *commit_list_insert(struct commit *item, struct commit_list *
 	return new_list;
 }
 
-void commit_list_reverse(struct commit_list **list_p)
-{
-	struct commit_list *prev = NULL, *curr = *list_p, *next;
-
-	if (!list_p)
-		return;
-	while (curr) {
-		next = curr->next;
-		curr->next = prev;
-		prev = curr;
-		curr = next;
-	}
-	*list_p = prev;
-}
-
 unsigned commit_list_count(const struct commit_list *l)
 {
 	unsigned c = 0;
diff --git a/commit.h b/commit.h
index bd17770..ccaa20b 100644
--- a/commit.h
+++ b/commit.h
@@ -59,7 +59,6 @@ unsigned commit_list_count(const struct commit_list *l);
 struct commit_list *commit_list_insert_by_date(struct commit *item,
 				    struct commit_list **list);
 void commit_list_sort_by_date(struct commit_list **list);
-void commit_list_reverse(struct commit_list **list_p);
 
 void free_commit_list(struct commit_list *list);
 
-- 
1.7.10
