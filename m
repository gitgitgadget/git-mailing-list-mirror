From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@lavabit.com>
Subject: [PATCH] object.c: remove unused functions
Date: Thu, 19 Jun 2008 08:21:08 +0900
Message-ID: <20080619082108.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 01:48:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K97Nm-00021h-IQ
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 01:48:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752942AbYFRXq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 19:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754776AbYFRXq4
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 19:46:56 -0400
Received: from karen.lavabit.com ([72.249.41.33]:37482 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753421AbYFRXqu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 19:46:50 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id E148FC7AFD;
	Wed, 18 Jun 2008 18:21:37 -0500 (CDT)
Received: from nanako3.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id HQGX2HJD6OPD; Wed, 18 Jun 2008 18:21:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=HAb7L5db+IO5xWo+5DeQs2Fx/NGD8EdcQed4o5rNB6Du661fgZZksiEsDafTH3Vluk6CXjQD4ZZIlSOqCH2+e76yj5gjwwOvY/TsgTgdaj3BuyjHYgNPYOi99jN7vc5Bwn18oUBO9/7kONXLHIo/s8/aYY0zKGVDGb5/3nQhMg4=;
  h=From:Date:To:Cc:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85428>

Removes unused functions object_list_append(), object_list_legnth() and
bject_list_contains().

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---

This is my first foray into C programming, so please be kind.

 object.c |   31 -------------------------------
 object.h |    7 -------
 2 files changed, 0 insertions(+), 38 deletions(-)

diff --git a/object.c b/object.c
index 50b6528..b386d58 100644
--- a/object.c
+++ b/object.c
@@ -215,37 +215,6 @@ struct object_list *object_list_insert(struct object *item,
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
-int object_list_contains(struct object_list *list, struct object *obj)
-{
-	while (list) {
-		if (list->item == obj)
-			return 1;
-		list = list->next;
-	}
-	return 0;
-}
-
 void add_object_array(struct object *obj, const char *name, struct object_array *array)
 {
 	add_object_array_with_mode(obj, name, array, S_IFINVALID);
diff --git a/object.h b/object.h
index 036bd66..8405fd2 100644
--- a/object.h
+++ b/object.h
@@ -61,13 +61,6 @@ struct object *lookup_unknown_object(const unsigned  char *sha1);
 struct object_list *object_list_insert(struct object *item,
 				       struct object_list **list_p);
 
-void object_list_append(struct object *item,
-			struct object_list **list_p);
-
-unsigned object_list_length(struct object_list *list);
-
-int object_list_contains(struct object_list *list, struct object *obj);
-
 /* Object array handling .. */
 void add_object_array(struct object *obj, const char *name, struct object_array *array);
 void add_object_array_with_mode(struct object *obj, const char *name, struct object_array *array, unsigned mode);
-- 
1.5.5.4
