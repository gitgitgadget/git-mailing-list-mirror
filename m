Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66FDC433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 09:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A013660EDF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 09:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237558AbhJOJqT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 05:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237602AbhJOJqG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 05:46:06 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EC8C06176A
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 02:43:56 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e12so25479055wra.4
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 02:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=afo6mndBoG0nBvcdj/zyZLwuv53S7FbjY4yYvbnVL7M=;
        b=MINRgUAyJ9q25UCT0rB2bai4F+npQy+5d7b7QfqfdQTULJG3cwNJGxLIuaTbUjhvz7
         +LemiE4jC4/MxclZfHFYLmXJxEyAnVcz8nRiv8zqfk3/CoC31I0y9dlrDX+brCDpcVdL
         lmrOJqAFItdxKFPI/GrtkW6KbqRAOFstl+o0E4fybg5aO69bdI2EpG8Qg1aoMnVNkcqE
         khC1MLNgsjrebxUrVJIxetAMX2zSUOYNHwLqeabBCS6NYLgK6kyf/79Nzub3QxgucEtF
         usF2Np90zy+eOyBJ5QC1lZv13Pfu+XZwvyWKG3RB+kdTRUPaFiW1iyDArZfg0WXgASVT
         QOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=afo6mndBoG0nBvcdj/zyZLwuv53S7FbjY4yYvbnVL7M=;
        b=qiiyi6t56jKVwqPT7ZVtOveJMP9+I1atdfL6C2ePG7fkdQ12B/DYeGEInDh/GkBWQd
         d8513tX9Aka3fGwAzKSZCFlWN738oP8UwbH0MrznuH6c+NW6bqa5C3pc/zMQXPElCuXZ
         9cZAXtaQvr5G/GSvr1S7mHBSNXAQEjba8XuIlS0HKtLLRlR1rEHH4Xfs/creq/4bNL6Y
         Ig+jQbfVXXnVFuJlF9RAa0Cobze1G1lFbP6oqCJN+8VkWwfhFik8NVQIGe3aCS2zf4h9
         QuXEvKqxCJRkXxjK3aOsCapBvYeGfGaohAIbObRr+w0rL6c0/za1YuAYeIsA7ViDMYD5
         WyIA==
X-Gm-Message-State: AOAM533NRlDwz7IyGeEjqOURSimHq5aVTorYqdmf1G67aRXsxhfYSaVW
        UfzDeqQ0F+F01SuMIW8WWNyVF67UDC72ww==
X-Google-Smtp-Source: ABdhPJyUW6DisQxNA1ZVlZUc7bDo15EYx6QT+Fn3F22shqDxwlstIFLTD2aykiz/7xc1HSf8V+6EVg==
X-Received: by 2002:adf:e390:: with SMTP id e16mr13070499wrm.217.1634291035055;
        Fri, 15 Oct 2021 02:43:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r4sm5963648wrz.58.2021.10.15.02.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 02:43:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 12/13] receive-pack: convert push-to-checkout hook to hook.h
Date:   Fri, 15 Oct 2021 11:43:40 +0200
Message-Id: <patch-v2-12.13-ae1e2a82147-20211015T093918Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
References: <cover-v2-00.13-00000000000-20211015T093918Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Move the push-to-checkout hook away from run-command.h to and over to
the new hook.h library.

This removes the last direct user of run_hook_le(), so we could remove
that function now, but let's leave that to a follow-up cleanup commit.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/receive-pack.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 25cc0c907e1..22e7a431728 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1435,9 +1435,12 @@ static const char *push_to_checkout(unsigned char *hash,
 				    struct strvec *env,
 				    const char *work_tree)
 {
+	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+
 	strvec_pushf(env, "GIT_WORK_TREE=%s", absolute_path(work_tree));
-	if (run_hook_le(env->v, push_to_checkout_hook,
-			hash_to_hex(hash), NULL))
+	strvec_pushv(&opt.env, env->v);
+	strvec_push(&opt.args, hash_to_hex(hash));
+	if (run_hooks_oneshot(push_to_checkout_hook, &opt))
 		return "push-to-checkout hook declined";
 	else
 		return NULL;
-- 
2.33.1.1338.g20da966911a

