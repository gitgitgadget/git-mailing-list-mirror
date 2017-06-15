Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4162020401
	for <e@80x24.org>; Thu, 15 Jun 2017 14:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752540AbdFOOtB (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 10:49:01 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:49162 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752514AbdFOOsC (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Jun 2017 10:48:02 -0400
X-AuditID: 12074411-f47ff70000007ac9-fe-59429e1b677a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 7D.A6.31433.B1E92495; Thu, 15 Jun 2017 10:47:55 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCC0A.dip0.t-ipconnect.de [87.188.204.10])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5FElbR0014537
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Thu, 15 Jun 2017 10:47:53 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 06/28] validate_packed_ref_cache(): take a `packed_ref_store *` parameter
Date:   Thu, 15 Jun 2017 16:47:11 +0200
Message-Id: <ee2a855dd49a88a8545fcb1654782a407ee4af8a.1497534157.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1497534157.git.mhagger@alum.mit.edu>
References: <cover.1497534157.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqCszzynSYEeExdpnd5gsnq8/wW7R
        daWbyaKh9wqzxe0V85ktljx8zWzRPeUto8WPlh5mi82b21kcOD3+vv/A5LFz1l12jwWbSj26
        2o+weTzr3cPocfGSssfnTXIB7FFcNimpOZllqUX6dglcGVd3aBdM5a843rONtYHxA08XIyeH
        hICJxNOlxxi7GLk4hAR2MEksnXAZyjnJJLF670dGkCo2AV2JRT3NTCC2iICaxMS2QywgRcwC
        k5gl3l5bCJYQFoiUeNhyhRXEZhFQlTjwcB1YM69AlET/zh4WiHXyErvaLoLVcApYSMz+so65
        i5EDaJu5xLHlGhMYeRYwMqxilEvMKc3VzU3MzClOTdYtTk7My0st0jXVy80s0UtNKd3ECAk4
        wR2MM07KHWIU4GBU4uFVaHCKFGJNLCuuzD3EKMnBpCTKyy8HFOJLyk+pzEgszogvKs1JLT7E
        KMHBrCTCO3UOUI43JbGyKrUoHyYlzcGiJM7Lt0TdT0ggPbEkNTs1tSC1CCYrw8GhJMFrPBeo
        UbAoNT21Ii0zpwQhzcTBCTKcB2j4X7DhxQWJucWZ6RD5U4yKUuK8HiAJAZBERmkeXC8sIbxi
        FAd6RZhXGWQFDzCZwHW/AhrMBDQ46IIDyOCSRISUVAOj1O7r4hbd925+v3Eim/fmjl72ada8
        v/fc5rFmaq76fT+M14B589qk3JxZLW6JUqmBe14vZZkesnl/3W1T3kpWSbubx7deUXbpan18
        IUn+u3C8a9BTQfcpV063CbjdvObzYplvm7OZbo5HwtH2xv+6sR21C75fu3QnaNPCKyFMxyxC
        nLx4bL8qsRRnJBpqMRcVJwIAhM8Mk+MCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It only cares about the packed-refs part of the reference store.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 2b0db60b2b..f061506bf0 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -396,12 +396,11 @@ static void files_ref_path(struct files_ref_store *refs,
  * Check that the packed refs cache (if any) still reflects the
  * contents of the file. If not, clear the cache.
  */
-static void validate_packed_ref_cache(struct files_ref_store *refs)
+static void validate_packed_ref_cache(struct packed_ref_store *refs)
 {
-	if (refs->packed_ref_store->cache &&
-	    !stat_validity_check(&refs->packed_ref_store->cache->validity,
-				 refs->packed_ref_store->path))
-		clear_packed_ref_cache(refs->packed_ref_store);
+	if (refs->cache &&
+	    !stat_validity_check(&refs->cache->validity, refs->path))
+		clear_packed_ref_cache(refs);
 }
 
 /*
@@ -417,7 +416,7 @@ static struct packed_ref_cache *get_packed_ref_cache(struct files_ref_store *ref
 	const char *packed_refs_file = refs->packed_ref_store->path;
 
 	if (!is_lock_file_locked(&refs->packed_ref_store->lock))
-		validate_packed_ref_cache(refs);
+		validate_packed_ref_cache(refs->packed_ref_store);
 
 	if (!refs->packed_ref_store->cache)
 		refs->packed_ref_store->cache = read_packed_refs(packed_refs_file);
@@ -1364,7 +1363,7 @@ static int lock_packed_refs(struct files_ref_store *refs, int flags)
 	 * cache is still valid. We've just locked the file, but it
 	 * might have changed the moment *before* we locked it.
 	 */
-	validate_packed_ref_cache(refs);
+	validate_packed_ref_cache(refs->packed_ref_store);
 
 	packed_ref_cache = get_packed_ref_cache(refs);
 	/* Increment the reference count to prevent it from being freed: */
-- 
2.11.0

