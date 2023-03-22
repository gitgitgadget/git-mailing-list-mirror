Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCF9C6FD1C
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 16:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjCVQBL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 12:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjCVQBH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 12:01:07 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75ED50F93
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 09:01:05 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id v4-20020a05600c470400b003ee4f06428fso2289260wmo.4
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 09:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679500864;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3ib7yuv25Yk7MrLfx2gVEaVtF2eRGWMtyxxUs9Xe7A=;
        b=JommsP5ttJfF3/cFtILd19aO4te9RkopzZVADwE/yj4qcWOdrWQbFoOyVGhqtX/9Oa
         v7eGt2Xmxq92f+2WsOcVqLFoI4TsvUDByNKi2RXoGFX5584Ty6i2Vpz5XTKJv1eSVjJ6
         iNRjNmX3Laa4vybIfsbYl1K4Yn7s5j8RLg6Sci77o/RCNNqdYIPszEcI7OZ9iyoQheF+
         Bxvu9ICTzsnGjDDUtlMU9YZUb4as/JOELjDz6rwB6YaHY9C303iwUX3etpLwxd9c34S7
         RMiuBfmhj0Qc9sacJYKrQ9nRExVnpUDqADpBubXT58GFwmMgmHFB0l456X02th5PyNGT
         jW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679500864;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A3ib7yuv25Yk7MrLfx2gVEaVtF2eRGWMtyxxUs9Xe7A=;
        b=FFj0lRNwkFI8xMwws639vMVE/XDJGcokOOyhcjeQeVlDb58HjYAOp6phCLAIe8OpCz
         jbjWuyt01uDuhwLgZVW0tCA9FqUAvv8YmIhJKvzY3vq9i5DbYaI2nBYemvpiSBjMw2cD
         cmLjXYLHOzkRmpt9rvGKPJcnMvgZfXuA9Y2NkzjCRlMUsNQwKfjpPSSj9Xz398b8FxgW
         hn3intARil8sIswr3bR45wrNPiDHG7+TZxPCwh/fYovaJO4/xc6EDPH21BZglj90w5GK
         eUBKHM09ZspOad5UEA7R0BiIxISBxUszp35XkQ/riz6a1N/sw/wAEa+WriKiWQURwema
         EYIA==
X-Gm-Message-State: AO0yUKXHu/BBhS7290g43a8OC0mU39VxyZ/HpUi3QJeFglQvHFJUWWK5
        JdTrPRDWefCVC8pLxTo0T5WRusgVB5E=
X-Google-Smtp-Source: AK7set+WCalcw8swzHHFL0tn1QvxgiVqHjSDnM810NOKMwuhp9SCDr6UvC3on5iKJvDWU08pXSC3Rg==
X-Received: by 2002:a7b:c850:0:b0:3ed:2f1a:883c with SMTP id c16-20020a7bc850000000b003ed2f1a883cmr41623wml.14.1679500864178;
        Wed, 22 Mar 2023 09:01:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l2-20020a05600c4f0200b003ee610d1ce9sm2302045wmq.34.2023.03.22.09.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 09:01:04 -0700 (PDT)
Message-Id: <3963d3e542896b9cdf871dc7ea13330ddac87795.1679500859.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1497.git.1679500859.gitgitgadget@gmail.com>
References: <pull.1497.git.1679500859.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Mar 2023 16:00:59 +0000
Subject: [PATCH 4/4] unpack-trees: take care to propagate the split-index flag
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When copying the `split_index` structure from one index structure to
another, we need to propagate the `SPLIT_INDEX_ORDERED` flag, too, if it
is set, otherwise Git might forget to write the shared index when that
is actually needed.

It just so _happens_ that in many instances when `unpack_trees()` is
called, the result causes the shared index to be written anyway, but
there are edge cases when that is not so.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 unpack-trees.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/unpack-trees.c b/unpack-trees.c
index 90b92114be8..ca5e47c77c0 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1916,6 +1916,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		 * create a new one.
 		 */
 		o->result.split_index = o->src_index->split_index;
+		if (o->src_index->cache_changed & SPLIT_INDEX_ORDERED)
+			o->result.cache_changed |= SPLIT_INDEX_ORDERED;
 		o->result.split_index->refcount++;
 	} else {
 		o->result.split_index = init_split_index(&o->result);
-- 
gitgitgadget
