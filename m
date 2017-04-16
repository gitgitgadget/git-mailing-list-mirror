Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0ED320A04
	for <e@80x24.org>; Sun, 16 Apr 2017 06:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753829AbdDPGma (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 02:42:30 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:60161 "EHLO
        alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752200AbdDPGm2 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 Apr 2017 02:42:28 -0400
X-AuditID: 1207440e-ccbff7000000340b-2a-58f31251ddbd
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 5F.CE.13323.15213F85; Sun, 16 Apr 2017 02:42:26 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B1058DF.dip0.t-ipconnect.de [91.16.88.223])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3G6gGN3025813
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 16 Apr 2017 02:42:23 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 02/20] refs_read_raw_ref(): new function
Date:   Sun, 16 Apr 2017 08:41:24 +0200
Message-Id: <18849e790ebd4ffa9857ac7abeff2bc84d3b98b1.1492323985.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1492323985.git.mhagger@alum.mit.edu>
References: <cover.1492323985.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsUixO6iqBsk9DnCoOeSmcXaZ3eYLLqudDNZ
        NPReYba4vWI+s8WSh6+ZLbqnvGW0+NHSw2yxeXM7iwOHx9/3H5g8ds66y+6xYFOpR1f7ETaP
        Z717GD0uXlL2+LxJLoA9issmJTUnsyy1SN8ugSvj84zVTAUH+Sve9X9la2DcytPFyMEhIWAi
        MW2iSRcjF4eQwA4midkTXrFAOCeYJJ5sa2DuYuTkYBPQlVjU08wEYosIqElMbDsEVsQs8JhJ
        4u+ybhaQhLCAtcSUxjXsIDaLgKrEtB33wBp4BaIkPk45ABaXEJCX2NV2kRXE5hSwkJhydwNY
        r5CAucT241eZJzDyLGBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka6yXm1mil5pSuokREmp8
        Oxjb18scYhTgYFTi4bXw/xQhxJpYVlyZe4hRkoNJSZRX5j9QiC8pP6UyI7E4I76oNCe1+BCj
        BAezkghvMsvnCCHelMTKqtSifJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpisDAeHkgTvDUGg
        RsGi1PTUirTMnBKENBMHJ8hwHqDh6SA1vMUFibnFmekQ+VOMilLivD8EgBICIImM0jy4Xlgq
        eMUoDvSKMC8zSDsPMI3Adb8CGswENJhh8geQwSWJCCmpBsbK75961ec/WPH5Gvurn08dmRby
        tf/8vJhtzs1Wfe/KM/an1Jrr0i/vzdqdohs7vTaZ+5oyb/CjZxbRu1Y2nfzmNu0V78yJp+TC
        nfc1XWTV1bYx9lxv0/AlKTv51hKrZS81eo9NemR2LbirX+rjw6kVOY8TzArVd5pnbLc7wdIW
        L3Joqwv7ORslluKMREMt5qLiRADrHoSx4AIAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extract a new function from `refs_resolve_ref_unsafe()`. It will be
useful elsewhere.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c               | 11 +++++++++--
 refs/refs-internal.h |  4 ++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index bad05ba861..aa461156c4 100644
--- a/refs.c
+++ b/refs.c
@@ -1326,6 +1326,13 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
 	return refs_for_each_rawref(get_main_ref_store(), fn, cb_data);
 }
 
+int refs_read_raw_ref(struct ref_store *ref_store,
+		      const char *refname, unsigned char *sha1,
+		      struct strbuf *referent, unsigned int *type)
+{
+	return ref_store->be->read_raw_ref(ref_store, refname, sha1, referent, type);
+}
+
 /* This function needs to return a meaningful errno on failure */
 const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 				    const char *refname,
@@ -1362,8 +1369,8 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 	for (symref_count = 0; symref_count < SYMREF_MAXDEPTH; symref_count++) {
 		unsigned int read_flags = 0;
 
-		if (refs->be->read_raw_ref(refs, refname,
-					   sha1, &sb_refname, &read_flags)) {
+		if (refs_read_raw_ref(refs, refname,
+				      sha1, &sb_refname, &read_flags)) {
 			*flags |= read_flags;
 			if (errno != ENOENT || (resolve_flags & RESOLVE_REF_READING))
 				return NULL;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 690498698e..6ee9f20dbc 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -165,6 +165,10 @@ struct ref_update {
 	const char refname[FLEX_ARRAY];
 };
 
+int refs_read_raw_ref(struct ref_store *ref_store,
+		      const char *refname, unsigned char *sha1,
+		      struct strbuf *referent, unsigned int *type);
+
 /*
  * Add a ref_update with the specified properties to transaction, and
  * return a pointer to the new object. This function does not verify
-- 
2.11.0

