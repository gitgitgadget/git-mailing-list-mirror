Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5381AC433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 03:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbhLUDag (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 22:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbhLUDaf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 22:30:35 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CA4C061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 19:30:35 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v20-20020a25fc14000000b005c2109e5ad1so23162085ybd.9
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 19:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tkgJSzecRrDxYgwIjLdsJ/sXFnGImwhOAKHkpWQq8EI=;
        b=M4+PB87CbJ4/ExqXDmFJaQBClwiMM6VE1ywhhW6+d/oKTcuTFD9bdLTza5hXfcw1Ph
         mPzmc4PFpsVyzVgG6Dw5YfaRjmcGP6KlfQ9ZRvaO2yZ4NuDE2owysr8CBx+f2TchbAVi
         m5kgnKB59w9pQIt3Z9AnSDM5bIRIynacFbPZ0eebeFo4DPNIkU/51sEv36O9VPsnc8LB
         OfgVspx/bWHWiG01JYO8UIoKk54m5NTQduqzNrNjB6EaM1Q2EanYXQkTctSNX3ZTiuyX
         Dd+kpwrbua8q5Vf1JRrgnnW0oY+dl0sreC3mVbP6WTRwboigIr63kTknVUGETHajbdJt
         42/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tkgJSzecRrDxYgwIjLdsJ/sXFnGImwhOAKHkpWQq8EI=;
        b=y+A9OX1bFyF384lDEAuo27dAKngydgdDHmadVnpuUfbAgcUEROwrHfenB5zgKVPuAN
         cTIHujJGKylEaLDCuOhlvcHUq5dNZaH3Z537+suwSYucEHLzxM1aaoX337881KkHCUbt
         Lp9cnxWJFSJnw7Yzwvrvw3UHevthvR51mJpnmYRYWV5M6ATUSFq97Jbh/RG/OSs2GjWM
         PBjq94NM7vhq22tWD0W/+gVtekurFlX68iq9eV1KX7Sgyi6prCgVRwlVET+FmYYwENlZ
         68OA2hACzTY6UoeTJRBnqtIcbh/OUMzHto2n9qsipSXB4eLjGnG029DaSSiAPkr4ZT1a
         wyUA==
X-Gm-Message-State: AOAM530lYb+/yyETTvG+bJe8/j9ILQyEQYoh2QSkMdooVnLuEtzZTIgC
        L8pkpX2cAJhl8NR8Kt1R2FlpRgPpZ62nKTxp9S008o51Y8l9VgltO35zSN5xug+6NeJSqtwlG6r
        GXor4EUhviJbyEJTEYsfvsD2lU033TyaLwnTjlDlpIEK5BzcQi/engQtwWAfRyJc=
X-Google-Smtp-Source: ABdhPJz7+cUKCuN/XYMoh8Khw0/grWS3npmxZV5ZUYk9kRUZIuGEaHySpIylN6ldLqT0mFESXzWdG0UuZiqqzg==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:e4d8:c4fc:fa70:c18e])
 (user=steadmon job=sendgmr) by 2002:a25:d653:: with SMTP id
 n80mr1842340ybg.749.1640057434369; Mon, 20 Dec 2021 19:30:34 -0800 (PST)
Date:   Mon, 20 Dec 2021 19:30:24 -0800
In-Reply-To: <cover.1640039978.git.steadmon@google.com>
Message-Id: <ae7d27b4be1e9b70fc4b7c97524bd6bfbe328270.1640039978.git.steadmon@google.com>
Mime-Version: 1.0
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1640039978.git.steadmon@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v8 3/3] config: require lowercase for branch.*.autosetupmerge
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, chooglen@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Although we only documented that branch.*.autosetupmerge would accept
"always" as a value, the actual implementation would accept any
combination of upper- or lower-case. Fix this to be consistent with
documentation and with other values of this config variable.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 152c94f29d..54c0e7d98e 100644
--- a/config.c
+++ b/config.c
@@ -1577,7 +1577,7 @@ static int git_default_i18n_config(const char *var, const char *value)
 static int git_default_branch_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "branch.autosetupmerge")) {
-		if (value && !strcasecmp(value, "always")) {
+		if (value && !strcmp(value, "always")) {
 			git_branch_track = BRANCH_TRACK_ALWAYS;
 			return 0;
 		} else if (value && !strcmp(value, "inherit")) {
-- 
2.34.1.307.g9b7440fafd-goog

