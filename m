Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BD7A20A04
	for <e@80x24.org>; Sun, 16 Apr 2017 06:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754961AbdDPGmm (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 02:42:42 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:60130 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753523AbdDPGmh (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 Apr 2017 02:42:37 -0400
X-AuditID: 12074414-807ff70000002bfd-9e-58f3125c2a2d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 65.7D.11261.C5213F85; Sun, 16 Apr 2017 02:42:36 -0400 (EDT)
Received: from bagpipes.fritz.box (p5B1058DF.dip0.t-ipconnect.de [91.16.88.223])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3G6gGN8025813
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
        Sun, 16 Apr 2017 02:42:34 -0400
From:   Michael Haggerty <mhagger@alum.mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 07/20] ref-cache: rename `find_ref()` to `find_ref_entry()`
Date:   Sun, 16 Apr 2017 08:41:29 +0200
Message-Id: <520707065009da2ecd0000fdd1080541fa4d97ec.1492323985.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1492323985.git.mhagger@alum.mit.edu>
References: <cover.1492323985.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsUixO6iqBsj9DnCYN4ra4u1z+4wWXRd6Way
        aOi9wmxxe8V8ZoslD18zW3RPecto8aOlh9li8+Z2FgcOj7/vPzB57Jx1l91jwaZSj672I2we
        z3r3MHpcvKTs8XmTXAB7FJdNSmpOZllqkb5dAlfG5rv8BSt4K+YeV25gnMDdxcjJISFgInH/
        zDdWEFtIYAeTxPnJ/BD2CSaJT9vNQGw2AV2JRT3NTCC2iICaxMS2QyxdjFwczAKPmST+Lutm
        AUkIC/hJ/Pj0jB3EZhFQlTj7+wZjFyMHB69AlMTyAzUQu+QldrVdBNvFKWAhMeXuBhaIXeYS
        249fZZ7AyLOAkWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6FXm5miV5qSukmRkiIiexgPHJS
        7hCjAAejEg+vhf+nCCHWxLLiytxDjJIcTEqivDL/gUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVE
        eJNZPkcI8aYkVlalFuXDpKQ5WJTEeb8tVvcTEkhPLEnNTk0tSC2CyWpwcAjcXdK7gVGKJS8/
        L1VJgjdaEGiIYFFqempFWmZOCUIpEwcnyCIeoEVbBUAWFRck5hZnpkPkTzEqSonz/gBJCIAk
        Mkrz4HphqeEVozjQW8K8zCAreIBpBa77FdBgJqDBDJM/gAwuSURISTUwttVzffofsbnjeX7s
        0e6K/vLya8YtBqkHZ09LLvHx27apeuOsL73fXiVxBB3wP/thxSI/JqW9vfK9EZ2aDkskNZOX
        Ttkwp6pQy9rhqbWDuMi182FMsTVOLyW8hS7X+e/X7GOb+mZrc4G0wpOuyfsfZh857VRoKPne
        PZjxqc3ehc66TwrErnxTYinOSDTUYi4qTgQAMKBUs+gCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function's visibility is about to be increased, so give it a more
distinctive name.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 05029d43b8..6e08bc798c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -385,7 +385,7 @@ static struct ref_dir *find_containing_dir(struct ref_dir *dir,
  * and recursing into subdirectories as necessary.  If the name is not
  * found or it corresponds to a directory entry, return NULL.
  */
-static struct ref_entry *find_ref(struct ref_dir *dir, const char *refname)
+static struct ref_entry *find_ref_entry(struct ref_dir *dir, const char *refname)
 {
 	int entry_index;
 	struct ref_entry *entry;
@@ -1226,7 +1226,7 @@ static struct ref_dir *get_loose_refs(struct files_ref_store *refs)
 static struct ref_entry *get_packed_ref(struct files_ref_store *refs,
 					const char *refname)
 {
-	return find_ref(get_packed_refs(refs), refname);
+	return find_ref_entry(get_packed_refs(refs), refname);
 }
 
 /*
@@ -2168,7 +2168,7 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
 	if (peel_status != PEEL_PEELED && peel_status != PEEL_NON_TAG)
 		die("internal error peeling reference %s (%s)",
 		    entry->name, oid_to_hex(&entry->u.value.oid));
-	packed_entry = find_ref(cb->packed_refs, entry->name);
+	packed_entry = find_ref_entry(cb->packed_refs, entry->name);
 	if (packed_entry) {
 		/* Overwrite existing packed entry with info from loose entry */
 		packed_entry->flag = REF_ISPACKED | REF_KNOWS_PEELED;
-- 
2.11.0

