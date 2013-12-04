From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [RFC 08/11] string_list_append_list(): new function
Date: Wed,  4 Dec 2013 06:44:47 +0100
Message-ID: <1386135890-13954-9-git-send-email-mhagger@alum.mit.edu>
References: <1386135890-13954-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 04 06:53:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vo5Ok-0008Hf-G4
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 06:53:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754469Ab3LDFxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 00:53:19 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:57647 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754391Ab3LDFxS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Dec 2013 00:53:18 -0500
X-AuditID: 1207440c-b7f566d000004272-53-529ec17c1416
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 3E.0A.17010.C71CE925; Wed,  4 Dec 2013 00:45:32 -0500 (EST)
Received: from michael.fritz.box (p57A24C7E.dip0.t-ipconnect.de [87.162.76.126])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id rB45jCAD016667
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 4 Dec 2013 00:45:31 -0500
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1386135890-13954-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsUixO6iqFtzcF6Qwc2jShZdV7qZLBp6rzBb
	3F4xn9mB2ePv+w9MHhcvKXt83iQXwBzFbZOUWFIWnJmep2+XwJ2xZNE3xoIv4hV/N01mamC8
	LNzFyMkhIWAi8WXbLnYIW0ziwr31bF2MXBxCApcZJVYdmsoE4Zxnknh07hgbSBWbgK7Eop5m
	JhBbREBc4u3xmUDdHBzMAhESh96WgISFBWwkXp56DjaURUBVYkrjazCbV8BFYuvFZVDLFCQ6
	1/xnBLE5BVwlOnqXMIOMEQKquXfWaQIj7wJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFuoZ6
	uZkleqkppZsYIYHCs4Px2zqZQ4wCHIxKPLwJnPOChFgTy4orcw8xSnIwKYny1m8HCvEl5adU
	ZiQWZ8QXleakFh9ilOBgVhLhtSkDyvGmJFZWpRblw6SkOViUxHlVl6j7CQmkJ5akZqemFqQW
	wWRlODiUJHg3HgBqFCxKTU+tSMvMKUFIM3FwgggukA08QBvWgRTyFhck5hZnpkMUnWJUlBLn
	nQySEABJZJTmwQ2AxfQrRnGgf4R5D4NU8QDTAVz3K6DBTECDzV/NAhlckoiQkmpg1DUMP6l3
	2oWJ/SiDJKNoVT5j0RqrsxvfHWapua6lEWeUIen64EHw71SplXKKyw1b7u579Uq0r0deJFBR
	9RCb9cy3Le5fykP1OX7NKhaWu1gYPnW/bIn9UZU/r7afOn9JPLdYsErspjPXY6PelHbzLwe0
	m3/9neHNbL13Uea8kwxXul951XAosRRnJBpqMRcVJwIADPQLHsQCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238763>

Add a new function that appends the strings from one string_list onto
another string_list.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-string-list.txt | 10 ++++++++--
 string-list.c                               |  9 +++++++++
 string-list.h                               |  8 ++++++++
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
index 20be348..2072cf7 100644
--- a/Documentation/technical/api-string-list.txt
+++ b/Documentation/technical/api-string-list.txt
@@ -22,8 +22,9 @@ member (you need this if you add things later) and you should set the
 `nr` and `alloc` members in that case, too.
 
 . Adds new items to the list, using `string_list_append`,
-  `string_list_append_nodup`, `string_list_insert`,
-  `string_list_split`, and/or `string_list_split_in_place`.
+  `string_list_append_nodup`, `string_list_append_list`,
+  `string_list_insert`, `string_list_split`, and/or
+  `string_list_split_in_place`.
 
 . Can check if a string is in the list using `string_list_has_string` or
   `unsorted_string_list_has_string` and get it from the list using
@@ -141,6 +142,11 @@ write `string_list_insert(...)->util = ...;`.
 	ownership of a malloc()ed string to a `string_list` that has
 	`strdup_string` set.
 
+`string_list_append_list`::
+
+	Append the strings from one string_list to the end of another
+	one.
+
 `sort_string_list`::
 
 	Sort the list's entries by string value in `strcmp()` order.
diff --git a/string-list.c b/string-list.c
index aabb25e..803acd1 100644
--- a/string-list.c
+++ b/string-list.c
@@ -212,6 +212,15 @@ struct string_list_item *string_list_append(struct string_list *list,
 			list->strdup_strings ? xstrdup(string) : (char *)string);
 }
 
+void string_list_append_list(struct string_list *dst, struct string_list *src)
+{
+	struct string_list_item *item;
+
+	ALLOC_GROW(dst->items, dst->nr + src->nr, dst->alloc);
+	for_each_string_list_item(item, src)
+		string_list_append(dst, item->string);
+}
+
 /* Yuck */
 static compare_strings_fn compare_for_qsort;
 
diff --git a/string-list.h b/string-list.h
index de6769c..7b0ae86 100644
--- a/string-list.h
+++ b/string-list.h
@@ -76,6 +76,14 @@ void string_list_remove_duplicates(struct string_list *sorted_list, int free_uti
 struct string_list_item *string_list_append(struct string_list *list, const char *string);
 
 /*
+ * Add all strings from src to the end of dst.  If dst->strdup_string
+ * is set, then the strings are copied; otherwise the new
+ * string_list_entries refer to the input strings.  src is left
+ * unchanged.
+ */
+void string_list_append_list(struct string_list *dst, struct string_list *src);
+
+/*
  * Like string_list_append(), except string is never copied.  When
  * list->strdup_strings is set, this function can be used to hand
  * ownership of a malloc()ed string to list without making an extra
-- 
1.8.4.3
