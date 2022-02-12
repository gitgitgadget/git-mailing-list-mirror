Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E3BC433F5
	for <git@archiver.kernel.org>; Sat, 12 Feb 2022 20:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbiBLUfB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 15:35:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiBLUfA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 15:35:00 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2152606E3
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 12:34:56 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m126-20020a1ca384000000b0037bb8e379feso9267476wme.5
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 12:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HsHj2KxDWTA9QM6TZSN11NDwemvgrQd3pHbka8fElO8=;
        b=N8150CHXpvX+hJss65r04LNIIvsPN7iqWPEmjtAJYYZZLDgI1CWaLwZIwJQAMksMHO
         EzXcGP22UQmMWzHNkqD1lHga7XPnTO1ywmTfBWBG7Spe0CcGCaPK/MF7QUFSjLS08399
         uFlN8JxTjTfGITG1HK67yWNiiViIt+Wo2pF0khCZa4RRjKt6yvJnn9w2kEhlBaWwd0Jl
         9wLKx89m0uduBftT3GxC05Nxh+Qbf//mjeJYV24eguYBJSSjkAIPeImPub9IsdIM3PTS
         kpoDLJRagGwpsGVUYKdAdHFE9Fkv9N4FQbNkekKshkDOK8Gy+wn1XnS+CQoQLJcxWBYp
         8djQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HsHj2KxDWTA9QM6TZSN11NDwemvgrQd3pHbka8fElO8=;
        b=lTOlmCsslKIhLtnJZXYUX2Rg6tGqw5R/XCBonc/7lxlna9rgt9sdchocNWPR4C73vk
         C3l/1t3TDYqxyXqEjweDswf3L6/iicBvgXp2Xgghur1tE86KbKjWG+WEwijiznhKJ6NR
         0QF4kxxZrnnzswvPosr2ADXdh3r4qfR84vYGgbveVmhV7yQdPtEtg6KpQdvFjGOT5mEf
         6Be+hAAyax5ngrS7qHC01NSxnjjLwWM52Br3VMoRYjRFrV1ru8+mJ/WqQ9mbMay1QQcB
         CnPZzJ/hPHruEODj8heWJQW64P35NWuHElcihC7hM8rbfhPA0RbgaSUea1VjqsG0/4Ih
         sexQ==
X-Gm-Message-State: AOAM53133aEGk7Z4spdH7u0bpRd6/5KkAEZ2iPPxmsrVdsbcY91DHoC6
        t7OXPgTJmbb4qBt34vdgKX8ucFz73iA=
X-Google-Smtp-Source: ABdhPJyBZrvYZR/s2/qRblP7koajMY+cbvOVfK5/um2iwUBEMoafUKqlatYsG4Dr9qHQJw6ACcGTRQ==
X-Received: by 2002:a7b:c184:: with SMTP id y4mr5287388wmi.117.1644698095352;
        Sat, 12 Feb 2022 12:34:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a10sm818619wrt.59.2022.02.12.12.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 12:34:54 -0800 (PST)
Message-Id: <4a7cd5542bb2f89b4874e4115542ccee9c4639af.1644698093.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
References: <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
        <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Feb 2022 20:34:42 +0000
Subject: [PATCH v4 01/12] merge-tree: rename merge_trees() to
 trivial_merge_trees()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
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

