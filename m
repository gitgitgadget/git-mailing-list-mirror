Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F73C4332F
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 08:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbiKOIEY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 03:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiKOIEW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 03:04:22 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1B5AE7F
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 00:04:20 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id z18so20711915edb.9
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 00:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xtSvmYR5WuR8Sqv65DzbZCgmu4PxKR0hAsi89hIRkfw=;
        b=jmczm2YZ2BynAJpPMP2CD8Tl8N2tymK00pWC8PbgVcIr1py3i4Y6iWEyUQVeDKNZMw
         x3vy21R/dmstASlbZamSW6dl8B0Uiz1Z1el4UzTBWhGD32jLewAeoFT1wRn6RowNAJHP
         GT1yBxtUQ49vr6sTeSfdarUNyAswm63W91slW0hQfvKsjY595ZvvSCXSHYv/U7KXGZUG
         Dh+hbR1fLj4fnARAfmP9ZqHPg1oYTMd/2vnI/oQr2Z9sHTIVef32kyKA+tzjep2GAfmX
         bHRFku2xmKDSgY3tkigVAcZLdyfySQC3D66zzGLWO1rM09SRT/6mk2MEu62NPLe3MzYi
         tTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xtSvmYR5WuR8Sqv65DzbZCgmu4PxKR0hAsi89hIRkfw=;
        b=pw3r7AAEkyN1KW5Sa2jfASL/lPquco7aLysNcrQ0gbay+WepbW+QeXk2RophKel377
         mBCIuP2yNsuTo1qydQMeVGPw0HF1C2j2G5nGuiJemYU0t/vkh0t+4r1qDsSEHj5yrshX
         RbT1sMZGMjdGI79WkwyXe7rOoMdjSSxe4n5JQCSUh3Jk9Id3ap5k1+4ltW55/tixXB1L
         uYGs2QrZCD633RRuK8fKS7K48oW8fSbvlmV9paFvfuZ4oitTXZsNWbOndRlAg9EiuPEz
         +x/ME+ajvKmAlrt57nJ8SAo8Ee8lL4WDbv0jMpw7mmibZhvvMz4X92RkFWRGHFXYg2Mx
         zOQA==
X-Gm-Message-State: ANoB5pn98IHhXq7+K3aY0E2TulOeHbNEgDlimn8HAW8tcyg097/+7mjT
        HDv+axPMBHZU2BWV4xCfPp6ZX2AkTiOKtw==
X-Google-Smtp-Source: AA0mqf5+4ORuddOY7bNSu84kY9pM+4iWTYu8rmo7B5ditJtGAUJy5tnmszugnMRbZesY+Pen1/r6Aw==
X-Received: by 2002:aa7:cd4a:0:b0:461:c7ef:b09e with SMTP id v10-20020aa7cd4a000000b00461c7efb09emr14048938edw.58.1668499458949;
        Tue, 15 Nov 2022 00:04:18 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i2-20020a1709061e4200b007ad84cf1346sm5161425ejj.110.2022.11.15.00.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 00:04:18 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Ronan Pigott <ronan@rjp.ie>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] builtin/gc.c: fix -Wdeclaration-after-statement
Date:   Tue, 15 Nov 2022 09:04:12 +0100
Message-Id: <patch-1.1-54d405f15f1-20221115T080212Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1473.g172bcc0511c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 1f80129d61b (maintenance: add option to register in a specific
config, 2022-11-09) code was added which triggers a
"-Wdeclaration-after-statement" warning, which is on by default with
DEVELOPER=1.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

This landed in the latest "next" push-out, causing e.g this CI
failure:
https://github.com/git/git/actions/runs/3467538041/jobs/5792504315

 builtin/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 56b107e7f0b..22a990db0be 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1543,6 +1543,7 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 	int found = 0;
 	struct string_list_item *item;
 	const struct string_list *list;
+	struct config_set cs;
 
 	argc = parse_options(argc, argv, prefix, options,
 			     builtin_maintenance_unregister_usage, 0);
@@ -1550,7 +1551,6 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 		usage_with_options(builtin_maintenance_unregister_usage,
 				   options);
 
-	struct config_set cs;
 	if (config_file) {
 		git_configset_init(&cs);
 		git_configset_add_file(&cs, config_file);
-- 
2.38.0.1473.g172bcc0511c

