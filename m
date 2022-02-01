Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAFAC4332F
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 03:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbiBADd5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Jan 2022 22:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbiBADdw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jan 2022 22:33:52 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83130C06173D
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 19:33:51 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id bg21-20020a05600c3c9500b0035283e7a012so713539wmb.0
        for <git@vger.kernel.org>; Mon, 31 Jan 2022 19:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s37iVId/FOEIMbqGP9swHK6j47nxc9iN9EDEFBnEQ/g=;
        b=OvlDLGSwQxmbx+lEy75n1lDHg06Z1KX0RmRhq9tuWFsYjY2nb9sYF4HML7bDtFctyG
         Ai0+W57/tyLGV18WRS12Qnm1SdXYc0VnnNBw3SGaE3J//QFgq6h/cIesPsgz4X3lEAVj
         5Xa8zv4KroU4OOKD9CDfyNUvQY7jUcQpihDsIopkwmwgFs43juxFxBYHLyXDtAHxILvC
         lKcaEiszl0TwWUGVcvQAGfJMZKje9zQ0xOVzTGMrWjRH5rRMcEsho0NssbFTkpZPkXKF
         RTrSyXMwkxSxz05/y2SdQAxEzDd1/j0YiTeR7FkUK+iXi+DiftdyqlfQHGxCuxuu/WMC
         GE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=s37iVId/FOEIMbqGP9swHK6j47nxc9iN9EDEFBnEQ/g=;
        b=bBrEDcVjXLrC4kiZ9RkOhk/2YBxz2pQ/iNitau86vNRbIMe8E9BnA8j+31/tkORv1j
         +5ozqvh/F7ecmHcr6rc3iir4OUoRA3xObQcvtf4M+xc7IxF/sTI8AvuJggOKMFl2wxbD
         KzXDDCL/TnNTCEJY354FtJtu9/5Pfew2TZuGXAJJayy4B/aIqzSCHV5Ft/KuXyZJEl1y
         CGNN6vEwDdrA0Ps9WKMidbQtTSbEFskUujB9kSdcPYkaI3+7D54TU/JVvK5AP3OxhCUD
         2VpKIdz7F/dGpLWcCohLQe2zsfZCvKBDgjwRRKNNGpI0Mjf0V2oJOh2Ehg8uC5x2i/bC
         R47w==
X-Gm-Message-State: AOAM530lo4pms5lySCvJ9A4yALcxOx01h5JUpgGyIGu16ckzdcfRZdJi
        X6wQyGzwPUBmyEnazMDjZICADkH9PKE=
X-Google-Smtp-Source: ABdhPJz1Q3Rflg6VSsV1RkHS+298rm82Et2yBAmAzgHahm708Po/zaaz6p6xBmAw6WC7Z4tYVzr2jQ==
X-Received: by 2002:a7b:c402:: with SMTP id k2mr38744wmi.188.1643686429965;
        Mon, 31 Jan 2022 19:33:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m8sm13113469wrn.106.2022.01.31.19.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 19:33:49 -0800 (PST)
Message-Id: <5c22a41c1f3b6edc941e8bcd0d77df87f1087f85.1643686425.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1093.v4.git.1643686424.gitgitgadget@gmail.com>
References: <pull.1093.v3.git.1639011433.gitgitgadget@gmail.com>
        <pull.1093.v4.git.1643686424.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Feb 2022 03:33:44 +0000
Subject: [PATCH v4 4/4] core.fsync: add a `derived-metadata` aggregate option
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
index 9f3c1ec4c42..3327cf6af0b 100644
--- a/cache.h
+++ b/cache.h
@@ -1012,9 +1012,10 @@ enum fsync_component {
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
index 325644e3c2c..64a8a4d7c2a 100644
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
