Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E72020401
	for <e@80x24.org>; Wed, 14 Jun 2017 09:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751863AbdFNJJO (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 05:09:14 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:44858 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751768AbdFNJHt (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Jun 2017 05:07:49 -0400
X-AuditID: 12074413-d93ff7000000742e-20-5940fcdf4d00
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 7C.FC.29742.FDCF0495; Wed, 14 Jun 2017 05:07:43 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCBFA.dip0.t-ipconnect.de [87.188.203.250])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5E97WER022456
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 14 Jun 2017 05:07:40 -0400
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
Subject: [PATCH 2/2] prefix_ref_iterator_advance(): relax the check of trim length
Date:   Wed, 14 Jun 2017 11:07:27 +0200
Message-Id: <0c63f38bf922f285d6d62fc9cbbc3f5b756e75bf.1497430232.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1497430232.git.mhagger@alum.mit.edu>
References: <cover.1497430232.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsUixO6iqHv/j0OkwZTvghZrn91hsni+/gS7
        RdeVbiaLht4rzBZP5t5ltri9Yj6zxZKHr5ktuqe8ZbT40dLDbLF5czuLxYQjK1gsHvW9ZXfg
        8fj7/gOTx85Zd9k9Fmwq9Xj4qovd48SM3yweXe1H2Dye9e5h9Lh4Sdnj7oQeFo/Pm+QCuKK4
        bFJSczLLUov07RK4MrYfWcBUMIW7Yu/8H+wNjO85uhg5OSQETCSuT3/F0sXIxSEksINJovvU
        M0YI5xSTxJrHT5hBqtgEdCUW9TQzgdgiAmoSE9sOgXUwCyxjkeg684sRJCEsECTRdP0TK4jN
        IqAq0XL5IVgzr0CUxJOHE5kh1slL7Gq7CFbDKWAhcet6CwuILSRgLjGx8yTbBEaeBYwMqxjl
        EnNKc3VzEzNzilOTdYuTE/PyUot0zfVyM0v0UlNKNzFCQlZ4B+Ouk3KHGAU4GJV4eB+8t48U
        Yk0sK67MPcQoycGkJMpbv9khUogvKT+lMiOxOCO+qDQntfgQowQHs5IIr8R5oBxvSmJlVWpR
        PkxKmoNFSZxXbYm6n5BAemJJanZqakFqEUxWhoNDSYJ34W+gRsGi1PTUirTMnBKENBMHJ8hw
        HqDh2T9BhhcXJOYWZ6ZD5E8xKkqJ8zaDNAuAJDJK8+B6YSnlFaM40CvCvHtBqniA6Qiu+xXQ
        YCagwUEXwAaXJCKkpBoYJWZu1+y78uCy1QTZz2sU29kMa5z/liS+kvt2KCv/anCo76Sw2Flf
        ItILw558eXJ55aYoCwn9s+Hxj38mylW8Pndvrk1k1229xxOcky32Wx6+kDv5DttFhd0/9xzY
        IvVw530nsQ17niRU7hW0SWyJsmGVNbqw4rlBVB/fspxK11/K/Q+YumTUlFiKMxINtZiLihMB
        Ank/jQQDAAA=
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

