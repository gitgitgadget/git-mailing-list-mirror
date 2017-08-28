Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06B35208DB
	for <e@80x24.org>; Mon, 28 Aug 2017 20:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751329AbdH1Ucu (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Aug 2017 16:32:50 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33534 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751207AbdH1Uct (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2017 16:32:49 -0400
Received: by mail-wr0-f193.google.com with SMTP id k94so1044900wrc.0
        for <git@vger.kernel.org>; Mon, 28 Aug 2017 13:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KS23vGfekyglB+NKsogmgAflnOkD5ZBIYhGaN21gCqY=;
        b=VsLzfzIqnv6GF2gVibjTqB6QR7TsFGzVwqh7P8PJ29vHaQs7BWbxedggvqwARyPGoc
         9jUqoy76daar4bYkIUa2j0imcPweaUB4ykRZtOIa7uSQQhtGa+FsQmkF6eQIoEJKP2y8
         +BBYxfV93zOPBmTrQgzNRjfVgHAQgJoT8cXSyrIPOoUsVmW6K3uUrHHqMLZOf/Ikt2iG
         oReFiLdsYsX6zasnDkUyHoN8/6vtahKuTdgZOw9/jk/uI10xTejHnc+WOBba0j5sgEBq
         NifHQuSdKd5HQswtCh5jB9tmIl/rsKm/aeLJw88iVj4H3Hpl75/oK3aPuezOneeQV8GN
         hoCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KS23vGfekyglB+NKsogmgAflnOkD5ZBIYhGaN21gCqY=;
        b=nF2W6Z9FRV/smO/QVx68KuNfZT5OlBWAbvys1VelqdZFhp7aycBzCHOWdq9qicLIfy
         piXsqbe1ojeNPUHtkj98G59HsiWmeKBktheTY8rn7gfTa5FKvg7EhCloE+l3DHi/xLL8
         uJE4cxIqf+MhQ+FHgAKFE+D5xJ2T1cyD5pf+xvnKkHHZa7nD94bPLEJQrMxs1+pO1Yc3
         Rs/Vu0r20dIV+Rb1g8qzsG+Lf2xr7S4gaI8aMnGYsjAfjh1I9lzo9ovvriMHPcznprhA
         fILvRu2aZuo7d8vhIwu2xmM6J0YHXzaAtVcn15vLomvaFrtgnwY/LCMIFt/qIVqpkoQ/
         MiTA==
X-Gm-Message-State: AHYfb5huiryt0VsvNEgQXH4kdC+dyYl2papVksoNrK+kBnw9rLPa+gIk
        86sBpMCaL8b3cZWChMg=
X-Received: by 10.223.173.103 with SMTP id p94mr1216906wrc.37.1503952368209;
        Mon, 28 Aug 2017 13:32:48 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id 13sm1232043wms.22.2017.08.28.13.32.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Aug 2017 13:32:47 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/2] refs/files-backend: add longer-scoped copy of string to list
Date:   Mon, 28 Aug 2017 22:32:24 +0200
Message-Id: <7f6617d2f1df9ee6746e4cbc41dc84bdb7788574.1503951733.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.151.g45c1275a3.dirty
In-Reply-To: <CAN0heSrkYL6OqVHHnDtA1DqE-FVqjB59bG2MsgxmJyxW33k9JA@mail.gmail.com>
References: <CAN0heSrkYL6OqVHHnDtA1DqE-FVqjB59bG2MsgxmJyxW33k9JA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

split_symref_update() receives a string-pointer `referent` and adds it
to the list of `affected_refnames`. The list simply holds on to the
pointers it is given, it does not copy the strings and it never frees
them. The `referent` string in split_symref_update() belongs to a string
buffer in the caller. After we return, the string will be leaked.

In the next patch, we want to properly release the string buffer in the
caller, but we can't safely do so until we've made sure that
`affected_refnames` will not be holding on to a pointer to the string.
We could configure the list to handle its own resources, but it would
mean some alloc/free-churning. The list is already handling other
strings (through other code paths) which we do not need to worry about,
and we'd be memory-churning those strings too, completely unnecessary.

Observe that split_symref_update() creates a `new_update`-object and
that `new_update->refname` is then a copy of `referent`. The difference
is, this copy will be freed, and it will be freed *after*
`affected_refnames` has been cleared.

Rearrange the handling of `referent`, so that we don't add it directly
to `affected_refnames`. Instead, first just check whether `referent`
exists in the string list, and later add `new_update->refname`.

Helped-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
Thanks Junio and Michael for your comments on the first version. This
first patch is now completely different and much much better (thanks
Michael!). The commit message should also be better (sorry Junio...).
The second one has a new commit message, but the diff is the same.

Martin

 refs/files-backend.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 5cca55510..bdb0e22e5 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2140,13 +2140,12 @@ static int split_symref_update(struct files_ref_store *refs,
 
 	/*
 	 * First make sure that referent is not already in the
-	 * transaction. This insertion is O(N) in the transaction
+	 * transaction. This check is O(N) in the transaction
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
@@ -2181,6 +2180,15 @@ static int split_symref_update(struct files_ref_store *refs,
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
+	assert(!item->util);
 	item->util = new_update;
 
 	return 0;
-- 
2.14.1.151.g45c1275a3.dirty

