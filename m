Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E5E71F859
	for <e@80x24.org>; Sun,  4 Sep 2016 16:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754264AbcIDQK3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:10:29 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:61523 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753981AbcIDQKN (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 12:10:13 -0400
X-AuditID: 12074413-ab7ff70000000955-7b-57cc472548ff
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 06.21.02389.5274CC75; Sun,  4 Sep 2016 12:09:09 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906AC6.dip0.t-ipconnect.de [87.144.106.198])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u84G8n5U026955
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 4 Sep 2016 12:09:07 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 08/38] resolve_missing_loose_ref(): add a files_ref_store argument
Date:   Sun,  4 Sep 2016 18:08:14 +0200
Message-Id: <abc7326c53a018854d4e9cddf2fec9e0922d9787.1473003903.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473003902.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqKvqfibcYPkZGYuuK91MFg29V5gt
        bq+Yz2yx5OFrZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7tHVfoTN41nvHkaP
        i5eUPfYv3cbmsfiBl8fnTXIBHFFcNimpOZllqUX6dglcGbMONrIV/Oer2LxFtYHxH3cXIyeH
        hICJxI7mucxdjFwcQgJbGSX6Lz1lh3BOMknsvvecDaSKTUBXYlFPMxOILSKgJjGx7RALSBEz
        SNGsiTPZQRLCAqES2zetZQaxWQRUJZb9+ADWzCsQJbGufSErxDo5iUvbvoDVcApYSJzZDbKa
        A2ibuUT7i+wJjDwLGBlWMcol5pTm6uYmZuYUpybrFicn5uWlFuma6+VmluilppRuYoQEnPAO
        xl0n5Q4xCnAwKvHwTtA9Ey7EmlhWXJl7iFGSg0lJlHfWwZPhQnxJ+SmVGYnFGfFFpTmpxYcY
        JTiYlUR4tV2AynlTEiurUovyYVLSHCxK4rxqS9T9hATSE0tSs1NTC1KLYLIyHBxKErzXXYEa
        BYtS01Mr0jJzShDSTBycIMN5gIbfBKnhLS5IzC3OTIfIn2JUlBLnfQmSEABJZJTmwfXCEsIr
        RnGgV4R5E9yAqniAyQSu+xXQYCagwet2nwYZXJKIkJJqYNRc9avFwzW/YMeCwjMl9/iDmrOy
        Klm+vcvr+2YisTTQ6qHO8svb7nBPTSnoCyt/ub/oeCDXQauLxhyty/ctPxAgMtdIYMZ6pp6i
        Jw/fWzzy6U9e3Bd8aGbnRlaJU6cNRR+sPe9/8mvdqf/1XzTWuu5Qudj7T+/bHKMvs7VjtkYG
        aP/aIbbuh6USS3FGoqEWc1FxIgDvo74p4wIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs/files-backend.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 2fc8ec9..0c92ace 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1412,13 +1412,11 @@ static struct ref_entry *get_packed_ref(struct files_ref_store *refs,
 /*
  * A loose ref file doesn't exist; check for a packed ref.
  */
-static int resolve_missing_loose_ref(const char *refname,
+static int resolve_missing_loose_ref(struct files_ref_store *refs,
+				     const char *refname,
 				     unsigned char *sha1,
 				     unsigned int *flags)
 {
-	struct files_ref_store *refs =
-		get_files_ref_store(NULL, "resolve_missing_loose_ref");
-
 	struct ref_entry *entry;
 
 	/*
@@ -1438,6 +1436,8 @@ static int resolve_missing_loose_ref(const char *refname,
 int read_raw_ref(const char *refname, unsigned char *sha1,
 		 struct strbuf *referent, unsigned int *type)
 {
+	struct files_ref_store *refs =
+		get_files_ref_store(NULL, "read_raw_ref");
 	struct strbuf sb_contents = STRBUF_INIT;
 	struct strbuf sb_path = STRBUF_INIT;
 	const char *path;
@@ -1466,7 +1466,7 @@ int read_raw_ref(const char *refname, unsigned char *sha1,
 	if (lstat(path, &st) < 0) {
 		if (errno != ENOENT)
 			goto out;
-		if (resolve_missing_loose_ref(refname, sha1, type)) {
+		if (resolve_missing_loose_ref(refs, refname, sha1, type)) {
 			errno = ENOENT;
 			goto out;
 		}
@@ -1500,7 +1500,7 @@ int read_raw_ref(const char *refname, unsigned char *sha1,
 		 * ref is supposed to be, there could still be a
 		 * packed ref:
 		 */
-		if (resolve_missing_loose_ref(refname, sha1, type)) {
+		if (resolve_missing_loose_ref(refs, refname, sha1, type)) {
 			errno = EISDIR;
 			goto out;
 		}
-- 
2.9.3

