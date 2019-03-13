Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AB2A20248
	for <e@80x24.org>; Wed, 13 Mar 2019 10:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfCMKQi (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 06:16:38 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36796 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbfCMKQg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 06:16:36 -0400
Received: by mail-ed1-f67.google.com with SMTP id e4so995880edi.3
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 03:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hvES2CYwotalqiVL4xUxzUNwJXDyRvCQftpNgrftrbo=;
        b=eMqI8ZJOH+7L3pYR6jtGf3uzORMKjXTOLRm40XUMaICOH7leenk1J1L9TpeldHj/ja
         Nvze33X4Uy0DTzVbTgUwtBxtgQEhgUZRWOwYAIzZYq5unne8eWxWdaHKugy+qQKW/VyB
         vWvcN4c3NrQqomFb5hmoT0qIDlc3UaTu5Q+WsRLAnkYxm0hjtTdjmndhhZoBygTw4bJn
         /oKvmeh3GlU0lfilaylVK9sejgM+Y2wdYMGedbedCOh0wSvHzxRqGxhjCpsjKmat3GBg
         VbFyzI2UOxGl8uGvgc5hm8JNES/GIlPITbiUZKwPD/fKlppipH0Nb3Lsa+HO8fXzB4gU
         H3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hvES2CYwotalqiVL4xUxzUNwJXDyRvCQftpNgrftrbo=;
        b=p/MKrX3CVBVXlzse+YURSDrLKK/2vtSLhDnxACwrpqOTOjNDjPvXNS3/GLkbjqALwg
         TkWhghO3fr6UaEpwsVUL9HA7bMihUUeRU8S4GZwUj19AbP5s9l/ZVccnIibUJr28J7mU
         fljxVvI2gt0qeOCs3b8bNgfGoeE6q0KCfx85Zlf/HGZvnJckgVMUhDIzG1Vg6nEVu6Cc
         FYoF7ts+kBRxgODayCxtCWKeAKjuBzNLS7CKczQJLcZLLygrGc/BAmxqi3OiIRYezC9W
         s9uEh9os3k1x342Q+U7Ki55Y72U3zQdrK3U5BTwRcaqUYlyq7GOdiK7zj7E1o7d47Jfj
         tIdQ==
X-Gm-Message-State: APjAAAWEcaesUl+iSgSXZQJy4L3AOOmHQKSD1+gPj/+xtDOJo2FwDLfE
        9nxiTwCGhEtMYpqH36npPSgIfUck
X-Google-Smtp-Source: APXvYqxNtmvPJSdG214CWaHaa3I0ZensdnJPqcXEzy5lOWltY+OqFMTYJ0ahw+wjnHDZ0/YijOyAGQ==
X-Received: by 2002:aa7:dc51:: with SMTP id g17mr7339828edu.240.1552472194466;
        Wed, 13 Mar 2019 03:16:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y21sm459476edb.54.2019.03.13.03.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 03:16:34 -0700 (PDT)
Date:   Wed, 13 Mar 2019 03:16:34 -0700 (PDT)
X-Google-Original-Date: Wed, 13 Mar 2019 10:16:29 GMT
Message-Id: <994446236d05d9d014e12a5102bcf9be222e3b57.1552472189.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.161.git.gitgitgadget@gmail.com>
References: <pull.161.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 4/4] get_oid(): when an object was not found, try harder
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It is quite possible that the loose object cache gets stale when new
objects are written. In that case, get_oid() would potentially say that
it cannot find a given object, even if it should find it.

Let's blow away the loose object cache as well as the read packs and try
again in that case.

Note: this does *not* affect the code path that was introduced to help
avoid looking for the same non-existing objects (which made some
operations really expensive via NFS): that code path is handled by the
`OBJECT_INFO_QUICK` flag (which does not even apply to `get_oid()`,
which has no equivalent flag, at least at the time this patch was
written).

This incidentally fixes the problem identified earlier where an
interactive rebase wanted to re-read (and validate) the todo list after
an `exec` command modified it.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sha1-name.c                 | 12 ++++++++++++
 t/t3429-rebase-edit-todo.sh |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/sha1-name.c b/sha1-name.c
index 6dda2c16df..cfe5c874b6 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -442,6 +442,18 @@ static enum get_oid_result get_short_oid(const char *name, int len,
 	find_short_packed_object(&ds);
 	status = finish_object_disambiguation(&ds, oid);
 
+	/*
+	 * If we didn't find it, do the usual reprepare() slow-path,
+	 * since the object may have recently been added to the repository
+	 * or migrated from loose to packed.
+	 */
+	if (status == MISSING_OBJECT) {
+		reprepare_packed_git(the_repository);
+		find_short_object_filename(&ds);
+		find_short_packed_object(&ds);
+		status = finish_object_disambiguation(&ds, oid);
+	}
+
 	if (!quietly && (status == SHORT_NAME_AMBIGUOUS)) {
 		struct oid_array collect = OID_ARRAY_INIT;
 
diff --git a/t/t3429-rebase-edit-todo.sh b/t/t3429-rebase-edit-todo.sh
index 862f229c87..76f6d306ea 100755
--- a/t/t3429-rebase-edit-todo.sh
+++ b/t/t3429-rebase-edit-todo.sh
@@ -11,7 +11,7 @@ test_expect_success 'rebase exec modifies rebase-todo' '
 	test -e F
 '
 
-test_expect_failure SHA1 'loose object cache vs re-reading todo list' '
+test_expect_success SHA1 'loose object cache vs re-reading todo list' '
 	GIT_REBASE_TODO=.git/rebase-merge/git-rebase-todo &&
 	export GIT_REBASE_TODO &&
 	write_script append-todo.sh <<-\EOS &&
-- 
gitgitgadget
