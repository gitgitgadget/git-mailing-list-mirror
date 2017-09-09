Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E35E7202A4
	for <e@80x24.org>; Sat,  9 Sep 2017 06:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757361AbdIIG5o (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Sep 2017 02:57:44 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34378 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751807AbdIIG5n (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2017 02:57:43 -0400
Received: by mail-wm0-f68.google.com with SMTP id l19so3015486wmi.1
        for <git@vger.kernel.org>; Fri, 08 Sep 2017 23:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DeXeoRXgY2fEKMEuygt8tt71LjqzGobRidA6QcQD0XY=;
        b=rjIOQeFuJgNTlfqLvASlKqHQN3RWXQ703ES/aPFmRyZBOqEh2gm2kEJf63TIFi6d1X
         /H8IrwVJvtrbUua/MFHFkB4BiPHPWaMPcx7BxEsxaOjhXPXuMsUHr9njwIL0ShHORgTO
         x8vE9Kdm228lOKIHB/3ZKNSn1vpDL9P294nGyOAwYote9SDFUVZF5s7NUxVoJ54ZWQB0
         fQFkHgmExpb18rFm7B3VMAIeN8NgPlBPVt7yvzk5Ese2yA4RyiJkwAchlfag7kKocXs3
         L1bs5gFDU58e9X89FgGJMNFCP7drMRoz8Y6UT1miW39lj0Tg4LEfgazQ2tLYdcRICa+E
         VCmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DeXeoRXgY2fEKMEuygt8tt71LjqzGobRidA6QcQD0XY=;
        b=ZpwKZTHIxsyyQggePYbwqAhWwFObBcBFspPjl4aUHKNA772uOjFaBaBvWMViaXlxj3
         nGT4dSZonneE74H/Se9zfMnETIiRhOouwRSfbyNZge/koCuN4LcByhiIUC2PvlQ6TERw
         baC6JKBxWp9T4TZiWsuOCuTq4APigDdwOctwEn0gwza7pHLKCv+387SwA7HIBqlZ/D4W
         qbYvCdve5ape+C0Prd13nzM8JoSJ3NN5iXV7Pcdd/kvnJs/XiSPD3MsyXzCKKsEWNP1Z
         JgRFtjur7uPb4IySeoi4luRLcAFn0fUaNVHkG2GgO1sdp489nsHPIf3agnPYGELpRnES
         PrNA==
X-Gm-Message-State: AHPjjUjD4AbtWmjFbj7P/E115BbLIJw1wWCjE/4R4lw6JSIpAPBViixc
        8fvhtf424OOesMjQ
X-Google-Smtp-Source: AOwi7QAAPf5fW8Pjf/W3g89WmzJYmRvfL4UEzXFGJnsM00FmrBOP9uHXo36a1rTh4GxTGGJJlwhL+A==
X-Received: by 10.28.61.134 with SMTP id k128mr3129172wma.48.1504940261416;
        Fri, 08 Sep 2017 23:57:41 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id v82sm4269403wmd.44.2017.09.08.23.57.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Sep 2017 23:57:40 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v4 1/4] refs/files-backend: add longer-scoped copy of string to list
Date:   Sat,  9 Sep 2017 08:57:15 +0200
Message-Id: <95e69cb0f7b80d78bc38d79f276204ff414685cf.1504939825.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.1.460.g848a19d64
In-Reply-To: <cover.1504939825.git.martin.agren@gmail.com>
References: <CAN0heSr0AWj-QwchX2DPzkZs9cx1gsfUTevN4JD1Ze=2t-YZiQ@mail.gmail.com> <cover.1504939825.git.martin.agren@gmail.com>
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
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 refs/files-backend.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0404f2c23..baceef3b3 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2634,13 +2634,12 @@ static int split_symref_update(struct files_ref_store *refs,
 
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
@@ -2675,6 +2674,17 @@ static int split_symref_update(struct files_ref_store *refs,
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
2.14.1.460.g848a19d64

