Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 738E320286
	for <e@80x24.org>; Wed, 13 Sep 2017 17:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751364AbdIMRQn (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 13:16:43 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:45708 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751125AbdIMRQf (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 Sep 2017 13:16:35 -0400
X-AuditID: 12074413-3a3ff70000007929-49-59b967f28ad0
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id E9.25.31017.2F769B95; Wed, 13 Sep 2017 13:16:34 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC855.dip0.t-ipconnect.de [87.188.200.85])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8DHGIiU001379
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 13 Sep 2017 13:16:33 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 06/20] read_packed_refs(): only check for a header at the top of the file
Date:   Wed, 13 Sep 2017 19:16:00 +0200
Message-Id: <a1d50f3a452873f3d845742d378887aac14f7cb6.1505319366.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1505319366.git.mhagger@alum.mit.edu>
References: <cover.1505319366.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsUixO6iqPspfWekwbx+I4u1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj2e9exg9
        Ll5S9vi8SS6ALYrLJiU1J7MstUjfLoEr4+q7C0wFNwQrVi59ytzA+I63i5GTQ0LARGLPnAOM
        XYxcHEICO5gkGhcfZgFJCAmcZJK42yEPYrMJ6Eos6mlmArFFBNQkJrYdYgFpYBZ4yiSx8+Rd
        VpCEsECkxK9Hn8FsFgFViWOv9jOD2LwCURJPen8zQmyTlzj34DZYnFPAQmLjjieMEMvMJRrn
        7GScwMizgJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGuuV5uZoleakrpJkZIgAnvYNx1Uu4Q
        owAHoxIPr4XNzkgh1sSy4srcQ4ySHExKorx7dYFCfEn5KZUZicUZ8UWlOanFhxglOJiVRHiD
        ooByvCmJlVWpRfkwKWkOFiVxXrUl6n5CAumJJanZqakFqUUwWRkODiUJXidgJAkJFqWmp1ak
        ZeaUIKSZODhBhvMADRcEqeEtLkjMLc5Mh8ifYtTl6Lh59w+TEEtefl6qlDjv31SgIgGQoozS
        PLg5sMTwilEc6C1h3mNpQFU8wKQCN+kV0BImoCVnTu8AWVKSiJCSamDMjgy25s28IPdz+uSg
        QKnt1z5eseTzunkiXONiW9ksr21Ry5dVi4fbh/EJ/H+802RO6W2W0+UaAmLlm87tzvM7c+po
        +9ne93Ham3lj0qTTb2h5ceeseSZ0KXzxX0PlH7WWbz8u0m2e8ezPoS06Dj/O3+tvaJxmF378
        yiPmuyxT9HfVu/7faWGqxFKckWioxVxUnAgATF9l2+cCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This tightens up the parsing a bit; previously, stray header-looking
lines would have been processed.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 154abbd83a..141f02b9c8 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -255,11 +255,34 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 	pos = buf;
 	eof = buf + size;
 
+	/* If the file has a header line, process it: */
+	if (pos < eof && *pos == '#') {
+		const char *traits;
+
+		eol = memchr(pos, '\n', eof - pos);
+		if (!eol)
+			die_unterminated_line(refs->path, pos, eof - pos);
+
+		strbuf_add(&line, pos, eol + 1 - pos);
+
+		if (!skip_prefix(line.buf, "# pack-refs with:", &traits))
+			die_invalid_line(refs->path, pos, eof - pos);
+
+		if (strstr(traits, " fully-peeled "))
+			peeled = PEELED_FULLY;
+		else if (strstr(traits, " peeled "))
+			peeled = PEELED_TAGS;
+		/* perhaps other traits later as well */
+
+		/* The "+ 1" is for the LF character. */
+		pos = eol + 1;
+		strbuf_reset(&line);
+	}
+
 	dir = get_ref_dir(packed_refs->cache->root);
 	while (pos < eof) {
 		struct object_id oid;
 		const char *refname;
-		const char *traits;
 
 		eol = memchr(pos, '\n', eof - pos);
 		if (!eol)
@@ -267,15 +290,6 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 
 		strbuf_add(&line, pos, eol + 1 - pos);
 
-		if (skip_prefix(line.buf, "# pack-refs with:", &traits)) {
-			if (strstr(traits, " fully-peeled "))
-				peeled = PEELED_FULLY;
-			else if (strstr(traits, " peeled "))
-				peeled = PEELED_TAGS;
-			/* perhaps other traits later as well */
-			goto next_line;
-		}
-
 		refname = parse_ref_line(&line, &oid);
 		if (refname) {
 			int flag = REF_ISPACKED;
@@ -307,7 +321,6 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 			die_invalid_line(refs->path, line.buf, line.len);
 		}
 
-	next_line:
 		/* The "+ 1" is for the LF character. */
 		pos = eol + 1;
 		strbuf_reset(&line);
-- 
2.14.1

