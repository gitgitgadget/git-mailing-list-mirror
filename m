Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80648C25B0E
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 23:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237835AbiHPX6X (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 19:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237811AbiHPX6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 19:58:16 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6E13DF31
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 16:58:15 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v3so14434573wrp.0
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 16:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=zYjewUCZigt4BLK5UfZbPXOdu2JYJk63IMi8RktRvQI=;
        b=SG2Mwj/Cm5NMzjxPZ3u0ZHPYYTGwCEBuu8fZ1flD1aR6pu2U+KVi8CPx/mBjiFtfn/
         ev7gRy6RuOlsChFa9aZg57R1KkfuRGpj3W5km+I2bFgLMD1tb8vBIbcXfOOsUeJAL0pk
         sN/FtYIT3oc0P6TSgQpnM8Irmo1f1+qiOyyfUe8dkY1hFZlUFuGYtKZJU3Zp8MXptHJW
         zbsUwyIpTmxLENMZhQhbLqIrVmvUpyELvq5dGGFmGWJclWnAI7hL2WtRo340FeCx+eyr
         XV+Tq+62Tv3xE2Pbpu2gilkAoh3kmiVIvGmrwVXvSjTUKn6ncDPatJnbQSFE1DHP/sxB
         3v2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=zYjewUCZigt4BLK5UfZbPXOdu2JYJk63IMi8RktRvQI=;
        b=6Pad13DelY1mU+l8kYfjnY7lNywKVKGLzBKJuDYm56sT5aBrTHl8v5Ysa4ecT6V9lh
         JGKD1Zk5IDVN6tgE+Mos/x0VtR3l5LJTpzQQrRXcAI7jdowzYkNnCUjMms5rOuxSsG3K
         qPhWL6QzmhRpC7VmnreXEQu71wqB+bAakunHQsLQl207NsOUW+W4bamGzhJiTjDVEeZb
         qRziGU2M1+lzhQ0ovRx5OHu4nYA2H3UFa9vLzS2ThSKoV74dQBvC4KWgvgPY1JrCuLl9
         mDyR0ORp6iHGomNCugHoIQg2mgpW0yEBmFMhpp3qbqHMGouufuCLuHeqA9NGK4HJHJdJ
         VDRw==
X-Gm-Message-State: ACgBeo2Va9R1D7KPn/9k41N6VyePQSGsNQFf/IkxHsFpN+8iYwP0LLlz
        Fv5ngTmqk0OHVsvR9fdnJJ4/nOvz3sw=
X-Google-Smtp-Source: AA6agR5iJ7qoE8iTj5RLrRXeJcDGHHWkpp5RAHdnXg6BQsvHnYJn0rHoDgni1bgFg4HH7TU6cB2BkQ==
X-Received: by 2002:a05:6000:a1b:b0:220:6d98:e97e with SMTP id co27-20020a0560000a1b00b002206d98e97emr13270044wrb.211.1660694295169;
        Tue, 16 Aug 2022 16:58:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bk12-20020a0560001d8c00b0021f0ff1bc6csm10938851wrb.41.2022.08.16.16.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 16:58:14 -0700 (PDT)
Message-Id: <dd59caa2e5aa7e76e75320e0a5d77ae5a408224a.1660694290.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>
References: <pull.1324.git.1660673269.gitgitgadget@gmail.com>
        <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Aug 2022 23:58:09 +0000
Subject: [PATCH v2 5/5] scalar: update technical doc roadmap with FSMonitor
 support
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, mjcheetham@outlook.com,
        gitster@pobox.com, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Update the Scalar roadmap to reflect completion of enabling the built-in
FSMonitor in Scalar.

Note that implementation of 'scalar help' was moved to the final set of
changes to move Scalar out of 'contrib/'. This is due to a dependency on
changes to 'git help', as all changes to the main Git tree *exclusively*
implemented to support Scalar are part of that series.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 Documentation/technical/scalar.txt | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/technical/scalar.txt b/Documentation/technical/scalar.txt
index 08bc09c225a..047390e46eb 100644
--- a/Documentation/technical/scalar.txt
+++ b/Documentation/technical/scalar.txt
@@ -84,13 +84,13 @@ series have been accepted:
 
 - `scalar-diagnose`: The `scalar` command is taught the `diagnose` subcommand.
 
+- 'scalar-add-fsmonitor: Enable the built-in FSMonitor in Scalar
+  enlistments. At the end of this series, Scalar should be feature-complete
+  from the perspective of a user.
+
 Roughly speaking (and subject to change), the following series are needed to
 "finish" this initial version of Scalar:
 
-- Finish Scalar features: Enable the built-in FSMonitor in Scalar enlistments
-  and implement `scalar help`. At the end of this series, Scalar should be
-  feature-complete from the perspective of a user.
-
 - Generalize features not specific to Scalar: In the spirit of making Scalar
   configure only what is needed for large repo performance, move common
   utilities into other parts of Git. Some of this will be internal-only, but one
@@ -98,9 +98,12 @@ Roughly speaking (and subject to change), the following series are needed to
   repository.
 
 - Move Scalar to toplevel: Move Scalar out of `contrib/` and into the root of
-  `git`, including updates to build and install it with the rest of Git. This
-  change will incorporate Scalar into the Git CI and test framework, as well as
-  expand regression and performance testing to ensure the tool is stable.
+  `git`. This includes a variety of related updates, including:
+    - building & installing Scalar in the Git root-level 'make [install]'.
+    - builing & testing Scalar as part of CI.
+    - moving and expanding test coverage of Scalar (including perf tests).
+    - implementing 'scalar help'/'git help scalar' to display scalar
+      documentation.
 
 Finally, there are two additional patch series that exist in Microsoft's fork of
 Git, but there is no current plan to upstream them. There are some interesting
-- 
gitgitgadget
