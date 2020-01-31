Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3FCC2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D8B21734
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHfmlrzo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgAaUQV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 15:16:21 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40961 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbgAaUQV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 15:16:21 -0500
Received: by mail-wr1-f68.google.com with SMTP id c9so10130035wrw.8
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 12:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LHv3OUouiSWEjPl69LIDx7kK+8FoKtUJpN5eFvZqOEw=;
        b=dHfmlrzog6K/8nMiu3Q5J5gWThZhOB2T8hLXhgKlhLKRt5LRUVzQAft4wt77rU7mO/
         JjweFVmqLe064tfEHyDPlR7MKN7hRGg2v9bWPLbc+zp4VI3vmFjH+FddRzey68ZLO9Q6
         WeelVR22kGs5Gzq54JQYvr4imoyEbdq4eLFqnOYZ8S9CvG8rp/rMY3ghzCuXlhyUJvtq
         Hr9pie337jBiP4bh2vjZp3NfB2cSBdo+f4krDhZpEhsOYQzQmnrDHgsTfCOO5w9OakLS
         FGib6NqBBqeWnzJNhOTQHb3zfmxkz8MGH79O5GMBmVwJPJaxcb3o7fuRo547Vbt4yv4X
         4vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LHv3OUouiSWEjPl69LIDx7kK+8FoKtUJpN5eFvZqOEw=;
        b=geuAODISbnmfnIWryVpkatsJFu4+8rP4dLGsOmcX/R9611tY8NW7Zm7Dvao6jumReI
         4Y7xFE4buE03A9V9W6ozFVaFhGhB4hU4xnAVnCS4bvvNmVyVm1qh4VDfG4mJIBjSD2D0
         KsrFjOBVMRA8lBpbHHoNfpiPQzwtLxKALETsPefcupMl8Wbfo4Dm4iCqpa0RHqq7CFDC
         6AAzl1dzcH09xxzZAlQemrX/fexIQJYkE1AixvNY6ANr2SGUBCDAPbo7xAJG21o/Ed2E
         q5lqZJBE9vWFDnapnI10OnXDxHAbccVJcGQC/docaXQ3wu3B7UO7C4RSo8FnEnXhY4RS
         Ncgg==
X-Gm-Message-State: APjAAAVeyVtb1GZeFod8vkm52CfIe9ReltJ+qC+X2miCoJyq7aHpV3ZS
        b49NFbm1m8VztKW4mU5r/Ur5pP6S
X-Google-Smtp-Source: APXvYqzV0AAduUDXy1XZwqVFA4avXolDhbOgMe+//daYaWdmraIdxmO6lHbt76ZJSU2ZlngDckX8gA==
X-Received: by 2002:a05:6000:1252:: with SMTP id j18mr136105wrx.103.1580501778700;
        Fri, 31 Jan 2020 12:16:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e17sm324798wrn.62.2020.01.31.12.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 12:16:18 -0800 (PST)
Message-Id: <5497ad8778c29ca936206d2ded6773758c236c12.1580501775.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.v4.git.1580501775.gitgitgadget@gmail.com>
References: <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
        <pull.513.v4.git.1580501775.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jan 2020 20:16:03 +0000
Subject: [PATCH v4 03/15] sparse-checkout: create leading directories
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'git init' command creates the ".git/info" directory and fills it
with some default files. However, 'git worktree add' does not create
the info directory for that worktree. This causes a problem when running
"git sparse-checkout init" inside a worktree. While care was taken to
allow the sparse-checkout config to be specific to a worktree, this
initialization was untested.

Safely create the leading directories for the sparse-checkout file. This
is the safest thing to do even without worktrees, as a user could delete
their ".git/info" directory and expect Git to recover safely.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c          |  4 ++++
 t/t1091-sparse-checkout-builtin.sh | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index b3bed891cb..3cee8ab46e 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -199,6 +199,10 @@ static int write_patterns_and_update(struct pattern_list *pl)
 	int result;
 
 	sparse_filename = get_sparse_checkout_filename();
+
+	if (safe_create_leading_directories(sparse_filename))
+		die(_("failed to create directory for sparse-checkout file"));
+
 	fd = hold_lock_file_for_update(&lk, sparse_filename,
 				      LOCK_DIE_ON_ERROR);
 
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index e28e1c797f..43d1f7520c 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -295,4 +295,14 @@ test_expect_success 'interaction with submodules' '
 	check_files super/modules/child a deep folder1 folder2
 '
 
+test_expect_success 'different sparse-checkouts with worktrees' '
+	git -C repo worktree add --detach ../worktree &&
+	check_files worktree "a deep folder1 folder2" &&
+	git -C worktree sparse-checkout init --cone &&
+	git -C repo sparse-checkout set folder1 &&
+	git -C worktree sparse-checkout set deep/deeper1 &&
+	check_files repo a folder1 &&
+	check_files worktree a deep
+'
+
 test_done
-- 
gitgitgadget

