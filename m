Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329E7C433EF
	for <git@archiver.kernel.org>; Sun, 19 Jun 2022 06:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbiFSGum (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Jun 2022 02:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbiFSGue (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Jun 2022 02:50:34 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4D1BF45
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 23:50:32 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l126-20020a1c2584000000b0039c1a10507fso4233357wml.1
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 23:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lt/vUZ0XFMcRtCAMMiib2k753yfBvnatGiqQvguXEkE=;
        b=WHXXJ9tLFrdBM0SNESqi809OnUYy2+bTIAAk8auPKp8uA3MJZpg9/YJKVazl4M5qF2
         zEZk8PXm4Q94n7hwDpgdn2jkZnNE1265QSgZVTVu/WTH4cTddmOh8eyBcHBOgHpVA0gJ
         F/k28CGA3UHCmsXLLw5f43A0TI4Ay9+Jey3qrVoPa2F7oxCvhOjkNBBwDwnwL4JEpex4
         BqhL6BVA5gCGC4u7O0pyZroWfQdNMBMNuvb6OAwcK4uA4cH3qNwHMm8WrmgDxV6ca4J4
         i7AEDdJCihweTv2nx9MtWRoV8fARIFvkLxx1dvvWzd0WA+zYG0i1tOXxCdkPYAuxzasc
         wj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lt/vUZ0XFMcRtCAMMiib2k753yfBvnatGiqQvguXEkE=;
        b=hbDXvfdxZopi4M1MeVdlYXwHZgLc3HicdDWrBuPbYXTY6iIdaj51FjPKGRQKNEeIG/
         6ewI8wtvkPiHGxU8vSet7/s/XLyzzilIU8rSk8G9DmqpmndO+KuAXfxpiTO+30TpxaMJ
         h8sE5Z5Gpb0p0gzHq/U0ccyrlOcOlCpHA6i2jgths1UZ2MOh/ACvMHZ48mhmJQZ0WhIN
         LVmwp82yUOiilDmvMSbllTwGfY39Jid0wP4TE+Ffq8fLudUW97GXMqXTNcLKOPLNDc1L
         O+7+uiwHJrI4uj2Naw93MB5nTcPpmydDSns27flDNATHcoZboVOA14EyCAMazpwOvnDz
         JZRA==
X-Gm-Message-State: AOAM532dNVZ5SDF8VZ4WBdh1UUHLEiK27yy3LSwQyW6E2wHUI0lloW58
        SZG7g1O4DVGMOfZE8gotatrnIi9BXCCHPA==
X-Google-Smtp-Source: ABdhPJzDgGTOIbrNJmD8FcOVl4tgWuCDqs3+2twHEabeIJmaCYaEArtysHpKS6CnpyGMWB5cNEhvsA==
X-Received: by 2002:a05:600c:a41:b0:39c:1512:98bd with SMTP id c1-20020a05600c0a4100b0039c151298bdmr29368983wmq.88.1655621430623;
        Sat, 18 Jun 2022 23:50:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d678f000000b0021b8208fa51sm5788331wru.80.2022.06.18.23.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 23:50:29 -0700 (PDT)
Message-Id: <230d84f09c8b75d15168d5ff8205b543fa8ca91d.1655621424.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
References: <pull.1231.git.1652977582.gitgitgadget@gmail.com>
        <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 19 Jun 2022 06:50:20 +0000
Subject: [PATCH v2 2/6] merge: remove unused variable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

restore_state() had a local variable sb that is not used, and in fact,
was never used even in the original commit that introduced it,
1c7b76be7d ("Build in merge", 2008-07-07).  Remove it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index f178f5a3ee1..00de224a2da 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -375,7 +375,6 @@ static void reset_hard(const struct object_id *oid, int verbose)
 static void restore_state(const struct object_id *head,
 			  const struct object_id *stash)
 {
-	struct strbuf sb = STRBUF_INIT;
 	const char *args[] = { "stash", "apply", NULL, NULL };
 
 	if (is_null_oid(stash))
@@ -391,7 +390,6 @@ static void restore_state(const struct object_id *head,
 	 */
 	run_command_v_opt(args, RUN_GIT_CMD);
 
-	strbuf_release(&sb);
 	refresh_cache(REFRESH_QUIET);
 }
 
-- 
gitgitgadget

