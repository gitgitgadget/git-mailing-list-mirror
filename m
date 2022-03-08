Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411BEC433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 14:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347447AbiCHOkY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 09:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347549AbiCHOkU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 09:40:20 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A87938D9D
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 06:39:23 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id h15so4535276wrc.6
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 06:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7/Vet349YwWXOD88+eWNxKjf9Jhn0cuBQkzK8diKGoU=;
        b=lCuzi6NanSuerHJToIHJNaZFXjRLC244M6rwqF3bt3kAOSkU11lwicq7rPbLDtEFUK
         IcPG/z2TohZoQcNyovbTQh1wGyuHxcvU87haUxU1NU8ltLv+fUikGhrwIXk0EnUDG0Fx
         VrwPIIkyMh7viczhf2WFIXKUmp3XGqlutNF6zC4hdylfrEbhUF7Km1UNOGKZLMLO0nFV
         +XgSgkFl34g6wFydWxj2Gp5YlFwYw/WAYusd054pRoTDQMEjl9amkj5vY7Gm41OURE1C
         GgMO9E0FFr8dNyPsBdlzaOxMU9XdT3o+GoLK7N6Ri3lnlghrc9tGgq9ukLfyD09Dy7yX
         a+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7/Vet349YwWXOD88+eWNxKjf9Jhn0cuBQkzK8diKGoU=;
        b=C1H/PVHdsq8dy+OGgMFQEv53SPlRGzZvKZNCyy3c1CEJ/ufj4HUGDv963qk4EJiwkt
         EwBQy1P2tgDJz4DGXYZ7H7Gz3C1Jh7S70fQVISvJF/WaaXJvTtdxX4WxfMHoowfor+BM
         ms5hd+88riMR2THguA8kHukCyaLEn3H0mFIeGNhZKUFVBgV2dZFQBiKV7BdneF3PaXCm
         +Nr9SHScny3o4G5WZhKAImSU7antevjRRfOXuPeo1CNaGqWNuOpwhmEBagWsZIrkS06P
         WqSclYng4VhAv6kiW6PVLAg9AUwqYLIqjCysB5Ap168Ckj4iKoeYIFB+imW+QJ4qZIAx
         6FhA==
X-Gm-Message-State: AOAM5313QkqTQJeqgghBf3zlRyjPSnQJ63ef6swLibvaSrrLxwhrRKqC
        gaFS5aAvGdLu45gDEhAi5xgfxuU6yeQ=
X-Google-Smtp-Source: ABdhPJzxuXrLFbCvtddggPTk0A7ny5augS6Ef9x7IfTlJFuer3MhmEyOC/IvtT3yC2+dlm2TZdmwLA==
X-Received: by 2002:a5d:49cb:0:b0:1f1:d7e0:3f66 with SMTP id t11-20020a5d49cb000000b001f1d7e03f66mr12887425wrs.218.1646750361785;
        Tue, 08 Mar 2022 06:39:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p3-20020a05600c358300b003897e440047sm2552272wmq.28.2022.03.08.06.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 06:39:21 -0800 (PST)
Message-Id: <a1eb4dceb0b1444427c0358948c57bafc513918f.1646750359.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
References: <pull.1159.v2.git.1646689840.gitgitgadget@gmail.com>
        <pull.1159.v3.git.1646750359.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 14:39:08 +0000
Subject: [PATCH v3 01/12] index-pack: document and test the --promisor option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The --promisor option of 'git index-pack' was created in 88e2f9e
(introduce fetch-object: fetch one promisor object, 2017-12-05) but was
untested. It is currently unused within the Git codebase, but that will
change in an upcoming change to 'git bundle unbundle' when there is a
filter capability.

For now, add documentation about the option and add a test to ensure it
is working as expected.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-index-pack.txt | 8 ++++++++
 t/t5300-pack-object.sh           | 4 +++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index 1f1e3592251..4e71c256ecb 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -122,6 +122,14 @@ This option cannot be used with --stdin.
 +
 include::object-format-disclaimer.txt[]
 
+--promisor[=<message>]::
+	Before committing the pack-index, create a .promisor file for this
+	pack. Particularly helpful when writing a promisor pack with --fix-thin
+	since the name of the pack is not final until the pack has been fully
+	written. If a `<message>` is provided, then that content will be
+	written to the .promisor file for future reference. See
+	link:technical/partial-clone.html[partial clone] for more information.
+
 NOTES
 -----
 
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 2fd845187e7..a11d61206ad 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -315,8 +315,10 @@ test_expect_success \
      git index-pack -o tmp.idx test-3.pack &&
      cmp tmp.idx test-1-${packname_1}.idx &&
 
-     git index-pack test-3.pack &&
+     git index-pack --promisor=message test-3.pack &&
      cmp test-3.idx test-1-${packname_1}.idx &&
+     echo message >expect &&
+     test_cmp expect test-3.promisor &&
 
      cat test-2-${packname_2}.pack >test-3.pack &&
      git index-pack -o tmp.idx test-2-${packname_2}.pack &&
-- 
gitgitgadget

