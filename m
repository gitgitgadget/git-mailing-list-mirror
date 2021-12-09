Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D498C4332F
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 00:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241769AbhLIBA6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 20:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241744AbhLIBAz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 20:00:55 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B97C061A32
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 16:57:22 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id t9so7044674wrx.7
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 16:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sZ4d+Vc6TZf1kygLr+gzSqna+teDkJh+PKnLy1fAYtE=;
        b=C/BduWJpu9iU8hoUuXCOMQ8IOcf/MclI11emxj8kRjaVLd9kY9MnCyFXUfqd9YvJdd
         iBZxK2Bn0c52TaKhpwl2UlQ+NsmOmEGkIjnByl+HGRM5/RJkkDkokGFzrVaEiCpE+2Fm
         mF6omU1/AKiDXZYKSb/f5GjFBNqCbvSUk5ZHnz+E5my04xADdhZKvYC/ejesiERAM5NF
         PdN/TrIjTxXhh4k5v+zNOx3DxgivqTiSpd2uZcbzkUgG1uz+lKvMrKmgRtzjln2oYOE3
         1FNJuMeZ30sEovF66x6RpPOV8ZlIteBKFebC8icWI5my7OFZeHqHBARZs73JZqSyo4F3
         x1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sZ4d+Vc6TZf1kygLr+gzSqna+teDkJh+PKnLy1fAYtE=;
        b=hYmYjiHQmLhRnilMJZ5BbN07Xo/W0+d3CZB26FLIBXHjAIQnYh3iabdf4SMiorT091
         ISXx4PrIDzMRXe/VcBKF8zZOf4lhnShbTyyoxwLlSXLkzvXeEryjW6osigWdj/Ed4WN3
         t7Tk4ijoHb3BbtDhkofVu7x/78oAkOfHZsXGnowbO8SI3wc6WGNaIEc3ie91uuICb7jG
         AGwK6kgxA9Vgw2vC8BFR6mtQZ3jhliB48WYtE9A7ye13f88TqkxGd94uc09J44pP/al/
         F5ViiAQ9/54b0rnxpivRo6bXDsL28QT9QqrWVIj+/yIKE0owN1Kom6uRr8l3EMO3ev9r
         xxJQ==
X-Gm-Message-State: AOAM530kSn+IN//ar6Gm8eKruglC3cIXotemg8FStkoDC/BAnBV5FIIk
        6JJWtPXylgYFRCnkwFDnDCs6bjdmyrM=
X-Google-Smtp-Source: ABdhPJzT15+HR0Eg33AJXKy7QE7qr+KuRv9iPleroGI2ZWA0get5dkQRRT+nKtlHp0949jeycV1eDA==
X-Received: by 2002:a5d:460d:: with SMTP id t13mr2563371wrq.44.1639011440628;
        Wed, 08 Dec 2021 16:57:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b10sm4040527wrt.36.2021.12.08.16.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 16:57:19 -0800 (PST)
Message-Id: <a830d177d4cd6cebde24e2c51c2185801b6d57dc.1639011434.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1093.v3.git.1639011433.gitgitgadget@gmail.com>
References: <pull.1093.v2.git.1638845211.gitgitgadget@gmail.com>
        <pull.1093.v3.git.1639011433.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 00:57:13 +0000
Subject: [PATCH v3 4/4] core.fsync: add a `derived-metadata` aggregate option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     rsbecker@nexbridge.com, bagasdotme@gmail.com, newren@gmail.com,
        avarab@gmail.com, nksingh85@gmail.com, ps@pks.im,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

This commit adds an aggregate option that currently includes the
commit-graph file and pack metadata (indexes and bitmaps).

The user may want to exclude this set from durability since they can be
recomputed from other data if they wind up corrupt or missing.

This is split out from the other patches in the series since it is
an optional nice-to-have that might be controversial.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 Documentation/config/core.txt | 6 +++---
 cache.h                       | 7 ++++---
 config.c                      | 1 +
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 8e5b7a795ab..21092f3a4d1 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -562,9 +562,9 @@ core.fsync::
 * `pack-metadata` hardens packfile bitmaps and indexes.
 * `commit-graph` hardens the commit graph file.
 * `index` hardens the index when it is modified.
-* `objects` is an aggregate option that includes `loose-objects`, `pack`,
-  `pack-metadata`, and `commit-graph`.
-* `default` is an aggregate option that is equivalent to `objects,-loose-object`
+* `objects` is an aggregate option that includes `loose-objects` and `pack`.
+* `derived-metadata` is an aggregate option that includes `pack-metadata` and `commit-graph`.
+* `default` is an aggregate option that is equivalent to `objects,derived-metadata,-loose-object`
 * `all` is an aggregate option that syncs all individual components above.
 
 core.fsyncMethod::
diff --git a/cache.h b/cache.h
index 4dc26d7b2c9..cc1c084242e 100644
--- a/cache.h
+++ b/cache.h
@@ -1004,9 +1004,10 @@ enum fsync_component {
 				  FSYNC_COMPONENT_COMMIT_GRAPH)
 
 #define FSYNC_COMPONENTS_OBJECTS (FSYNC_COMPONENT_LOOSE_OBJECT | \
-				  FSYNC_COMPONENT_PACK | \
-				  FSYNC_COMPONENT_PACK_METADATA | \
-				  FSYNC_COMPONENT_COMMIT_GRAPH)
+				  FSYNC_COMPONENT_PACK)
+
+#define FSYNC_COMPONENTS_DERIVED_METADATA (FSYNC_COMPONENT_PACK_METADATA | \
+					   FSYNC_COMPONENT_COMMIT_GRAPH)
 
 #define FSYNC_COMPONENTS_ALL (FSYNC_COMPONENT_LOOSE_OBJECT | \
 			      FSYNC_COMPONENT_PACK | \
diff --git a/config.c b/config.c
index b3e7006c68e..d9ef3ef0060 100644
--- a/config.c
+++ b/config.c
@@ -1223,6 +1223,7 @@ static const struct fsync_component_entry {
 	{ "commit-graph", FSYNC_COMPONENT_COMMIT_GRAPH },
 	{ "index", FSYNC_COMPONENT_INDEX },
 	{ "objects", FSYNC_COMPONENTS_OBJECTS },
+	{ "derived-metadata", FSYNC_COMPONENTS_DERIVED_METADATA },
 	{ "default", FSYNC_COMPONENTS_DEFAULT },
 	{ "all", FSYNC_COMPONENTS_ALL },
 };
-- 
gitgitgadget
