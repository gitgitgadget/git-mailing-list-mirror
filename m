Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E14C7EE29
	for <git@archiver.kernel.org>; Sat, 10 Jun 2023 20:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjFJUV5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jun 2023 16:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbjFJUVf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2023 16:21:35 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BC635BC
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:29 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-30ae901a9ffso2674383f8f.2
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686428488; x=1689020488;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+M0/92IfMNu3+ZNKHyADTtuyGLmFRsLqMO6az5RJJ1Y=;
        b=RUyM1t1DlRzDPeYPqea23rBBkxjaihf8t5+1moonqBay5ueTyD69p4knYPsvkYu1fW
         1nj6hEDCcpD3GPS1IW65sUUIUAvUy9/3IiUQ5R4+BJ+SXoYafrMrW2XrswLuFgJz0baj
         vHB2S9CKbOp3gUlr8CiGplgJyD+03MJtVrEnxv3xwzsv1w0lrU9YIrvrLHQX722FzJvd
         QaqbgnWmI362BV61zBR7XbytLAVJEyREvsNUX6vJ10TTQGPcai7vmHK4LhI68xO4sEfQ
         9RmvyI4CzjJ9xhNKFBQnSh8levUvg37xhQjLPCveDA0aNttAmUXRmntryq2vbO0VgIX+
         nNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686428488; x=1689020488;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+M0/92IfMNu3+ZNKHyADTtuyGLmFRsLqMO6az5RJJ1Y=;
        b=hsGcvyErDscN6MQFZZJesXDafvWM48dBhC8h4AMgSCet9MCZXl5C/jBMciLGve1LMF
         4BTdNY21C9YuV6S2KP8pzdZe6BZY19SgQ6aBbSPlKYJWwhdR2e7BOKHY4wIlZ6hXER3j
         ODEdvtwalzbdeAAGQaHf9OO7smqo2H6M+vpfPqzOAVBV1S3InWGOEWdVldzfn5vDPt/A
         uFYLh749nFYGpFZc7prBoz5As54g1yLaGWATmKVHypQri2IT523gnlZDjb7Kf8BEoWMO
         2lhMLZ98hAEls72xhch14OZVgi+EkDNcG9ghi+5AnqZFFlWDbClfVWutXrJFeHtaOP60
         FJiw==
X-Gm-Message-State: AC+VfDxm29WNf7b6+LJ/mhYObpzjghlZpvnEKypr0dB/D/fjd5rA05/5
        SiwVdQRLycW3eRBjZp8/395F8mqs+u8=
X-Google-Smtp-Source: ACHHUZ62Eqo25BwoZ95UrUaZS6FFf5C023V+7TQFyp2ooo2X7+Ez+N9Ob8COhrKWkEWPu2MYy9beqQ==
X-Received: by 2002:adf:f842:0:b0:30d:1df7:f145 with SMTP id d2-20020adff842000000b0030d1df7f145mr1779524wrq.64.1686428488036;
        Sat, 10 Jun 2023 13:21:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v13-20020adfebcd000000b00309382eb047sm7931033wrn.112.2023.06.10.13.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 13:21:27 -0700 (PDT)
Message-Id: <d38823dd116e4579bbbeb96ff7b1eae8116681bb.1686428485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 10 Jun 2023 20:21:02 +0000
Subject: [PATCH 03/25] completion: complete --cc
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f07b00b9c68..b61c54e37f7 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1754,7 +1754,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--submodule --submodule= --ignore-submodules
 			--indent-heuristic --no-indent-heuristic
 			--textconv --no-textconv --break-rewrites
-			--patch --no-patch
+			--patch --no-patch --cc
 			--anchored=
 "
 
-- 
gitgitgadget

