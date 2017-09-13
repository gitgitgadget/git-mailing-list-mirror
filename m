Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 146B420286
	for <e@80x24.org>; Wed, 13 Sep 2017 17:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751312AbdIMRQj (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 13:16:39 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:62784 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751179AbdIMRQc (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 Sep 2017 13:16:32 -0400
X-AuditID: 1207440e-be1ff70000007085-c7-59b967ee71b9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 5B.8E.28805.EE769B95; Wed, 13 Sep 2017 13:16:30 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC855.dip0.t-ipconnect.de [87.188.200.85])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8DHGIiS001379
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 13 Sep 2017 13:16:28 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 04/20] die_unterminated_line(), die_invalid_line(): new functions
Date:   Wed, 13 Sep 2017 19:15:58 +0200
Message-Id: <7d40a319b3c41577efee8ef9f5c426b7517751ba.1505319366.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1505319366.git.mhagger@alum.mit.edu>
References: <cover.1505319366.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsUixO6iqPsufWekwdFTxhZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntuie8pbR4kdLD7PF5s3tLA4cHn/ff2Dy2DnrLrvHgk2lHs969zB6
        XLyk7PF5k1wAWxSXTUpqTmZZapG+XQJXxuKb21kL9gpXXN01mbmB8Q5/FyMnh4SAicSMtydZ
        uxi5OIQEdjBJ/F+/gR3COckk8fBFPytIFZuArsSinmYmEFtEQE1iYtshFpAiZoGnTBI7T94F
        KxIWCJRo+3ydEcRmEVCVOHb2B1gDr0CUxLQrWxgh1slLnHtwmxnE5hSwkNi44wlYXEjAXKJx
        zk7GCYw8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGuvlZpbopaaUbmKEhBjfDsb29TKH
        GAU4GJV4eC1sdkYKsSaWFVfmHmKU5GBSEuXdqwsU4kvKT6nMSCzOiC8qzUktPsQowcGsJMIb
        FAWU401JrKxKLcqHSUlzsCiJ86otUfcTEkhPLEnNTk0tSC2CycpwcChJ8P5NA2oULEpNT61I
        y8wpQUgzcXCCDOcBGn4BpIa3uCAxtzgzHSJ/ilGXo+Pm3T9MQix5+XmpUuK8f1OBigRAijJK
        8+DmwFLDK0ZxoLeEeY+BjOIBphW4Sa+AljABLTlzegfIkpJEhJRUA2Pnogo1p9+lxtI1vme/
        6bOFhfO35SSee9i6bMkcvl6XtucWk/+dVdyzfeqPlsy15mxhq6fuW/70pvgb72Xu4TPZ/7IZ
        Pr1S1PpyUeCdh5vaVm9pr+V32aphv6FVxb/uFvO9JH4N3tvRmmqiRfsPCjscMA6foKjmrZfw
        Yot/02w5z8LNp1XOGCmxFGckGmoxFxUnAgAvq9j/6AIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extract some helper functions for reporting errors. While we're at it,
prevent them from spewing unlimited output to the terminal. These
functions will soon have more callers.

These functions accept the problematic line as a `(ptr, len)` pair
rather than a NUL-terminated string, and `die_invalid_line()` checks
for an EOL itself, because these calling conventions will be
convenient for future callers. (Efficiency is not a concern here
because these functions are only ever called if the `packed-refs` file
is corrupt.)

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index a3d9210cb0..5c50c223ef 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -161,6 +161,29 @@ static const char *parse_ref_line(struct strbuf *line, struct object_id *oid)
 	return ref;
 }
 
+static NORETURN void die_unterminated_line(const char *path,
+					   const char *p, size_t len)
+{
+	if (len < 80)
+		die("unterminated line in %s: %.*s", path, (int)len, p);
+	else
+		die("unterminated line in %s: %.75s...", path, p);
+}
+
+static NORETURN void die_invalid_line(const char *path,
+				      const char *p, size_t len)
+{
+	const char *eol = memchr(p, '\n', len);
+
+	if (!eol)
+		die_unterminated_line(path, p, len);
+	else if (eol - p < 80)
+		die("unexpected line in %s: %.*s", path, (int)(eol - p), p);
+	else
+		die("unexpected line in %s: %.75s...", path, p);
+
+}
+
 /*
  * Read from the `packed-refs` file into a newly-allocated
  * `packed_ref_cache` and return it. The return value will already
@@ -227,7 +250,7 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 		const char *traits;
 
 		if (!line.len || line.buf[line.len - 1] != '\n')
-			die("unterminated line in %s: %s", refs->path, line.buf);
+			die_unterminated_line(refs->path, line.buf, line.len);
 
 		if (skip_prefix(line.buf, "# pack-refs with:", &traits)) {
 			if (strstr(traits, " fully-peeled "))
@@ -266,8 +289,7 @@ static struct packed_ref_cache *read_packed_refs(struct packed_ref_store *refs)
 			 */
 			last->flag |= REF_KNOWS_PEELED;
 		} else {
-			strbuf_setlen(&line, line.len - 1);
-			die("unexpected line in %s: %s", refs->path, line.buf);
+			die_invalid_line(refs->path, line.buf, line.len);
 		}
 	}
 
-- 
2.14.1

