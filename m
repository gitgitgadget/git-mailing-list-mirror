Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B25C001B0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 21:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjHJVSS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 17:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjHJVSL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 17:18:11 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADA82D47
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:18:09 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe2ba3e260so12126165e9.2
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691702287; x=1692307087;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khwfBRi3Dsan8ZlxMTVmXTmzM2RY6h9G9wQX3EGM/So=;
        b=eDLZVIeJy8KnixsYr4FJsC1b3l1SFf4hGxICk0hCi7Mxly46rTaDCPtR9MeUu/f5r2
         Jpa+psN7MIDROxhggQdRP2gFwKHtF++DXmZa4ub6fi95cmEh6aD16gte3uBn5+azg456
         VLKYc7i+XLmHpS1aPuKJAk0zpCx6ni9AihnTbhO6afdjLH0c60hBOHWh0BQm4lO9HSFj
         Z4IC2e7tarJYuV5lFbLKcvATlyl4QUji5sslAEyq85yToe9DrDroEwkOD0ET8pDmuX9X
         TnULSL+rmxkHd0BF7UV/8uE3Pd3lPpgxwPmeKt9t68Vi6V5O2rC6l/krTwH2tv5VczVP
         0Xog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691702287; x=1692307087;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=khwfBRi3Dsan8ZlxMTVmXTmzM2RY6h9G9wQX3EGM/So=;
        b=dMaAHO/zx4zp4x5br5aQDJt3WihWaMSckmN30gqV1porrGv1wuU8a7Q9IDNCvIunxd
         DnQLosmonf47qEekoRnvdb2q5hQTT+63o/IT9kf3e5wyHdAQF3ONeFXzYnt5jTv2dC+R
         5uwR2BpzQWl4J88D1nXsIlWrSTlaDlRmjJH/2MWCU1xiI1UBbLwGfm7tv/reSV6cuiF1
         3kv10PIDzNjXh6P0KFNqUbJDv3OW3lgWNxDSgmISld4FqnfJ8qB3ARaYGGMxrPinAztu
         iFijpGokpKdlj/BUaMq1Rt5RNerTE7ClpunNV3l81xUf9Stm+oMAb5Kyt019W7e/oMCs
         GLZg==
X-Gm-Message-State: AOJu0YxFjxLRiICrf4578kFJR8ciAJylsWzJ5FtYlsGmMP1r9f3Xg1Y8
        aUUQrWuwSh8LakVU0JFZ7vKnHnwdJr0=
X-Google-Smtp-Source: AGHT+IEqTaJijtu+1w3kqacdoQyeQhxx6IpWmTHIQol7moZeLWCuzbDO2jA9PbCzFHYPItSf+TkCyw==
X-Received: by 2002:a7b:c045:0:b0:3fb:40ff:1cba with SMTP id u5-20020a7bc045000000b003fb40ff1cbamr89259wmc.6.1691702287621;
        Thu, 10 Aug 2023 14:18:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n20-20020a7bc5d4000000b003fe2a40d287sm3261045wmk.1.2023.08.10.14.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 14:18:07 -0700 (PDT)
Message-ID: <040766861e21afe5f686299560677e429be11844.1691702283.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
References: <pull.1564.git.1691210737.gitgitgadget@gmail.com>
        <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Aug 2023 21:17:55 +0000
Subject: [PATCH v2 05/13] trailer: trailer location is a place, not an action
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Linus Arver <linusa@google.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

Fix the help text to say "placement" instead of "action" because the
values are placements, not actions.

While we're at it, tweak the documentation to say "placements" instead
of "values", similar to how the existing language for "--if-exists" uses
the word "action" to describe both the syntax (with the phrase
"--if-exists <action>") and the possible values (with the phrase
"possible actions").

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 2 +-
 builtin/interpret-trailers.c             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 72f5bdb652f..b5284c3d33f 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -117,7 +117,7 @@ OPTIONS
 	and applies to all '--trailer' options until the next occurrence of
 	'--where' or '--no-where'. Upon encountering '--no-where', clear the
 	effect of any previous use of '--where', such that the relevant configuration
-	variables are no longer overridden. Possible values are `after`,
+	variables are no longer overridden. Possible placements are `after`,
 	`before`, `end` or `start`.
 
 --if-exists <action>::
diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index c5e83452654..cf4f703c4e2 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -97,7 +97,7 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "in-place", &opts.in_place, N_("edit files in place")),
 		OPT_BOOL(0, "trim-empty", &opts.trim_empty, N_("trim empty trailers")),
 
-		OPT_CALLBACK(0, "where", NULL, N_("action"),
+		OPT_CALLBACK(0, "where", NULL, N_("placement"),
 			     N_("where to place the new trailer"), option_parse_where),
 		OPT_CALLBACK(0, "if-exists", NULL, N_("action"),
 			     N_("action if trailer already exists"), option_parse_if_exists),
-- 
gitgitgadget

