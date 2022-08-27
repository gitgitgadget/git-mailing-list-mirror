Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04018C0502E
	for <git@archiver.kernel.org>; Sat, 27 Aug 2022 12:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbiH0Moq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Aug 2022 08:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbiH0Mof (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2022 08:44:35 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B2E31374
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 05:44:34 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so2119063wmb.4
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 05:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=oaO05srWf/I52sc2LqNWTDuaqmQesAxh5GR52Lgsn+E=;
        b=DfA60Rk6hcHUVT8IqwPDwYzoZlxtLOmtfGu6Q1wogzrzS2MeHhYB27v5kSw1hBsBXa
         GeZM9uiHQh+LHfCINJEf1iyYLLQynXE2YRenxUbh60uom6Bx+w7zhu/eOYowZ4wbGfA8
         7dVXTlh72Qa8DNIh0QlIGlymXDq2Vt61AbcmTyhz9DFQhkqZg/h9Z04buJpEHKtAGmrG
         hP60aPKSWh/A7AGFzY3vyzog5R1cpUU7xvPUdbnyL5bmw7aU13e7iPEea0Q6fQJ7rWcP
         2kKNEyjzRo6ZlEd0KyUVWwzMYImPRgCkfpJFKWC+qMd5c9ynNTxVSRLuuCFo5DGFWjcm
         eh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=oaO05srWf/I52sc2LqNWTDuaqmQesAxh5GR52Lgsn+E=;
        b=QvVhvJjqS0h7qvDrBZ09dAFChWoIiEMlrdofjT7T4z4ktkFRh/2H5FP5Z9mx3VI69t
         qTOFD1ewyZ6mDeonHO39/nsWJb9hTO781/MDjiR8M7GDzfK0ywUleAVVnKqWjWuLNCML
         KUZx/S7c806FxzRz7o39vAr2ueUGnG7Dz8tmIn/GzefBsw86QBfTMRxAxPx3Sp68wBtG
         JS892wfVp+9jOoxRzC6XmBMU41VNJrOU/Vpdf2PVjO0aUM8ibEF/BqYw3H49Ol834+9f
         ctd9qERQ8lZ3zm0Eu3zWUnJznggGKpetges1fDWhaxLYAbKgqG7hcPNptsnJ6yCeCKJx
         miiQ==
X-Gm-Message-State: ACgBeo2K0fRKmjQrgn4+Z/yH/AFja1HhMQ5DIIIeb95sqvegVev51BpW
        Vd4x9rk+4JxYOaZJ+ZPNJlgRuxfcNhw=
X-Google-Smtp-Source: AA6agR40eMMdY9Y1QuytOxQ/73zo5Z69k4BEf8IFljot6MqlRoN20DipkYoLsMN9hRdA1OqXEMOeVw==
X-Received: by 2002:a05:600c:1009:b0:3a5:4512:5f71 with SMTP id c9-20020a05600c100900b003a545125f71mr2309735wmc.134.1661604272507;
        Sat, 27 Aug 2022 05:44:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v15-20020adfe28f000000b002255eebf785sm2200099wri.89.2022.08.27.05.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 05:44:31 -0700 (PDT)
Message-Id: <9ab30552c6ae6a5d0a85d7a7bbdd10af4a4cf7ec.1661604264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
References: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
        <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 27 Aug 2022 12:44:12 +0000
Subject: [PATCH v5 04/16] bisect--helper: simplify exit code computation
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
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We _already_ have a function to determine whether a given `enum
bisect_error` value is non-zero but still _actually_ indicates success.

Let's use it instead of duplicating the logic.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index aa94c25ec73..2f9c7f54f3f 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1380,12 +1380,5 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	}
 	free_terms(&terms);
 
-	/*
-	 * Handle early success
-	 * From check_merge_bases > check_good_are_ancestors_of_bad > bisect_next_all
-	 */
-	if ((res == BISECT_INTERNAL_SUCCESS_MERGE_BASE) || (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND))
-		res = BISECT_OK;
-
-	return -res;
+	return is_bisect_success(res) ? 0 : -res;
 }
-- 
gitgitgadget

