Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EBDD1FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 13:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751563AbdBIN22 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 08:28:28 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:60632 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751480AbdBIN20 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Feb 2017 08:28:26 -0500
X-AuditID: 12074411-fbbff700000009b7-d1-589c6e392fea
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 1A.0A.02487.93E6C985; Thu,  9 Feb 2017 08:27:21 -0500 (EST)
Received: from bagpipes.fritz.box (p4FEDF6A1.dip0.t-ipconnect.de [79.237.246.161])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v19DRB5G023019
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Thu, 9 Feb 2017 08:27:20 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 4/5] files_ref_store::submodule: use NULL for the main repository
Date:   Thu,  9 Feb 2017 14:27:01 +0100
Message-Id: <111d663c0fd3e9669e7c28537f581833488ca4a6.1486629195.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1486629195.git.mhagger@alum.mit.edu>
References: <cover.1486629195.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsUixO6iqGuZNyfC4O8iHYuuK91MFg29V5gt
        +pd3sVncXjGf2WLJw9fMFt1T3jJabN7czuLA7vH3/Qcmj52z7rJ7fPgY57FgU6lHV/sRNo+L
        l5Q9Pm+SC2CP4rJJSc3JLEst0rdL4Mo41nWMrWCnaMXdzguMDYxrBbsYOTgkBEwk/vyq7GLk
        4hASuMwoMWPRSlYI5ySTxIqZf9m7GDk52AR0JRb1NDOB2CICahIT2w6xgBQxC6xnkjg97wMr
        SEJYIFDi9eF7zCA2i4CqxPOln1hAbF6BKIm7LavYQGwJATmJS9u+gNVwClhI/J5whRHEFhIw
        l/h7/DvTBEaeBYwMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0TfVyM0v0UlNKNzFCwktwB+OM
        k3KHGAU4GJV4eC9Yz44QYk0sK67MPcQoycGkJMob8R8oxJeUn1KZkVicEV9UmpNafIhRgoNZ
        SYQ3JWdOhBBvSmJlVWpRPkxKmoNFSZyXb4m6n5BAemJJanZqakFqEUxWhoNDSYL3L0ijYFFq
        empFWmZOCUKaiYMTZDgP0PAZYMOLCxJzizPTIfKnGBWlxHmzQRICIImM0jy4Xlj8v2IUB3pF
        mPcQSBUPMHXAdb8CGswENPj66Vkgg0sSEVJSDYwtO7RWhul4+DQ4fZ7N/sRimpyTeMT9c0/2
        2yqFt71sYFMo3K+7TeuazZmKZpUs7Z9Zbsptd2Nd6wyeiK6JvePUfZ356qKmMJ/cqKMLv8e+
        XTSrJPjrN+dA7gph5dOqR2TFfePTJh/a9imbMVLh5P+Ir+ZH1z9j2S/MHZ6cHlwTuWTRocZj
        U5VYijMSDbWYi4oTAUj89X/aAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The old practice of storing the empty string in this member for the main
repository was a holdover from before 00eebe3 (refs: create a base class
"ref_store" for files_ref_store, 2016-09-04), when the submodule was
stored in a flex array at the end of `struct files_ref_store`. Storing
NULL for this case is more idiomatic and a tiny bit less code.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 794b88c..069a8ee 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -915,8 +915,8 @@ struct files_ref_store {
 
 	/*
 	 * The name of the submodule represented by this object, or
-	 * the empty string if it represents the main repository's
-	 * reference store:
+	 * NULL if it represents the main repository's reference
+	 * store:
 	 */
 	const char *submodule;
 
@@ -982,7 +982,7 @@ static struct ref_store *files_ref_store_create(const char *submodule)
 
 	base_ref_store_init(ref_store, &refs_be_files);
 
-	refs->submodule = submodule ? xstrdup(submodule) : "";
+	refs->submodule = xstrdup_or_null(submodule);
 
 	return ref_store;
 }
@@ -994,7 +994,7 @@ static struct ref_store *files_ref_store_create(const char *submodule)
 static void files_assert_main_repository(struct files_ref_store *refs,
 					 const char *caller)
 {
-	if (*refs->submodule)
+	if (refs->submodule)
 		die("BUG: %s called for a submodule", caller);
 }
 
@@ -1158,7 +1158,7 @@ static struct packed_ref_cache *get_packed_ref_cache(struct files_ref_store *ref
 {
 	char *packed_refs_file;
 
-	if (*refs->submodule)
+	if (refs->submodule)
 		packed_refs_file = git_pathdup_submodule(refs->submodule,
 							 "packed-refs");
 	else
@@ -1228,7 +1228,7 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 	size_t path_baselen;
 	int err = 0;
 
-	if (*refs->submodule)
+	if (refs->submodule)
 		err = strbuf_git_path_submodule(&path, refs->submodule, "%s", dirname);
 	else
 		strbuf_git_path(&path, "%s", dirname);
@@ -1269,7 +1269,7 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 		} else {
 			int read_ok;
 
-			if (*refs->submodule) {
+			if (refs->submodule) {
 				hashclr(sha1);
 				flag = 0;
 				read_ok = !resolve_gitlink_ref(refs->submodule,
@@ -1383,7 +1383,7 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 	*type = 0;
 	strbuf_reset(&sb_path);
 
-	if (*refs->submodule)
+	if (refs->submodule)
 		strbuf_git_path_submodule(&sb_path, refs->submodule, "%s", refname);
 	else
 		strbuf_git_path(&sb_path, "%s", refname);
-- 
2.9.3

