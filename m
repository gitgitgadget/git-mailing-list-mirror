Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD34BC433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 10:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236885AbiGAKnc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 06:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235453AbiGAKnN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 06:43:13 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030046451
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 03:43:12 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o19-20020a05600c4fd300b003a0489f414cso1315507wmq.4
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 03:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z0qrWxiCS+trZie3a0zkDzD9E/m8fEPjts/NDbhfK3s=;
        b=JPjXpEHGLEsnY1zDhXuWydY1Q/8Pn6IQKbXAErvccXAQ7YXDS0D4eTmgaeW+1QZFnP
         WF2arRxb3gKTbLvvjtv0ov4nk3/pE1yQ0eSI9MvD5mDlPM0R0EGamgzKDOzzpN9wVw/j
         9VeufYTug7CvqPJNzs5J1wFY4la9OWi6Go4xmLscgHjajkXGy8SkWuhPnZ54ODzHG7nd
         fdavMr3UDOB5tJeIa1dTR2ul2EdLiDp4VRc4HOXes8EC1fOLZBpWypK3zI880HSfg9SK
         Ao6cNemin6nMhEqDCLfmHMgM8S+dhvcilkOd5Yu8sfiU+YmxpzJnYBJ6lpaqxIz+qpc0
         0gnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z0qrWxiCS+trZie3a0zkDzD9E/m8fEPjts/NDbhfK3s=;
        b=ufkafnhrFM1/q9bSuaI7SOYOO54IWYh/f7L1+ay9ahdgBJEKWz9/7PRqJD3XMGysNG
         rbXvj8o09hWwG/vwO2OpK3bWxqiSoqDA+lR46JpVsnwu745/LSEPFM25oh2a2AFJoiwO
         wL278W1WLjKYqtzavSTYHFC56jjtZJu9dZEWjMJCg85uXmZv0ORNHnEsIfDy9vXFuc4K
         AKBjm5OdlmE3rcBzkHqHW3MugQw2vrtVaXGuPyLJTdtWH61k5m/p6FJh1tUdhvtjl/et
         enx7L3E4IbczEqqG869n54RcTpuomOf4z8r/d86f1IG/JADk9/CT7E7LkDnxJJDaGxni
         fEBQ==
X-Gm-Message-State: AJIora8w+vL7VabxDeR6BwlU2VSWRFBw11BnWK8Lg7NE+mx2Syuc8kh/
        aIwDMnyCiXxIm1R9F8JKsQRnaAj2OGRSQA==
X-Google-Smtp-Source: AGRyM1sB+zYp2x7vs+YT0tapXx/E066RRnZP/AIOkVrxKcdjJQStB4u8Mr6g+tH4N+xkM1NUHKwUSg==
X-Received: by 2002:a7b:cb93:0:b0:3a0:4d00:2517 with SMTP id m19-20020a7bcb93000000b003a04d002517mr15920132wmi.117.1656672191263;
        Fri, 01 Jul 2022 03:43:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q63-20020a1c4342000000b003973c54bd69sm6257674wma.1.2022.07.01.03.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 03:43:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 09/11] gc: fix a memory leak
Date:   Fri,  1 Jul 2022 12:42:58 +0200
Message-Id: <patch-v2-09.11-10a97a9cac4-20220701T104017Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.900.g4d0de1cceb2
In-Reply-To: <cover-v2-00.11-00000000000-20220701T104017Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com> <cover-v2-00.11-00000000000-20220701T104017Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in code added in 41abfe15d95 (maintenance: add
pack-refs task, 2021-02-09), we need to call strvec_clear() on the
"struct strvec" that we initialized.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 021e9256ae2..eeff2b760e0 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -168,9 +168,15 @@ struct maintenance_run_opts;
 static int maintenance_task_pack_refs(MAYBE_UNUSED struct maintenance_run_opts *opts)
 {
 	struct strvec pack_refs_cmd = STRVEC_INIT;
+	int ret;
+
 	strvec_pushl(&pack_refs_cmd, "pack-refs", "--all", "--prune", NULL);
 
-	return run_command_v_opt(pack_refs_cmd.v, RUN_GIT_CMD);
+	ret = run_command_v_opt(pack_refs_cmd.v, RUN_GIT_CMD);
+
+	strvec_clear(&pack_refs_cmd);
+
+	return ret;
 }
 
 static int too_many_loose_objects(void)
-- 
2.37.0.900.g4d0de1cceb2

