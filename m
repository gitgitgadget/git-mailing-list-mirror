Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 537791F859
	for <e@80x24.org>; Sun,  4 Sep 2016 16:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754544AbcIDQNE (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:13:04 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:56096 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754387AbcIDQNB (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 12:13:01 -0400
X-AuditID: 1207440e-dc3ff70000000931-15-57cc472e5b94
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 39.0B.02353.E274CC75; Sun,  4 Sep 2016 12:09:18 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906AC6.dip0.t-ipconnect.de [87.144.106.198])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u84G8n5Z026955
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 4 Sep 2016 12:09:17 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 13/38] resolve_gitlink_packed_ref(): remove function
Date:   Sun,  4 Sep 2016 18:08:19 +0200
Message-Id: <9b5862009f45ae8ca8b14133ea0fcf0054901d70.1473003903.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473003902.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqKvnfibc4MQtHYuuK91MFg29V5gt
        bq+Yz2yx5OFrZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7tHVfoTN41nvHkaP
        i5eUPfYv3cbmsfiBl8fnTXIBHFFcNimpOZllqUX6dglcGc2HVzMXbOOtaDi5hamB8SdXFyMn
        h4SAicSqv1vYuxi5OIQEtjJK7Fv0Dso5ySQx6+JvZpAqNgFdiUU9zUwgtoiAmsTEtkMsIEXM
        YEUTZ7KDJIQF3CW+n77LBmKzCKhK3O99BmbzCkRJ7Dx8mR1inZzEpW1fwIZyClhInNk9F8jm
        ANpmLtH+InsCI88CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbrGermZJXqpKaWbGCEhx7eD
        sX29zCFGAQ5GJR5eC+0z4UKsiWXFlbmHGCU5mJREeWcdPBkuxJeUn1KZkVicEV9UmpNafIhR
        goNZSYRX2wWonDclsbIqtSgfJiXNwaIkzqu2RN1PSCA9sSQ1OzW1ILUIJivDwaEkwXvdFahR
        sCg1PbUiLTOnBCHNxMEJMpwHaPhNkBre4oLE3OLMdIj8KUZFKXHelyAJAZBERmkeXC8sJbxi
        FAd6RZhX0Q2oigeYTuC6XwENZgIavG73aZDBJYkIKakGxgqfxb0eNy6LmiRVWfQwfpFo25B4
        95biNSfGN6UOLKfP/PiXOjv8yZM3S82+Ld762Wj1/fcarVMC3d7Puf09K2Hpb0fm2Vc8ZtT9
        zv+ariy31oZtz0u9uD77SdEvyuYzTz+uteXHZJuUyXXcCx/vsD6yfNLM+113+irEtry0T+4z
        qWT2by+6mqrEUpyRaKjFXFScCAAGCVBR5AIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that resolve_packed_ref() can work with an arbitrary
files_ref_store, there is no need to have a separate
resolve_gitlink_packed_ref() function.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs/files-backend.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 32ca5ff..3b0c837 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1490,25 +1490,6 @@ static void unlock_ref(struct ref_lock *lock)
 
 #define MAXREFLEN (1024)
 
-/*
- * Called by resolve_gitlink_ref_recursive() after it failed to read
- * from the loose refs in refs. Find <refname> in the packed-refs file
- * for the submodule.
- */
-static int resolve_gitlink_packed_ref(struct files_ref_store *refs,
-				      const char *refname, unsigned char *sha1)
-{
-	struct ref_entry *ref;
-	struct ref_dir *dir = get_packed_refs(refs);
-
-	ref = find_ref(dir, refname);
-	if (ref == NULL)
-		return -1;
-
-	hashcpy(sha1, ref->u.value.oid.hash);
-	return 0;
-}
-
 static int resolve_gitlink_ref_recursive(struct files_ref_store *refs,
 					 const char *refname, unsigned char *sha1,
 					 int recursion)
@@ -1524,8 +1505,11 @@ static int resolve_gitlink_ref_recursive(struct files_ref_store *refs,
 		: git_pathdup("%s", refname);
 	fd = open(path, O_RDONLY);
 	free(path);
-	if (fd < 0)
-		return resolve_gitlink_packed_ref(refs, refname, sha1);
+	if (fd < 0) {
+		unsigned int flags;
+
+		return resolve_packed_ref(refs, refname, sha1, &flags);
+	}
 
 	len = read(fd, buffer, sizeof(buffer)-1);
 	close(fd);
-- 
2.9.3

