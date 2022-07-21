Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386C4C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 09:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbiGUJGL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 05:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbiGUJGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 05:06:09 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFB63F318
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 02:06:05 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id o18so1082792pgu.9
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 02:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5pGHNKIZgch1sM94eEQ4ZIEHhDVQyshvY/UtJ5FdJPE=;
        b=cA29teIUapyH4KiZYRZlQ6r1uZMGQndOKIMi7cMfQTHBwnfuHTAQdqhNw9wMsasuEw
         GFBWFVN/sMYvLi4f0LK2buQIIDNMI6PAL4IC6nXiRxNu1v04ZdU3ml8dcFEnin5d9r7w
         IlK0Pwjnp7j7BMN5GPrEttl7xRIPvJ0gWVzUTwIbfAZ10ju8Y9+X3mg4izxFNNw1m3eG
         HWFmUsfi5WDXsI+spJw267yNm6xfbWU1uNBaE9YiBJ2M/U9zrQt5xDgE//yO7VL3XvEm
         7a1GfcGJStwEyU78ik/fVDX5haWLM2hSzij3LxcnBvLgG1npXyJNO7fFNUAByPdBxxRD
         OKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5pGHNKIZgch1sM94eEQ4ZIEHhDVQyshvY/UtJ5FdJPE=;
        b=rTENSjuGLtC9aQSi9ONPhe03ykUOPAemA7e5g5A9w+OCFFShrfLn0e1MO4crusO8SS
         h6Bs/gNvzlIkm3GCZHrFTZ6bo2IYywIFFC5WK0XUFvFnI0uAB0aQikDk2SMnf9jGLGfV
         5GS1GVWm2P/DIh7ggU5BUnwV5YfIo3EeBH4lOpMB/MSjzuYGPLTcnWgMLhg1sYa6hG2O
         3TeVjfolaoSlZ6Mgj5/VWpWGF3rCW9cnX3jyt9scDrG8htHpHI0VHrxs7obHUepqjL51
         IUvs0wIEN843svJoNlfLR6dExHfIcFOLDrGVF7YEVVxAMLNLiUy4OU2Au/21PePyT98o
         Dpdg==
X-Gm-Message-State: AJIora8Nd+foYzi6GL96iS0IdOBtvofNVhQLYogdReoI1WNgsj/j6+BO
        1Iraw/zVPFqMIDEDA+Bmgr0=
X-Google-Smtp-Source: AGRyM1sqQ/JeNL0Cbl5GED+xu6vLmCuov120GYRKpMJFcila4ExFlNaZyPdYDlZDkJLjJP4TnU6GWA==
X-Received: by 2002:a05:6a00:a29:b0:52a:c0c3:4379 with SMTP id p41-20020a056a000a2900b0052ac0c34379mr43832474pfh.15.1658394364834;
        Thu, 21 Jul 2022 02:06:04 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.102])
        by smtp.gmail.com with ESMTPSA id y10-20020a17090322ca00b0016c9e5f291bsm1127291plg.111.2022.07.21.02.06.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jul 2022 02:06:04 -0700 (PDT)
From:   "tenglong.tl" <dyroneteng@gmail.com>
X-Google-Original-From: "tenglong.tl" <tenglong.tl@tenglongtldeMacBook-Pro.local>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@jeffhostetler.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH v8 3/6] pack-bitmap.c: rename "idx_name" to "bitmap_name"
Date:   Thu, 21 Jul 2022 17:05:45 +0800
Message-Id: <263f45ba96c322665f102e22e1899c93541d87c4.1658393856.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.679.gc613175da2
In-Reply-To: <cover.1658393855.git.dyroneteng@gmail.com>
References: <cover.1658393855.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

In "open_pack_bitmap_1()" and "open_midx_bitmap_1()" we use
a var named "idx_name" to represent the bitmap filename which
is computed by "midx_bitmap_filename()" or "pack_bitmap_filename()"
before we open it.

There may bring some confusion in this "idx_name" naming, which
might lead us to think of ".idx "or" multi-pack-index" files,
although bitmap is essentially can be understood as a kind of index,
let's define this name a little more accurate here.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 pack-bitmap.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index c970ab46dd..7d8cc063fc 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -314,10 +314,10 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 			      struct multi_pack_index *midx)
 {
 	struct stat st;
-	char *idx_name = midx_bitmap_filename(midx);
-	int fd = git_open(idx_name);
+	char *bitmap_name = midx_bitmap_filename(midx);
+	int fd = git_open(bitmap_name);
 
-	free(idx_name);
+	free(bitmap_name);
 
 	if (fd < 0)
 		return -1;
@@ -369,14 +369,14 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 {
 	int fd;
 	struct stat st;
-	char *idx_name;
+	char *bitmap_name;
 
 	if (open_pack_index(packfile))
 		return -1;
 
-	idx_name = pack_bitmap_filename(packfile);
-	fd = git_open(idx_name);
-	free(idx_name);
+	bitmap_name = pack_bitmap_filename(packfile);
+	fd = git_open(bitmap_name);
+	free(bitmap_name);
 
 	if (fd < 0)
 		return -1;
-- 
2.35.0.rc0.679.gc613175da2

