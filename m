Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E055C1F4DD
	for <e@80x24.org>; Tue, 29 Aug 2017 17:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751191AbdH2RSp (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 13:18:45 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37478 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbdH2RSo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2017 13:18:44 -0400
Received: by mail-wm0-f68.google.com with SMTP id x189so4392250wmg.4
        for <git@vger.kernel.org>; Tue, 29 Aug 2017 10:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Km/lqkgF/UjTPv3qmBxDUDqjUlRxEi85MaRZc9ebCjc=;
        b=Tl7wR1ZnSsmW15q6H7cI0QtK/qNhPUoNzl4TEEk3EDPaxCGPJyAqiB0VFINEgTUBxM
         U0YT+qAtMAsiwwMF0iCpH47aW7E3hlMHhxcwAs3eItxguzALYrqiJi45wZxba5nTSWTG
         8XYizdg7RVS8nRNFD9jqN5eEx93Sl/JtV4bkk5HhjNX9p33r6iIxYe/RTbJ2AFRENo1n
         WC0eSgSrbaYJPSUz+p8DEAjFjoIrQC2GQjXS2VHylXjxB71nglr16SI0s+ZYGk4KmXNL
         Ui0xMadsMvImcBb2yimA8fzD49AwYzjLkOrYABrLTFuurEEvYmIfTxukYDOsHmoPdd65
         feeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Km/lqkgF/UjTPv3qmBxDUDqjUlRxEi85MaRZc9ebCjc=;
        b=NmwwwiidPGWv/lIcdh6euIsNzFH/yifJuD9zP+MHO5l7HfFcXDqxr0yDMYyPgDv4Ou
         4CltXYf8743ylYZ9xermAeXUEe3I1Z+bxctI47nCE+XvYcjRhRCHm5TTwf/Dawu9Uwsi
         Qump8lERpgsx/tzi/fECEd6ZLZjRFefYPyJDwWUDjH/DZeIRnIKWEbDUjs0wHhFKwULe
         OO9JscfENkizexqsg1X1XBTBMMmUunwbxXuxZ5XNx2mPEgzznjJs0GVCdSHLD3xD+9AQ
         WyBURYbLHsdyTaWvb7SWCW7Ds78215rHINY98BtJJPdesOVa4FVghvGWQhhSnOCatDT9
         krFw==
X-Gm-Message-State: AHYfb5h6z82s5IQgnWwTns8HtTSlpb1LRkf809tFH/W1SOKDUau3H2x+
        eR1IDJ5OgrdcWxtm
X-Received: by 10.28.105.12 with SMTP id e12mr132355wmc.151.1504027123096;
        Tue, 29 Aug 2017 10:18:43 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id r12sm3054921wrr.28.2017.08.29.10.18.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Aug 2017 10:18:42 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 1/3] refs/files-backend: add longer-scoped copy of string to list
Date:   Tue, 29 Aug 2017 19:18:22 +0200
Message-Id: <4b4c0d178ad2216eecbc49fb6f54dd8a1d1ac119.1504024261.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.151.g45c1275a3.dirty
In-Reply-To: <CAN0heSqn59sFF3A-eQ593G+ZDWnO9pKM5F=sgiSQk+prUr-nSQ@mail.gmail.com>
References: <CAN0heSqn59sFF3A-eQ593G+ZDWnO9pKM5F=sgiSQk+prUr-nSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

split_symref_update() receives a string-pointer `referent` and adds it
to the list of `affected_refnames`. The list simply holds on to the
pointers it is given, it does not copy the strings and it does not ever
free them. The `referent` string in split_symref_update() belongs to a
string buffer in the caller. After we return, the string will be leaked.

In the next patch, we want to properly release the string buffer in the
caller, but we can't safely do so until we've made sure that
`affected_refnames` will not be holding on to a pointer to the string.
We could configure the list to handle its own resources, but it would
mean some alloc/free-churning. The list is already handling other
strings (through other code paths) which we do not need to worry about,
and we'd be memory-churning those strings too, completely unnecessary.

Observe that split_symref_update() creates a `new_update`-object through
ref_transaction_add_update(), after which `new_update->refname` is a
copy of `referent`. The difference is, this copy will be freed, and it
will be freed *after* `affected_refnames` has been cleared.

Rearrange the handling of `referent`, so that we don't add it directly
to `affected_refnames`. Instead, first just check whether `referent`
exists in the string list, and later add `new_update->refname`.

Helped-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
v3: "O(lg N)" in comment; if-BUG() instead of assert()

 refs/files-backend.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index fccbc24ac..73615d869 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2144,13 +2144,12 @@ static int split_symref_update(struct files_ref_store *refs,
 
 	/*
 	 * First make sure that referent is not already in the
-	 * transaction. This insertion is O(N) in the transaction
+	 * transaction. This check is O(lg N) in the transaction
 	 * size, but it happens at most once per symref in a
 	 * transaction.
 	 */
-	item = string_list_insert(affected_refnames, referent);
-	if (item->util) {
-		/* An entry already existed */
+	if (string_list_has_string(affected_refnames, referent)) {
+		/* An entry already exists */
 		strbuf_addf(err,
 			    "multiple updates for '%s' (including one "
 			    "via symref '%s') are not allowed",
@@ -2185,6 +2184,17 @@ static int split_symref_update(struct files_ref_store *refs,
 	update->flags |= REF_LOG_ONLY | REF_NODEREF;
 	update->flags &= ~REF_HAVE_OLD;
 
+	/*
+	 * Add the referent. This insertion is O(N) in the transaction
+	 * size, but it happens at most once per symref in a
+	 * transaction. Make sure to add new_update->refname, which will
+	 * be valid as long as affected_refnames is in use, and NOT
+	 * referent, which might soon be freed by our caller.
+	 */
+	item = string_list_insert(affected_refnames, new_update->refname);
+	if (item->util)
+		BUG("%s unexpectedly found in affected_refnames",
+		    new_update->refname);
 	item->util = new_update;
 
 	return 0;
-- 
2.14.1.151.g45c1275a3.dirty

