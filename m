Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727C6C636C8
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 23:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C717613DA
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 23:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhGOX30 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 19:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbhGOX3L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 19:29:11 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A37C061764
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 16:26:17 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id v17-20020a05622a1451b02902533c8b7139so5204755qtx.3
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 16:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=P8rrmc24odBA/EU2X/mV0SLuWz46mUvnzj5DrSY/x7g=;
        b=q6Q1qmu/5zz81xeYCTdL3sjfISZUEEb00eizp1hn5zjey+5knMUEa9vZ82dIlIMD7q
         IFNV96zXvmgnWHJiRqcAbZDCaH4xY99Ru9w3pyXe18akPp8dbvj0okepJ8mScp9Gxf78
         vx1mpme4sA2H8rJ+rFIMxFbPQgeFOOx3F84D7edFsiFCjS7cDU2qYr1JALKVAuMAwUJb
         sf0VP146j9CGoSjTBORXAc3phfNXgS+Bjdo+KbDinQ5LkTXWl0HXMBj7DNyEqJo4AcDJ
         lRiFJPkK9drK8/WDTv4bQm1/YVYLVjjN5IyGNCKLX2hpj9Z13/ILXvOl1SrW3/ar2rb2
         KwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=P8rrmc24odBA/EU2X/mV0SLuWz46mUvnzj5DrSY/x7g=;
        b=C4gid6UIu+LWP0i7AM91/By4PspO/Ia5/A11pXLsLQRUEiIlwwlFANFfeFEAZ7GENT
         fB+8mCyw93mmwRkXnc1N9ujmdipSxw6zI5o0Ouhw7jr0jrzsZXHvtMAd3/9qBRYuNq7e
         2TrVYo+FnWVhtOjSRvIf7NeQjMKRZH2cxSFdlybDGxJtWZlMCEv5rA+ljvpZ/PXYicTJ
         m7kEDLdnW1npSmc58+LU7zEKt0BgDG20gBXeSt5fFFK9K/YgRzFlcFckTmiU2q6fnBlr
         hIrrjcj5ef+EU6pzIQl/6KxnGs2pc4iP2GBx8J9VC6ZNEkIVmSQxWEk5ZCTq80mvNsXG
         Z9ng==
X-Gm-Message-State: AOAM531h1nhNafVa6I9hY++5ynYK5t5mLMtCXA+oGqNL2Qn+G/tO7A3V
        MXncn6h8EGKRFxZcmkoWZleC0a5jwwBUyQGCB3+UwYAQf3dwdMGymz/9f0zkD5+KoRFsXoYz+dV
        azwkJkr5b3xqwNpjpc3dj2wqfQfPFAhBwimzaF5uR5jxZ7XdGyQv/2aORdne8mirFQSgmTI6lIQ
        ==
X-Google-Smtp-Source: ABdhPJycaGcDxH7YMJC8tUQdsyfoQ+JEVKigsYZCYp9xOO4//A8v5xiSILS4a1eeY3R9zhMLO0nqGzCoFERzWEPeErY=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:c795:6596:6e89:ce2])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6214:4102:: with SMTP id
 kc2mr6939571qvb.44.1626391576845; Thu, 15 Jul 2021 16:26:16 -0700 (PDT)
Date:   Thu, 15 Jul 2021 16:25:58 -0700
In-Reply-To: <20210715232603.3415111-1-emilyshaffer@google.com>
Message-Id: <20210715232603.3415111-5-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210715232603.3415111-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 4/9] hook: treat hookdir hook specially
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Soon, we will allow users to specify hooks using the config. These
config-specified hooks may require different child_process options than
hook executables in the gitdir. So, let's differentiate between hooks
coming from the gitdir and hooks coming from the config.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 hook.c | 3 ++-
 hook.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hook.c b/hook.c
index 19138a8290..3a588cb055 100644
--- a/hook.c
+++ b/hook.c
@@ -117,6 +117,7 @@ struct list_head* hook_list(const char* hookname)
 		struct hook *to_add = xmalloc(sizeof(*to_add));
 		to_add->hook_path = hook_path;
 		to_add->feed_pipe_cb_data = NULL;
+		to_add->from_hookdir = 1;
 		list_add_tail(&to_add->list, hook_head);
 	}
 
@@ -200,7 +201,7 @@ static int pick_next_hook(struct child_process *cp,
 	cp->dir = hook_cb->options->dir;
 
 	/* add command */
-	if (hook_cb->options->absolute_path)
+	if (run_me->from_hookdir && hook_cb->options->absolute_path)
 		strvec_push(&cp->args, absolute_path(run_me->hook_path));
 	else
 		strvec_push(&cp->args, run_me->hook_path);
diff --git a/hook.h b/hook.h
index 586ddf40bb..60389cd8cd 100644
--- a/hook.h
+++ b/hook.h
@@ -22,6 +22,8 @@ struct hook {
 	/* The path to the hook */
 	const char *hook_path;
 
+	unsigned from_hookdir : 1;
+
 	/*
 	 * Use this to keep state for your feed_pipe_fn if you are using
 	 * run_hooks_opt.feed_pipe. Otherwise, do not touch it.
-- 
2.32.0.402.g57bb445576-goog

