From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 17/18] object.c: remove unused functions
Date: Mon, 11 Jan 2010 23:53:00 -0800
Message-ID: <1263282781-25596-18-git-send-email-gitster@pobox.com>
References: <1263282781-25596-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 08:53:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUbZW-0004h8-B8
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 08:53:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753508Ab0ALHxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 02:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753495Ab0ALHxp
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 02:53:45 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41272 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490Ab0ALHxn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 02:53:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0571A8E8B4
	for <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=W1ND
	8FpzIeALr/kjaDCm2Spi1Hc=; b=qh+71hVZlwbhNNMAmhnml/NsskWZxznNy5zQ
	C1y6THaCTE670k6+OETBsQqx5TYosSE02aVGwxt0jX1nO3/h++rRhUL1n7ppXhma
	x6Wk7wblfBc1rAXJZUJPVWpkgb1AnOcRvI/UqvVC2+vdjiPjRM74Gq67BkuQzkWN
	ez/RMQM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=LW8TLl
	HkHqCDfj+ha22wUp7aq/rtV+Vbg4A0Qtk76AxKKTKgmLeaEY9zXFmoCTNgKiqydw
	Aiu5CQozBfOzbvPKz+SYRI7QknC6c0QAM7io/c+/UPodDijmFT6ZmXtDxDgrhg6e
	BXfanDz1nfSfrLNQ1WFYiuODH+761z7NotiJI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F11698E8B3
	for <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C7DE8E8B2 for
 <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:42 -0500 (EST)
X-Mailer: git-send-email 1.6.6.280.ge295b7.dirty
In-Reply-To: <1263282781-25596-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 9AA36686-FF4F-11DE-A07A-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136691>

object_list_append() and object_list_length}() are not used anywhere.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 object.c |   21 ---------------------
 object.h |    5 -----
 2 files changed, 0 insertions(+), 26 deletions(-)

diff --git a/object.c b/object.c
index fe8eaaf..3ca92c4 100644
--- a/object.c
+++ b/object.c
@@ -217,27 +217,6 @@ struct object_list *object_list_insert(struct object *item,
         return new_list;
 }
 
-void object_list_append(struct object *item,
-			struct object_list **list_p)
-{
-	while (*list_p) {
-		list_p = &((*list_p)->next);
-	}
-	*list_p = xmalloc(sizeof(struct object_list));
-	(*list_p)->next = NULL;
-	(*list_p)->item = item;
-}
-
-unsigned object_list_length(struct object_list *list)
-{
-	unsigned ret = 0;
-	while (list) {
-		list = list->next;
-		ret++;
-	}
-	return ret;
-}
-
 int object_list_contains(struct object_list *list, struct object *obj)
 {
 	while (list) {
diff --git a/object.h b/object.h
index 89dd0c4..82877c8 100644
--- a/object.h
+++ b/object.h
@@ -72,11 +72,6 @@ struct object *lookup_unknown_object(const unsigned  char *sha1);
 struct object_list *object_list_insert(struct object *item,
 				       struct object_list **list_p);
 
-void object_list_append(struct object *item,
-			struct object_list **list_p);
-
-unsigned object_list_length(struct object_list *list);
-
 int object_list_contains(struct object_list *list, struct object *obj);
 
 /* Object array handling .. */
-- 
1.6.6.280.ge295b7.dirty
