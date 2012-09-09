From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/4] Add a new function, string_list_split_in_place()
Date: Sun,  9 Sep 2012 07:53:07 +0200
Message-ID: <1347169990-9279-2-git-send-email-mhagger@alum.mit.edu>
References: <1347169990-9279-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 09 07:54:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAaTo-0003vs-5w
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 07:54:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114Ab2IIFyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 01:54:31 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:43616 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751521Ab2IIFxr (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Sep 2012 01:53:47 -0400
X-AuditID: 1207440e-b7f036d0000008b5-7d-504c2eeaa203
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 17.9D.02229.AEE2C405; Sun,  9 Sep 2012 01:53:46 -0400 (EDT)
Received: from michael.fritz.box (p57A25CBD.dip.t-dialin.net [87.162.92.189])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q895raZA028212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 9 Sep 2012 01:53:45 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1347169990-9279-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMIsWRmVeSWpSXmKPExsUixO6iqPtKzyfA4MQkHYuuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M6Y3rKGsWC3ecW8z6dYGxin
	6HQxcnJICJhI3Lj8iQnCFpO4cG89WxcjF4eQwGVGiX2rN0M5Z5gktq89ygJSxSagK7Gopxms
	Q0RATWJi2yGwOLOAg8Tmz42MILawgKvE4VvXwGpYBFQljp8+xQ5i8wo4S5ybcg9qm6LEj+9r
	mEFsTgEXidtXd4PVCAHVfP98mX0CI+8CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbrGermZ
	JXqpKaWbGCHBwreDsX29zCFGAQ5GJR5e5jveAUKsiWXFlbmHGCU5mJREec21fQKE+JLyUyoz
	Eosz4otKc1KLDzFKcDArifBeZQfK8aYkVlalFuXDpKQ5WJTEedWWqPsJCaQnlqRmp6YWpBbB
	ZGU4OJQkeC/pAjUKFqWmp1akZeaUIKSZODhBBBfIBh6gDS4ghbzFBYm5xZnpEEWnGBWlxHnP
	gSQEQBIZpXlwA2Bx/YpRHOgfYd5VIFU8wJQA1/0KaDAT0GCRZx4gg0sSEVJSDYwWBuf3/mNm
	P8acv5I/qXiyjd+jI08aThQ1pt/KcDzMNU+lk33d+yqdjFkyX/eyH5nFrTDFyyylSD/2rsgr
	STu7e2dsdofFHeGbnPJT12uj74QTbgkfbntPWOK8z3qvjsCN/BUyx7bJbTl36347d6+MYcOp
	8hn64Rxefn5ykYe4Lhv7tf1ZYq7EUpyRaKjFXFScCADoIU/ExgIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205048>

Split a string into a string_list on a separator character.

This is similar to the strbuf_split_*() functions except that it works
with the more powerful string_list interface.  If strdup_strings is
false, it reuses the memory from the input string (thereby needing no
string memory allocations, though of course allocations are still
needed for the string_list_items array).

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

In the tests, I use here documents to specify the expected output.  Is
this OK?  (It is certainly convenient.)

 .gitignore                                  |  1 +
 Documentation/technical/api-string-list.txt | 12 ++++++
 Makefile                                    |  1 +
 string-list.c                               | 23 +++++++++++
 string-list.h                               | 19 +++++++++
 t/t0063-string-list.sh                      | 63 +++++++++++++++++++++++++++++
 test-string-list.c                          | 25 ++++++++++++
 7 files changed, 144 insertions(+)
 create mode 100755 t/t0063-string-list.sh
 create mode 100644 test-string-list.c

diff --git a/.gitignore b/.gitignore
index bb5c91e..0ca7df8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -193,6 +193,7 @@
 /test-run-command
 /test-sha1
 /test-sigchain
+/test-string-list
 /test-subprocess
 /test-svn-fe
 /common-cmds.h
diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
index 5a0c14f..3b959a2 100644
--- a/Documentation/technical/api-string-list.txt
+++ b/Documentation/technical/api-string-list.txt
@@ -124,6 +124,18 @@ counterpart for sorted lists, which performs a binary search.
 	is set. The third parameter controls if the `util` pointer of the
 	items should be freed or not.
 
+`string_list_split_in_place`::
+
+	Split string into substrings on character delim and append the
+	substrings to a string_list.  The delimiter characters in
+	string are overwritten with NULs in the process.  If maxsplit
+	is a positive integer, then split at most maxsplit times.  If
+	list.strdup_strings is not set, then the new string_list_items
+	point into string, which therefore must not be modified or
+	freed while the string_list is in use.  Return the number of
+	substrings appended to the list.
+
+
 Data structures
 ---------------
 
diff --git a/Makefile b/Makefile
index 66e8216..ebbb381 100644
--- a/Makefile
+++ b/Makefile
@@ -501,6 +501,7 @@ TEST_PROGRAMS_NEED_X += test-run-command
 TEST_PROGRAMS_NEED_X += test-scrap-cache-tree
 TEST_PROGRAMS_NEED_X += test-sha1
 TEST_PROGRAMS_NEED_X += test-sigchain
+TEST_PROGRAMS_NEED_X += test-string-list
 TEST_PROGRAMS_NEED_X += test-subprocess
 TEST_PROGRAMS_NEED_X += test-svn-fe
 
diff --git a/string-list.c b/string-list.c
index d9810ab..110449c 100644
--- a/string-list.c
+++ b/string-list.c
@@ -194,3 +194,26 @@ void unsorted_string_list_delete_item(struct string_list *list, int i, int free_
 	list->items[i] = list->items[list->nr-1];
 	list->nr--;
 }
+
+int string_list_split_in_place(struct string_list *list, char *string,
+			       int delim, int maxsplit)
+{
+	int count = 0;
+	char *p = string, *end;
+	for (;;) {
+		count++;
+		if (maxsplit > 0 && count > maxsplit) {
+			string_list_append(list, p);
+			return count;
+		}
+		end = strchr(p, delim);
+		if (end) {
+			*end = '\0';
+			string_list_append(list, p);
+			p = end + 1;
+		} else {
+			string_list_append(list, p);
+			return count;
+		}
+	}
+}
diff --git a/string-list.h b/string-list.h
index 0684cb7..7e51d03 100644
--- a/string-list.h
+++ b/string-list.h
@@ -45,4 +45,23 @@ int unsorted_string_list_has_string(struct string_list *list, const char *string
 struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
 						     const char *string);
 void unsorted_string_list_delete_item(struct string_list *list, int i, int free_util);
+
+/*
+ * Split string into substrings on character delim and append the
+ * substrings to list.  The delimiter characters in string are
+ * overwritten with NULs in the process.  If maxsplit is a positive
+ * integer, then split at most maxsplit times.  If list.strdup_strings
+ * is not set, then the new string_list_items point into string, which
+ * therefore must not be modified or freed while the string_list
+ * is in use.  Return the number of substrings appended to list.
+ *
+ * Examples:
+ *   string_list_split_in_place(l, "foo:bar:baz", ':', -1) -> ["foo", "bar", "baz"]
+ *   string_list_split_in_place(l, "foo:bar:baz", ':', 1) -> ["foo", "bar:baz"]
+ *   string_list_split_in_place(l, "foo:bar:", ':', -1) -> ["foo", "bar", ""]
+ *   string_list_split_in_place(l, "", ':', -1) -> [""]
+ *   string_list_split_in_place(l, ":", ':', -1) -> ["", ""]
+ */
+int string_list_split_in_place(struct string_list *list, char *string,
+			       int delim, int maxsplit);
 #endif /* STRING_LIST_H */
diff --git a/t/t0063-string-list.sh b/t/t0063-string-list.sh
new file mode 100755
index 0000000..0eede83
--- /dev/null
+++ b/t/t0063-string-list.sh
@@ -0,0 +1,63 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 Michael Haggerty
+#
+
+test_description='Test string list functionality'
+
+. ./test-lib.sh
+
+string_list_split_in_place() {
+	cat >split-expected &&
+	test_expect_success "split $1 $2 $3" "
+		test-string-list split_in_place '$1' '$2' '$3' >split-actual &&
+		test_cmp split-expected split-actual
+	"
+}
+
+string_list_split_in_place "foo:bar:baz" ":" "-1" <<EOF
+3
+[0]: "foo"
+[1]: "bar"
+[2]: "baz"
+EOF
+
+string_list_split_in_place "foo:bar:baz" ":" "0" <<EOF
+3
+[0]: "foo"
+[1]: "bar"
+[2]: "baz"
+EOF
+
+string_list_split_in_place "foo:bar:baz" ":" "1" <<EOF
+2
+[0]: "foo"
+[1]: "bar:baz"
+EOF
+
+string_list_split_in_place "foo:bar:baz" ":" "2" <<EOF
+3
+[0]: "foo"
+[1]: "bar"
+[2]: "baz"
+EOF
+
+string_list_split_in_place "foo:bar:" ":" "-1" <<EOF
+3
+[0]: "foo"
+[1]: "bar"
+[2]: ""
+EOF
+
+string_list_split_in_place "" ":" "-1" <<EOF
+1
+[0]: ""
+EOF
+
+string_list_split_in_place ":" ":" "-1" <<EOF
+2
+[0]: ""
+[1]: ""
+EOF
+
+test_done
diff --git a/test-string-list.c b/test-string-list.c
new file mode 100644
index 0000000..f08d3cc
--- /dev/null
+++ b/test-string-list.c
@@ -0,0 +1,25 @@
+#include "cache.h"
+#include "string-list.h"
+
+int main(int argc, char **argv)
+{
+	if ((argc == 4 || argc == 5) && !strcmp(argv[1], "split_in_place")) {
+		struct string_list list = STRING_LIST_INIT_NODUP;
+		int i;
+		char *s = xstrdup(argv[2]);
+		int delim = *argv[3];
+		int maxsplit = (argc == 5) ? atoi(argv[4]) : -1;
+
+		i = string_list_split_in_place(&list, s, delim, maxsplit);
+		printf("%d\n", i);
+		for (i = 0; i < list.nr; i++)
+			printf("[%d]: \"%s\"\n", i, list.items[i].string);
+		string_list_clear(&list, 0);
+		free(s);
+		return 0;
+	}
+
+	fprintf(stderr, "%s: unknown function name: %s\n", argv[0],
+		argv[1] ? argv[1] : "(there was none)");
+	return 1;
+}
-- 
1.7.11.3
