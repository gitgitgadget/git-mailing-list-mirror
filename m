Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1129FC433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 17:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242216AbiAER1o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 12:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242203AbiAER1k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 12:27:40 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E47EC061212
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 09:27:39 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id q8so3909206wra.12
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 09:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HsHj2KxDWTA9QM6TZSN11NDwemvgrQd3pHbka8fElO8=;
        b=n9p/5Y7rn9CDge8DKefAhY1iqgvi43SQLT+02acgKX78gNh8t82fmHIKNDNDwyiN7a
         wCkwHujQvf7b+/wPLprjflz4NOPecZlXljEJtsbpBpWTUo0vOd7q9LQyMDXgxrvH3i+x
         VSWVr3QT36Xg99TnQ/D+1TT5Uye601OO1N14gADpRbH8RlwGvLOYzuREUVg26wBiH3JR
         5OrevNWBldFpWRa097zdUPmKlstKSxz5OLZUCffdz4E2PeXUqho6HQcT5uefgQe5ik0o
         x6z85r7zriUS4dnEUBlq+HOmv5ed2z+VQWCKqV+ZNGHFYzZQS70NRMtP8pnw1Jx+iex3
         cl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HsHj2KxDWTA9QM6TZSN11NDwemvgrQd3pHbka8fElO8=;
        b=CI+/XqSDyzp1OeWm7Y6GNwb6zs225+La4E4nSmK3b9CfXCgLmPeRP6f0GAlH626po5
         QX3n9R279RM8fAy9vCqGk1DFzkAVZamMqt4JU3LqAWe++ZIOeQd9pKulBkVBgtqqK/Q2
         033WoUZwC5KlF09uKfWSGyZBtlv3MYSp0IkFKChTULYZzwQjGrYzwIf72vhF6EtSarnU
         GH6qKhLlN+9OUYKD7hCWrktm8nNZNeRKKlNEAVZsojKzXRji0IgaigRUp8Suv9mXJoF8
         5jc2lL/GZlan9zUQsSqokOuVcX0qXjI01YLbSI/5paz6c6bqtecYBxpnD+zmBGnU7e3V
         zVKw==
X-Gm-Message-State: AOAM530rXVn5C88cKFhtARwsnAeDWq3YWiFZofjKM8VSEjPzpqr2ruS9
        It8tuY6DbKsgnyIHIIN1qwYspqpm2Gs=
X-Google-Smtp-Source: ABdhPJyqdltB4PqVaUM6Ll4rJnB9SEH8NxufyYIXagNJkDKHghYKxclFqGQsL8BPInwMgC5FfuQ9AA==
X-Received: by 2002:adf:ecc8:: with SMTP id s8mr49843076wro.184.1641403657324;
        Wed, 05 Jan 2022 09:27:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h19sm3049391wmm.13.2022.01.05.09.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 09:27:36 -0800 (PST)
Message-Id: <a7c7910d834b2e46ee6c5063db48f9cf551d0a35.1641403655.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com>
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
        <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Jan 2022 17:27:28 +0000
Subject: [PATCH v2 1/8] merge-tree: rename merge_trees() to
 trivial_merge_trees()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

merge-recursive.h defined its own merge_trees() function, different than
the one found in builtin/merge-tree.c.  That was okay in the past, but
we want merge-tree to be able to use the merge-ort functions, which will
end up including merge-recursive.h.  Rename the function found in
builtin/merge-tree.c to avoid the conflict.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge-tree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 5dc94d6f880..06f9eee9f78 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -28,7 +28,7 @@ static void add_merge_entry(struct merge_list *entry)
 	merge_result_end = &entry->next;
 }
 
-static void merge_trees(struct tree_desc t[3], const char *base);
+static void trivial_merge_trees(struct tree_desc t[3], const char *base);
 
 static const char *explanation(struct merge_list *entry)
 {
@@ -225,7 +225,7 @@ static void unresolved_directory(const struct traverse_info *info,
 	buf2 = fill_tree_descriptor(r, t + 2, ENTRY_OID(n + 2));
 #undef ENTRY_OID
 
-	merge_trees(t, newbase);
+	trivial_merge_trees(t, newbase);
 
 	free(buf0);
 	free(buf1);
@@ -342,7 +342,7 @@ static int threeway_callback(int n, unsigned long mask, unsigned long dirmask, s
 	return mask;
 }
 
-static void merge_trees(struct tree_desc t[3], const char *base)
+static void trivial_merge_trees(struct tree_desc t[3], const char *base)
 {
 	struct traverse_info info;
 
@@ -378,7 +378,7 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 	buf1 = get_tree_descriptor(r, t+0, argv[1]);
 	buf2 = get_tree_descriptor(r, t+1, argv[2]);
 	buf3 = get_tree_descriptor(r, t+2, argv[3]);
-	merge_trees(t, "");
+	trivial_merge_trees(t, "");
 	free(buf1);
 	free(buf2);
 	free(buf3);
-- 
gitgitgadget

