Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE2721F859
	for <e@80x24.org>; Sun,  4 Sep 2016 16:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754149AbcIDQKO (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:10:14 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:56457 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753865AbcIDQKN (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 12:10:13 -0400
X-AuditID: 12074411-a1bff70000000932-62-57cc47212344
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id AC.DD.02354.1274CC75; Sun,  4 Sep 2016 12:09:06 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906AC6.dip0.t-ipconnect.de [87.144.106.198])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u84G8n5S026955
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 4 Sep 2016 12:09:04 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 06/38] add_packed_ref(): add a files_ref_store argument
Date:   Sun,  4 Sep 2016 18:08:12 +0200
Message-Id: <e97937c1bc45f9bf0d9fc5464d84cee514512e7d.1473003902.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473003902.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsUixO6iqKvkfibc4MNjY4uuK91MFg29V5gt
        bq+Yz2yx5OFrZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7tHVfoTN41nvHkaP
        i5eUPfYv3cbmsfiBl8fnTXIBHFFcNimpOZllqUX6dglcGT/ObGUueMdTcfNMP0sD4wuuLkZO
        DgkBE4n+73eZQWwhga2MErvumHQxcgHZJ5kkXmzqZQJJsAnoSizqaQazRQTUJCa2HWIBKWIG
        KZo1cSY7SEJYwEvi5/wDrF2MHBwsAqoSDycqgJi8AlESu1oFIHbJSVza9gVsF6eAhcSZ3XOZ
        QUqEBMwl2l9kT2DkWcDIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11QvN7NELzWldBMjJNgE
        dzDOOCl3iFGAg1GJh3eC7plwIdbEsuLK3EOMkhxMSqK8sw6eDBfiS8pPqcxILM6ILyrNSS0+
        xCjBwawkwqvtAlTOm5JYWZValA+TkuZgURLn5Vui7ickkJ5YkpqdmlqQWgSTleHgUJLgve4K
        1ChYlJqeWpGWmVOCkGbi4AQZzgM0/CZIDW9xQWJucWY6RP4Uo6KUOO9LkIQASCKjNA+uF5YM
        XjGKA70izKvoBlTFA0wkcN2vgAYzAQ1et/s0yOCSRISUVANjgqvC05AzT1X+pn9R/zzvWqJI
        utuS/HtaNzj+MuoctjhZ82/R3+6+vbtNeZlE37zhXai4htn49vUtEbufik4TafiqdP/oISPW
        SZw3GW9nz1342O7OfeUtHx/2bfSpCIisytLmS75wzv7RjVuJUR7Xdz2ytWIWvtj+PiZQdVut
        15unORWG+uLcSizFGYmGWsxFxYkAFXKWZuECAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs/files-backend.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 439c500..c544de8 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1192,10 +1192,9 @@ static struct ref_dir *get_packed_refs(struct files_ref_store *refs)
  * lock_packed_refs()).  To actually write the packed-refs file, call
  * commit_packed_refs().
  */
-static void add_packed_ref(const char *refname, const unsigned char *sha1)
+static void add_packed_ref(struct files_ref_store *refs,
+			   const char *refname, const unsigned char *sha1)
 {
-	struct files_ref_store *refs =
-		get_files_ref_store(NULL, "add_packed_ref");
 	struct packed_ref_cache *packed_ref_cache = get_packed_ref_cache(refs);
 
 	if (!packed_ref_cache->lock)
@@ -3879,6 +3878,8 @@ static int ref_present(const char *refname,
 int initial_ref_transaction_commit(struct ref_transaction *transaction,
 				   struct strbuf *err)
 {
+	struct files_ref_store *refs =
+		get_files_ref_store(NULL, "initial_ref_transaction_commit");
 	int ret = 0, i;
 	struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
 
@@ -3938,7 +3939,7 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
 
 		if ((update->flags & REF_HAVE_NEW) &&
 		    !is_null_sha1(update->new_sha1))
-			add_packed_ref(update->refname, update->new_sha1);
+			add_packed_ref(refs, update->refname, update->new_sha1);
 	}
 
 	if (commit_packed_refs()) {
-- 
2.9.3

