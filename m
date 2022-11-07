Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29780C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 18:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbiKGSge (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 13:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbiKGSgN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 13:36:13 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599352497A
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 10:36:12 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id p13-20020a05600c468d00b003cf8859ed1bso7718379wmo.1
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 10:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAsIG3Q7Y722cAUQFUTkCz2gvIX8KTEf/tthursnj+s=;
        b=RT9/5AQ38nsw+Lak4Q9RmFoIXiPoT7X0NcYbiURzQzih+EBJh7yJtEo9kskN93Fx8B
         0lUGVsSjg5JKzDVtzlsu8bK2gCaccz91QzQIV526vc2y/pU9//bNemYeJF8ls3lWHFQx
         uvXN3Vr2rGJzozFk4k4uLQ/H5c5z3mW7eRRj+FD4XL3JFgHYOKLKBStv4nRIKNCApjJ8
         AmZ825BNUTcJGUVulNjbEKQgZNnWLLa3uj8r7NuE2j8VldlKmMAI5TtOgzJ7UHR4gmYQ
         U1jjxiB1DiKEc+FgS0lq3HHRYHVqQqShjHavLHxBfGG8wb3VZsFmoXyXOgincTY/UoD3
         sALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fAsIG3Q7Y722cAUQFUTkCz2gvIX8KTEf/tthursnj+s=;
        b=q4k75MMWtVCpqk7N3JCluMNQUy05HQu9YfCwF2NTFn4kIr2+No5KmCasB2MKmoubnm
         lt00o4XnMNKNeUTMF6WPAEPqe71y8IdBKx5r8b/nLj1/PPz5y07dnGohAJhfkmrprdyV
         204gvy76b3WOXKTYR47GudGjqpmLFSmOcl1ADlV1bvQv19oLOE0gyDmmOzBaZhkf9Rus
         1KUvfDXOdiXhmLPbTBDzDG/YRWuCFP4jrDilggVq3jNAJrdf7MeA2TOb077VK/Cn0PM2
         rYc6mi1m+OzGqFmF11Kd9noWoX3sotF7kLmpPyOY1/Pd65TmZ4Mpj/16tupnun5Dq52D
         IGUA==
X-Gm-Message-State: ANoB5pk8BVQLFZ9V4HE1vdTLDM2/BGfSEBJqC5bT8NiR+ndevKIxXXcF
        MA1VXp9Yhdz0DIw4ZwvUCsc8tKK+8UQ=
X-Google-Smtp-Source: AA0mqf5P2kX9eI92TdewIrFk9CfmmNq1QxwsJcgks0wklZL1R4cmZiKVmyTTgmBXsgjhnk/stNx+qg==
X-Received: by 2002:a1c:4384:0:b0:3cf:b287:916b with SMTP id q126-20020a1c4384000000b003cfb287916bmr2521667wma.181.1667846170715;
        Mon, 07 Nov 2022 10:36:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n4-20020a5d6604000000b002366fb99cdasm7846723wru.50.2022.11.07.10.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:36:10 -0800 (PST)
Message-Id: <0cf654925f8d16a439871499a02125d75140ee36.1667846164.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Nov 2022 18:35:38 +0000
Subject: [PATCH 04/30] config: fix multi-level bulleted list
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The documentation for 'extensions.worktreeConfig' includes a bulletted
list describing certain config values that need to be moved into the
worktree config instead of the repository config file. However, since we
are already in a bulletted list, the documentation tools do not know
when that inner list is complete. Paragraphs intended to not be part of
that inner list are rendered as part of the last bullet.

Modify the format to match a similar doubly-nested list from the
'column.ui' config documentation. Reword the descriptions slightly to
make the config keys appear as their own heading in the inner list.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/config/extensions.txt | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/extensions.txt b/Documentation/config/extensions.txt
index ce8185adf53..18ed1c58126 100644
--- a/Documentation/config/extensions.txt
+++ b/Documentation/config/extensions.txt
@@ -62,10 +62,15 @@ When enabling `extensions.worktreeConfig`, you must be careful to move
 certain values from the common config file to the main working tree's
 `config.worktree` file, if present:
 +
-* `core.worktree` must be moved from `$GIT_COMMON_DIR/config` to
-  `$GIT_COMMON_DIR/config.worktree`.
-* If `core.bare` is true, then it must be moved from `$GIT_COMMON_DIR/config`
-  to `$GIT_COMMON_DIR/config.worktree`.
+--
+`core.worktree`;;
+	This config value must be moved from `$GIT_COMMON_DIR/config` to
+	`$GIT_COMMON_DIR/config.worktree`.
+
+`core.bare`;;
+	If true, then this value must be moved from
+	`$GIT_COMMON_DIR/config` to `$GIT_COMMON_DIR/config.worktree`.
+--
 +
 It may also be beneficial to adjust the locations of `core.sparseCheckout`
 and `core.sparseCheckoutCone` depending on your desire for customizable
-- 
gitgitgadget

