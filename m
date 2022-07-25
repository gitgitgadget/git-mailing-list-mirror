Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6DEC43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 13:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbiGYNxS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 09:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbiGYNxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 09:53:16 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCF41581A
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 06:53:15 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d13so8406445wrn.10
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 06:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OX8LShq5uYNdKTGwBtDaU5leyVnCnfiLNbRITPel/m0=;
        b=N/Y3KYJWDpuVneD3t4Jgk0esFAQcumvU9CeWpCRrE9ZADQu1/M0Wxgqn0NGuQxf/Pd
         4kx/lrYc2dg6tzxdyjSmjVXgCdJKsdZGdxzSXxWXqishJULmFzKClaIAMcBQ5jFISy2b
         UOvsAuoL0k1vxSeZ07znX15WX6x872u2wVDPmSwucCf2cBbVsNmOiVkX9wmh1TeCLORG
         DwfWIuPiLpykyXEMCX9+TnMFFIZDsFQ7a7l6fVgdbw15L6O3HI7KTQwjDFSuaNk/BUy6
         68SgAq+aKd7XJvf74krv2ozcsmasNmh17jZhRcAWGlYEGnNCKegLphodmzQ1XpLGq5vq
         VcNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OX8LShq5uYNdKTGwBtDaU5leyVnCnfiLNbRITPel/m0=;
        b=wkFobujwbCEqDscYED2a3V+USxJ8+YZXOuoLlwo2C4/do0Zxy0OUc40HglMIwJIEFZ
         Smmfywy0NYvY5uA5MxeEbrnkuxDfHQbWwm0xPw++0Fs7gDiWm+KnAyMpgBpk+r18+ruK
         A+C8jIm32R/qq4rDpvAUQ25MWD5FssV8rm6Zttt58/D2XlLU8EKhNWXdNE7f/nYXxQw9
         IHR/5jKwiLT5NEtBNrZPNBQfOafZn/NK+QNWu/2v9Kbg8a9l4puVvAYyzNnvlX9KC1fq
         q6tR0GKWjpEcVHwq7Qnl2v6TbNoYe+/cqLTHpjwLIf3m+WnmCJmH01FswYr9jFcdwbGC
         DzTQ==
X-Gm-Message-State: AJIora/P/RzyK4S1NcfSEzaAtQvN7CItOmvtjlOg+/hlVVITt7T3cetp
        1Kakgfgauaizsj1ThY02jxGTJ8Ww0IQ=
X-Google-Smtp-Source: AGRyM1tBx5P2jAhL30gYkqixS2c0MJh2lWnOdB823Ab1Vpix/9Rq/N8d2cRB3SVTg/q3PDj17cp2Fg==
X-Received: by 2002:adf:ded1:0:b0:21e:8653:c5f7 with SMTP id i17-20020adfded1000000b0021e8653c5f7mr4009209wrn.679.1658757193066;
        Mon, 25 Jul 2022 06:53:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h7-20020a05600c2ca700b003a3253b706esm13159408wmc.34.2022.07.25.06.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 06:53:11 -0700 (PDT)
Message-Id: <a933471c3afdd2c95d4115719c24d79e5e430b4d.1658757188.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1248.v3.git.1658757188.gitgitgadget@gmail.com>
References: <pull.1248.v2.git.1656535245.gitgitgadget@gmail.com>
        <pull.1248.v3.git.1658757188.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Jul 2022 13:53:08 +0000
Subject: [PATCH v3 2/2] bundle-uri: add example bundle organization
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        Josh Steadmon <steadmon@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The previous change introduced the bundle URI design document. It
creates a flexible set of options that allow bundle providers many ways
to organize Git object data and speed up clones and fetches. It is
particularly important that we have flexibility so we can apply future
advancements as new ideas for efficiently organizing Git data are
discovered.

However, the design document does not provide even an example of how
bundles could be organized, and that makes it difficult to envision how
the feature should work at the end of the implementation plan.

Add a section that details how a bundle provider could work, including
using the Git server advertisement for multiple geo-distributed servers.
This organization is based on the GVFS Cache Servers which have
successfully used similar ideas to provide fast object access and
reduced server load for very large repositories.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/technical/bundle-uri.txt | 105 +++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/Documentation/technical/bundle-uri.txt b/Documentation/technical/bundle-uri.txt
index af195f2b429..5575a005177 100644
--- a/Documentation/technical/bundle-uri.txt
+++ b/Documentation/technical/bundle-uri.txt
@@ -349,6 +349,111 @@ error conditions:
   should not use bundle URIs for fetch unless the server has explicitly
   recommended it through a `bundle.heuristic` value.
 
+Example Bundle Provider organization
+------------------------------------
+
+The bundle URI feature is intentionally designed to be flexible to
+different ways a bundle provider wants to organize the object data.
+However, it can be helpful to have a complete organization model described
+here so providers can start from that base.
+
+This example organization is a simplified model of what is used by the
+GVFS Cache Servers (see section near the end of this document) which have
+been beneficial in speeding up clones and fetches for very large
+repositories, although using extra software outside of Git.
+
+The bundle provider deploys servers across multiple geographies. Each
+server manages its own bundle set. The server can track a number of Git
+repositories, but provides a bundle list for each based on a pattern. For
+example, when mirroring a repository at `https://<domain>/<org>/<repo>`
+the bundle server could have its bundle list available at
+`https://<server-url>/<domain>/<org>/<repo>`. The origin Git server can
+list all of these servers under the "any" mode:
+
+	[bundle]
+		version = 1
+		mode = any
+		
+	[bundle "eastus"]
+		uri = https://eastus.example.com/<domain>/<org>/<repo>
+		
+	[bundle "europe"]
+		uri = https://europe.example.com/<domain>/<org>/<repo>
+		
+	[bundle "apac"]
+		uri = https://apac.example.com/<domain>/<org>/<repo>
+
+This "list of lists" is static and only changes if a bundle server is
+added or removed.
+
+Each bundle server manages its own set of bundles. The initial bundle list
+contains only a single bundle, containing all of the objects received from
+cloning the repository from the origin server. The list uses the
+`creationToken` heuristic and a `creationToken` is made for the bundle
+based on the server's timestamp.
+
+The bundle server runs regularly-scheduled updates for the bundle list,
+such as once a day. During this task, the server fetches the latest
+contents from the origin server and generates a bundle containing the
+objects reachable from the latest origin refs, but not contained in a
+previously-computed bundle. This bundle is added to the list, with care
+that the `creationToken` is strictly greater than the previous maximum
+`creationToken`.
+
+When the bundle list grows too large, say more than 30 bundles, then the
+oldest "_N_ minus 30" bundles are combined into a single bundle. This
+bundle's `creationToken` is equal to the maximum `creationToken` among the
+merged bundles.
+
+An example bundle list is provided here, although it only has two daily
+bundles and not a full list of 30:
+
+	[bundle]
+		version = 1
+		mode = all
+		heuristic = creationToken
+
+	[bundle "2022-02-13-1644770820-daily"]
+		uri = https://eastus.example.com/<domain>/<org>/<repo>/2022-02-09-1644770820-daily.bundle
+		creationToken = 1644770820
+
+	[bundle "2022-02-09-1644442601-daily"]
+		uri = https://eastus.example.com/<domain>/<org>/<repo>/2022-02-09-1644442601-daily.bundle
+		creationToken = 1644442601
+
+	[bundle "2022-02-02-1643842562"]
+		uri = https://eastus.example.com/<domain>/<org>/<repo>/2022-02-02-1643842562.bundle
+		creationToken = 1643842562
+
+To avoid storing and serving object data in perpetuity despite becoming
+unreachable in the origin server, this bundle merge can be more careful.
+Instead of taking an absolute union of the old bundles, instead the bundle
+can be created by looking at the newer bundles and ensuring that their
+necessary commits are all available in this merged bundle (or in another
+one of the newer bundles). This allows "expiring" object data that is not
+being used by new commits in this window of time. That data could be
+reintroduced by a later push.
+
+The intention of this data organization has two main goals. First, initial
+clones of the repository become faster by downloading precomputed object
+data from a closer source. Second, `git fetch` commands can be faster,
+especially if the client has not fetched for a few days. However, if a
+client does not fetch for 30 days, then the bundle list organization would
+cause redownloading a large amount of object data.
+
+One way to make this organization more useful to users who fetch frequently
+is to have more frequent bundle creation. For example, bundles could be
+created every hour, and then once a day those "hourly" bundles could be
+merged into a "daily" bundle. The daily bundles are merged into the
+oldest bundle after 30 days.
+
+It is recommened that this bundle strategy is repeated with the `blob:none`
+filter if clients of this repository are expecting to use blobless partial
+clones. This list of blobless bundles stays in the same list as the full
+bundles, but uses the `bundle.<id>.filter` key to separate the two groups.
+For very large repositories, the bundle provider may want to _only_ provide
+blobless bundles.
+
 Implementation Plan
 -------------------
 
-- 
gitgitgadget
