Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4FBC433FE
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 17:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243578AbiBWRzp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 12:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234110AbiBWRzo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 12:55:44 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FE265BC
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 09:55:15 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d17so6076262wrc.9
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 09:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7/Vet349YwWXOD88+eWNxKjf9Jhn0cuBQkzK8diKGoU=;
        b=P29g+cBobG2E39g70chUs6flKta/3ZKJE0FVm2WkWIAyUZWjTuccGtivSWIhk4ZIze
         1aeaRuGvizN/+9uRAwXDXNbcqWTc0jGy/qVvMkLKe53NGPG5NfFYA1mI4VVoA4DCBZid
         jBX7p48mHd3PxFJWzliKm/sL64im1jPZIG8oOJohASqstSQX3LQ20b2YehHtD9+uK4kq
         8NyCbLtBVdW1oZN4JL5UNHHP13hR6d6XBg7zg+gVwWMn01pmd/l5UXlQP3bPVSHlUAY0
         +9dj+ODmu4KuvVtNTD3685HcOI5Rv7cpjRl3yiDM48dqrOjAGHJf5AdjYWORsl4iJ6J0
         fQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7/Vet349YwWXOD88+eWNxKjf9Jhn0cuBQkzK8diKGoU=;
        b=KFeoxWKRvxcxdLKHgSy4KWdcx+933zpgUWCg+ULD2dXH3tYI7QW/2KJ0vEiyWHzrMP
         AB2lCVIxCSFTabAp0yySRt1nHqLWuW/5DTxPAy+5rUB1poW61Hdtp/7TuPyposbSXW3t
         UlLMzr3UdcE2iWlLYX6qZsFShpqJYpAGuyfsPBvH5Dsv0FIJCTod0o+BS4EWeJgf5zWN
         STCyCo+VnalHSmcMoboU7PyF3ckScznj/njexgfuIjKzc+JS8PSdmeIcZqgGHa+ikGVx
         R5SGI1x8+aHmDjibYGqDoztvX6b2iOhjIvm0G0lAyVjRRtK2S0EhIclDdPfmkPkdlvWT
         XpRw==
X-Gm-Message-State: AOAM533b3AYGs4TZvq7UOqaMtKOFIb1iF/DVufDoHY04HAr/yc26iYUe
        VAgE0rbKe5l03wp+Bsiu9Yr/X4H8yGk=
X-Google-Smtp-Source: ABdhPJyzEb7AOb1Xq6Iibpiwml7lsMVjk8g9/NxrxXiklUYkzeH9V7jyVwbX4SiiskbSuuXONLbvvg==
X-Received: by 2002:a5d:47ae:0:b0:1e8:e479:fa8e with SMTP id 14-20020a5d47ae000000b001e8e479fa8emr557719wrb.169.1645638914005;
        Wed, 23 Feb 2022 09:55:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j9sm276747wmc.5.2022.02.23.09.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 09:55:13 -0800 (PST)
Message-Id: <a1eb4dceb0b1444427c0358948c57bafc513918f.1645638911.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 17:55:01 +0000
Subject: [PATCH 01/11] index-pack: document and test the --promisor option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
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

