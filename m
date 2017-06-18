Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EC7B20401
	for <e@80x24.org>; Sun, 18 Jun 2017 13:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753169AbdFRNkC (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Jun 2017 09:40:02 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:42205 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753161AbdFRNkA (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 18 Jun 2017 09:40:00 -0400
X-AuditID: 1207440e-20fff70000000c7e-cb-594682aeb946
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 34.32.03198.EA286495; Sun, 18 Jun 2017 09:39:59 -0400 (EDT)
Received: from bagpipes.fritz.box (p54AAE99B.dip0.t-ipconnect.de [84.170.233.155])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5IDdj8i017544
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 18 Jun 2017 09:39:55 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=98yvind=20Holm?= <sunny@sunbase.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 2/2] prefix_ref_iterator_advance(): relax the check of trim length
Date:   Sun, 18 Jun 2017 15:39:42 +0200
Message-Id: <7ea7841cf2ea9eb17535d5e655c7834347d5acfe.1497792827.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1497792827.git.mhagger@alum.mit.edu>
References: <cover.1497792827.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqLu+yS3S4PURGYu1z+4wWTxff4Ld
        outKN5NFQ+8VZosnc+8yW9xeMZ/ZYsnD18wW3VPeMlr8aOlhtti8uZ3FYsKRFSwWj/resjvw
        ePx9/4HJY+esu+weCzaVejx81cXucWLGbxaPrvYjbB7Pevcwely8pOxxd0IPi8fnTXIBXFFc
        NimpOZllqUX6dglcGduPLGAqmMJdsXf+D/YGxvccXYycHBICJhJXO+6wdTFycQgJ7GCS2Nd0
        jh3COcUkcf/QJUaQKjYBXYlFPc1MILaIgJrExLZDLCBFzALLWCS6zvwCKxIWCJW4OPkzWBGL
        gKrEysezWEFsXoEoiW9nf7NBrJOX2NV2ESzOKWAh8f7kNWYQW0jAXOJSWzvzBEaeBYwMqxjl
        EnNKc3VzEzNzilOTdYuTE/PyUot0jfVyM0v0UlNKNzFCQpZvB2P7eplDjAIcjEo8vC/aXSOF
        WBPLiitzDzFKcjApifJ+knWLFOJLyk+pzEgszogvKs1JLT7EKMHBrCTC2+0JlONNSaysSi3K
        h0lJc7AoifOqLVH3ExJITyxJzU5NLUgtgsnKcHAoSfD6NgI1ChalpqdWpGXmlCCkmTg4QYbz
        AA2XrgUZXlyQmFucmQ6RP8WoKCXOe7UBKCEAksgozYPrhaWUV4ziQK8I8x4CWcEDTEdw3a+A
        BjMBDWY+4wIyuCQRISXVwKgSu/BJapjy5PtH1d8qSa98cGpvcs2y9jte/gq+szSvzn7LL/h/
        sc3pLNPIV3xCbXGdUoe2BV29+SXh3oWda+5qM05fYXZ3W6tTSqpZWteNP1VLf1UvTi5yur/1
        gYv4/NcT7zYd+VD7s3COqYSwcKuxzpwP0dJ/QupXG+RJNhwN9UkyC+2f6KzEUpyRaKjFXFSc
        CACVLBwVBAMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before the previous commit, `for_each_bad_bisect_ref()` called
`for_each_fullref_in_submodule()` in such a way as to trim the whole
refname away. This is a questionable use of the API, but is not ipso
facto dangerous, so tolerate it in case there are other callers
relying on this behavior. But continue to refuse to trim *more*
characters than the refname contains, as that really makes no sense.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/iterator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/refs/iterator.c b/refs/iterator.c
index 4cf449ef66..de52d5fe93 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -298,11 +298,11 @@ static int prefix_ref_iterator_advance(struct ref_iterator *ref_iterator)
 			 * you haven't already checked for via a
 			 * prefix check, whether via this
 			 * `prefix_ref_iterator` or upstream in
-			 * `iter0`). So if there wouldn't be at least
-			 * one character left in the refname after
-			 * trimming, report it as a bug:
+			 * `iter0`. So consider it a bug if we are
+			 * asked to trim off more characters than the
+			 * refname contains:
 			 */
-			if (strlen(iter->iter0->refname) <= iter->trim)
+			if (strlen(iter->iter0->refname) < iter->trim)
 				die("BUG: attempt to trim too many characters");
 			iter->base.refname = iter->iter0->refname + iter->trim;
 		} else {
-- 
2.11.0

