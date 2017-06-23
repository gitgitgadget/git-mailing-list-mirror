Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 854C820401
	for <e@80x24.org>; Fri, 23 Jun 2017 07:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754195AbdFWHDM (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 03:03:12 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:59243 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754164AbdFWHDK (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Jun 2017 03:03:10 -0400
X-AuditID: 12074412-b97ff70000000fed-5a-594cbd23816e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 37.9F.04077.32DBC495; Fri, 23 Jun 2017 03:02:59 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC5B4.dip0.t-ipconnect.de [87.188.197.180])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5N71o6E001300
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 23 Jun 2017 03:02:57 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 29/29] read_packed_refs(): die if `packed-refs` contains bogus data
Date:   Fri, 23 Jun 2017 09:01:47 +0200
Message-Id: <1e08748aa5a6dc05003b08207a9a4bc344758ca2.1498200513.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498200513.git.mhagger@alum.mit.edu>
References: <cover.1498200513.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsUixO6iqKu81yfS4PkBA4u1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzWyx5+JrZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4LNpV6
        dLUfYfN41ruH0ePiJWWPz5vkAtijuGxSUnMyy1KL9O0SuDJe9j5jLpjDWdHRc4CtgXEZexcj
        J4eEgInE4QMbWUFsIYEdTBL728K6GLmA7FNMEu2rGphAEmwCuhKLeprBbBEBNYmJbYdYQIqY
        BSYxS7y9thAsISwQJjHh40KwqSwCqhIr15wCs3kFoiS2L1jICLFNXmJX20WwbZwCFhI9E5ez
        Q2w2l1j1ezXrBEaeBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0zfRyM0v0UlNKNzFCgk5o
        B+P6k3KHGAU4GJV4eBPOekcKsSaWFVfmHmKU5GBSEuXVjPSJFOJLyk+pzEgszogvKs1JLT7E
        KMHBrCTCq7MKKMebklhZlVqUD5OS5mBREuf9uVjdT0ggPbEkNTs1tSC1CCYrw8GhJMHbshuo
        UbAoNT21Ii0zpwQhzcTBCTKcB2i4x2aQ4cUFibnFmekQ+VOMilLivBtAmgVAEhmleXC9sKTw
        ilEc6BVh3kSQKh5gQoHrfgU0mAlo8Iw1YINLEhFSUg2MORPPpM5WNPp6vcq04vqMqWbKmn4J
        /7+7TZ67K0/86LaE8ncunUe5FPMP2MokNv2eJ+ba7pBj6Tz70eZfa5fLW13g0vbJ+9oQ5zdH
        69xe3WMVNtJSBxd+WzKVKcWr/8LS2VxiT6qrvj38JPOjVG7r5Q+3e66k79fie64gcIrlFK/O
        ki37J/WfVGIpzkg01GIuKk4EAC3cW0vlAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The old code ignored any lines that it didn't understand. This is
dangerous. Instead, `die()` if the `packed-refs` file contains any
lines that we don't know how to handle.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 377c775adb..1cbaf036df 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -253,9 +253,7 @@ static struct packed_ref_cache *read_packed_refs(const char *packed_refs_file)
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
@@ -267,6 +265,8 @@ static struct packed_ref_cache *read_packed_refs(const char *packed_refs_file)
 			 * reference:
 			 */
 			last->flag |= REF_KNOWS_PEELED;
+		} else {
+			die("unexpected line in %s: %s", packed_refs_file, line.buf);
 		}
 	}
 
-- 
2.11.0

