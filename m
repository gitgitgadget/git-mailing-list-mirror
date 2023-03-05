Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F7AC6FD18
	for <git@archiver.kernel.org>; Sun,  5 Mar 2023 05:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjCEFIM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Mar 2023 00:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjCEFIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Mar 2023 00:08:09 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622BBCDD8
        for <git@vger.kernel.org>; Sat,  4 Mar 2023 21:08:08 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id a7so3806431pfx.10
        for <git@vger.kernel.org>; Sat, 04 Mar 2023 21:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677992887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLcjZ25juOAs612nNWxOEC+99TNrXZOUHLmuSEgQR54=;
        b=UiQw6knIeT6Yylb6+RI2alsWZi2vkgurgdQc0dfx4O72texNbIyNNDd7QV7LliVOv0
         BlivO4+Iqza3lf1spSthXOHOpoLl5rtpntVwIs7F9oOWCRTUmtJDQzYzg2HLWyFQo65z
         IG+p9v4BOoPngWe37TFnp2jlaRcn6CZKwINhxfO22Qg8aavIHbgs2k9ibROWIZYNXtxa
         N33dNKx+TWLBvyazYzJ8jIHVxHgxSDfJwfja6Rj0m2cGAO0Wk4dnG7CVgNhcW4xGK+7p
         Z+uEX385D/DpeG3zHiLJmPBTTBmnjI3flZglX4gsf4tmVphqwIzDMW2eXfi8tfkWZv7N
         WHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677992887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MLcjZ25juOAs612nNWxOEC+99TNrXZOUHLmuSEgQR54=;
        b=4HYjYuFaHRFwDbKn97vw1KjGMQOuI1PKxaYTytKK2q+V1kuSIbIRsNAthokPjeqxxx
         tVzTnavs/OztES5u70lEmruWgbQJYZLlmxL3FIRYTCRDKtWzX5XzlH2iccnm4KuiFPBI
         XLbmbDybfOfq2pDSzhJE/s/3poBzWyslujaeNKuCuIGNS6L2lTeDUTh+px4I+Sd0rSR4
         wYOzR3EJpBAuJ7QviSxttsXHTcjEguBaYTkXXudcn4JEBoxn3uAKpLuxkhPFIRLgRdGR
         BFI7Six7u72JNaMGa+uOrJxuG6v5kbHbDdimCvxZ0CAiAWT2mU9eL7YgSJO31rJBpl3M
         /Zig==
X-Gm-Message-State: AO0yUKVPxO7xT2GxM2LUv9Onf3IBOUrrTJIlDW+0pD8nOnxhVpVwpoD9
        YeSU1kaRhO6LM+e2wlXE9yHJ1Bx9FSIhlA==
X-Google-Smtp-Source: AK7set9pNn4EfMMUlnS3lhonx/WY4hOJdnuszD4zxHdHO1boOvHvtINpPJX0AH3KO4vKP5kaRAp42w==
X-Received: by 2002:aa7:9488:0:b0:5a8:b6ab:49c3 with SMTP id z8-20020aa79488000000b005a8b6ab49c3mr5751368pfk.17.1677992887475;
        Sat, 04 Mar 2023 21:08:07 -0800 (PST)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id v6-20020aa78506000000b005dd975176c3sm3996769pfn.53.2023.03.04.21.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 21:08:07 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, sorganov@gmail.com,
        chooglen@google.com, calvinwan@google.com, jonathantanmy@google.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v6 2/3] rebase: deprecate --rebase-merges=""
Date:   Sat,  4 Mar 2023 22:07:08 -0700
Message-Id: <20230305050709.68736-3-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230305050709.68736-1-alexhenrie24@gmail.com>
References: <20230225180325.796624-1-alexhenrie24@gmail.com>
 <20230305050709.68736-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The unusual syntax --rebase-merges="" (that is, --rebase-merges with an
empty string argument) has been an undocumented synonym of
--rebase-merges without an argument. Deprecate that syntax to avoid
confusion when a rebase.rebaseMerges config option is introduced, where
rebase.rebaseMerges="" will be equivalent to --no-rebase-merges.

It is not likely that anyone is actually using this syntax, but just in
case, deprecate the empty string argument instead of dropping support
for it immediately.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/rebase.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 6635f10d52..c36ddc0050 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1140,7 +1140,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		{OPTION_STRING, 'r', "rebase-merges", &rebase_merges,
 			N_("mode"),
 			N_("try to rebase merges instead of skipping them"),
-			PARSE_OPT_OPTARG, NULL, (intptr_t)""},
+			PARSE_OPT_OPTARG, NULL, (intptr_t)"no-rebase-cousins"},
 		OPT_BOOL(0, "fork-point", &options.fork_point,
 			 N_("use 'merge-base --fork-point' to refine upstream")),
 		OPT_STRING('s', "strategy", &options.strategy,
@@ -1438,7 +1438,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	if (rebase_merges) {
 		if (!*rebase_merges)
-			; /* default mode; do nothing */
+			warning(_("--rebase-merges with an empty string "
+				  "argument is deprecated and will stop "
+				  "working in a future version of Git. Use "
+				  "--rebase-merges without an argument "
+				  "instead, which does the same thing."));
 		else if (!strcmp("rebase-cousins", rebase_merges))
 			options.rebase_cousins = 1;
 		else if (strcmp("no-rebase-cousins", rebase_merges))
-- 
2.39.2

