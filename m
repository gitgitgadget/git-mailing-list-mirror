Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04A8C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 18:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240190AbiGSSeV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 14:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238800AbiGSSeE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 14:34:04 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C025B078
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:34:02 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id a11so3349758wmq.3
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=W9LE5F7vTwtXAWGBMDv2szsK46Ek/X4Dk7Y4zvegjpw=;
        b=hwMauZEDKk3l0/k8jwhBLzGTsteEY+lJY43EwM7D2CP3eyBGQ1xm7ib1GhErzxgfXs
         UmgTlkZx9y+OUVfUGEJs2o7jBGexhfHIGMG3N0v91cEzsT9rNc/rlP3GTUAaUUzRwiUM
         +LqpcRHB8KcL2vNNqmO5HOgORX8T2ZyzY/RbdKhGo33GJcdk2+ncoxG/HMFgIYXKCfZn
         hgVWSy6V9L639WHnLt3e5ZsbCP0J++2O5wQqhim1caWdsaZhzZRDqJxeNMeY3YasqG2i
         G/DKTFNv5yZqUYaWJaX9MZZbTAbcfDGdF6D8CeRIdfyUkV+V0nZm8blenTRjfqz4gW5J
         EBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=W9LE5F7vTwtXAWGBMDv2szsK46Ek/X4Dk7Y4zvegjpw=;
        b=JsONqA+cBzQvhVoygr/gNB3j5e3N8GYFTTvN5jsgHXouC0M2pEGGXxbZejfaeVCpL7
         m6elx5zahoa1wc8K8SFii4k2Wu6JZ6nGaGrKgNXgBhunId8JrP5VzSXyg+3lTxB3ydsa
         i/ag6WON9DVhUVtAg35mDhO2Ncd9JBdtib9LDAI+Tw47iUGPuFfbHU1HIsHsudSbGEXv
         J8XeaIQQ6J6nuwdE8mbF04Q0bW2VVP+nJgLqYyU4zCq+3TXXQWKQugVUYszpGdDaLyAq
         Ygg6sjvCFvwRzN230wqIuvuRcenc6he1bvjB7AtOlZ48NAJWLzkFiWKr4XkrUHfB28Zr
         vffA==
X-Gm-Message-State: AJIora/PHbNmL/o9Eu1lOLNI0aXA6ps8VNcA015WIcpwwNa805hhJZon
        jR2o85KY8+SAD9IYBf7fryBauq6s62g=
X-Google-Smtp-Source: AGRyM1tYO4rVfT/ZVWWCtO76f6X6B3umtvE1sdxyWJn3e84wOl7xaLOBI28RiXCd6z8i7D9Y3YlMNQ==
X-Received: by 2002:a05:600c:3554:b0:3a3:1d70:9101 with SMTP id i20-20020a05600c355400b003a31d709101mr530776wmq.61.1658255641092;
        Tue, 19 Jul 2022 11:34:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a18-20020a5d4572000000b0021d6e14a9ccsm13812678wrc.16.2022.07.19.11.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:34:00 -0700 (PDT)
Message-Id: <2a6577974c7f72c075cb403b4b2573c6d1c7f033.1658255624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.v5.git.1658255624.gitgitgadget@gmail.com>
References: <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
        <pull.1247.v5.git.1658255624.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jul 2022 18:33:43 +0000
Subject: [PATCH v5 11/12] sequencer: ignore HEAD ref under --update-refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When using the 'git rebase -i --update-refs' option, the todo list is
populated with 'update-ref' commands for all tip refs in the history
that is being rebased. Refs that are checked out by some worktree are
instead added as a comment to warn the user that they will not be
updated.

Until now, this included the HEAD ref, which is being updated by the
rebase process itself, regardless of the --update-refs option. Remove
the comment in this case by ignoring any decorations that match the HEAD
ref.

Reported-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 sequencer.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 67812c0294f..1602649332b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5853,12 +5853,25 @@ static int add_decorations_to_list(const struct commit *commit,
 				   struct todo_add_branch_context *ctx)
 {
 	const struct name_decoration *decoration = get_name_decoration(&commit->object);
+	const char *head_ref = resolve_ref_unsafe("HEAD",
+						  RESOLVE_REF_READING,
+						  NULL,
+						  NULL);
 
 	while (decoration) {
 		struct todo_item *item;
 		const char *path;
 		size_t base_offset = ctx->buf->len;
 
+		/*
+		 * If the branch is the current HEAD, then it will be
+		 * updated by the default rebase behavior.
+		 */
+		if (head_ref && !strcmp(head_ref, decoration->name)) {
+			decoration = decoration->next;
+			continue;
+		}
+
 		ALLOC_GROW(ctx->items,
 			ctx->items_nr + 1,
 			ctx->items_alloc);
-- 
gitgitgadget

