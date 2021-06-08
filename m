Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28818C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 16:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0218261059
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 16:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbhFHQO6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 12:14:58 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:41802 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbhFHQO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 12:14:56 -0400
Received: by mail-wr1-f41.google.com with SMTP id o3so3813261wri.8
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 09:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0YqrfPqhOZkvS87u14mSd9+jPXQ4zsmGbqUyI/4q29c=;
        b=stabryr+XZRzsvF0iVPCUQhCC9pF2AfaLULasYJPqOpg/mv07n9yhcsTvpUhllhCyC
         XJDHocbpEipOv0qVBgU1sglQlMnTucS5qdfjvoizHp0m67qrCDXFdQt9u0KFvOPgaTYC
         3DZzcX0b2qZDh3OjdX+Se3djbIgXXi2+cKHxKVIC41wv/XV64hx4cZrpcH1UuQIfxWYZ
         F632GXx86b4aUu/hLbE/p2DHpLs4jZSdk+d00zAONYfywb+FT6eDe51w3GJQjeBrNhKx
         QlZs3J5QEZRkzPTC/iNnrmXtUtV/jAfpk+vq/3oHfsJ/xlyCp8BNYmZgZnQRrQ5wc53F
         o0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0YqrfPqhOZkvS87u14mSd9+jPXQ4zsmGbqUyI/4q29c=;
        b=QzKxZQ8QrTaibNUvHAiVQNJSeZ2Z74i4vftnRFwsH6kU+Y/pP8fVBixt+MFbBruLDZ
         GEP+ObLxiqVaU2XUid7Y9s3iuAltLdOHUnPt2IsKKeRcrCxKfzefSebGhk891X2n8c1q
         Ce8vddSDHfQbXi0h/2U7rVH5KaWX0nV79az+ww3ni97ForJjuLUcltAUDIeGc45ShUbB
         yo2sTSZeIUrtY/QajrIp55Mc3/9W+C181QtwnzLeoidf1i5tBAF5MEtqx/5l6fgwN9nB
         bJWTTV59y6pSRj4nWll8gWJGEYsbW1IJATdalIVf59Hnv+j6zH9CW2r0xhZyfePSFzye
         +Ksg==
X-Gm-Message-State: AOAM532DzyPoFBhOXX+cELxrah/mWt6rDmUIcMDShM3BfG8NJ+zcrGda
        4I4IqWjS1CimYBeqKFSBLc69PNx8/7U=
X-Google-Smtp-Source: ABdhPJzjINbwFz0tg05KvBZWAAuZBIXhZAoa/4A0SMi4GsSM5/cBrccB9pDkF/+h6QrpyCi6147Fsg==
X-Received: by 2002:a5d:6b52:: with SMTP id x18mr22921643wrw.11.1623168706876;
        Tue, 08 Jun 2021 09:11:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s1sm3398096wmj.8.2021.06.08.09.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 09:11:46 -0700 (PDT)
Message-Id: <6de569e6ac492213e81321ca35f1f1b365ba31e3.1623168703.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.962.v4.git.1623168703.gitgitgadget@gmail.com>
References: <pull.962.v3.git.1622781578.gitgitgadget@gmail.com>
        <pull.962.v4.git.1623168703.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Jun 2021 16:11:42 +0000
Subject: [PATCH v4 4/4] merge-ort: miscellaneous touch-ups
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Add some notes in the code about invariants with match_mask when adding
pairs.  Also add a comment that seems to have been left out in my work
of pushing these changes upstream.

Signed-off-by: Elijah Newren <newren@gmail.com>
Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
---
 merge-ort.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 2ec382e292a6..cfa751053b01 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -765,6 +765,7 @@ static void add_pair(struct merge_options *opt,
 	int names_idx = is_add ? side : 0;
 
 	if (is_add) {
+		assert(match_mask == 0 || match_mask == 6);
 		if (strset_contains(&renames->cached_target_names[side],
 				    pathname))
 			return;
@@ -772,6 +773,8 @@ static void add_pair(struct merge_options *opt,
 		unsigned content_relevant = (match_mask == 0);
 		unsigned location_relevant = (dir_rename_mask == 0x07);
 
+		assert(match_mask == 0 || match_mask == 3 || match_mask == 5);
+
 		/*
 		 * If pathname is found in cached_irrelevant[side] due to
 		 * previous pick but for this commit content is relevant,
@@ -3477,6 +3480,8 @@ static void process_entry(struct merge_options *opt,
 	 */
 	if (!ci->merged.clean)
 		strmap_put(&opt->priv->conflicted, path, ci);
+
+	/* Record metadata for ci->merged in dir_metadata */
 	record_entry_for_tree(dir_metadata, path, &ci->merged);
 }
 
-- 
gitgitgadget
