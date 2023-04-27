Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D1CC77B61
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 22:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344151AbjD0WWh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 18:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344065AbjD0WW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 18:22:29 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1345B35BD
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 15:22:28 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-2f87c5b4635so8182090f8f.1
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 15:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682634146; x=1685226146;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpazyE4bbmAlxnqGcVH35HUnUNnOOayZeAuXHUx7b9A=;
        b=JELT/kBdWEOAi+vFhQfzQk5JACHsddX9jcDexlR9It1/H0dC56wj0QYNLA+doSa+Se
         rgrqEX6L6rG78zJ5U/GZQiDGkGK2s3fxST3wRBGl9lvWAyj/pUtoeOgMVrM6iLgVdpPG
         YGhtKKz6ogJMQzEYgV1/7lh0XiuF40U0eM1sdFe1X6IeRT+xEdBbSMEnI+VVRaCpZEyG
         lYn/Co1dAxZsRZnu7dDRv+FqlUXFtu8t+bDv6aaYK1UDswFDdY3QClvsFF9f5TQMLn0N
         T++1xPqx9TolhFcNU4v1V6KXRQvUqvlYNexoRu9aShm46OLeJJXGop08F9jRRLNx82CG
         RPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682634146; x=1685226146;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wpazyE4bbmAlxnqGcVH35HUnUNnOOayZeAuXHUx7b9A=;
        b=a/BQ5eKZXOSMCOsTuufmruFRnmi6nBjwqNuajs9nq/N+0hBie6BeLHKtE3zQNm3iTH
         Otwigf56SlQDUGQQmX6I4bf0Fkf0tk+L3IXPaxepEq3tHMNQ9XwW3bgeBj506YCEJiwq
         J1v8ril/1Xsbx5xdRC7Q93uqtgnHPaM1g4x/HO/P87kmv/sb+WAPMjY45Ydfl0tVnLiM
         6yZ7q4P86ETisctmQyg7NTOLv4s0r3QNdw64PmQXCu2SXQ/8jy88dRl1Ft3y6TbvaC/q
         LiOD6QhSdxBLKahw5jmnYEhVSXcGyUGZ4sSvd9s9y7Yp4xjiHrNCbxCaeTw3FOJ/aFMR
         h3iw==
X-Gm-Message-State: AC+VfDwx8ljXTcpa2CGgmtcoR1kMA6Zj/aIiztaEsWi1C0m+bPU8km6W
        1r5W3nksM6QuYNiC3zh/dHOGyZprg9A=
X-Google-Smtp-Source: ACHHUZ5n3RnwFtVOtXarxrNr9rxtkAOv9WA9maAaUrNI78BAuXYl/hAECgwiauAxPlNJda/UJQ/Ryg==
X-Received: by 2002:adf:e4c5:0:b0:304:7ff2:f2a3 with SMTP id v5-20020adfe4c5000000b003047ff2f2a3mr2155742wrm.66.1682634146162;
        Thu, 27 Apr 2023 15:22:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i5-20020a5d5585000000b002fa6929eb83sm19454743wrv.21.2023.04.27.15.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 15:22:25 -0700 (PDT)
Message-Id: <acee642531a582c0abc5d88b23476680e653314f.1682634143.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1495.v2.git.git.1682634143.gitgitgadget@gmail.com>
References: <pull.1495.git.git.1681329955.gitgitgadget@gmail.com>
        <pull.1495.v2.git.git.1682634143.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Apr 2023 22:22:23 +0000
Subject: [PATCH v2 2/2] cocci: codify authoring and reviewing practices
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

These practices largely reflect what we are already doing on the mailing
list, which should help new Coccinelle authors and reviewers get up to
speed.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 contrib/coccinelle/README | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/contrib/coccinelle/README b/contrib/coccinelle/README
index 9b28ba1c57a..055ad0e06a7 100644
--- a/contrib/coccinelle/README
+++ b/contrib/coccinelle/README
@@ -92,3 +92,33 @@ that might be useful to developers.
 
    The absolute times will differ for you, but the relative speedup
    from caching should be on that order.
+
+== Authoring and reviewing coccinelle changes
+
+* When a .cocci is made, both the Git changes and .cocci file should be
+  reviewed. When reviewing such a change, do your best to understand the .cocci
+  changes (e.g. by asking the author to explain the change) and be explicit
+  about your understanding of the changes. This helps us decide whether input
+  from coccinelle experts is needed or not. If you aren't sure of the cocci
+  changes, indicate what changes you actively endorse and leave an Acked-by
+  (instead of Reviewed-by).
+
+* Authors should consider that reviewers may not be coccinelle experts, thus the
+  the .cocci changes may not be self-evident. A plain text description of the
+  changes is strongly encouraged, especially when using more esoteric features
+  of the language.
+
+* .cocci rules should target only the problem it is trying to solve; "collateral
+  damage" is not allowed. Reviewers should look out and flag overly-broad rules.
+
+* Consider the cost-benefit ratio of .cocci changes. In particular, consider the
+  effect on the runtime of "make coccicheck", and how often your .cocci check
+  will catch something valuable. As a rule of thumb, rules that can bail early
+  if a file doesn't have a particular token will have a small impact on runtime,
+  and vice-versa.
+
+* .cocci files used for refactoring should be temporarily kept in-tree to aid
+  the refactoring of out-of-tree code (e.g. in-flight topics). Periodically
+  evaluate the cost-benefit ratio to determine when the file should be removed.
+  For example, consider how many out-of-tree users are left and how much this
+  slows down "make coccicheck".
-- 
gitgitgadget
