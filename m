Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE90C433FE
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 19:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351289AbiCOTOk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 15:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351287AbiCOTOj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 15:14:39 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36E155B4
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 12:13:24 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id u17so462271pfk.11
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 12:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yHOWUvFKKmXIx0W9CUm6qBk1A/ZTR05Cg8/wHnWeX8o=;
        b=HM1/YZ0vRggiOfHw2VNv6C596+vAY5h1FPR4AJjyujM8fy9tbXhfjW512LCzLJ5M1y
         nzOVUml6itUH3e3Irn78nnvdr2/gxRMNSSXMtb7UlyOvIKZWTwaTXQnK9pdPRRnRBHDx
         Rk9WRexpztOUua3ICJCbUZVVhEgfNqwHzcvKXSAIztebHQIv9PO2XQCuR4Dg5GPddqsN
         yZlcEq9nuWcsuWBPJA6AW9FioB1TM4SsPcXSF3ey68PjJgbb8BNWpoDQ4ef7+g96HMWO
         IHwu4th7WBZ7Gs71FXKOO3mEzXd41KyzZMCc4X7Z6wfn/I2sI2JcOfzqywp985rQU91d
         eY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yHOWUvFKKmXIx0W9CUm6qBk1A/ZTR05Cg8/wHnWeX8o=;
        b=XnY8JNZHhioPzgwDHR0nyJK5mq+ODyLyNVQT+EjZ6AysHOB+8HdfcI1gjRrtay5eDJ
         CnU+EMrK6ptFOUrnFzVyNAFVgZIXtZolG4LqACMy9sR4ZYiaUwC+LHetdgkZABVfZhPv
         /feyQFt31bJwqSnQiPyEb1G+xmisnDGtnFLzx9EP9zeZ9Wrea07IHCtWRIwin8DeyYHC
         A0kmXfxdamXPltaBw3seM0qTCDDV5dcvQf8MSvxX3FlM9RPglbhRzIAh1k1cBH1ocsDJ
         4feWK6y9vpgcGJXSyiubNeZCe9ZD2VE61L8fbbyZxoXzu3Veup1vi1xUElADxB3/isVU
         dNng==
X-Gm-Message-State: AOAM5307l504VzyLfnf8sMfvdd7uo+qL+sA4ycXWG3IrIs5n7U5aobjl
        09n+b42Nu2sjfWLuzi1lO+FJMK0U/w+29g==
X-Google-Smtp-Source: ABdhPJzvSYcjE9BOq3PuZn8Ai8OcMqWbTACWp6Xc6/zmJlMmwX/goYD1H5aMGuezbvdBaAhjHrzctQ==
X-Received: by 2002:a63:2fc7:0:b0:381:15fb:3072 with SMTP id v190-20020a632fc7000000b0038115fb3072mr18651823pgv.340.1647371603892;
        Tue, 15 Mar 2022 12:13:23 -0700 (PDT)
Received: from neeraj-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:f:ae23:3152:3a4d:d1f6])
        by smtp.gmail.com with ESMTPSA id p25-20020a637419000000b0037fa57520adsm1510pgc.27.2022.03.15.12.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 12:13:23 -0700 (PDT)
From:   Neeraj Singh <nksingh85@gmail.com>
X-Google-Original-From: Neeraj Singh <neerajsi@microsoft.com>
To:     gitgitgadget@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, bagasdotme@gmail.com,
        git@vger.kernel.org, neerajsi@microsoft.com, newren@gmail.com,
        nksingh85@gmail.com, ps@pks.im, rsbecker@nexbridge.com,
        sandals@crustytoothpaste.net
Subject: [PATCH v7] core.fsync: documentation and user-friendly aggregate options
Date:   Tue, 15 Mar 2022 12:12:45 -0700
Message-Id: <20220315191245.17990-1-neerajsi@microsoft.com>
X-Mailer: git-send-email 2.33.0.334.g55a40fc8fd
In-Reply-To: <7e4cc6e10a5d88f4c6c44efaa68f2325007fd935.1646952205.git.gitgitgadget@gmail.com>
References: <7e4cc6e10a5d88f4c6c44efaa68f2325007fd935.1646952205.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit adds aggregate options for the core.fsync setting that are
more user-friendly. These options are specified in terms of 'levels of
safety', indicating which Git operations are considered to be sync
points for durability.

The new documentation is also included here in its entirety for ease of
review.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
This revision fixes a grammatical mistake in the core.fsync documentation.

 Documentation/config/core.txt | 40 +++++++++++++++++++++++++++++++++++
 cache.h                       | 23 +++++++++++++++++---
 config.c                      |  5 +++++
 3 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index ab911d6e26..9a3ad71e9e 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -547,6 +547,46 @@ core.whitespace::
   is relevant for `indent-with-non-tab` and when Git fixes `tab-in-indent`
   errors. The default tab width is 8. Allowed values are 1 to 63.
 
+core.fsync::
+	A comma-separated list of components of the repository that
+	should be hardened via the core.fsyncMethod when created or
+	modified.  You can disable hardening of any component by
+	prefixing it with a '-'.  Items that are not hardened may be
+	lost in the event of an unclean	system shutdown. Unless you
+	have special requirements, it is recommended that you leave
+	this option empty or pick one of `committed`, `added`,
+	or `all`.
++
+When this configuration is encountered, the set of components starts with
+the platform default value, disabled components are removed, and additional
+components are added. `none` resets the state so that the platform default
+is ignored.
++
+The empty string resets the fsync configuration to the platform
+default. The default on most platforms is equivalent to
+`core.fsync=committed,-loose-object`, which has good performance,
+but risks losing recent work in the event of an unclean system shutdown.
++
+* `none` clears the set of fsynced components.
+* `loose-object` hardens objects added to the repo in loose-object form.
+* `pack` hardens objects added to the repo in packfile form.
+* `pack-metadata` hardens packfile bitmaps and indexes.
+* `commit-graph` hardens the commit graph file.
+* `index` hardens the index when it is modified.
+* `objects` is an aggregate option that is equivalent to
+  `loose-object,pack`.
+* `derived-metadata` is an aggregate option that is equivalent to
+  `pack-metadata,commit-graph`.
+* `committed` is an aggregate option that is currently equivalent to
+  `objects`. This mode sacrifices some performance to ensure that work
+  that is committed to the repository with `git commit` or similar commands
+  is hardened.
+* `added` is an aggregate option that is currently equivalent to
+  `committed,index`. This mode sacrifices additional performance to
+  ensure that the results of commands like `git add` and similar operations
+  are hardened.
+* `all` is an aggregate option that syncs all individual components above.
+
 core.fsyncMethod::
 	A value indicating the strategy Git will use to harden repository data
 	using fsync and related primitives.
diff --git a/cache.h b/cache.h
index e08eeac6c1..86680f144e 100644
--- a/cache.h
+++ b/cache.h
@@ -1007,9 +1007,26 @@ enum fsync_component {
 	FSYNC_COMPONENT_INDEX			= 1 << 4,
 };
 
-#define FSYNC_COMPONENTS_DEFAULT (FSYNC_COMPONENT_PACK | \
-				  FSYNC_COMPONENT_PACK_METADATA | \
-				  FSYNC_COMPONENT_COMMIT_GRAPH)
+#define FSYNC_COMPONENTS_OBJECTS (FSYNC_COMPONENT_LOOSE_OBJECT | \
+				  FSYNC_COMPONENT_PACK)
+
+#define FSYNC_COMPONENTS_DERIVED_METADATA (FSYNC_COMPONENT_PACK_METADATA | \
+					   FSYNC_COMPONENT_COMMIT_GRAPH)
+
+#define FSYNC_COMPONENTS_DEFAULT (FSYNC_COMPONENTS_OBJECTS | \
+				  FSYNC_COMPONENTS_DERIVED_METADATA | \
+				  ~FSYNC_COMPONENT_LOOSE_OBJECT)
+
+#define FSYNC_COMPONENTS_COMMITTED (FSYNC_COMPONENTS_OBJECTS)
+
+#define FSYNC_COMPONENTS_ADDED (FSYNC_COMPONENTS_COMMITTED | \
+				FSYNC_COMPONENT_INDEX)
+
+#define FSYNC_COMPONENTS_ALL (FSYNC_COMPONENT_LOOSE_OBJECT | \
+			      FSYNC_COMPONENT_PACK | \
+			      FSYNC_COMPONENT_PACK_METADATA | \
+			      FSYNC_COMPONENT_COMMIT_GRAPH | \
+			      FSYNC_COMPONENT_INDEX)
 
 /*
  * A bitmask indicating which components of the repo should be fsynced.
diff --git a/config.c b/config.c
index 80f33c9198..fd8e165931 100644
--- a/config.c
+++ b/config.c
@@ -1332,6 +1332,11 @@ static const struct fsync_component_name {
 	{ "pack-metadata", FSYNC_COMPONENT_PACK_METADATA },
 	{ "commit-graph", FSYNC_COMPONENT_COMMIT_GRAPH },
 	{ "index", FSYNC_COMPONENT_INDEX },
+	{ "objects", FSYNC_COMPONENTS_OBJECTS },
+	{ "derived-metadata", FSYNC_COMPONENTS_DERIVED_METADATA },
+	{ "committed", FSYNC_COMPONENTS_COMMITTED },
+	{ "added", FSYNC_COMPONENTS_ADDED },
+	{ "all", FSYNC_COMPONENTS_ALL },
 };
 
 static enum fsync_component parse_fsync_components(const char *var, const char *string)
-- 
2.33.0.334.g55a40fc8fd

