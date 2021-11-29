Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E6DC433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 19:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349986AbhK2TiX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 14:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350026AbhK2TgS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 14:36:18 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D94C0617A2
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 07:52:47 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id a9so37839274wrr.8
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 07:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ldyVwS09nc2OLJia/8NlZArMqqWxVI8EkShpKdO52GA=;
        b=ZchwIldkQ2DVpcBPG0872Q1OO2nbclkO+FMReM4G6UZVOQz5+zxuDDWau/cg2vAGdc
         o+sa3eqjZ7SqG1/7JTpSrVMeqjruShid3jxNeEV3cNder5LnBHpBxPwch3mKZCAqqIAk
         JrELSpcuS+5UCtKZTSM0uqSBp/qKXV8d1+T5J55khA1rccgdfwJkngBD5CgQFeH4YLNG
         /VpqnnVTsAlKE1ZlUz38aimfjWlr4aJSEtatdl5JUlw5MF8xkuVe2BG8uSqaM9pTs/73
         Dv7hydM0u/u2IGzqcZXvPr/pB8zLIERODVNG07FbIDofVZTAMNQvT4dF+CgBDnp3pJGY
         PQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ldyVwS09nc2OLJia/8NlZArMqqWxVI8EkShpKdO52GA=;
        b=fozqcsP3owFXIOEGqEkj68t51ikd/xaXF41VGsXNFLXgzsa2mGMOh05M5ogVaqY6pq
         6frgO9hPHzi/N3240YFqt9JS14lketHQzx3h5fuALho/ZuC/qlB1hUX+FPJOVgi3cXC4
         I/8yJvaY194sL5LLTJeMrPZa1xILLekMXgcV80rdkt0pU1yU86ASnaUCAcv3sWc7nV0f
         hE/bA/3XPlSwWKNBHAFuqEh0jr8nGlpUpSPr37fid6BHc6Hzb1pQGefKbKiaN+iv53Nr
         oBx3nBLFXni2qd5SYVOb+1TqvbJty0E2LtKzTHdm/w7R2Awufas+ZBiSDMW5c2+fAAm7
         u7Rg==
X-Gm-Message-State: AOAM530twatd2PTKhYzZh8ereRfZJzcNEQqIpNNqXrUlGfBxxR/Vtu4F
        Ix6yUHhB1uGbxJWPx2pR5P2zJ8iDMiY=
X-Google-Smtp-Source: ABdhPJw7h+ZPygZ1TYPmmxGQhQxuwt0AFi/PVo0CiHKlyZYjdqyzcfSzcFbGZVFQppKktFWJy1KtIQ==
X-Received: by 2002:adf:e842:: with SMTP id d2mr35004039wrn.399.1638201165601;
        Mon, 29 Nov 2021 07:52:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z15sm13917625wrr.65.2021.11.29.07.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 07:52:45 -0800 (PST)
Message-Id: <ad7013a31aa5688747c1606d8c38aa96365c3711.1638201164.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v6.git.1638201164.gitgitgadget@gmail.com>
References: <pull.1048.v5.git.1635345563.gitgitgadget@gmail.com>
        <pull.1048.v6.git.1638201164.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Nov 2021 15:52:36 +0000
Subject: [PATCH v6 1/8] reset: rename is_missing to !is_in_reset_tree
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Rename and invert value of `is_missing` to `is_in_reset_tree` to make the
variable more descriptive of what it represents.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/reset.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 51c9e2f43ff..d3695ce43c4 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -131,10 +131,10 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filespec *one = q->queue[i]->one;
-		int is_missing = !(one->mode && !is_null_oid(&one->oid));
+		int is_in_reset_tree = one->mode && !is_null_oid(&one->oid);
 		struct cache_entry *ce;
 
-		if (is_missing && !intent_to_add) {
+		if (!is_in_reset_tree && !intent_to_add) {
 			remove_file_from_cache(one->path);
 			continue;
 		}
@@ -144,7 +144,7 @@ static void update_index_from_diff(struct diff_queue_struct *q,
 		if (!ce)
 			die(_("make_cache_entry failed for path '%s'"),
 			    one->path);
-		if (is_missing) {
+		if (!is_in_reset_tree) {
 			ce->ce_flags |= CE_INTENT_TO_ADD;
 			set_object_name_for_intent_to_add_entry(ce);
 		}
-- 
gitgitgadget

