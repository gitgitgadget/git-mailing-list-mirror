From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 08/38] resolve_missing_loose_ref(): add a files_ref_store argument
Date: Fri,  3 Jun 2016 23:03:43 +0200
Message-ID: <6caa9cba0e57dd8fd84e2c37b7ad4e5fcd83098c.1464983301.git.mhagger@alum.mit.edu>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 23:06:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8wIX-0001b3-6T
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 23:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933028AbcFCVGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 17:06:24 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:58635 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932834AbcFCVEk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 17:04:40 -0400
X-AuditID: 1207440e-ef3ff700000008c5-49-5751f0e76adc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 42.68.02245.7E0F1575; Fri,  3 Jun 2016 17:04:39 -0400 (EDT)
Received: from michael.fritz.box (p548D60E2.dip0.t-ipconnect.de [84.141.96.226])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u53L4KcY003260
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 3 Jun 2016 17:04:37 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1464983301.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsUixO6iqPv8Q2C4wdw/whbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2uLMm0ZGBw6Pv+8/MHnsnHWX3eNZ7x5Gj4uXlD32
	L93G5rH4gZfHguf32T0+b5IL4IjitklKLCkLzkzP07dL4M74M+8Ma8Er3oo3/TeYGxh/c3Ux
	cnJICJhIXN30hqWLkYtDSGAro8SfxsfsEM5xJokpbVfYQKrYBHQlFvU0M4HYIgIREg2vWhhB
	ipgF5jBJ3H7YyQySEBYIkrj+5TKYzSKgKnGjswXM5hWIkli25DIjxDo5icvTH4AN5RSwkGj5
	vIoVxBYSMJdoPHWYZQIjzwJGhlWMcok5pbm6uYmZOcWpybrFyYl5ealFusZ6uZkleqkppZsY
	IWHHt4Oxfb3MIUYBDkYlHt6CZ4HhQqyJZcWVuYcYJTmYlER5994BCvEl5adUZiQWZ8QXleak
	Fh9ilOBgVhLhTXkNlONNSaysSi3Kh0lJc7AoifOqLVH3ExJITyxJzU5NLUgtgsnKcHAoSfAu
	eg/UKFiUmp5akZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+KgvhiYByApHiA9nJ/ANlbXJCY
	CxSFaD3FqCglzhsKMlcAJJFRmgc3FpZMXjGKA30pzJsMUsUDTERw3a+ABjMBDS545A8yuCQR
	ISXVwKjLpqGw/7XCzemBIs1L9UOFLs5psrQP/fX2QseKq3HxN5RPJWVaTTiVrbf57rbtbAzF
	e+5+Up883Zq99/Kd6LNheSznvB/tdN1QkC7EyLn4HvfEzf5L7mV2mRXnz8o2Dml6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296397>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 57f1965..9307fa0 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1416,13 +1416,11 @@ static struct ref_entry *get_packed_ref(struct files_ref_store *refs,
 /*
  * A loose ref file doesn't exist; check for a packed ref.
  */
-static int resolve_missing_loose_ref(const char *refname,
+static int resolve_missing_loose_ref(struct files_ref_store *refs,
+				     const char *refname,
 				     unsigned char *sha1,
 				     unsigned int *flags)
 {
-	struct files_ref_store *refs =
-		get_files_ref_store(NULL, "resolve_missing_loose_ref");
-
 	struct ref_entry *entry;
 
 	/*
@@ -1442,6 +1440,8 @@ static int resolve_missing_loose_ref(const char *refname,
 int read_raw_ref(const char *refname, unsigned char *sha1,
 		 struct strbuf *referent, unsigned int *type)
 {
+	struct files_ref_store *refs =
+		get_files_ref_store(NULL, "read_raw_ref");
 	struct strbuf sb_contents = STRBUF_INIT;
 	struct strbuf sb_path = STRBUF_INIT;
 	const char *path;
@@ -1470,7 +1470,7 @@ stat_ref:
 	if (lstat(path, &st) < 0) {
 		if (errno != ENOENT)
 			goto out;
-		if (resolve_missing_loose_ref(refname, sha1, type)) {
+		if (resolve_missing_loose_ref(refs, refname, sha1, type)) {
 			errno = ENOENT;
 			goto out;
 		}
@@ -1504,7 +1504,7 @@ stat_ref:
 		 * ref is supposed to be, there could still be a
 		 * packed ref:
 		 */
-		if (resolve_missing_loose_ref(refname, sha1, type)) {
+		if (resolve_missing_loose_ref(refs, refname, sha1, type)) {
 			errno = EISDIR;
 			goto out;
 		}
-- 
2.8.1
