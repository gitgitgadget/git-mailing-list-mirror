From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 5/6] string_list: add a function string_list_longest_prefix()
Date: Mon, 10 Sep 2012 23:18:45 +0200
Message-ID: <1347311926-5207-6-git-send-email-mhagger@alum.mit.edu>
References: <1347311926-5207-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 23:19:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBBOL-0000q5-IC
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 23:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753927Ab2IJVTU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 17:19:20 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:57931 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752861Ab2IJVTQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Sep 2012 17:19:16 -0400
X-AuditID: 12074411-b7fa36d0000008cc-69-504e59543106
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id D9.B2.02252.4595E405; Mon, 10 Sep 2012 17:19:16 -0400 (EDT)
Received: from michael.fritz.box (p57A25B0C.dip.t-dialin.net [87.162.91.12])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8ALIwqQ020122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 10 Sep 2012 17:19:15 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1347311926-5207-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsUixO6iqBsS6Rdg8OMTt0XXlW4mi4beK8wW
	t1fMZ7b40dLD7MDi8ff9ByaPZ717GD0uXlL2+LxJLoAlitsmKbGkLDgzPU/fLoE749KieWwF
	v9Qrpi/qYmxg/CLfxcjJISFgIrHh9ltWCFtM4sK99WxdjFwcQgKXGSW+fLvOCuGcYZK4MHkS
	WBWbgK7Eop5mJhBbREBNYmLbIRYQm1kgRaLjeTcjiC0sECDxYekJZhCbRUBVYteqy+xdjBwc
	vALOEr82cUEsU5T48X0NWAmngIvE7v6t7CC2EFDJ9xX/WCYw8i5gZFjFKJeYU5qrm5uYmVOc
	mqxbnJyYl5dapGuql5tZopeaUrqJERI+gjsYZ5yUO8QowMGoxMOrweMXIMSaWFZcmXuIUZKD
	SUmU1zAEKMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEN14TKMebklhZlVqUD5OS5mBREuflW6Lu
	JySQnliSmp2aWpBaBJOV4eBQkuC1iwBqFCxKTU+tSMvMKUFIM3FwgggukA08QBtyQQp5iwsS
	c4sz0yGKTjEqSonzGoAkBEASGaV5cANgkf6KURzoH2FeX5AqHmCSgOt+BTSYCWiwr4cPyOCS
	RISUVAOj+NSvOatVTmR9vfd6Oq81x4SVp1wbll1YL7+yf7+m1rcJ23MVrh70FvTpMdDMzdJb
	uF2Wc8YOnciTHndPL/SO31CUqdmeLDLjnW//ObmetvvRjwqClvge8nN0FgjdrngvP1O4ec4n
	Y4P33QGTbd8vPdajr/mU5V+yvc2X+JfvtFdNZ1yRHFKnxFKckWioxVxUnAgAyEWR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205190>

Add a function that finds the longest string from a string_list that
is a prefix of a given string.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-string-list.txt |  8 ++++++++
 string-list.c                               | 20 +++++++++++++++++++
 string-list.h                               |  8 ++++++++
 t/t0063-string-list.sh                      | 30 +++++++++++++++++++++++++++++
 test-string-list.c                          | 20 +++++++++++++++++++
 5 files changed, 86 insertions(+)

diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
index dd9aa3d..231a877 100644
--- a/Documentation/technical/api-string-list.txt
+++ b/Documentation/technical/api-string-list.txt
@@ -75,6 +75,14 @@ Functions
 	to be deleted.  Preserve the order of the items that are
 	retained.
 
+`string_list_longest_prefix`::
+
+	Return the longest string within a string_list that is a
+	prefix (in the sense of prefixcmp()) of the specified string,
+	or NULL if no such prefix exists.  This function does not
+	require the string_list to be sorted (it does a linear
+	search).
+
 `print_string_list`::
 
 	Dump a string_list to stdout, useful mainly for debugging purposes. It
diff --git a/string-list.c b/string-list.c
index e9b7fd8..0b1f00a 100644
--- a/string-list.c
+++ b/string-list.c
@@ -136,6 +136,26 @@ void filter_string_list(struct string_list *list, int free_util,
 	list->nr = dst;
 }
 
+char *string_list_longest_prefix(const struct string_list *prefixes,
+				 const char *string)
+{
+	int i, max_len = -1;
+	char *retval = NULL;
+
+	for (i = 0; i < prefixes->nr; i++) {
+		char *prefix = prefixes->items[i].string;
+		if (!prefixcmp(string, prefix)) {
+			int len = strlen(prefix);
+			if (len > max_len) {
+				retval = prefix;
+				max_len = len;
+			}
+		}
+	}
+
+	return retval;
+}
+
 void string_list_clear(struct string_list *list, int free_util)
 {
 	if (list->items) {
diff --git a/string-list.h b/string-list.h
index 3a6a6dc..5efd07b 100644
--- a/string-list.h
+++ b/string-list.h
@@ -38,6 +38,14 @@ int for_each_string_list(struct string_list *list,
 void filter_string_list(struct string_list *list, int free_util,
 			string_list_each_func_t want, void *cb_data);
 
+/*
+ * Return the longest string in prefixes that is a prefix (in the
+ * sense of prefixcmp()) of string, or NULL if no such prefix exists.
+ * This function does not require the string_list to be sorted (it
+ * does a linear search).
+ */
+char *string_list_longest_prefix(const struct string_list *prefixes, const char *string);
+
 
 /* Use these functions only on sorted lists: */
 int string_list_has_string(const struct string_list *list, const char *string);
diff --git a/t/t0063-string-list.sh b/t/t0063-string-list.sh
index dbfc05e..41c8826 100755
--- a/t/t0063-string-list.sh
+++ b/t/t0063-string-list.sh
@@ -17,6 +17,14 @@ test_split () {
 	"
 }
 
+test_longest_prefix () {
+	test "$(test-string-list longest_prefix "$1" "$2")" = "$3"
+}
+
+test_no_longest_prefix () {
+	test_must_fail test-string-list longest_prefix "$1" "$2"
+}
+
 test_split "foo:bar:baz" ":" "-1" <<EOF
 3
 [0]: "foo"
@@ -88,4 +96,26 @@ test_expect_success "test remove_duplicates" '
 	test a:b:c = "$(test-string-list remove_duplicates a:a:a:b:b:b:c:c:c)"
 '
 
+test_expect_success "test longest_prefix" '
+	test_no_longest_prefix - '' &&
+	test_no_longest_prefix - x &&
+	test_longest_prefix "" x "" &&
+	test_longest_prefix x x x &&
+	test_longest_prefix "" foo "" &&
+	test_longest_prefix : foo "" &&
+	test_longest_prefix f foo f &&
+	test_longest_prefix foo foobar foo &&
+	test_longest_prefix foo foo foo &&
+	test_no_longest_prefix bar foo &&
+	test_no_longest_prefix bar:bar foo &&
+	test_no_longest_prefix foobar foo &&
+	test_longest_prefix foo:bar foo foo &&
+	test_longest_prefix foo:bar bar bar &&
+	test_longest_prefix foo::bar foo foo &&
+	test_longest_prefix foo:foobar foo foo &&
+	test_longest_prefix foobar:foo foo foo &&
+	test_longest_prefix foo: bar "" &&
+	test_longest_prefix :foo bar ""
+'
+
 test_done
diff --git a/test-string-list.c b/test-string-list.c
index 2d6eda7..5e9631f 100644
--- a/test-string-list.c
+++ b/test-string-list.c
@@ -97,6 +97,26 @@ int main(int argc, char **argv)
 		return 0;
 	}
 
+	if (argc == 4 && !strcmp(argv[1], "longest_prefix")) {
+		/* arguments: <colon-separated-prefixes>|- <string> */
+		struct string_list prefixes = STRING_LIST_INIT_DUP;
+		int retval;
+		const char *prefix_string = argv[2];
+		const char *string = argv[3];
+		const char *match;
+
+		parse_string_list(&prefixes, prefix_string);
+		match = string_list_longest_prefix(&prefixes, string);
+		if (match) {
+			printf("%s\n", match);
+			retval = 0;
+		}
+		else
+			retval = 1;
+		string_list_clear(&prefixes, 0);
+		return retval;
+	}
+
 	fprintf(stderr, "%s: unknown function name: %s\n", argv[0],
 		argv[1] ? argv[1] : "(there was none)");
 	return 1;
-- 
1.7.11.3
