Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255D3C433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 13:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386056AbiDUN35 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 09:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377865AbiDUN3v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 09:29:51 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E18837A0D
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 06:26:54 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id p3so3676501pfw.0
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 06:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UdGyCn43+OHjY3CvW6jv/rL7yauPpi/BUM+a9VWdVkE=;
        b=lviRgpYjnTdM0w9vLq8RN7lGESQPKJVoXBPQ8YsitxeyzHytwMvpIVm2/WEXcx08Q0
         CJHRCGPW7gHI3n2aKAjPdNP1Y2qKfSl3oXX9W7tcjLA8ogCQbEgvLPV4DS+TlPmOtaQ1
         ZzDzM2EM0/4d8oQhpI6Zrvn+FpgK4KF7qoZrM0lkOABuILG+otFVIqg22bL3/BpgEA+C
         OYClJRDz+iE3F1gpy6guSgbvzjU7a4pKr+PF7gcXekCmk8DRg4BEYPi7lVD0jNZRC5SG
         3WanlQX8eEoHKz+tU+I/9mNixurCjoq6IMK1SayPfWFjeyS48fEPQepuhfro5OxSKTmU
         qLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UdGyCn43+OHjY3CvW6jv/rL7yauPpi/BUM+a9VWdVkE=;
        b=q+NGFVW+RlJxe1UiReE2DZDFrbhl0Acg3GtIDLr9KPlxp8KFlG6R+pd9X/fMXSCd9B
         CfcgqDt/AG0LPysWQH+PMW/4rKthIZlT4fhTbr1daEeZz6Ix+zrcCVGBOGpHS1BXfYPr
         EDyye2HhamlF+749OT3ysUgekir5jEn7ag5Jf3dbbX/BipcRApQNoHypMDZ4yoYo40JH
         4mrgUEfBfCijtiSw6PDGuw703BIsZme7qboukwwFRwqAM3ZUrGExC2f6Kj1xPIRW4uU4
         stYik/Q/JLACA9kxvwvqgCd/mvx/eSJt69S4MWgLOMpU8jirot1R0nq4qT6BLN8BVUQ1
         2O/g==
X-Gm-Message-State: AOAM533K4q5PxuZ5y5BOqSmU1Sr496iwJixGMQV4Vn6n3FEeZr8PDC+W
        ypvugqaS3xxmqERUFcHcDCk=
X-Google-Smtp-Source: ABdhPJwzwiaW02aDB7+G+3cWdoIUr7fduoMMPluupnMukKvicyQqZDtJRb8ANt65Ln+HNxjCC47bAA==
X-Received: by 2002:a05:6a00:890:b0:4f6:686e:a8a9 with SMTP id q16-20020a056a00089000b004f6686ea8a9mr28894992pfj.83.1650547614088;
        Thu, 21 Apr 2022 06:26:54 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.42])
        by smtp.gmail.com with ESMTPSA id bd42-20020a056a0027aa00b0050a6e0ccc54sm15463647pfb.186.2022.04.21.06.26.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Apr 2022 06:26:53 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        me@ttaylorr.com, tenglong.tl@alibaba-inc.com, gitster@pobox.com
Subject: [PATCH v2 2/5] pack-bitmap.c: rename "idx_name" to "bitmap_name"
Date:   Thu, 21 Apr 2022 21:26:37 +0800
Message-Id: <1fff3b3ca76d0b5e026270fdf746c55b582405d5.1650547400.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.583.g30faa5f068
In-Reply-To: <cover.1650547400.git.dyroneteng@gmail.com>
References: <cover.1650547400.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In "open_pack_bitmap_1()" and "open_midx_bitmap_1()" we use
a var named "idx_name" to represent the bitmap filename which
is computed by "midx_bitmap_filename()" or "pack_bitmap_filename()"
before we open it.

There may bring some confusion in this "idx_name" naming, which
might lead us to think of ".idx "or" multi-pack-index" files,
although bitmap is essentially can be understood as a kind of index
, let's define this name a little more accurate here.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 pack-bitmap.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 112c2b12c6..f13a6bfe3a 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -313,10 +313,10 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
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
@@ -368,14 +368,14 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
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
2.35.1.583.g30faa5f068

