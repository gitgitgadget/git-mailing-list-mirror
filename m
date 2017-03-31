Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 878861FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 14:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933203AbdCaOLv (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 10:11:51 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:64946 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933155AbdCaOLq (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 31 Mar 2017 10:11:46 -0400
X-AuditID: 12074412-4bbff70000000b04-53-58de63a14da1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 39.16.02820.1A36ED85; Fri, 31 Mar 2017 10:11:45 -0400 (EDT)
Received: from bagpipes.fritz.box (p4FEDFA60.dip0.t-ipconnect.de [79.237.250.96])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2VEBRBn010139
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Fri, 31 Mar 2017 10:11:43 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 08/20] ref-cache: rename `remove_entry()` to `remove_entry_from_dir()`
Date:   Fri, 31 Mar 2017 16:11:06 +0200
Message-Id: <d68fe455742381b9c64fcd25130011385ef1c6a1.1490966385.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1490966385.git.mhagger@alum.mit.edu>
References: <cover.1490966385.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsUixO6iqLsw+V6EwYqXUhZrn91hsui60s1k
        0dB7hdni9or5zBZLHr5mtuie8pbR4kdLD7PF5s3tLA4cHn/ff2Dy2DnrLrvHgk2lHl3tR9g8
        nvXuYfS4eEnZ4/MmuQD2KC6blNSczLLUIn27BK6MrUsPsBe0c1Y8W/yTuYFxD3sXIyeHhICJ
        xPGtvSxdjFwcQgI7mCSuX7/OBOGcZJJ4f/8aC0gVm4CuxKKeZiYQW0RATWJi2yGwDmaBN0wS
        B7b8AisSFoiUOP73PNhYFgFViQPfVrKC2LwCURIbr9xgg1gnL7Gr7SJYnFPAQmLdzENg9UIC
        5hIL1k5gm8DIs4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrplebmaJXmpK6SZGSLAJ7WBc
        f1LuEKMAB6MSD6+C370IIdbEsuLK3EOMkhxMSqK8vuFAIb6k/JTKjMTijPii0pzU4kOMEhzM
        SiK8THFAOd6UxMqq1KJ8mJQ0B4uSOO/Pxep+QgLpiSWp2ampBalFMFkNDg6Bu0t6NzBKseTl
        56UqSfAyAqNNSLAoNT21Ii0zpwShlImDE2QRD9CiBUkgi4oLEnOLM9Mh8qcYdTl+9Rx7wyQE
        NkhKnJcVpEgApCijNA9uDix5vGIUB3pRmJcPpIoHmHjgJr0CWsIEtMTi612QJSWJCCmpBkbf
        fV1sCQ1l3y2Sy5RCQg5PNEx3UvJY3vt+ZtKxRFkl08S3MxJe/jVtvcr60t1MoVezXCP1SzGT
        A+/t3gaZ7qfV30sEdufFKJ7+UN85mel4rMk55UbRtVVuLuUxTx9mrUre9EFxwayt301SCprN
        n8v9lZEVruZxenfqqcf1s7a3Eg8rpn6eo8RSnJFoqMVcVJwIAAV2LBT5AgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function's visibility is about to be increased, so give it a more
distinctive name.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6768c8c86b..b4c11afadf 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -413,7 +413,7 @@ static struct ref_entry *find_ref_entry(struct ref_dir *dir, const char *refname
  * empty by the removal.  dir must represent the top-level directory
  * and must already be complete.
  */
-static int remove_entry(struct ref_dir *dir, const char *refname)
+static int remove_entry_from_dir(struct ref_dir *dir, const char *refname)
 {
 	int refname_len = strlen(refname);
 	int entry_index;
@@ -2338,7 +2338,7 @@ static int repack_without_refs(struct files_ref_store *refs,
 
 	/* Remove refnames from the cache */
 	for_each_string_list_item(refname, refnames)
-		if (remove_entry(packed, refname->string) != -1)
+		if (remove_entry_from_dir(packed, refname->string) != -1)
 			removed = 1;
 	if (!removed) {
 		/*
-- 
2.11.0

