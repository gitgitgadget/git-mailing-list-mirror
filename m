Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D16B20401
	for <e@80x24.org>; Thu, 15 Jun 2017 14:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752736AbdFOOss (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 10:48:48 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:63442 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752732AbdFOOsr (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Jun 2017 10:48:47 -0400
X-AuditID: 1207440e-1f7ff70000000c7e-a0-59429e440c09
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 76.66.03198.44E92495; Thu, 15 Jun 2017 10:48:36 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCC0A.dip0.t-ipconnect.de [87.188.204.10])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5FElbRJ014537
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Thu, 15 Jun 2017 10:48:34 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 25/28] clear_packed_ref_cache(): don't protest if the lock is held
Date:   Thu, 15 Jun 2017 16:47:30 +0200
Message-Id: <3be564c3f49454cc0ea48bf5ebb70a34e17bd41d.1497534157.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1497534157.git.mhagger@alum.mit.edu>
References: <cover.1497534157.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsUixO6iqOsyzynS4O9fEYu1z+4wWTxff4Ld
        outKN5NFQ+8VZovbK+YzWyx5+JrZonvKW0aLHy09zBabN7ezOHB6/H3/gclj56y77B4LNpV6
        dLUfYfN41ruH0ePiJWWPz5vkAtijuGxSUnMyy1KL9O0SuDLmvT7DWLCdraJn9jy2BsZVrF2M
        nBwSAiYSZ/7fYuxi5OIQEtjBJHGlazsThHOSSeLwrmPMIFVsAroSi3qamUBsEQE1iYlth1hA
        ipgFJjFLvL22ECwhLBAksfHabnYQm0VAVeLfx7+MIDavQJTEp6NTmSHWyUvsarsItppTwEJi
        9pd1QHEOoG3mEseWa0xg5FnAyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdYLzezRC81pXQT
        IyTo+HYwtq+XOcQowMGoxMOr0OAUKcSaWFZcmXuIUZKDSUmUl18OKMSXlJ9SmZFYnBFfVJqT
        WnyIUYKDWUmEd+ocoBxvSmJlVWpRPkxKmoNFSZxXbYm6n5BAemJJanZqakFqEUxWhoNDSYJ3
        81ygRsGi1PTUirTMnBKENBMHJ8hwHqDhf8GGFxck5hZnpkPkTzHqcjR92PKFSYglLz8vVUqc
        1wOkSACkKKM0D24OLFm8YhQHekuYVxlkHQ8w0cBNegW0hAloSdAFB5AlJYkIKakGxop/soqt
        wnsWrWfhjHz2Jep364vi87EBDEWP5r9iOTX/5Kbo07vfH+2+OempfakqM3OKGYuB6uXDjWy5
        Kntk5+9hXLL1pB5z6q2VEr9XfvC0COCVfKUjorq6gfVBs9+cqLNzFN+9M+S94H9U5tnl5uQP
        f/e433l13CTsYGCt3xqpbbf507/PrlRiKc5INNRiLipOBABoiQXU8QIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The existing callers already check that the lock isn't held just
before calling `clear_packed_ref_cache()`, and in the near future we
want to be able to call this function when the lock is held.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/packed-backend.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index ff6326ddb8..1732e3aad4 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -133,8 +133,6 @@ static void clear_packed_ref_cache(struct packed_ref_store *refs)
 	if (refs->cache) {
 		struct packed_ref_cache *cache = refs->cache;
 
-		if (is_lock_file_locked(&refs->lock))
-			die("BUG: packed-ref cache cleared while locked");
 		refs->cache = NULL;
 		release_packed_ref_cache(cache);
 	}
-- 
2.11.0

