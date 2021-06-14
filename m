Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6997C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91AF16144F
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 10:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbhFNKix (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 06:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbhFNKgX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 06:36:23 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD433C0619F6
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:33:49 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id h11-20020a05600c350bb02901b59c28e8b4so12205776wmq.1
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 03:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CpCb373suqu9uZ+XOdqIZHCL/vvYRRFgJmucadMTSv8=;
        b=GM665Cx6GviwzdW1bHMpRaBlulxk0LUigue0vGcuqkbV//UUZH2va01GsJSCF15V0J
         jPe8THPOi3JroRXokRqWUW0AHtE9OpjrKkPE4V3Fyc7tyI6t45efGFIC0zoG6XmQwPBD
         E8lYp5OBUaS7KgOfTZwtzEwGZ61snne6mn5gsxvlpA25ytiCSPZDWROsrNgYEVSxAwLk
         OiImkp1GPFJX03Ncv77oZ8xnQPJQb6CNcid0GNsGMqCf8Y29eMb2Tqdhq16Z9rS88jY5
         9/1UVBJYl/zoGvjOZxwWIV1WtQJZfES0D/jsVFACJDHONZKc32r+1rp9ISbf9KLCoHWJ
         Bpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CpCb373suqu9uZ+XOdqIZHCL/vvYRRFgJmucadMTSv8=;
        b=NUsyHS2O3OEJI30WcfPalRKeZ2yGmCS4wT0TNwtbJeL5qeq69v4vdFYARLkH8OyAxT
         bhvibAGzs1+2eAd4VuwTqqHix5/KAt6oHtfc7LdKTrDGjBQp5FUQAxJxvkTCV0IXSi9/
         yKTYrG4Sve33WFERAlBa5ydqKeF/WQiJc2WHnic1LeZs9JyT99ZmK+dTN6mY2QhOz101
         VVz4YnJmf0TpzAp7TOvndKIGHQsGbF+usEi0B1vs+zDkFA6BqygthVJwaVHxruXuHF4+
         78VqrZB919ZtW3DJD1yrCn9wJ7JYBwDwhdV1KA/291DaB7ZsOM+UD4v3FeB5f6+beG/N
         /nvg==
X-Gm-Message-State: AOAM533OPO6c9K0HBmeAnqKi7AXFjb3FjYUE9EJh1rXH3hqw+Q29oIJB
        SYUXz+v1UQryCylBxMvTfeln+VRuL/g5ag==
X-Google-Smtp-Source: ABdhPJzuykclBMJw3eszXytZa3+JCk4JmkZTQzuWdi5iu9szMuI0NkTnReibRD00liAfdYDoLhDBvA==
X-Received: by 2002:a05:600c:154:: with SMTP id w20mr16250676wmm.185.1623666827945;
        Mon, 14 Jun 2021 03:33:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w18sm15911843wrt.55.2021.06.14.03.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 03:33:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 04/30] gc: use hook library for pre-auto-gc hook
Date:   Mon, 14 Jun 2021 12:32:53 +0200
Message-Id: <patch-04.30-da2763192ae-20210614T101920Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
References: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com> <cover-00.30-00000000000-20210614T101920Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Using the hook.h library instead of the run-command.h library to run
pre-auto-gc means that those hooks can be set up in config files, as
well as in the hookdir. pre-auto-gc is called only from builtin/gc.c.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index f05d2f0a1ac..a12641a691d 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -32,6 +32,7 @@
 #include "remote.h"
 #include "object-store.h"
 #include "exec-cmd.h"
+#include "hook.h"
 
 #define FAILED_RUN "failed to run %s"
 
@@ -348,6 +349,8 @@ static void add_repack_incremental_option(void)
 
 static int need_to_gc(void)
 {
+	struct run_hooks_opt hook_opt = RUN_HOOKS_OPT_INIT;
+
 	/*
 	 * Setting gc.auto to 0 or negative can disable the
 	 * automatic gc.
@@ -394,8 +397,11 @@ static int need_to_gc(void)
 	else
 		return 0;
 
-	if (run_hook_le(NULL, "pre-auto-gc", NULL))
+	if (run_hooks("pre-auto-gc", &hook_opt)) {
+		run_hooks_opt_clear(&hook_opt);
 		return 0;
+	}
+	run_hooks_opt_clear(&hook_opt);
 	return 1;
 }
 
-- 
2.32.0.rc3.434.gd8aed1f08a7

