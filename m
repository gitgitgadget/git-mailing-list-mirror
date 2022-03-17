Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FAEC433F5
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 18:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbiCQSKZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 14:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237180AbiCQSKS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 14:10:18 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAD8130C15
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 11:09:00 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o7-20020a05600c4fc700b0038c87edc21eso85018wmq.0
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 11:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tEiqB4DYzqPQat/UNPwslvUiWt7FnnEnWkr+I9BVK/k=;
        b=Pa0iXm1FdKVqNqEHZBSAd+FruCzPdIZYSQGPkLh6aZOZgb4jtK56o08MZD1HE0qxic
         72i3QAX7wr/Z4H5loy/TUV89bqhoXa7ZJNjhBxTKKa2wLnIFfuZ4nUh6Y6lk01QknXPc
         8Ed2H4JQ4XY59qiO68Uum8Bh65ANBCHeFX80xN7cKN2s3AGUCBOqvCpX+iPeVNVrnA8H
         MCZ9DnmQf5vhaTHn/dJWijBzOjHY2kpphVFsJRM0Ty4Cr5zXamB7DGoMqkGzogVG7c8J
         j8kfCoozdZSdtjoBCQJu/Epw8WefoQILQdfrPJcX642LUTeG2dHfB+JsJVT9d/TpPhoM
         IM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tEiqB4DYzqPQat/UNPwslvUiWt7FnnEnWkr+I9BVK/k=;
        b=YqMgibludxXeErCJ59k1QwWZIkfmAzqmtpgbG5JCXYfkGOp06JK6AM1uY2paWWswao
         UvB6ozZcZotwuglf4sW1x1BK46t/Bq9Kk2BMWP0srC+Mwoe3NgJGfY9zeLD3a8HCfW+q
         YyGHLrpLPevEYwJtua6yF8JpjJcm86vQOjwuzfVXD1U89EYD5519QV20iSA9yXQs7Rjt
         /eMrqB+X1xsrzMgm2/Qstymcc6Lxbx7Hd7lGoqJ+TChB9nR9lg1yjyewVBbb4OGJ3MpU
         I48OIXGvmyPIOb8ozt3LTlrjU4babVRKa4prBXgLASKsdzXZJ3eT3qrns3RuF4a0ukiY
         u2QA==
X-Gm-Message-State: AOAM530JOp95PhV7Bc3shrMGAKB0OaG/A8FuSxteyz/oy3q9udo7ZAbq
        WWNzuSCAFdPc1RAEe0p/Eb7JDEMWOAj5ow==
X-Google-Smtp-Source: ABdhPJzRKXViHHKcadwAbK6oyUeSi4/IxY2bV6q8gWqa1v34r3Ko+0X/4LlF2voB7/XpnXMSc2m3qw==
X-Received: by 2002:a7b:c381:0:b0:37b:e01f:c1c0 with SMTP id s1-20020a7bc381000000b0037be01fc1c0mr13166608wmj.98.1647540539048;
        Thu, 17 Mar 2022 11:08:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d5988000000b00203d5f1f3e4sm4756253wri.105.2022.03.17.11.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 11:08:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/8] git reflog [expire|delete]: make -h output consistent with SYNOPSIS
Date:   Thu, 17 Mar 2022 19:08:37 +0100
Message-Id: <patch-5.8-130e718722b-20220317T180439Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1384.g7d2906948a1
In-Reply-To: <cover-0.8-00000000000-20220317T180439Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20220317T180439Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make use of the guaranteed pretty alignment of "-h" output added in my
4631cfc20bd (parse-options: properly align continued usage output,
2021-09-21) and wrap and format the "git reflog [expire|delete] -h"
usage output. Also add the missing "--single-worktree" option, as well
as adding other things that were in the SYNOPSIS output, but not in
the "-h" output.

This was last touched in 33d7bdd6459 (builtin/reflog.c: use
parse-options api for expire, delete subcommands, 2022-01-06), but in
that commit the previous usage() output was faithfully
reproduced. Let's follow-up on that and make this even easier to read.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/reflog.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 25313d504a9..458764400b5 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -6,14 +6,13 @@
 #include "reflog.h"
 
 #define BUILTIN_REFLOG_EXPIRE_USAGE \
-	N_("git reflog expire [--expire=<time>] " \
-	   "[--expire-unreachable=<time>] " \
-	   "[--rewrite] [--updateref] [--stale-fix] [--dry-run | -n] " \
-	   "[--verbose] [--all] <refs>...")
+	N_("git reflog expire [--expire=<time>] [--expire-unreachable=<time>]\n" \
+	   "                  [--rewrite] [--updateref] [--stale-fix]\n" \
+	   "                  [--dry-run | -n] [--verbose] [--all [--single-worktree] | <refs>...]")
 
 #define BUILTIN_REFLOG_DELETE_USAGE \
-	N_("git reflog delete [--rewrite] [--updateref] " \
-	   "[--dry-run | -n] [--verbose] <refs>...")
+	N_("git reflog delete [--rewrite] [--updateref]\n" \
+	   "                  [--dry-run | -n] [--verbose] <ref>@{<specifier>}...")
 
 #define BUILTIN_REFLOG_EXISTS_USAGE \
 	N_("git reflog exists <ref>")
-- 
2.35.1.1384.g7d2906948a1

