From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/5] string_list: add a function string_list_remove_empty_items()
Date: Sun,  4 Nov 2012 08:07:06 +0100
Message-ID: <1352012830-13591-2-git-send-email-mhagger@alum.mit.edu>
References: <1352012830-13591-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 04 08:08:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUuJJ-0001EE-BM
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 08:07:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550Ab2KDHHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2012 02:07:30 -0500
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:63249 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750951Ab2KDHHa (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Nov 2012 02:07:30 -0500
X-AuditID: 12074414-b7f846d0000008b8-78-50961431fc17
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id BA.0B.02232.13416905; Sun,  4 Nov 2012 02:07:29 -0500 (EST)
Received: from michael.fritz.box (p57A25973.dip.t-dialin.net [87.162.89.115])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qA477Hw4028486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 4 Nov 2012 02:07:28 -0500
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352012830-13591-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsUixO6iqGsoMi3A4NM+LouuK91MFg29V5gt
	bq+Yz2zxo6WH2YHF4+/7D0wez3r3MHpcvKTs8XmTXABLFLdNUmJJWXBmep6+XQJ3xv8jM1kK
	zopWfFv6ib2BcZtgFyMnh4SAicTP1kmsELaYxIV769m6GLk4hAQuM0rsvLKaGcI5wyRxf84l
	RpAqNgFdiUU9zUwgtoiArMT3wxvB4swCuRKL391mB7GFBQIl5n66wQxiswioSmzcNxmsnlfA
	ReJVywd2iG1yEh/2PAKzOQVcJTZcaWPpYuQAWuYi0fm2fgIj7wJGhlWMcok5pbm6uYmZOcWp
	ybrFyYl5ealFuhZ6uZkleqkppZsYIeEjsoPxyEm5Q4wCHIxKPLy/V0wNEGJNLCuuzD3EKMnB
	pCTKe0l4WoAQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd4tn4HKeVMSK6tSi/JhUtIcLErivN8W
	q/sJCaQnlqRmp6YWpBbBZGU4OJQkeFeBDBUsSk1PrUjLzClBSDNxcIIILpANPEAbtoMU8hYX
	JOYWZ6ZDFJ1iVJQS5zUCSQiAJDJK8+AGwCL9FaM40D/CvHYgVTzAJAHX/QpoMBPI4EtTQAaX
	JCKkpBoYvfmmTU9cvPRYFVd+15SpkZrpQre/vHucV9MsnV/5Woln1oRr9bJH3042mRrY42b+
	WirLWbhrW8iiOy/l4rbul75yyI1Dw43ZUWgDi3OIdW+Xq+eD3b8dXgudabRlCmieUXGd+/S8
	u53X2Ndmb/aM0WaODmvY4xIqJ/PilWO91IbrhWlvAyyVWIozEg21mIuKEwGYbCq3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209019>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-string-list.txt | 9 ++++++++-
 string-list.c                               | 9 +++++++++
 string-list.h                               | 7 +++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
index 94d7a2b..7386bca 100644
--- a/Documentation/technical/api-string-list.txt
+++ b/Documentation/technical/api-string-list.txt
@@ -38,7 +38,8 @@ member (you need this if you add things later) and you should set the
   `unsorted_string_list_delete_item`.
 
 . Can remove items not matching a criterion from a sorted or unsorted
-  list using `filter_string_list`.
+  list using `filter_string_list`, or remove empty strings using
+  `string_list_remove_empty_items`.
 
 . Finally it should free the list using `string_list_clear`.
 
@@ -75,6 +76,12 @@ Functions
 	to be deleted.  Preserve the order of the items that are
 	retained.
 
+`string_list_remove_empty_items`::
+
+	Remove any empty strings from the list.  If free_util is true,
+	call free() on the util members of any items that have to be
+	deleted.  Preserve the order of the items that are retained.
+
 `string_list_longest_prefix`::
 
 	Return the longest string within a string_list that is a
diff --git a/string-list.c b/string-list.c
index c54b816..397e6cf 100644
--- a/string-list.c
+++ b/string-list.c
@@ -136,6 +136,15 @@ void filter_string_list(struct string_list *list, int free_util,
 	list->nr = dst;
 }
 
+static int item_is_not_empty(struct string_list_item *item, void *unused)
+{
+	return *item->string != '\0';
+}
+
+void string_list_remove_empty_items(struct string_list *list, int free_util) {
+	filter_string_list(list, free_util, item_is_not_empty, NULL);
+}
+
 char *string_list_longest_prefix(const struct string_list *prefixes,
 				 const char *string)
 {
diff --git a/string-list.h b/string-list.h
index 5efd07b..c50b0d0 100644
--- a/string-list.h
+++ b/string-list.h
@@ -39,6 +39,13 @@ void filter_string_list(struct string_list *list, int free_util,
 			string_list_each_func_t want, void *cb_data);
 
 /*
+ * Remove any empty strings from the list.  If free_util is true, call
+ * free() on the util members of any items that have to be deleted.
+ * Preserve the order of the items that are retained.
+ */
+void string_list_remove_empty_items(struct string_list *list, int free_util);
+
+/*
  * Return the longest string in prefixes that is a prefix (in the
  * sense of prefixcmp()) of string, or NULL if no such prefix exists.
  * This function does not require the string_list to be sorted (it
-- 
1.8.0
