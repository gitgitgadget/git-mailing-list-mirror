Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFCD91F859
	for <e@80x24.org>; Sun,  4 Sep 2016 16:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754217AbcIDQKW (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:10:22 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:54561 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753966AbcIDQKN (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 12:10:13 -0400
X-AuditID: 1207440d-bf7ff700000008af-e9-57cc471d6021
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 0F.76.02223.D174CC75; Sun,  4 Sep 2016 12:09:03 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906AC6.dip0.t-ipconnect.de [87.144.106.198])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u84G8n5Q026955
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 4 Sep 2016 12:09:00 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Ronnie Sahlberg <sahlberg@google.com>,
        David Turner <dturner@twopensource.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 04/38] refs: add a backend method structure
Date:   Sun,  4 Sep 2016 18:08:10 +0200
Message-Id: <4da46c8dfa4b7ec13927ca8597b64ffff7de4430.1473003902.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473003902.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsUixO6iqCvvfibcYMlWcYv5m04wWnRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li5lVri38TaizOvGlkdODy+Pv+A5PHzll32T0W
        bCr16Go/wubxrHcPo8fFS8oe+5duY/NY/MDLY8Hz++wenzfJBXBFcdmkpOZklqUW6dslcGWs
        X3WIveC5aMXNQ2+ZGhifC3YxcnJICJhILNjUxd7FyMUhJLCVUeL+4slsEM5JJokT206ygVSx
        CehKLOppZgKxRQTUJCa2HWIBKWIWWM0scaxpMyNIQljATmLJy/9gNouAqsS2N/uAijg4eAWi
        JPqX8kNsk5O4tO0LM4jNKWAhcWb3XGaQEiEBc4n2F9kTGHkWMDKsYpRLzCnN1c1NzMwpTk3W
        LU5OzMtLLdI10svNLNFLTSndxAgJSt4djP/XyRxiFOBgVOLhtdA+Ey7EmlhWXJl7iFGSg0lJ
        lHfWwZPhQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4tV2AynlTEiurUovyYVLSHCxK4rxqS9T9
        hATSE0tSs1NTC1KLYLIyHBxKErwNrkCNgkWp6akVaZk5JQhpJg5OkOE8QMNvgtTwFhck5hZn
        pkPkTzEqSonzhoBsFQBJZJTmwfXCksYrRnGgV4R5Fd2AqniACQeu+xXQYCagwet2nwYZXJKI
        kJJqYOzeEaPCN3tOxrTqKzM3Hnq1KNbbN5J/fWn7aYeNrEL/juSUtulXis05H1XzMW3Pqje9
        YWHGUSZN03Qd5YUPNj4/zNrdK23pm7XNvC0yP12KY5JjnO9TofvPbQpLpy9+/VOqvSiNpfN8
        7A8NJf4DP5zWXfnVGCy2Vd/9/rG1l5U5Qs2rhJcqKLEUZyQaajEXFScCAL5p7ZD1AgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

Add a `struct ref_storage_be` to represent types of reference stores. In
OO notation, this is the class, and will soon hold some class
methods (e.g., a factory to create new ref_store instances) and will
also serve as the vtable for ref_store instances of that type.

As yet, the backends cannot do anything.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c               | 19 +++++++++++++++++++
 refs.h               |  2 ++
 refs/files-backend.c |  5 +++++
 refs/refs-internal.h |  8 ++++++++
 4 files changed, 34 insertions(+)

diff --git a/refs.c b/refs.c
index 4c609df..d2a29bb 100644
--- a/refs.c
+++ b/refs.c
@@ -10,6 +10,25 @@
 #include "tag.h"
 
 /*
+ * List of all available backends
+ */
+static struct ref_storage_be *refs_backends = &refs_be_files;
+
+static struct ref_storage_be *find_ref_storage_backend(const char *name)
+{
+	struct ref_storage_be *be;
+	for (be = refs_backends; be; be = be->next)
+		if (!strcmp(be->name, name))
+			return be;
+	return NULL;
+}
+
+int ref_storage_backend_exists(const char *name)
+{
+	return find_ref_storage_backend(name) != NULL;
+}
+
+/*
  * How to handle various characters in refnames:
  * 0: An acceptable character for refs
  * 1: End-of-component
diff --git a/refs.h b/refs.h
index 1b02043..9a29f1b 100644
--- a/refs.h
+++ b/refs.h
@@ -544,4 +544,6 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 		  reflog_expiry_cleanup_fn cleanup_fn,
 		  void *policy_cb_data);
 
+int ref_storage_backend_exists(const char *name);
+
 #endif /* REFS_H */
diff --git a/refs/files-backend.c b/refs/files-backend.c
index aa09586..ecf66e6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -4076,3 +4076,8 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 	unlock_ref(lock);
 	return -1;
 }
+
+struct ref_storage_be refs_be_files = {
+	NULL,
+	"files"
+};
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 0206e2b..2c9d134 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -525,4 +525,12 @@ int do_for_each_ref_iterator(struct ref_iterator *iter,
 int read_raw_ref(const char *refname, unsigned char *sha1,
 		 struct strbuf *referent, unsigned int *type);
 
+/* refs backends */
+struct ref_storage_be {
+	struct ref_storage_be *next;
+	const char *name;
+};
+
+extern struct ref_storage_be refs_be_files;
+
 #endif /* REFS_REFS_INTERNAL_H */
-- 
2.9.3

