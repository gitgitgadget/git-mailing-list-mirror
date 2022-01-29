Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81201C433EF
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 18:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353007AbiA2SHV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 13:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352994AbiA2SHS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 13:07:18 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A890C06173B
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 10:07:17 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id e8so17240137wrc.0
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 10:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HsHj2KxDWTA9QM6TZSN11NDwemvgrQd3pHbka8fElO8=;
        b=p8OJnrhjeN6FRKHoNflXgrUCy41hpHiBXCko0rdzUBOwlKNEeEIhbH2FxNko4veTn4
         Ae07fwHN3IvOKMhBcsOi5CZCraYVuigGQxSscajQu25jFSiUSZSvIv90Yhy0oLRye4QR
         9z0vdF49SbZXw+3OmaeEcTKpYrsDb4l+W7pidrH4NZbKrGNkZNjdI2yfGcMpIR1do7pg
         /u25uq7Y+QQTHH+6DuxZjtvtlhtMDfRf7RHEy68NCQpJAGIop1z5yqjl+JBJ/OVgFfLf
         ba2q6HOB09SxJfyl6q3PoxUqJiAwAF41v8uWE/lAqndv/S5PaBB61ZSGQjiNP/BCqM7a
         259g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HsHj2KxDWTA9QM6TZSN11NDwemvgrQd3pHbka8fElO8=;
        b=z/YcjI9Qk7BltQn6T275qcmGsS5qjvTh1F3Ac98xZwC9Zm9ltwsKXY9VAO9BKsp43A
         hsy8wNCwo2odynNbNcaM9BqlYU7rmuKW6/rf+qT8qCCYKoYVp3pvB+SA5RsXpH18rqH/
         XQUfBrL5Q8ti/4oaiRllAalI+xqSH1p3L5CIfSEqpDHXheWOTdomQAl/r5SG50W5uu/g
         QJYCf6GiibRtlOs25Bjoz2iHzdlKooYxPiENofQS0eGxN8rNJH1gSUNfeyVP8b1xhS1J
         QWrLfMXXPvNd9kAaTxEyUXHBFmn6M8tDYDOdtrNUKQebpKwwYtkI3jZ0ANS87MUtx2V5
         8M+Q==
X-Gm-Message-State: AOAM533V3ReuxZnEQnTbzrh3tSXZI+ZkzEPJeOFDIMUtLm6zwhR3V0qf
        6SNR8tDVk5HDFdzOq5bwZs4usTapskI=
X-Google-Smtp-Source: ABdhPJwY4RlBMAri+GRFGwMHZyLuzyb1N240ggMSpMvVzjl3L9aX3AgeXUOjrHG56GRVr4vftgHsTg==
X-Received: by 2002:adf:fb4a:: with SMTP id c10mr10902820wrs.243.1643479635923;
        Sat, 29 Jan 2022 10:07:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x6sm8720770wrn.18.2022.01.29.10.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 10:07:15 -0800 (PST)
Message-Id: <4a7cd5542bb2f89b4874e4115542ccee9c4639af.1643479633.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
        <pull.1122.v2.git.1643479633.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 29 Jan 2022 18:07:01 +0000
Subject: [PATCH v2 01/13] merge-tree: rename merge_trees() to
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
        Johannes Sixt <j6t@kdbg.org>, Elijah Newren <newren@gmail.com>,
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

