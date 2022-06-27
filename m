Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31055C43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 18:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240259AbiF0Sgw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 14:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240200AbiF0Sg3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 14:36:29 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B96186E1
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:31:26 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id v65-20020a1cac44000000b003a03c76fa38so5379463wme.5
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=myo5tcMb8Xf5bZFQBptagcWIswi5SasbgaGUzlTnphY=;
        b=Pkx9NGOLMMbNBxQoLbAMkNOOx5KrzEO6hqNES8aisMn9SaOMLxA5WtOArU4k/Ra5u5
         H2cfTY0vK9uAVD2JXKzyo03Hw1ntk7U8kS8AiwwksgBSt6R+xRwHNJS4vSWSfXgfdu6+
         Y0h3Bpf0EQgJOLTR52Yq3qpx9kfPw9K57h1qFHKk93pZAMU3JR4yg9h7rjpi/M8AOVRh
         VLyN2qBwIRDZNYZHNojVY3i33jX5CNVA59UwyldWXfcDGhnJ1c9lmo8oLxsxMYO2NAIB
         7+NOwYkkwWGwW2ON1wiuYo82Kce/b3NsvkGTtdCUdx99BaY7IC3yfVdGxhl5GUA1Hn7f
         Ewsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=myo5tcMb8Xf5bZFQBptagcWIswi5SasbgaGUzlTnphY=;
        b=M7nzVq0hpMrY50DRbueKc9VwDH1XIQPlChNa6lJVeeWXwUPf9lwEBQ/lMFbLeqIuOQ
         l48aW9G81OGUU2XCoeKh8bO5sUUu5FsRKzKswPheiTWFU3kSgi1PmzoOWyyQRTvF2Sz/
         fVUIoL7JSpzwkUPXJcbqTaDWybGL3pzD41R/u+5SBLioKI48erlljR5RqKWljyfxkVia
         q/Mn0GtjtV7O8qVH5bTBqDZeDCRh0/SzPdsIjrlOqDTdc0JtAW6lSKXl11NXA0DxdCmq
         BABo60SfgtXoncsMVJ3ATFV69pzVOWLEgxKrB9wwLblmt6AnbpwluwtrA5RouRuZAEx0
         If6Q==
X-Gm-Message-State: AJIora/Knoyy2Kk5ZXo6JRZUsCnDlp0A304+8v9Ir3e/aRQthwBqkz2t
        FkVBmN6pWTDMednxoHnQ/xPk4R1C9+0+RA==
X-Google-Smtp-Source: AGRyM1vEt33lKd+ebiHpefQKMF1UFfsoKKykgkqaZMvdmeS4YUW6tAzUN4mSpBWqGcfJNSafBpdQLQ==
X-Received: by 2002:a05:600c:34d0:b0:3a0:2c07:73ac with SMTP id d16-20020a05600c34d000b003a02c0773acmr22181346wmq.85.1656354685267;
        Mon, 27 Jun 2022 11:31:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w9-20020a5d6089000000b0020e5b4ebaecsm11218882wrt.4.2022.06.27.11.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 11:31:24 -0700 (PDT)
Message-Id: <e85f236304b0de455713c45bbcb2248d25cd0f11.1656354677.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
References: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
        <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jun 2022 18:31:06 +0000
Subject: [PATCH v4 05/16] bisect--helper: really retire --bisect-next-check
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 911aba14205 (bisect--helper: retire `--bisect-next-check` subcommand,
2021-09-13), we removed the usage string and the implementation, but not
actually the option.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 8cfe3926dc7..75d008d7fa8 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1280,7 +1280,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		BISECT_RESET = 1,
-		BISECT_NEXT_CHECK,
 		BISECT_TERMS,
 		BISECT_START,
 		BISECT_AUTOSTART,
@@ -1296,8 +1295,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
 			 N_("reset the bisection state"), BISECT_RESET),
-		OPT_CMDMODE(0, "bisect-next-check", &cmdmode,
-			 N_("check whether bad or good terms exist"), BISECT_NEXT_CHECK),
 		OPT_CMDMODE(0, "bisect-terms", &cmdmode,
 			 N_("print out the bisect terms"), BISECT_TERMS),
 		OPT_CMDMODE(0, "bisect-start", &cmdmode,
-- 
gitgitgadget

