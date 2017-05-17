Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0419201A7
	for <e@80x24.org>; Wed, 17 May 2017 12:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753843AbdEQMGo (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 08:06:44 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:58689 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753665AbdEQMGe (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 May 2017 08:06:34 -0400
X-AuditID: 1207440f-701ff700000004e5-24-591c3cc956dd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 48.78.01253.9CC3C195; Wed, 17 May 2017 08:06:33 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B104B68.dip0.t-ipconnect.de [91.16.75.104])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4HC5pgB000430
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Wed, 17 May 2017 08:06:31 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 20/23] refs_ref_iterator_begin(): handle `GIT_REF_PARANOIA`
Date:   Wed, 17 May 2017 14:05:43 +0200
Message-Id: <14f627170d676bd5c49d91ee0eedea46939e9837.1495014840.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495014840.git.mhagger@alum.mit.edu>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsUixO6iqHvSRibS4NpTQ4u1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAlfGjX0v2Qrm8lbc2CrUwPiVq4uRk0NCwETi
        yZcWxi5GLg4hgR1MEr1XvjJDOCeYJN5d28wGUsUmoCuxqKeZCcQWEVCTmNh2iAWkiFngMZPE
        32XdLCAJYQFviaUPToMVsQioSrye8gRoLAcHr0CURMdGGYht8hK72i6ygticAhYS998/Ygcp
        ERIwl9h+vXICI88CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbomermZJXqpKaWbGCFhxr+D
        sWu9zCFGAQ5GJR7eCVzSkUKsiWXFlbmHGCU5mJREefc/AArxJeWnVGYkFmfEF5XmpBYfYpTg
        YFYS4b1pKhMpxJuSWFmVWpQPk5LmYFES51Vfou4nJJCeWJKanZpakFoEk5Xh4FCS4J1iDdQo
        WJSanlqRlplTgpBm4uAEGc4DNJwLpIa3uCAxtzgzHSJ/ilFRSpz3AEhCACSRUZoH1wtLA68Y
        xYFeEebVAyYFIR5gCoHrfgU0mAlocDPIR7zFJYkIKakGRpV373eL9az+cmD29zK5b8K5mUuL
        T729VfFFcNrS5zk2Au4s1VYmE3ueh0q/1JxUzPRz8fc3e0V+Ch7R8uK1KuHJjPvDsjwvcdXs
        lCmXJtfp+XL/OKW7Lz76X6DLIwHlxeXFVbz+AS9ZXVye1jaoHd+6YJIke5OHy+Z+Ib/k2a/q
        Nm4RdDmtpcRSnJFoqMVcVJwIADijkN3eAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of handling `GIT_REF_PARANOIA` in
`files_ref_iterator_begin()`, handle it in
`refs_ref_iterator_begin()`, where it will cover all reference stores.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               |  5 +++++
 refs/files-backend.c | 11 ++++-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 68a0872562..f4b95109af 100644
--- a/refs.c
+++ b/refs.c
@@ -1246,6 +1246,11 @@ struct ref_iterator *refs_ref_iterator_begin(
 {
 	struct ref_iterator *iter;
 
+	if (ref_paranoia < 0)
+		ref_paranoia = git_env_bool("GIT_REF_PARANOIA", 0);
+	if (ref_paranoia)
+		flags |= DO_FOR_EACH_INCLUDE_BROKEN;
+
 	iter = refs->be->iterator_begin(refs, prefix, flags);
 
 	/*
diff --git a/refs/files-backend.c b/refs/files-backend.c
index eb74d1119a..d3716c3a6f 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1087,15 +1087,12 @@ static struct ref_iterator *files_ref_iterator_begin(
 	struct ref_iterator *loose_iter, *packed_iter;
 	struct files_ref_iterator *iter;
 	struct ref_iterator *ref_iterator;
+	unsigned int required_flags = REF_STORE_READ;
 
-	if (ref_paranoia < 0)
-		ref_paranoia = git_env_bool("GIT_REF_PARANOIA", 0);
-	if (ref_paranoia)
-		flags |= DO_FOR_EACH_INCLUDE_BROKEN;
+	if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN))
+		required_flags |= REF_STORE_ODB;
 
-	refs = files_downcast(ref_store,
-			      REF_STORE_READ | (ref_paranoia ? 0 : REF_STORE_ODB),
-			      "ref_iterator_begin");
+	refs = files_downcast(ref_store, required_flags, "ref_iterator_begin");
 
 	iter = xcalloc(1, sizeof(*iter));
 	ref_iterator = &iter->base;
-- 
2.11.0

