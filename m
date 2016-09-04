Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F122A1F859
	for <e@80x24.org>; Sun,  4 Sep 2016 16:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754481AbcIDQMQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 12:12:16 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:45874 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754335AbcIDQLu (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 4 Sep 2016 12:11:50 -0400
X-AuditID: 1207440c-22bff700000008d5-9c-57cc47465710
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id 2F.0A.02261.6474CC75; Sun,  4 Sep 2016 12:09:42 -0400 (EDT)
Received: from bagpipes.fritz.box (p57906AC6.dip0.t-ipconnect.de [87.144.106.198])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u84G8n5m026955
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 4 Sep 2016 12:09:40 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 26/38] commit_ref_update(): add a files_ref_store argument
Date:   Sun,  4 Sep 2016 18:08:32 +0200
Message-Id: <832c66fc96bb474df73169819938ccc827f810d0.1473003903.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1473003902.git.mhagger@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqOvmfibcoLlDxqLrSjeTRUPvFWaL
        2yvmM1ssefia2aJ7yltGix8tPcwWM69aW5x508jowOHx9/0HJo+ds+6ye3S1H2HzeNa7h9Hj
        4iVlj/1Lt7F5LH7g5fF5k1wARxSXTUpqTmZZapG+XQJXxrlzX9kL2kUrdv/7zdjAuFywi5GT
        Q0LAROLBuaOsXYxcHEICWxkl3n9azQLhnGSS+HBzFiNIFZuArsSinmYmEFtEQE1iYtshsCJm
        kKJZE2eygySEBXwlehe0gjWwCKhKvL84CSzOKxAl8fjgI2aIdXISl7Z9AbM5BSwkzuyeC2Rz
        AG0zl2h/kT2BkWcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1DvdzMEr3UlNJNjJCQ49nB
        +G2dzCFGAQ5GJR5eC+0z4UKsiWXFlbmHGCU5mJREeWcdPBkuxJeUn1KZkVicEV9UmpNafIhR
        goNZSYRX2wWonDclsbIqtSgfJiXNwaIkzqu6RN1PSCA9sSQ1OzW1ILUIJivDwaEkwRvlBtQo
        WJSanlqRlplTgpBm4uAEGc4DNLwPpIa3uCAxtzgzHSJ/ilFRSpz3pStQQgAkkVGaB9cLSwmv
        GMWBXhHmVQRp5wGmE7juV0CDmYAGr9t9GmRwSSJCSqqBMSL9yHcj6UmflT9ebHi6K/FJsptO
        2A2DewGeQha/ZH2DBZKN/yb3Mlq83RB9InK2+aRTvGtltFxlis0KluX9UBGq7HRMFGX68upM
        qXAr/8VrPpE3VhV0zlq17Ma3d9sOXZWbuOqFiFTn8jsiq7pXcUROqPi3M/qzcNLEU25zju8Q
        Vp921sf7ixJLcUaioRZzUXEiAM5rYVbkAgAA
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
index ae425c5..001b8ef 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2574,12 +2574,14 @@ static int files_verify_refname_available(struct ref_store *ref_store,
 
 static int write_ref_to_lockfile(struct ref_lock *lock,
 				 const unsigned char *sha1, struct strbuf *err);
-static int commit_ref_update(struct ref_lock *lock,
+static int commit_ref_update(struct files_ref_store *refs,
+			     struct ref_lock *lock,
 			     const unsigned char *sha1, const char *logmsg,
 			     struct strbuf *err);
 
 int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
 {
+	struct files_ref_store *refs = get_files_ref_store(NULL, "rename_ref");
 	unsigned char sha1[20], orig_sha1[20];
 	int flag = 0, logmoved = 0;
 	struct ref_lock *lock;
@@ -2652,7 +2654,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	hashcpy(lock->old_oid.hash, orig_sha1);
 
 	if (write_ref_to_lockfile(lock, orig_sha1, &err) ||
-	    commit_ref_update(lock, orig_sha1, logmsg, &err)) {
+	    commit_ref_update(refs, lock, orig_sha1, logmsg, &err)) {
 		error("unable to write current sha1 into %s: %s", newrefname, err.buf);
 		strbuf_release(&err);
 		goto rollback;
@@ -2672,7 +2674,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	flag = log_all_ref_updates;
 	log_all_ref_updates = 0;
 	if (write_ref_to_lockfile(lock, orig_sha1, &err) ||
-	    commit_ref_update(lock, orig_sha1, NULL, &err)) {
+	    commit_ref_update(refs, lock, orig_sha1, NULL, &err)) {
 		error("unable to write current sha1 into %s: %s", oldrefname, err.buf);
 		strbuf_release(&err);
 	}
@@ -2908,12 +2910,12 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
  * to the loose reference lockfile. Also update the reflogs if
  * necessary, using the specified lockmsg (which can be NULL).
  */
-static int commit_ref_update(struct ref_lock *lock,
+static int commit_ref_update(struct files_ref_store *refs,
+			     struct ref_lock *lock,
 			     const unsigned char *sha1, const char *logmsg,
 			     struct strbuf *err)
 {
-	struct files_ref_store *refs =
-		get_files_ref_store(NULL, "commit_ref_update");
+	assert_main_repository(&refs->base, "commit_ref_update");
 
 	clear_loose_ref_cache(refs);
 	if (log_ref_write(lock->ref_name, lock->old_oid.hash, sha1, logmsg, 0, err)) {
-- 
2.9.3

