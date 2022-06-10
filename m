Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0360C43334
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 02:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345926AbiFJCCg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 22:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345908AbiFJCCR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 22:02:17 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1302BA996
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 19:02:01 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id a10so10689288wmj.5
        for <git@vger.kernel.org>; Thu, 09 Jun 2022 19:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wRA5jRM2zPUm87xWbXkGdgEjKraeJ92JI9CfybIBpxc=;
        b=BFgzRA38QtITsrnnt3SV2XejzefHosKzZX1bdHfohS/uqlSWCVN4ywFdPKrkkFjqpD
         oPnilLk7CcK3on38Zh7q1MiVlGyFj9OY0iVIyb1KFNAg2YxvUHJ4zNzjjp3Wo2qFMmSn
         zZMrHSDc4Le7lZmaGpiX5OeXnw/e8TkBMOuqrrpsOQGYy9MSbLXaV3hBhr6X9hST34Qg
         DQSn90O/NY/cdVc/FlSbw95HmOBSiOfox+yQJZVkA/0yIR0a8k3vio9U0KTfpOdiGZRE
         XOHtE0fQJvSdCVGpm8eHGcpzIKNjnEXgkGN6ABo4INwbRRWb+IEdQnOqRessbb6r9ucD
         vxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wRA5jRM2zPUm87xWbXkGdgEjKraeJ92JI9CfybIBpxc=;
        b=avglNRaARROpN4LeF2J1g6nK2nX4X1TOz/cIBSknzu/uJBJ7ZsGA8dFxXmSUfBV2wi
         BvjDHAgyJqKVkZl2zD3FD7sGHPlqw2k6SDgtcBEkkIaEVrebQlnAkkLBlfgFwgsIEOBF
         BnpE5pIC6EaSwx2QxbhgIwPVmvRO6e5m4RpMuHDycyvMnJaL1FOs+yBot1edf/4JN/cY
         zXXK/2z3LPHSoeyLEwA6SAOUEekReVl2Hh1f81UY7Lw5OL+3QKmHMrLliBJ5JG+1OQEH
         OScxkuaPzmTeWezpxrEHbrnBW6xbKpxEd3oEINEhbYFhmFQuo3APixP5rxkDwAmJwjFB
         bFTQ==
X-Gm-Message-State: AOAM531mTO7LrNbxUM6Q26++8NB1ri5BQM+aDesN80N8hYaIhQJ3Q0eM
        ufddxDF59ZFvNS728WGvFmeloT/rHuPLfg==
X-Google-Smtp-Source: ABdhPJxq5xwvobXaiVDo+M59n6Rxd6vVCY7EOeCiRhxvfo6+kqDsbf6FKnMfvM2bsg9WIztUtiDgNQ==
X-Received: by 2002:a05:600c:4e4c:b0:39c:5c73:b20c with SMTP id e12-20020a05600c4e4c00b0039c5c73b20cmr6163580wmq.37.1654826519470;
        Thu, 09 Jun 2022 19:01:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m5-20020adffe45000000b00219e8d28fb1sm122547wrs.57.2022.06.09.19.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 19:01:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 14/20] git-submodule doc: document the -v" option to "update"
Date:   Fri, 10 Jun 2022 04:01:26 +0200
Message-Id: <RFC-patch-14.20-1cb40a5f42e-20220610T011725Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1178.gb5b1747c546
In-Reply-To: <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
References: <pull.1275.git.git.1654820781.gitgitgadget@gmail.com> <RFC-cover-00.20-00000000000-20220610T011725Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In e84c3cf3dc3 (git-submodule.sh: accept verbose flag in cmd_update to
be non-quiet, 2018-08-14) the "git submodule update" sub-command was
made to understand "-v" for "don't be quiet" (but not
"--verbose"). Let's update the documentation to reflect this.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-submodule.txt | 7 +++++--
 git-submodule.sh                | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 4d3ab6b9f92..5f1c552110e 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] deinit [-f|--force] (--all|[--] <path>...)
-'git submodule' [--quiet] update [<options>] [--] [<path>...]
+'git submodule' [--quiet] update [-v] [<options>] [--] [<path>...]
 'git submodule' [--quiet] set-branch [<options>] [--] <path>
 'git submodule' [--quiet] set-url [--] <path> <newurl>
 'git submodule' [--quiet] summary [<options>] [--] [<path>...]
@@ -133,7 +133,7 @@ If you really want to remove a submodule from the repository and commit
 that use linkgit:git-rm[1] instead. See linkgit:gitsubmodules[7] for removal
 options.
 
-update [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--depth <depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--filter <filter spec>] [--] [<path>...]::
+update [-v] [--init] [--remote] [-N|--no-fetch] [--[no-]recommend-shallow] [-f|--force] [--checkout|--rebase|--merge] [--reference <repository>] [--depth <depth>] [--recursive] [--jobs <n>] [--[no-]single-branch] [--filter <filter spec>] [--] [<path>...]::
 +
 --
 Update the registered submodules to match what the superproject
@@ -270,6 +270,9 @@ OPTIONS
 --quiet::
 	Only print error messages.
 
+-v::
+	Don't be quiet. This option is only valid for the update command.
+
 --progress::
 	This option is only valid for add and update commands.
 	Progress status is reported on the standard error stream
diff --git a/git-submodule.sh b/git-submodule.sh
index d8abdd8e8ad..1929c34ae8b 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -10,7 +10,7 @@ USAGE="[--quiet] [--cached]
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] deinit [-f|--force] (--all| [--] <path>...)
-   or: $dashless [--quiet] update [--init [--filter=<filter-spec>]] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--[no-]single-branch] [--] [<path>...]
+   or: $dashless [--quiet] update [-v] [--init [--filter=<filter-spec>]] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--[no-]single-branch] [--] [<path>...]
    or: $dashless [--quiet] set-branch (--default|--branch <branch>) [--] <path>
    or: $dashless [--quiet] set-url [--] <path> <newurl>
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
-- 
2.36.1.1178.gb5b1747c546

