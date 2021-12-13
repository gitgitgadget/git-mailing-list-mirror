Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0BAC433FE
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 16:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbhLMQCG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 11:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238932AbhLMQCA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 11:02:00 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27E7C06173F
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:01:59 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so11885717wmc.2
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HOTpe9FNENotMYcACPCrU+33ZDetlyOQNtsGAWihsVI=;
        b=e6H+Rf9xQHwztqIhR+uYrB//XcgwQ4LsWu4w7aMCsr3DnqPe0x7Gd5aIma2kGqsyxC
         bX0Hij7xeqiWqbKNJULiUVsQWoXpZH1g8TH7h8CU48OYKv7V2t7++mOdpVZPNO4mAvxT
         8BuksmDunrCRMxHJPO4eH6w+oV7CYLm8jaqXTPkheZzI1qCkMpGbvkbYZVMm12PDliLs
         sYLWT0iN7G0Z6KNEScwwo8HdRRx1vL1lasspq0mqvR3IpErzU7brVnTSkfp8uelelhzy
         WM8BabZAblv3jJajxhjtR5/FYFc/VvO+ZJyajrQvluYH7IE9Tnegm3yf+xjK0+E8gHcl
         glfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HOTpe9FNENotMYcACPCrU+33ZDetlyOQNtsGAWihsVI=;
        b=xpjkXFy+UuaxYjca8hXyxU6UvPDbnzvqqi3I2ooSbb3wuwzltMMIT0fUxZ2Hz7BE1u
         Sm7RnMAZgWwHS+7vyHu1dGR5a7dI0Gp2b16W5XoLjsVNMHF8wArDM6twUIe+pydWYUJb
         VbGbSP4U24r2qFiJVe3YGY4oKmYC9S/5Mx54Aq3Q/tRqteYSHpZyWxTDRR898yB4auvy
         z5aDGJfitK8QdQYHDbqYzfE5d+X0SwKslrxOQNyhfVUc/HED6Wg0Agfhr09dbCg1XYAx
         EjGSbCwTy/Zi5JpMgAqBVDBdXo/M39j+2UZ5y1OKrWIRIUO3qRtlEG2GAcc6gHx/fV9D
         wfSg==
X-Gm-Message-State: AOAM532rgTVVFlMuM+Lpr9pnriqy35UtkuYaUfKmCpgO9xNmhW3vWqaA
        Yhrh9WWAiPCqHZ4Gg0s8DUXsG6ohQ/A=
X-Google-Smtp-Source: ABdhPJxegogNsdAce69801X7gR/l1ayGlW4sGtEWalGWuIqdATWmFPPj4DG/1utw6sulxLX7WzXUPQ==
X-Received: by 2002:a05:600c:2190:: with SMTP id e16mr16655578wme.79.1639411318175;
        Mon, 13 Dec 2021 08:01:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n33sm7770738wms.46.2021.12.13.08.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:01:57 -0800 (PST)
Message-Id: <80b1988b885cb52bfb2f5837b6fee4c333863096.1639411309.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
References: <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
        <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Dec 2021 16:01:44 +0000
Subject: [PATCH v3 06/11] reftable: fix resource warning
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This would trigger in the unlikely event that we are compacting, and the next
available file handle is 0.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/stack.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index df5021ebf08..10dfd370e8e 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -877,7 +877,7 @@ static int stack_compact_range(struct reftable_stack *st, int first, int last,
 	struct strbuf new_table_path = STRBUF_INIT;
 	int err = 0;
 	int have_lock = 0;
-	int lock_file_fd = 0;
+	int lock_file_fd = -1;
 	int compact_count = last - first + 1;
 	char **listp = NULL;
 	char **delete_on_success =
@@ -911,7 +911,7 @@ static int stack_compact_range(struct reftable_stack *st, int first, int last,
 	}
 	/* Don't want to write to the lock for now.  */
 	close(lock_file_fd);
-	lock_file_fd = 0;
+	lock_file_fd = -1;
 
 	have_lock = 1;
 	err = stack_uptodate(st);
@@ -932,7 +932,7 @@ static int stack_compact_range(struct reftable_stack *st, int first, int last,
 
 		sublock_file_fd = open(subtab_lock.buf,
 				       O_EXCL | O_CREAT | O_WRONLY, 0644);
-		if (sublock_file_fd > 0) {
+		if (sublock_file_fd >= 0) {
 			close(sublock_file_fd);
 		} else if (sublock_file_fd < 0) {
 			if (errno == EEXIST) {
@@ -1013,7 +1013,7 @@ static int stack_compact_range(struct reftable_stack *st, int first, int last,
 		goto done;
 	}
 	err = close(lock_file_fd);
-	lock_file_fd = 0;
+	lock_file_fd = -1;
 	if (err < 0) {
 		err = REFTABLE_IO_ERROR;
 		unlink(new_table_path.buf);
@@ -1050,9 +1050,9 @@ done:
 		listp++;
 	}
 	free_names(subtable_locks);
-	if (lock_file_fd > 0) {
+	if (lock_file_fd >= 0) {
 		close(lock_file_fd);
-		lock_file_fd = 0;
+		lock_file_fd = -1;
 	}
 	if (have_lock) {
 		unlink(lock_file_name.buf);
-- 
gitgitgadget

