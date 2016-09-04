Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F54B20193
	for <e@80x24.org>; Sun,  4 Sep 2016 16:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754323AbcIDQN1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:13:27 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:54601 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754505AbcIDQNB (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 12:13:01 -0400
X-AuditID: 1207440d-be3ff700000008af-06-57cc473c80eb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 82.86.02223.C374CC75; Sun,  4 Sep 2016 12:09:33 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906AC6.dip0.t-ipconnect.de [87.144.106.198])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u84G8n5h026955
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 4 Sep 2016 12:09:31 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 21/38] refs: make pack_refs() virtual
Date:   Sun,  4 Sep 2016 18:08:27 +0200
Message-Id: <a46ef6f70f2ed1e7f9c688e7c5a5845ec05bef40.1473003903.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473003902.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqGvrfibc4PMDFouuK91MFg29V5gt
        bq+Yz2yx5OFrZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7tHVfoTN41nvHkaP
        i5eUPfYv3cbmsfiBl8fnTXIBHFFcNimpOZllqUX6dglcGU9WXWEpuCdYsXnCIsYGxpN8XYyc
        HBICJhLHGjexdDFycQgJbGWU2LT7HzOEc5JJom3OGkaQKjYBXYlFPc1MILaIgJrExLZDYB3M
        IEWzJs5kB0kIC1hIXGn8xAZiswioSrQsmQIW5xWIktjUeZERYp2cxKVtX5hBbE6g+jO75wLZ
        HEDbzCXaX2RPYORZwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXSC83s0QvNaV0EyMk5Hh3
        MP5fJ3OIUYCDUYmH10L7TLgQa2JZcWXuIUZJDiYlUd5ZB0+GC/El5adUZiQWZ8QXleakFh9i
        lOBgVhLh1XYBKudNSaysSi3Kh0lJc7AoifOqLVH3ExJITyxJzU5NLUgtgsnKcHAoSfA2uAI1
        ChalpqdWpGXmlCCkmTg4QYbzAA2/CVLDW1yQmFucmQ6RP8WoKCXOGwKyVQAkkVGaB9cLSwmv
        GMWBXhHmVXQDquIBphO47ldAg5mABq/bfRpkcEkiQkqqgVEy1ezIDDdFwS0RZxIT7269cf/B
        9i278ww7Zwbv7K8/JRLEc2jv1PXFt19O36Xebeaa9tmNQfSGTGBt/5+6I3Uthm8ulrL9rV95
        /ba+RWf4t27R99MvPN/mveHxK//C9bksDtEZZqufd503YLqoW/DxlrjJrW2sNU93ZNnrTnl9
        fgLbA2FWjgQlluKMREMt5qLiRABck5WJ5AIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c               | 7 +++++++
 refs/files-backend.c | 6 ++++--
 refs/refs-internal.h | 4 ++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 662c417..961927a 100644
--- a/refs.c
+++ b/refs.c
@@ -1421,6 +1421,13 @@ void assert_main_repository(struct ref_store *refs, const char *caller)
 }
 
 /* backend functions */
+int pack_refs(unsigned int flags)
+{
+	struct ref_store *refs = get_ref_store(NULL);
+
+	return refs->be->pack_refs(refs, flags);
+}
+
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4e1d431..7ad8821 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2354,10 +2354,10 @@ static void prune_refs(struct ref_to_prune *r)
 	}
 }
 
-int pack_refs(unsigned int flags)
+static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
 {
 	struct files_ref_store *refs =
-		get_files_ref_store(NULL, "pack_refs");
+		files_downcast(ref_store, 0, "pack_refs");
 	struct pack_refs_cb_data cbdata;
 
 	memset(&cbdata, 0, sizeof(cbdata));
@@ -4032,6 +4032,8 @@ struct ref_storage_be refs_be_files = {
 	files_ref_store_create,
 	files_transaction_commit,
 
+	files_pack_refs,
+
 	files_read_raw_ref,
 	files_verify_refname_available
 };
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 6c698f4..256f7f5 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -500,6 +500,8 @@ typedef int ref_transaction_commit_fn(struct ref_store *refs,
 				      struct ref_transaction *transaction,
 				      struct strbuf *err);
 
+typedef int pack_refs_fn(struct ref_store *ref_store, unsigned int flags);
+
 /*
  * Read a reference from the specified reference store, non-recursively.
  * Set type to describe the reference, and:
@@ -554,6 +556,8 @@ struct ref_storage_be {
 	ref_store_init_fn *init;
 	ref_transaction_commit_fn *transaction_commit;
 
+	pack_refs_fn *pack_refs;
+
 	read_raw_ref_fn *read_raw_ref;
 	verify_refname_available_fn *verify_refname_available;
 };
-- 
2.9.3

