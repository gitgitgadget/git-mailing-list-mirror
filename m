Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53CC81FAF4
	for <e@80x24.org>; Fri, 10 Feb 2017 11:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753044AbdBJLQt (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 06:16:49 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:58457 "EHLO
        alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752921AbdBJLQl (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Feb 2017 06:16:41 -0500
X-AuditID: 1207440d-967ff70000000a35-99-589da1174855
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 06.1C.02613.711AD985; Fri, 10 Feb 2017 06:16:39 -0500 (EST)
Received: from bagpipes.fritz.box (p57906495.dip0.t-ipconnect.de [87.144.100.149])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v1ABGLLl025185
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 10 Feb 2017 06:16:37 -0500
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 8/9] files_ref_store::submodule: use NULL for the main repository
Date:   Fri, 10 Feb 2017 12:16:18 +0100
Message-Id: <a7d07a3b3374e399e0ac04b57802d247ad05a9cb.1486724698.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1486724698.git.mhagger@alum.mit.edu>
References: <cover.1486724698.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqCu+cG6EwfMbxhZdV7qZLBp6rzBb
        9C/vYrO4vWI+s8WSh6+ZLbqnvGW0+NHSw2yxeXM7iwOHx9/3H5g8ds66y+7x4WOcx4JNpR5d
        7UfYPJ717mH0uHhJ2ePzJrkAjigum5TUnMyy1CJ9uwSujBff/zAX7BSteLXgElsD41rBLkZO
        DgkBE4lr/xewdTFycQgJXGaUWPnvKxOEc4pJ4u2nZmaQKjYBXYlFPc1MILaIgJrExLZDLCA2
        M0jRuQVgcWGBEImdp3+A1bMIqEo82vIVLM4rECVxcdd5VohtchKXtn0Bq+EUsJD4d+IMmC0k
        YC5xfNVR5gmMPAsYGVYxyiXmlObq5iZm5hSnJusWJyfm5aUW6Rrp5WaW6KWmlG5ihIQc7w7G
        /+tkDjEKcDAq8fC+qJkTIcSaWFZcmXuIUZKDSUmU9/uMuRFCfEn5KZUZicUZ8UWlOanFhxgl
        OJiVRHhtOoByvCmJlVWpRfkwKWkOFiVxXrUl6n5CAumJJanZqakFqUUwWRkODiUJXoYFQI2C
        RanpqRVpmTklCGkmDk6Q4TxAw9lBaniLCxJzizPTIfKnGBWlxHnr5gMlBEASGaV5cL2wlPCK
        URzoFWFeMZB2HmA6get+BTSYCWjw9dOzQAaXJCKkpBoYM9bdUtXfk/uS8faJR9fWrdwY8Xnn
        nzcyjMtSr6pG3XHe6hk8V4T5vNy2CPGWN2/n6qqoSLZGur4+5LOw/LPFTSPjoxNWSS6rWHLt
        YEFB+eEov9Wl77c8LrJUK14a9/7Buasbo46zdy/zb7/zcEXvSx2lb5J/lhTOuijtd1DzqH53
        w6KUPQsj1imxFGckGmoxFxUnAgCyI5RR5AIAAA==
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
index c9d2d28..4fe92f0 100644
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

