From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 8/8] string_list_longest_prefix(): remove function
Date: Sun, 28 Oct 2012 17:16:27 +0100
Message-ID: <1351440987-26636-9-git-send-email-mhagger@alum.mit.edu>
References: <1351440987-26636-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 28 17:17:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSVYN-0003ej-Cl
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 17:17:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753279Ab2J1QRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 12:17:18 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:52361 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753096Ab2J1QRQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Oct 2012 12:17:16 -0400
X-AuditID: 1207440f-b7fde6d00000095c-e7-508d5a8b544b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 35.D2.02396.B8A5D805; Sun, 28 Oct 2012 12:17:15 -0400 (EDT)
Received: from michael.fritz.box (p57A2465E.dip.t-dialin.net [87.162.70.94])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q9SGGXJi002689
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 28 Oct 2012 12:17:14 -0400
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351440987-26636-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsUixO6iqNsd1RtgMK3TyKLrSjeTRUPvFWaL
	J3PvMlscPWVhcXvFfGaLHy09zBbr311ldmD3+Pv+A5PHzll32T0evupi93jWu4fR4+IlZY/P
	m+QC2KK4bZISS8qCM9Pz9O0SuDMWnLjPXNCuXXFwcgtjA+NhpS5GTg4JAROJlweOMEHYYhIX
	7q1n62Lk4hASuMwo8Xv2dnYI5wyTxKddf8Cq2AR0JRb1NIPZIgKyEt8Pb2QEKWIWuMsoMeno
	VDaQhLCAq8TVO7NYQGwWAVWJfd+fgDXwCrhILNz1lgVinZzEhz2PgDZwcHAC1R/tdwYJCwGV
	/Fn1jnECI+8CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbomermZJXqpKaWbGCEBx7+DsWu9
	zCFGAQ5GJR7eSwU9AUKsiWXFlbmHGCU5mJREeZmDegOE+JLyUyozEosz4otKc1KLDzFKcDAr
	ifAu5QbK8aYkVlalFuXDpKQ5WJTEedWXqPsJCaQnlqRmp6YWpBbBZGU4OJQkeC9EAjUKFqWm
	p1akZeaUIKSZODhBBBfIBh6gDetACnmLCxJzizPTIYpOMSpKifMeiwBKCIAkMkrz4AbAUsMr
	RnGgf4R5H4O08wDTClz3K6DBTECDdfjABpckIqSkGhgrrjirz/od/d1svk1at/XqrYbrbatE
	Hy+6cj5wfbRRPdekxJ8yHMoiAdu7Uqck7pL+w1W7dK1eWVbEw+rjk+fmJnad7opk28lWXvck
	QGM/bxCjneLXFY7PvB/uWLxlzt43tx/8E+dmkfk+y4U7/YKuVvTs8G0H33HpfNae 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208558>

This function was added in f103f95b11d087f07c0c48bf784cd9197e18f203 in
the erroneous expectation that it would be used in the
reimplementation of longest_ancestor_length().  But it turned out to
be easier to use a function specialized for comparing path prefixes
(i.e., one that knows about slashes and root paths) than to prepare
the paths in such a way that a generic string prefix comparison
function can be used.  So delete string_list_longest_prefix() and its
documentation and test cases.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-string-list.txt |  8 --------
 string-list.c                               | 20 -------------------
 string-list.h                               |  8 --------
 t/t0063-string-list.sh                      | 30 -----------------------------
 test-string-list.c                          | 20 -------------------
 5 files changed, 86 deletions(-)

diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
index 94d7a2b..618400d 100644
--- a/Documentation/technical/api-string-list.txt
+++ b/Documentation/technical/api-string-list.txt
@@ -75,14 +75,6 @@ Functions
 	to be deleted.  Preserve the order of the items that are
 	retained.
 
-`string_list_longest_prefix`::
-
-	Return the longest string within a string_list that is a
-	prefix (in the sense of prefixcmp()) of the specified string,
-	or NULL if no such prefix exists.  This function does not
-	require the string_list to be sorted (it does a linear
-	search).
-
 `print_string_list`::
 
 	Dump a string_list to stdout, useful mainly for debugging purposes. It
diff --git a/string-list.c b/string-list.c
index c54b816..decfa74 100644
--- a/string-list.c
+++ b/string-list.c
@@ -136,26 +136,6 @@ void filter_string_list(struct string_list *list, int free_util,
 	list->nr = dst;
 }
 
-char *string_list_longest_prefix(const struct string_list *prefixes,
-				 const char *string)
-{
-	int i, max_len = -1;
-	char *retval = NULL;
-
-	for (i = 0; i < prefixes->nr; i++) {
-		char *prefix = prefixes->items[i].string;
-		if (!prefixcmp(string, prefix)) {
-			int len = strlen(prefix);
-			if (len > max_len) {
-				retval = prefix;
-				max_len = len;
-			}
-		}
-	}
-
-	return retval;
-}
-
 void string_list_clear(struct string_list *list, int free_util)
 {
 	if (list->items) {
diff --git a/string-list.h b/string-list.h
index 5efd07b..3a6a6dc 100644
--- a/string-list.h
+++ b/string-list.h
@@ -38,14 +38,6 @@ int for_each_string_list(struct string_list *list,
 void filter_string_list(struct string_list *list, int free_util,
 			string_list_each_func_t want, void *cb_data);
 
-/*
- * Return the longest string in prefixes that is a prefix (in the
- * sense of prefixcmp()) of string, or NULL if no such prefix exists.
- * This function does not require the string_list to be sorted (it
- * does a linear search).
- */
-char *string_list_longest_prefix(const struct string_list *prefixes, const char *string);
-
 
 /* Use these functions only on sorted lists: */
 int string_list_has_string(const struct string_list *list, const char *string);
diff --git a/t/t0063-string-list.sh b/t/t0063-string-list.sh
index 41c8826..dbfc05e 100755
--- a/t/t0063-string-list.sh
+++ b/t/t0063-string-list.sh
@@ -17,14 +17,6 @@ test_split () {
 	"
 }
 
-test_longest_prefix () {
-	test "$(test-string-list longest_prefix "$1" "$2")" = "$3"
-}
-
-test_no_longest_prefix () {
-	test_must_fail test-string-list longest_prefix "$1" "$2"
-}
-
 test_split "foo:bar:baz" ":" "-1" <<EOF
 3
 [0]: "foo"
@@ -96,26 +88,4 @@ test_expect_success "test remove_duplicates" '
 	test a:b:c = "$(test-string-list remove_duplicates a:a:a:b:b:b:c:c:c)"
 '
 
-test_expect_success "test longest_prefix" '
-	test_no_longest_prefix - '' &&
-	test_no_longest_prefix - x &&
-	test_longest_prefix "" x "" &&
-	test_longest_prefix x x x &&
-	test_longest_prefix "" foo "" &&
-	test_longest_prefix : foo "" &&
-	test_longest_prefix f foo f &&
-	test_longest_prefix foo foobar foo &&
-	test_longest_prefix foo foo foo &&
-	test_no_longest_prefix bar foo &&
-	test_no_longest_prefix bar:bar foo &&
-	test_no_longest_prefix foobar foo &&
-	test_longest_prefix foo:bar foo foo &&
-	test_longest_prefix foo:bar bar bar &&
-	test_longest_prefix foo::bar foo foo &&
-	test_longest_prefix foo:foobar foo foo &&
-	test_longest_prefix foobar:foo foo foo &&
-	test_longest_prefix foo: bar "" &&
-	test_longest_prefix :foo bar ""
-'
-
 test_done
diff --git a/test-string-list.c b/test-string-list.c
index 4693295..00ce6c9 100644
--- a/test-string-list.c
+++ b/test-string-list.c
@@ -97,26 +97,6 @@ int main(int argc, char **argv)
 		return 0;
 	}
 
-	if (argc == 4 && !strcmp(argv[1], "longest_prefix")) {
-		/* arguments: <colon-separated-prefixes>|- <string> */
-		struct string_list prefixes = STRING_LIST_INIT_DUP;
-		int retval;
-		const char *prefix_string = argv[2];
-		const char *string = argv[3];
-		const char *match;
-
-		parse_string_list(&prefixes, prefix_string);
-		match = string_list_longest_prefix(&prefixes, string);
-		if (match) {
-			printf("%s\n", match);
-			retval = 0;
-		}
-		else
-			retval = 1;
-		string_list_clear(&prefixes, 0);
-		return retval;
-	}
-
 	fprintf(stderr, "%s: unknown function name: %s\n", argv[0],
 		argv[1] ? argv[1] : "(there was none)");
 	return 1;
-- 
1.8.0
