Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 393FB1F859
	for <e@80x24.org>; Sun,  4 Sep 2016 16:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754559AbcIDQNK (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:13:10 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:55354 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754387AbcIDQNF (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 12:13:05 -0400
X-AuditID: 12074414-c8fff70000000931-3f-57cc4744c853
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 58.9A.02353.4474CC75; Sun,  4 Sep 2016 12:09:40 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906AC6.dip0.t-ipconnect.de [87.144.106.198])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u84G8n5l026955
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 4 Sep 2016 12:09:38 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 25/38] lock_raw_ref(): add a files_ref_store argument
Date:   Sun,  4 Sep 2016 18:08:31 +0200
Message-Id: <12edfade1c59ad1eac43761a7ba9466c1d00e924.1473003903.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473003902.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsUixO6iqOvifibc4MxTGYuuK91MFg29V5gt
        bq+Yz2yx5OFrZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7tHVfoTN41nvHkaP
        i5eUPfYv3cbmsfiBl8fnTXIBHFFcNimpOZllqUX6dglcGbsWeBW0C1c8OHaBqYFxGX8XIyeH
        hICJxOffy1m7GLk4hAS2MkqcevmWGcI5ySSxa9dRNpAqNgFdiUU9zUwgtoiAmsTEtkMsIEXM
        IEWzJs5kB0kIC3hILJ7/lgXEZhFQlWj5cAvM5hWIkuj49owVYp2cxKVtX5hBbE4BC4kzu+cC
        2RxA28wl2l9kT2DkWcDIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI10IvN7NELzWldBMjJOBE
        djAeOSl3iFGAg1GJh9dC+0y4EGtiWXFl7iFGSQ4mJVHeWQdPhgvxJeWnVGYkFmfEF5XmpBYf
        YpTgYFYS4dV2ASrnTUmsrEotyodJSXOwKInzflus7ickkJ5YkpqdmlqQWgSTleHgUJLgve4K
        1ChYlJqeWpGWmVOCkGbi4AQZzgM0/CZIDW9xQWJucWY6RP4Uo6KUOO9LkIQASCKjNA+uF5YQ
        XjGKA70izJvgBlTFA0wmcN2vgAYzAQ1et/s0yOCSRISUVAOjd9E2ZpG5bK/Cnzee3ZZsp69f
        43N54tnJO7U2dhf56WTskWaTE5dYuUp/sdm73HezJRk67knvSTl/9GpI7fuFOea7kqbwvwj9
        n8E3RcgipfzAz7errR49dZMxLE/1ny+9euoKzlc+jM/Du4Njg/sVY358vvF04YG8E+d++DFe
        2OmQ2JSzW32dEktxRqKhFnNRcSIAcDnjyeMCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs/files-backend.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 363f306..ae425c5 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1523,7 +1523,8 @@ static void unlock_ref(struct ref_lock *lock)
  *   avoided, namely if we were successfully able to read the ref
  * - Generate informative error messages in the case of failure
  */
-static int lock_raw_ref(const char *refname, int mustexist,
+static int lock_raw_ref(struct files_ref_store *refs,
+			const char *refname, int mustexist,
 			const struct string_list *extras,
 			const struct string_list *skip,
 			struct ref_lock **lock_p,
@@ -1531,15 +1532,14 @@ static int lock_raw_ref(const char *refname, int mustexist,
 			unsigned int *type,
 			struct strbuf *err)
 {
-	struct ref_store *ref_store = get_ref_store(NULL);
-	struct files_ref_store *refs =
-		files_downcast(ref_store, 0, "lock_raw_ref");
 	struct ref_lock *lock;
 	struct strbuf ref_file = STRBUF_INIT;
 	int attempts_remaining = 3;
 	int ret = TRANSACTION_GENERIC_ERROR;
 
 	assert(err);
+	assert_main_repository(&refs->base, "lock_raw_ref");
+
 	*type = 0;
 
 	/* First lock the file so it can't change out from under us. */
@@ -1623,7 +1623,7 @@ static int lock_raw_ref(const char *refname, int mustexist,
 	 * fear that its value will change.
 	 */
 
-	if (files_read_raw_ref(ref_store, refname,
+	if (files_read_raw_ref(&refs->base, refname,
 			       lock->old_oid.hash, referent, type)) {
 		if (errno == ENOENT) {
 			if (mustexist) {
@@ -3518,6 +3518,8 @@ static int lock_ref_for_update(struct ref_update *update,
 			       struct string_list *affected_refnames,
 			       struct strbuf *err)
 {
+	struct files_ref_store *refs =
+		get_files_ref_store(NULL, "lock_ref_for_update");
 	struct strbuf referent = STRBUF_INIT;
 	int mustexist = (update->flags & REF_HAVE_OLD) &&
 		!is_null_sha1(update->old_sha1);
@@ -3534,7 +3536,7 @@ static int lock_ref_for_update(struct ref_update *update,
 			return ret;
 	}
 
-	ret = lock_raw_ref(update->refname, mustexist,
+	ret = lock_raw_ref(refs, update->refname, mustexist,
 			   affected_refnames, NULL,
 			   &update->lock, &referent,
 			   &update->type, err);
-- 
2.9.3

