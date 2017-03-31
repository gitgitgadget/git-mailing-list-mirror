Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB6511FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 14:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933209AbdCaOLy (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 10:11:54 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:50435 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933135AbdCaOLj (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 31 Mar 2017 10:11:39 -0400
X-AuditID: 1207440c-abdff70000002e8f-6f-58de63985862
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id A9.C9.11919.8936ED85; Fri, 31 Mar 2017 10:11:36 -0400 (EDT)
Received: from bagpipes.fritz.box (p4FEDFA60.dip0.t-ipconnect.de [79.237.250.96])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2VEBRBi010139
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 31 Mar 2017 10:11:34 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 03/20] refs_ref_iterator_begin(): new function
Date:   Fri, 31 Mar 2017 16:11:01 +0200
Message-Id: <840b199ad58f11a690c684ad110807ed81d3b0eb.1490966385.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1490966385.git.mhagger@alum.mit.edu>
References: <cover.1490966385.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsUixO6iqDsj+V6EwdxOa4u1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAldG+6VvbAUzBSt6dl9ga2Bs5eti5OSQEDCR
        +Ph6IWMXIxeHkMAOJokDP5eyQTgnmSRmTV7GClLFJqArsainmQnEFhFQk5jYdogFpIhZ4A1Q
        x5ZfLCAJYQFHidOnZ4E1sAioSvR8uAHWwCsQJbH0WD8rxDp5iV1tF8FsTgELiXUzD7GD2EIC
        5hIL1k5gm8DIs4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrqFebmaJXmpK6SZGSLDx7GD8
        tk7mEKMAB6MSD+8J73sRQqyJZcWVuYcYJTmYlER5fcOBQnxJ+SmVGYnFGfFFpTmpxYcYJTiY
        lUR4meKAcrwpiZVVqUX5MClpDhYlcV7VJep+QgLpiSWp2ampBalFMFkZDg4lCd6KJKBGwaLU
        9NSKtMycEoQ0EwcnyHAeoOEpIDW8xQWJucWZ6RD5U4y6HLca9rxhEmLJy89LlRLnZQUpEgAp
        yijNg5sDSxKvGMWB3hLm9QKp4gEmGLhJr4CWMAEtsfh6F2RJSSJCSqqBUbvJONSlk/nitPhk
        3qiuL4Iz3n0zkoldMqlNbn/YnwNbHIo+KK20nFG19ri0kpu+n5Ui65+ixUIb4v4u0P/2nuNd
        mU2oQE6BF4+Wtr/DyZNfUrwWty1a8ZP1YEnGW6Y9LOcnKM5Z03JyQp2/SkSQSO7klMgtyxY6
        PZq/SiKu4U/yWZ7uud9slFiKMxINtZiLihMBQT20VO0CAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extract a new function from `do_for_each_ref()`. It will be useful
elsewhere.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               | 15 +++++++++++++--
 refs/refs-internal.h | 11 +++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 0ed6c3c7a4..aeb704ab92 100644
--- a/refs.c
+++ b/refs.c
@@ -1230,6 +1230,18 @@ int head_ref(each_ref_fn fn, void *cb_data)
 	return head_ref_submodule(NULL, fn, cb_data);
 }
 
+struct ref_iterator *refs_ref_iterator_begin(
+		struct ref_store *refs,
+		const char *prefix, int trim, int flags)
+{
+	struct ref_iterator *iter;
+
+	iter = refs->be->iterator_begin(refs, prefix, flags);
+	iter = prefix_ref_iterator_begin(iter, prefix, trim);
+
+	return iter;
+}
+
 /*
  * Call fn for each reference in the specified submodule for which the
  * refname begins with prefix. If trim is non-zero, then trim that
@@ -1247,8 +1259,7 @@ static int do_for_each_ref(struct ref_store *refs, const char *prefix,
 	if (!refs)
 		return 0;
 
-	iter = refs->be->iterator_begin(refs, prefix, flags);
-	iter = prefix_ref_iterator_begin(iter, prefix, trim);
+	iter = refs_ref_iterator_begin(refs, prefix, trim, flags);
 
 	return do_for_each_ref_iterator(iter, fn, cb_data);
 }
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 6ee9f20dbc..545989ae7f 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -335,6 +335,17 @@ struct ref_iterator *empty_ref_iterator_begin(void);
  */
 int is_empty_ref_iterator(struct ref_iterator *ref_iterator);
 
+/*
+ * Return an iterator that goes over each reference in `refs` for
+ * which the refname begins with prefix. If trim is non-zero, then
+ * trim that many characters off the beginning of each refname. flags
+ * can be DO_FOR_EACH_INCLUDE_BROKEN to include broken references in
+ * the iteration.
+ */
+struct ref_iterator *refs_ref_iterator_begin(
+		struct ref_store *refs,
+		const char *prefix, int trim, int flags);
+
 /*
  * A callback function used to instruct merge_ref_iterator how to
  * interleave the entries from iter0 and iter1. The function should
-- 
2.11.0

