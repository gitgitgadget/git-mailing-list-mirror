Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CBFC433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 20:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58D8461050
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 20:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348395AbhIXUNy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 16:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348384AbhIXUNt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 16:13:49 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5330C061571
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 13:12:15 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t18so30887790wrb.0
        for <git@vger.kernel.org>; Fri, 24 Sep 2021 13:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7X2vP95Nrih2/ZYF5MeQkFO3N7Ybz8M6MMt6amHXYUA=;
        b=CHz9kopmiJRA22IMCnAv1XOPq9NhJIEYwfqb2P6WrLKKlFafAspAkcH5SC6/zoY2xf
         sFZ6UV7LwAd5BxvXLGROJDh2KAjwZte4Nvned5fpDuKyazHkqJRUUv9hAtc5+iKtYtfX
         V/bohwn4K4K3ysmo0iinrKjt+YaosbPFAwK38/pj22jV4cTKe3Y50vwxb6Tr6rTBqQOJ
         lJ9jCESaG5ovBSWwksZgE8VeX72vmQ2tNMNtcfT87uIvESMi6UWNxf6AEIPgRIFuVK5v
         XFH6FOEHq730OdEu0n8S1SknOlRPM57yPu/yNaUpy1RXxvQ5x3Ki7/YIL1PHPS/NAX5o
         /MEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7X2vP95Nrih2/ZYF5MeQkFO3N7Ybz8M6MMt6amHXYUA=;
        b=PIvyK+1A2nnjxcBIuRFKK42eOQgogzb1DkfkVo4zOPVdMpJg1VL3+2Y1hl/hgpbTaD
         X4HCys9IsRKHX4h+XHztvXtb4Mq9oWKFCzFNkWNEnDvnJbwfWI8Sat/xPHUhYH/V/zj7
         Hws26bselQ6F7GKZbJjzzJPFgC79YuFPsjsDxdawfx1dmpFbmLJsG7quegqo/PQpDfaB
         S7BjXOId17C1S+oiuWN8Gq/HPdLOD7IXeuUijS4S0B1TtUC3iK0Ebm33kuohRNfFr4LJ
         S3StHXWYFxr7/V7MBtaGlB16pnA1AF5MCX55CWvuNFcwh/TQyarBr8D5hTkv2gpZTUrg
         y2CA==
X-Gm-Message-State: AOAM533AdKCi9VL2dGTYMGQGMYxCazHCd8Y0V3OBEu/+AB+ao1wx2JE8
        dAmnph4EWN4lObTRaohmXEwEUoMpCu0=
X-Google-Smtp-Source: ABdhPJx/fGUBRbzJ9gTSh7qVTa7D6aIEaaFKcBM9mlepQntd3L7gnv6p/iJHoaAfPD6jE+AJ8JqvzQ==
X-Received: by 2002:a5d:4579:: with SMTP id a25mr13840802wrc.222.1632514334553;
        Fri, 24 Sep 2021 13:12:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t22sm5577974wmj.30.2021.09.24.13.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 13:12:14 -0700 (PDT)
Message-Id: <df6fab94d6727424e0e18ed1fba3c5c985032aab.1632514331.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v5.git.git.1632514331.gitgitgadget@gmail.com>
References: <pull.1076.v4.git.git.1632176111.gitgitgadget@gmail.com>
        <pull.1076.v5.git.git.1632514331.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Sep 2021 20:12:06 +0000
Subject: [PATCH v5 2/7] bulk-checkin: rename 'state' variable and separate
 'plugged' boolean
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

Preparation for adding bulk-fsync to the bulk-checkin.c infrastructure.

* Rename 'state' variable to 'bulk_checkin_state', since we will later
  be adding 'bulk_fsync_state'.  This also makes the variable easier to
  find in the debugger, since the name is more unique.

* Move the 'plugged' data member of 'bulk_checkin_state' into a separate
  static variable. Doing this avoids resetting the variable in
  finish_bulk_checkin when zeroing the 'bulk_checkin_state'. As-is, we
  seem to unintentionally disable the plugging functionality the first
  time a new packfile must be created due to packfile size limits. While
  disabling the plugging state only results in suboptimal behavior for
  the current code, it would be fatal for the bulk-fsync functionality
  later in this patch series.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 bulk-checkin.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index b023d9959aa..f117d62c908 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -10,9 +10,9 @@
 #include "packfile.h"
 #include "object-store.h"
 
-static struct bulk_checkin_state {
-	unsigned plugged:1;
+static int bulk_checkin_plugged;
 
+static struct bulk_checkin_state {
 	char *pack_tmp_name;
 	struct hashfile *f;
 	off_t offset;
@@ -21,7 +21,7 @@ static struct bulk_checkin_state {
 	struct pack_idx_entry **written;
 	uint32_t alloc_written;
 	uint32_t nr_written;
-} state;
+} bulk_checkin_state;
 
 static void finish_bulk_checkin(struct bulk_checkin_state *state)
 {
@@ -260,21 +260,23 @@ int index_bulk_checkin(struct object_id *oid,
 		       int fd, size_t size, enum object_type type,
 		       const char *path, unsigned flags)
 {
-	int status = deflate_to_pack(&state, oid, fd, size, type,
+	int status = deflate_to_pack(&bulk_checkin_state, oid, fd, size, type,
 				     path, flags);
-	if (!state.plugged)
-		finish_bulk_checkin(&state);
+	if (!bulk_checkin_plugged)
+		finish_bulk_checkin(&bulk_checkin_state);
 	return status;
 }
 
 void plug_bulk_checkin(void)
 {
-	state.plugged = 1;
+	assert(!bulk_checkin_plugged);
+	bulk_checkin_plugged = 1;
 }
 
 void unplug_bulk_checkin(void)
 {
-	state.plugged = 0;
-	if (state.f)
-		finish_bulk_checkin(&state);
+	assert(bulk_checkin_plugged);
+	bulk_checkin_plugged = 0;
+	if (bulk_checkin_state.f)
+		finish_bulk_checkin(&bulk_checkin_state);
 }
-- 
gitgitgadget

