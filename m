Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBE5C433FE
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 21:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbiAVV4I (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jan 2022 16:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbiAVV4H (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jan 2022 16:56:07 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC93FC06173D
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 13:56:06 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id l25so6470937wrb.13
        for <git@vger.kernel.org>; Sat, 22 Jan 2022 13:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HsHj2KxDWTA9QM6TZSN11NDwemvgrQd3pHbka8fElO8=;
        b=KcKZ/W6TDraQOypEZBBmPxm6sjzJ1xbo7JK+KH+B9KxPGLGqSgWnRV9AmDGqhJrm/8
         0pdv0TFL3rkKuFapz0xeNyWfKXknSYV04c83VYS8sOoC/Nxx8K/SeQwVK4nutZbaGTca
         iM1CzB83iaimA0Capgk+6pjmF+1PnZ2ycgI/JyDHxUNn++RzNDg5lwROEIc41le5WL1z
         CI4q3MpuWFHwhfrJbGd+FBAvBEqYUOGR9b1K+yJ6ZL9mBvwWQqLSU5VGPKKy+j3kE09q
         k66MHDubKoxiFoLWvYVkRDlIaBCrAJ8NC5nvOCcMiMDMqLyvs+DRdnW760RMPWodmmvY
         g23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HsHj2KxDWTA9QM6TZSN11NDwemvgrQd3pHbka8fElO8=;
        b=cXE9+T7XDvWYBJOoeVzOUsQg1+N1z1Wyljyrf/ZUBg0DmOWyBFLFfnNXjiww5RTFKl
         DeIc5GKh+EmifYmfGc6n4eFTy24MUfJkx8i4jKlxcuCQng2Nr/qN/VzPLWzq8jj8XU6O
         +YN5q6AmkjN3PV9TdSmAiKIV2ktyzLQ1SjsrV+PyzoX7m6tHqBpDQ5n4qKHNOCWhsevM
         G6FqrgSne1/duNY0yeJSeWfyKJQday7f9EGYNhbq0su5AaJ0UjYjuA7752bQ80603z/V
         8NaMnl1Ih3PpKpfrKX45/qim1p74gRzP4nJ4adSfq41Ve89D4s4GfwQI/mLuW5pGRWmR
         wPbg==
X-Gm-Message-State: AOAM5302NbZOsvVicFRkaPTAg0dsCzLA0WngOAWZeOv2F9JQHqqEDe7F
        2GnKTQU+x+K2AeSTixGYzKrSX/ocpvg=
X-Google-Smtp-Source: ABdhPJzwqYo40cGQlx7seMDj3v0sI9yEXxYAlxvnndeHYVBdCPEzDR0sKj0TgsHmcVfViGx7pZgPVw==
X-Received: by 2002:a5d:5046:: with SMTP id h6mr8778056wrt.167.1642888565233;
        Sat, 22 Jan 2022 13:56:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m64sm3511678wmm.31.2022.01.22.13.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 13:56:04 -0800 (PST)
Message-Id: <4a7cd5542bb2f89b4874e4115542ccee9c4639af.1642888562.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Jan 2022 21:55:51 +0000
Subject: [PATCH 01/12] merge-tree: rename merge_trees() to
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

