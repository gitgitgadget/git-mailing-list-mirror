Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05FE920209
	for <e@80x24.org>; Sat,  1 Jul 2017 18:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752195AbdGASca (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 14:32:30 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:43717 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752172AbdGASc1 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 1 Jul 2017 14:32:27 -0400
X-AuditID: 12074414-50fff70000001c95-44-5957eab9dfdd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 50.35.07317.9BAE7595; Sat,  1 Jul 2017 14:32:25 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCCEF.dip0.t-ipconnect.de [87.188.204.239])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v61IVBBh010294
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sat, 1 Jul 2017 14:32:22 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 30/30] read_packed_refs(): die if `packed-refs` contains bogus data
Date:   Sat,  1 Jul 2017 20:31:08 +0200
Message-Id: <8b0ddf2433044fa5c5c3ec59633fc59b4f8faf8e.1498933362.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498933362.git.mhagger@alum.mit.edu>
References: <cover.1498933362.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsUixO6iqLvzVXikweZ7XBZrn91hsni+/gS7
        RdeVbiaLht4rzBa3V8xntljy8DWzRfeUt4wWP1p6mC02b25nceD0+Pv+A5PHzll32T0WbCr1
        6Go/wubxrHcPo8fFS8oenzfJBbBHcdmkpOZklqUW6dslcGW8XrKFtWCOZMWsK8/YGhgfiHQx
        cnJICJhIvF/+gxXEFhLYwSTxZVJZFyMXkH2SSeJk2zVmkASbgK7Eop5mJhBbREBNYmLbIRaQ
        ImaBScwSb68tBEsIC4RJHN2xEcxmEVCVePJ8B1gzr0CUxJt735khtslL7Gq7CLaNU8BC4k/b
        emaIzeYSzQf7WCYw8ixgZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuhl5tZopeaUrqJERJ0
        IjsYj5yUO8QowMGoxMO7ISQsUog1say4MvcQoyQHk5Io78proZFCfEn5KZUZicUZ8UWlOanF
        hxglOJiVRHhzn4dHCvGmJFZWpRblw6SkOViUxHm/LVb3ExJITyxJzU5NLUgtgsnKcHAoSfBO
        egnUKFiUmp5akZaZU4KQZuLgBBnOAzR84V2Q4cUFibnFmekQ+VOMxhxzfu/4wsTxasL/b0xC
        LHn5ealS4rytIOMEQEozSvPgpsESxytGcaDnhHkZgGlEiAeYdODmvQJaxQS0SnhGCMiqkkSE
        lFQD45y47tezJofFFHxaaWpn2Mk0U8J95n3/PRMjVQ18SuMnvfcpadL7/zifrdnLeE/Grocb
        3HZv2zl5xdopyzRizYOfpXAeFZe5VXkybbJaLcelKvUQqcnqP37NmFO+y2lt7oxMlmn61xR2
        nH5eN+enVtqzmvzlkZMXsO3lXTS/x+u1cLuOzYNT2kosxRmJhlrMRcWJAMe0+VD3AgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The old code ignored any lines that it didn't understand, including
unterminated lines. This is dangerous. Instead, `die()` if the
`packed-refs` file contains any unterminated lines or lines that we
don't know how to handle.

This fixes the tests added in the last commit.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 10 +++++++---
 t/t3210-pack-refs.sh  |  6 +++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 377c775adb..a28befbfa3 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -229,6 +229,9 @@ static struct packed_ref_cache *read_packed_refs(const char *packed_refs_file)
 		const char *refname;
 		const char *traits;
 
+		if (!line.len || line.buf[line.len - 1] != '\n')
+			die("unterminated line in %s: %s", packed_refs_file, line.buf);
+
 		if (skip_prefix(line.buf, "# pack-refs with:", &traits)) {
 			if (strstr(traits, " fully-peeled "))
 				peeled = PEELED_FULLY;
@@ -253,9 +256,7 @@ static struct packed_ref_cache *read_packed_refs(const char *packed_refs_file)
 			    (peeled == PEELED_TAGS && starts_with(refname, "refs/tags/")))
 				last->flag |= REF_KNOWS_PEELED;
 			add_ref_entry(dir, last);
-			continue;
-		}
-		if (last &&
+		} else if (last &&
 		    line.buf[0] == '^' &&
 		    line.len == PEELED_LINE_LENGTH &&
 		    line.buf[PEELED_LINE_LENGTH - 1] == '\n' &&
@@ -267,6 +268,9 @@ static struct packed_ref_cache *read_packed_refs(const char *packed_refs_file)
 			 * reference:
 			 */
 			last->flag |= REF_KNOWS_PEELED;
+		} else {
+			strbuf_setlen(&line, line.len - 1);
+			die("unexpected line in %s: %s", packed_refs_file, line.buf);
 		}
 	}
 
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index 4b65836283..2bb4b25ed9 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -194,7 +194,7 @@ test_expect_success 'notice d/f conflict with existing ref' '
 	test_must_fail git branch foo/bar/baz/lots/of/extra/components
 '
 
-test_expect_failure 'reject packed-refs with unterminated line' '
+test_expect_success 'reject packed-refs with unterminated line' '
 	cp .git/packed-refs .git/packed-refs.bak &&
 	test_when_finished "mv .git/packed-refs.bak .git/packed-refs" &&
 	printf "%s" "$HEAD refs/zzzzz" >>.git/packed-refs &&
@@ -203,7 +203,7 @@ test_expect_failure 'reject packed-refs with unterminated line' '
 	test_cmp expected_err err
 '
 
-test_expect_failure 'reject packed-refs containing junk' '
+test_expect_success 'reject packed-refs containing junk' '
 	cp .git/packed-refs .git/packed-refs.bak &&
 	test_when_finished "mv .git/packed-refs.bak .git/packed-refs" &&
 	printf "%s\n" "bogus content" >>.git/packed-refs &&
@@ -212,7 +212,7 @@ test_expect_failure 'reject packed-refs containing junk' '
 	test_cmp expected_err err
 '
 
-test_expect_failure 'reject packed-refs with a short SHA-1' '
+test_expect_success 'reject packed-refs with a short SHA-1' '
 	cp .git/packed-refs .git/packed-refs.bak &&
 	test_when_finished "mv .git/packed-refs.bak .git/packed-refs" &&
 	printf "%.7s %s\n" $HEAD refs/zzzzz >>.git/packed-refs &&
-- 
2.11.0

