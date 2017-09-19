Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F26C520281
	for <e@80x24.org>; Tue, 19 Sep 2017 06:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750774AbdISGWq (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 02:22:46 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:42077 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750974AbdISGWp (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Sep 2017 02:22:45 -0400
X-AuditID: 1207440c-7e5ff7000000143e-d2-59c0b7b497fe
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id FC.37.05182.4B7B0C95; Tue, 19 Sep 2017 02:22:44 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAE885.dip0.t-ipconnect.de [84.170.232.133])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8J6MV1b002857
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Tue, 19 Sep 2017 02:22:42 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 04/21] die_unterminated_line(), die_invalid_line(): new functions
Date:   Tue, 19 Sep 2017 08:22:12 +0200
Message-Id: <7d40a319b3c41577efee8ef9f5c426b7517751ba.1505799700.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1505799700.git.mhagger@alum.mit.edu>
References: <cover.1505799700.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsUixO6iqLtl+4FIg5c/zS3WPrvDZPF8/Ql2
        i64r3UwWDb1XmC36l3exWdxeMZ/ZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4fPsZ5
        LNhU6vGsdw+jx8VLyh6fN8kFsEdx2aSk5mSWpRbp2yVwZSy+uZ21YK9wxdVdk5kbGO/wdzFy
        cEgImEg0ffXoYuTiEBLYwSQx4e9LdgjnFJPExqtzGLsYOTnYBHQlFvU0M4HYIgJqEhPbDrGA
        FDELrGSWmLT1CitIQlggROLg5fVgNouAqsStKx1sIBt4BaIk3hxMAwlLCMhLnHtwmxnE5hSw
        kGjes50FpERIwFziwNHiCYw8CxgZVjHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGurlZpbopaaU
        bmKEhBvPDsZv62QOMQpwMCrx8Apc2x8pxJpYVlyZe4hRkoNJSZQ3bNOBSCG+pPyUyozE4oz4
        otKc1OJDjBIczEoivIcWAeV4UxIrq1KL8mFS0hwsSuK8qkvU/YQE0hNLUrNTUwtSi2CyMhwc
        ShK8isC4EhIsSk1PrUjLzClBSDNxcIIM5wEargJSw1tckJhbnJkOkT/FqMvRcfPuHyYhlrz8
        vFQpcd7724CKBECKMkrz4ObA0sQrRnGgt4R5XUGqeIApBm7SK6AlTEBLsjeALSlJREhJNTCy
        8Ft99eHltQ8uXPNVZvvz+Bvpiz7knG7vvzJzVdwrV667qnkimbMasg03+9okW1+yuB3wJImt
        c8VS3dRvc9W2H/hZm9rb/W2OmM/dyJKW4BO//u+r+BWtHlF4YlHNz3n56+6+vVKw0v0i/1Oh
        69nWM7nn1fN1Bp/Zv/r307UFWz857zxRfna/EktxRqKhFnNRcSIAO8l6ee4CAAA=
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

