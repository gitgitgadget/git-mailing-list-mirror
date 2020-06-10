Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668B9C433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 06:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F05820760
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 06:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiX3faV0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgFJGcF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 02:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgFJGcA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 02:32:00 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9C0C03E96B
        for <git@vger.kernel.org>; Tue,  9 Jun 2020 23:31:58 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id s18so936308ioe.2
        for <git@vger.kernel.org>; Tue, 09 Jun 2020 23:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G0AJ7z17PvhrhwgSYQy1/yJUXiwj9MUj5AnxIybjMak=;
        b=HiX3faV0h3Hm4kSpjn4iT5m0TqXSfuYLnw6L/eSZHcHutnyQRuXu8nIpZHcun1u+nz
         lQz1havsX1aGmZIq+7XyUIYRpo/6mjCsuD0eKMeqOr1l3axIMre/1YlT2KfGEyZWgHhW
         2SHD3NikQBmU6nTmkY8RR2rhmn0JfRlZVJRV7WxfMnUkJ7ev6eoAOHplHQW+zgB2oeEw
         BfgW5zw2pVcY2mtPsQUIDqFCObiiMv+FZwNQ/7l3XLDW04JuSJNZmFMQPxodVJrXco1+
         L05qW1snqz+NNbFjCoLAXkkWLvlXlQO/sfK5EwP2Az2FfuyYRgp/lbmt2YlXf+EvjjQ0
         y2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=G0AJ7z17PvhrhwgSYQy1/yJUXiwj9MUj5AnxIybjMak=;
        b=WKNcX14l1cpvxjuWnCSYHBokS2RVR21xC54brkrrSw/4O/Y+bDyYxGsFbkKAa6mpZz
         GUgsCb+lUZtLuj6f39+4AHDM5TGrMTtr6miXKuJUoIBxxBx7CvE7sihQ/CnB3V0QCiVK
         lCrTvfcfSLtAtLjXecUPpWmory4RGpzRCpamsVHv2dYkdTl7G+2j8vRKt2uBuuFIPnIh
         GWd4DKB06VS0tWh2OWiVCb0o+2w/dKRCByQBVfuAIVmPsiShhzFi9/8DOBU2kS0kk0bb
         llfS/MjNfkCwiN6IAdO7t0AFljJ1RoNTXa00NTeTh6mYE8Lfua6HH4SYt4AmirjSQxVm
         0Xsw==
X-Gm-Message-State: AOAM533R39+VDcX6vtrwUPcxW2fVGnToQ1yKi4JDsPHhYarzQXvo0iu2
        sFCCOM5YOB5UevAjh1fujWfZZj9bpvw=
X-Google-Smtp-Source: ABdhPJwP5Ws2nmYOsOQ2ON4tf2eTKErpYMdQmGdaJqK7U4YJQe8+a1EI/9GxwMWjip93b5WeE4dpPQ==
X-Received: by 2002:a05:6602:1243:: with SMTP id o3mr1782349iou.89.1591770717624;
        Tue, 09 Jun 2020 23:31:57 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id f22sm8497868iob.18.2020.06.09.23.31.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2020 23:31:56 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?Jonathan=20M=C3=BCller?= <jonathanmueller.dev@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/7] worktree: give "should be pruned?" function more meaningful name
Date:   Wed, 10 Jun 2020 02:30:44 -0400
Message-Id: <20200610063049.74666-3-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.27.0.90.gabb59f83a2
In-Reply-To: <20200610063049.74666-1-sunshine@sunshineco.com>
References: <20200610063049.74666-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Readers of the name prune_worktree() are likely to expect the function
to actually prune a worktree, however, it only answers the question
"should this worktree be pruned?". Give it a name more reflective of its
true purpose to avoid such confusion.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/worktree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 9b15f19fc5..35d38607e7 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -67,7 +67,7 @@ static void delete_worktrees_dir_if_empty(void)
 	rmdir(git_path("worktrees")); /* ignore failed removal */
 }
 
-static int prune_worktree(const char *id, struct strbuf *reason)
+static int should_prune_worktree(const char *id, struct strbuf *reason)
 {
 	struct stat st;
 	char *path;
@@ -144,7 +144,7 @@ static void prune_worktrees(void)
 		if (is_dot_or_dotdot(d->d_name))
 			continue;
 		strbuf_reset(&reason);
-		if (!prune_worktree(d->d_name, &reason))
+		if (!should_prune_worktree(d->d_name, &reason))
 			continue;
 		if (show_only || verbose)
 			printf_ln(_("Removing %s/%s: %s"),
-- 
2.27.0.90.gabb59f83a2

