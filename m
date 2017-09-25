Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4366720281
	for <e@80x24.org>; Mon, 25 Sep 2017 08:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933974AbdIYIAk (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 04:00:40 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:54855 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933835AbdIYIAh (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 25 Sep 2017 04:00:37 -0400
X-AuditID: 1207440c-7e5ff7000000143e-1d-59c8b7a3f54c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id CF.E5.05182.3A7B8C95; Mon, 25 Sep 2017 04:00:35 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDF6.dip0.t-ipconnect.de [87.188.205.246])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v8P80N6O027347
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 25 Sep 2017 04:00:33 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 04/21] die_unterminated_line(), die_invalid_line(): new functions
Date:   Mon, 25 Sep 2017 10:00:01 +0200
Message-Id: <55b1102936de66e00bdee75cd38454a70d4228af.1506325610.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1506325610.git.mhagger@alum.mit.edu>
References: <cover.1506325610.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqLt4+4lIg7mvjS3WPrvDZPF8/Ql2
        i64r3UwWDb1XmC36l3exWdxeMZ/ZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4fPsZ5
        LNhU6vGsdw+jx8VLyh6fN8kFsEdx2aSk5mSWpRbp2yVwZSy+uZ21YK9wxdVdk5kbGO/wdzFy
        ckgImEh87H3K1MXIxSEksINJ4vrjTkYI5xSTxJUr99hBqtgEdCUW9TQzgdgiAmoSE9sOsYAU
        MQusZJaYtPUKK0hCWCBE4v66j2ANLAKqEk8X/wWL8wpESaxtPcYEsU5e4tyD28wgNqeAhcSb
        M0fYQGwhAXOJ8zdusU5g5FnAyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdQLzezRC81pXQT
        IyToeHYwflsnc4hRgINRiYc34t/xSCHWxLLiytxDjJIcTEqivHf5TkQK8SXlp1RmJBZnxBeV
        5qQWH2KU4GBWEuE9thoox5uSWFmVWpQPk5LmYFES51Vdou4nJJCeWJKanZpakFoEk5Xh4FCS
        4P29DahRsCg1PbUiLTOnBCHNxMEJMpwHaPhykBre4oLE3OLMdIj8KUZdjo6bd/8wCbHk5eel
        SonzbgApEgApyijNg5sDSxavGMWB3hLmlQWmDiEeYKKBm/QKaAkT0JLeqWBLShIRUlINjPFN
        L87N6JdUfPNnbe/UiTk8v1Tln6UVbqjg2bI6/puPNdO6GTGSPT8/fKtKmBNi9D6r9Fnu6pV5
        VzUm3/h/Y6bZr7nluwpOPF6zZY7+13Uy/NaPtl9YdOI3f86GKXMKBFKbapKtfM+/2Sdjn+93
        Qbyn1zRj4nRd9pdaz/ssigROLF68+SMfq48SS3FGoqEWc1FxIgDeDour8QIAAA==
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

