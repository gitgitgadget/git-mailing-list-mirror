Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C76520401
	for <e@80x24.org>; Fri, 23 Jun 2017 07:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754124AbdFWHDS (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 03:03:18 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:50055 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754662AbdFWHCf (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 23 Jun 2017 03:02:35 -0400
X-AuditID: 1207440d-3d1ff70000001be7-48-594cbd0bfce1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 0D.51.07143.B0DBC495; Fri, 23 Jun 2017 03:02:35 -0400 (EDT)
Received: from bagpipes.fritz.box (p57BCC5B4.dip0.t-ipconnect.de [87.188.197.180])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5N71o63001300
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 23 Jun 2017 03:02:33 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 18/29] packed_read_raw_ref(): new function, replacing `resolve_packed_ref()`
Date:   Fri, 23 Jun 2017 09:01:36 +0200
Message-Id: <cacc4d404f8964765acbd19c2f7191046a6d2005.1498200513.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1498200513.git.mhagger@alum.mit.edu>
References: <cover.1498200513.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqMu91yfSYGKPoMXaZ3eYLJ6vP8Fu
        0XWlm8miofcKs8XtFfOZLZY8fM1s0T3lLaPFj5YeZovNm9tZHDg9/r7/wOSxc9Zddo8Fm0o9
        utqPsHk8693D6HHxkrLH501yAexRXDYpqTmZZalF+nYJXBnrN81mKVgmVNG7fj9bA+M+vi5G
        Tg4JAROJi/NOsXUxcnEICexgkvh1/ycrSEJI4BSTxMN7AiA2m4CuxKKeZiYQW0RATWJi2yEW
        kAZmgUnMEm+vLQRLCAvES1x79oq5i5GDg0VAVWJXXyVImFcgSqKxq5EdYpm8xK62i2DzOQUs
        JHomLmeH2GUuser3atYJjDwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuka6eVmluilppRu
        YoSEHO8Oxv/rZA4xCnAwKvHwJpz1jhRiTSwrrsw9xCjJwaQkyqsZ6RMpxJeUn1KZkVicEV9U
        mpNafIhRgoNZSYRXZxVQjjclsbIqtSgfJiXNwaIkzqu2RN1PSCA9sSQ1OzW1ILUIJivDwaEk
        wduyG6hRsCg1PbUiLTOnBCHNxMEJMpwHaLjHZpDhxQWJucWZ6RD5U4yKUuK8G0CaBUASGaV5
        cL2wlPCKURzoFWHeRJAqHmA6get+BTSYCWjwjDVgg0sSEVJSDYwqn5zjNmia1cSUGOrru8c8
        4fbX8995xnxN7so1J1VEyyft3lJefK6Po21SaFn9/mL/yfnda2fq51zU9bdz/qDg2KV9X0L2
        ade8yk2O9nLLjt2fkySY/rPl3m7bBfdWsPwKVjcJPXwisnhqIYvtvFW/9L5/duqriou0XvFV
        4WJWZm2KDtO7fUosxRmJhlrMRcWJAF0QhVPkAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new function, `packed_read_raw_ref()`, which is nearly a
`read_raw_ref_fn`. Use it in place of `resolve_packed_ref()`.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0490cc087e..346794cf7c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -608,27 +608,23 @@ static struct ref_entry *get_packed_ref(struct packed_ref_store *refs,
 	return find_ref_entry(get_packed_refs(refs), refname);
 }
 
-/*
- * A loose ref file doesn't exist; check for a packed ref.
- */
-static int resolve_packed_ref(struct files_ref_store *refs,
-			      const char *refname,
-			      unsigned char *sha1, unsigned int *flags)
+static int packed_read_raw_ref(struct packed_ref_store *refs,
+			       const char *refname, unsigned char *sha1,
+			       struct strbuf *referent, unsigned int *type)
 {
 	struct ref_entry *entry;
 
-	/*
-	 * The loose reference file does not exist; check for a packed
-	 * reference.
-	 */
-	entry = get_packed_ref(refs->packed_ref_store, refname);
-	if (entry) {
-		hashcpy(sha1, entry->u.value.oid.hash);
-		*flags |= REF_ISPACKED;
-		return 0;
+	*type = 0;
+
+	entry = get_packed_ref(refs, refname);
+	if (!entry) {
+		errno = ENOENT;
+		return -1;
 	}
-	/* refname is not a packed reference. */
-	return -1;
+
+	hashcpy(sha1, entry->u.value.oid.hash);
+	*type = REF_ISPACKED;
+	return 0;
 }
 
 static int files_read_raw_ref(struct ref_store *ref_store,
@@ -674,7 +670,8 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 	if (lstat(path, &st) < 0) {
 		if (errno != ENOENT)
 			goto out;
-		if (resolve_packed_ref(refs, refname, sha1, type)) {
+		if (packed_read_raw_ref(refs->packed_ref_store, refname,
+					sha1, referent, type)) {
 			errno = ENOENT;
 			goto out;
 		}
@@ -713,7 +710,8 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 		 * ref is supposed to be, there could still be a
 		 * packed ref:
 		 */
-		if (resolve_packed_ref(refs, refname, sha1, type)) {
+		if (packed_read_raw_ref(refs->packed_ref_store, refname,
+					sha1, referent, type)) {
 			errno = EISDIR;
 			goto out;
 		}
-- 
2.11.0

