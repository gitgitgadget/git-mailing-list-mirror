Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8B3C6FD1F
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 09:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjCVJv1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 05:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjCVJuw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 05:50:52 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F1A6188B
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 02:49:37 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e18so4789078wra.9
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 02:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679478575;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMdTeCz8rJ3p+YPGo6LBNdCbedcwhA8HW3O4dGSn8qo=;
        b=JZbfA35/x7b4w7I5LDF17NSAB/hmyhx5YPu9gNW/3HkZjrZoeopvAt9MlYix4syADD
         lfRD9ol5zDXBmUF99479Vxjw+XsX2vcPSnXNidLpTd9KtspOB6M/vu5jqUwyuosVCMnw
         S3TojISDTNgOByQwoRXa4tebT4QlcOLSINWiZzHCsIQNU3ytPjY49uSuOfM8ZtVFxKpM
         iCjwz7VV3BEzcfMN+hqbUVR06o+ibZy6QM8wnA/e8bjEhsfZcFqB7z1fjJ3x1ddyGRFn
         oiNEqZCRyAvT3IaeOMwx4RUS6XsWMBk9sGVO022TDCabKlxbuNaR39kfWUpKe0GH5g+7
         39Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679478575;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EMdTeCz8rJ3p+YPGo6LBNdCbedcwhA8HW3O4dGSn8qo=;
        b=S1FkhIlCB8jDV6+Ewe/qxzhOPomj83+F+QyiQFma6k/wW7HZBgB0EvmaZu5HlhJW2E
         k1mONeAUjfW9RZTE3bTr3QnwX6gBzIXEqBEBZ9dEoS89urvIJaEKNE6QU4xlJ2TzS35t
         Ona1u+M7lHJzDhsU/kafbyM8vhoq4eqUozfKQKyfC0oxqGybsbq0BausTRVsiZuCu5s7
         5FGNiHou9ulqIJo64kKJ1mv0uqSfijSXRxKmSvLgpGDDW4ozZGs9kbF2MX0UpgTm/kKO
         0AgyjHFbkG4dsoaQp529k8kHsNQzPza4P7MB3tvk/j4GhBgzSZMu4wOL4BH69Y6mi2Qv
         jxlg==
X-Gm-Message-State: AO0yUKUAmhefBXFHgaXgyARw9umgf6V94N+tEJPmB0K7zPaneflw8fWa
        Q7KdaeeyyhUjIN/Vce3cDzgaAcBmnPA=
X-Google-Smtp-Source: AK7set/d4i60Pfum7SLHqEV3wpkeOSrPALJebBZ+5hy1A/zWEJMVj6w+I8HAjtdF1R2FUz412KeCEg==
X-Received: by 2002:a5d:5508:0:b0:2d8:57b1:db6c with SMTP id b8-20020a5d5508000000b002d857b1db6cmr4728798wrv.9.1679478575323;
        Wed, 22 Mar 2023 02:49:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n17-20020adff091000000b002c5534db60bsm13488645wro.71.2023.03.22.02.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 02:49:35 -0700 (PDT)
Message-Id: <44e79f0d69c86e3cf4363aaa10acda91bfa3e9ee.1679478573.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1471.v2.git.git.1679478573.gitgitgadget@gmail.com>
References: <pull.1471.git.git.1679153586903.gitgitgadget@gmail.com>
        <pull.1471.v2.git.git.1679478573.gitgitgadget@gmail.com>
From:   "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Mar 2023 09:49:33 +0000
Subject: [PATCH v2 2/2] Document the output format of ls-remote
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sean Allred <code@seanallred.com>,
        Sean Allred <allred.sean@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sean Allred <allred.sean@gmail.com>

While well-established, the output format of ls-remote was not actually
documented. This patch adds an OUTPUT section to the documentation
following the format of git-show-ref.txt (which has similar semantics).

Signed-off-by: Sean Allred <allred.sean@gmail.com>
---
 Documentation/git-ls-remote.txt | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index ff3da547ddb..9913ab3f83d 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -96,6 +96,30 @@ OPTIONS
 	separator (so `bar` matches `refs/heads/bar` but not
 	`refs/heads/foobar`).
 
+OUTPUT
+------
+
+The output is in the format:
+
+------------
+<OID> TAB <reference name> LF
+------------
+
+For example,
+
+----
+$ git ls-remote
+950264636c68591989456e3ba0a5442f93152c1a	refs/heads/main
+73876f4861cd3d187a4682290ab75c9dccadbc56	refs/heads/maint
+d9ab777d41f92a8c1684c91cfb02053d7dd1046b	refs/heads/next
+74a0ffe000da036ce4ca843d991a7c6b8c246a08	refs/heads/seen
+860bc4360c4fcba0fe2df942984d87f8467af3df	refs/heads/todo
+d4ca2e3147b409459955613c152220f4db848ee1	refs/tags/v2.40.0
+8810a79228a149a9773bf9c75f381fca27a6a80e	refs/tags/v2.40.0-rc0
+f899c182d0bffb6e915da7c8db9be202b144c098	refs/tags/v2.40.0-rc1
+6bed3304b2b2f1cf440ca3050b57a7cf3a3fe687	refs/tags/v2.40.0-rc2
+----
+
 EXAMPLES
 --------
 
-- 
gitgitgadget
