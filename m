Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC4DC0015E
	for <git@archiver.kernel.org>; Sat,  5 Aug 2023 04:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjHEEp4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Aug 2023 00:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjHEEpp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2023 00:45:45 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB61468C
        for <git@vger.kernel.org>; Fri,  4 Aug 2023 21:45:43 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-317c11517a0so1541359f8f.0
        for <git@vger.kernel.org>; Fri, 04 Aug 2023 21:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691210741; x=1691815541;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Ri4Eh44IPRnBeWk/hxMHZMiN24KG42dufyrl/Raytg=;
        b=NfcJ5VqdoWxSMcbO/gdAw2wDf+oT0KuDKLhyVwlFzY8Crk163WubeQQtejIC8FPWJP
         /060bA90AXo9KS3x3RxMBOpbypJoZ+dTUVs8BTO9OgiZSDQezGbgxMjFDM8jDAOdsFca
         WLVkFsO8mPXH8D66hVrzirkSltl2tD9SHRf75/akBkLfH2hXArKmR5/VnU6sfnQhC5gs
         AwKu9oH1frP2A3x0c2ExS9DMrf1dK3qIE2v7qTjMObOsoxYTthWTltCDYFdzRI6VvFU1
         mSg7X6nQEzvGxH2MQHtfIsAEV6Z3BOcRG45p54FYf4cYwFLov8jYMNAYAdr5h1ijzsc1
         TSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691210741; x=1691815541;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Ri4Eh44IPRnBeWk/hxMHZMiN24KG42dufyrl/Raytg=;
        b=KLBKTvQU2SHP+IUX/ShZRGb7dKAhck5ByLceIyBto7fQ5iQlrD5J8Hau4eTOkWgf/u
         QN5qC6rlqn8k62ZjEx/etugGD2o3tq3RppAtOUYl5KlVpMTY1HIxc0IW/2+T5ms8e3Tp
         LWaQhj8IOaOnPcbNDQrQaH6Ru595po8UqbuPmaS9KRo9nj5NXVwqVRhfuiSFw5L1+Idi
         inyuxQnBGJ1KZRFLez8B4iJzmllgCuzEoNsQfgFqLCoGl3KH+qae9nINKGVAbVqLQmwt
         1KAexf1UTOKvJxgO0ykrxjhZI2k1PmUzKksVMaDmBSZNRvgjV3hBCjNkfmSJTg4hK5J2
         Y0YA==
X-Gm-Message-State: AOJu0YzM0o9WJpbMGZudmPUr0p7ajoD+aAsH3jwxgBiInNZ1jCG6fMNM
        rCGC7JAHEUGWD6U90IycY3A3mD8QSkg=
X-Google-Smtp-Source: AGHT+IHlKuHNg/jDAQWaFaasnQwQTTGJAAwDSHASClxF8n+gRwV22BFUTdWYBiLCFVeB5cpUd0Rjzg==
X-Received: by 2002:adf:e0cb:0:b0:317:a499:72c8 with SMTP id m11-20020adfe0cb000000b00317a49972c8mr1089792wri.1.1691210741477;
        Fri, 04 Aug 2023 21:45:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d17-20020a5d6dd1000000b003140fff4f75sm4106865wrz.17.2023.08.04.21.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 21:45:41 -0700 (PDT)
Message-ID: <53adcd9bf14548187bd2ee0f4d0073959fde66cb.1691210737.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1564.git.1691210737.gitgitgadget@gmail.com>
References: <pull.1564.git.1691210737.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 05 Aug 2023 04:45:36 +0000
Subject: [PATCH 4/5] trailer: trailer location is a place, not an action
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>, Linus Arver <linusa@google.com>
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
index 91a4dbc9a72..c9b1e60251d 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -116,7 +116,7 @@ OPTIONS
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

