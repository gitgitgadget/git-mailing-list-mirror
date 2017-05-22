Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB3482023D
	for <e@80x24.org>; Mon, 22 May 2017 14:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934733AbdEVOTJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 10:19:09 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:56205 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934694AbdEVOTC (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 May 2017 10:19:02 -0400
X-AuditID: 1207440e-797ff70000007d8a-c6-5922f354032b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 2C.59.32138.453F2295; Mon, 22 May 2017 10:19:01 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCCDA0.dip0.t-ipconnect.de [87.188.205.160])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v4MEI24V023503
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Mon, 22 May 2017 10:18:58 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 22/25] refs_ref_iterator_begin(): handle `GIT_REF_PARANOIA`
Date:   Mon, 22 May 2017 16:17:52 +0200
Message-Id: <dcd5c44b31a5845b02551ac59ba659eb3d2822c7.1495460199.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1495460199.git.mhagger@alum.mit.edu>
References: <cover.1495460199.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqBv6WSnSYMIRJou1z+4wWTxff4Ld
        outKN5NFQ+8VZosnc+8yW9xeMZ/ZYsnD18wW3VPeMlr8aOlhtti8uZ3Fgcvj7/sPTB47Z91l
        91iwqdTj4asudo+u9iNsHs969zB6XLyk7PF5k1wARxSXTUpqTmZZapG+XQJXxvrnxxkL5vJW
        rG67y9rA+JWri5GTQ0LAROLK3FVMXYxcHEICO5gkmta+Z4VwTjFJnPnSwwxSxSagK7Gop5kJ
        xBYRUJOY2HaIBaSIWWADs8Sb6avBEsICfhJfV/0Ds1kEVCWmb/3C3sXIwcErECWxq7MIYpu8
        xK62i6wgNqeAhcTvWQfAyoUEzCV6/61mmcDIs4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqR
        rrFebmaJXmpK6SZGSCDy7WBsXy9ziFGAg1GJh1fjsVKkEGtiWXFl7iFGSQ4mJVHeo2+AQnxJ
        +SmVGYnFGfFFpTmpxYcYJTiYlUR4te8C5XhTEiurUovyYVLSHCxK4rxqS9T9hATSE0tSs1NT
        C1KLYLIyHBxKErx6n4AaBYtS01Mr0jJzShDSTBycIMN5gIav+QAyvLggMbc4Mx0if4pRUUqc
        1wCkWQAkkVGaB9cLSxSvGMWBXhHmLQSp4gEmGbjuV0CDmYAGWz+TBxlckoiQkmpgNF7zcG3o
        iUVH1W7w7JAJ/yl36DD7l7ebFe5+rmviPfDrEPs7QYGSuJUvZ+xeW5+xfNNvaV+ms7MOJN5P
        7jvVV2rg89i8Jnty7IXf++RO7tXj5XMzfj/9CIOx4qt9BU7tKhmrD57RCFFbkvTjzOGG14vn
        cR+ZfmVjYL0Qs6aFTlFhc0mxJPOjr0osxRmJhlrMRcWJANOlIrPvAgAA
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
index d1c781d94e..f0685c9251 100644
--- a/refs.c
+++ b/refs.c
@@ -1259,6 +1259,11 @@ struct ref_iterator *refs_ref_iterator_begin(
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
index dbfd03f989..5de36fc335 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1074,15 +1074,12 @@ static struct ref_iterator *files_ref_iterator_begin(
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

