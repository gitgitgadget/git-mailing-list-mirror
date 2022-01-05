Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE4CC433F5
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 19:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243504AbiAET03 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 14:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243475AbiAET0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 14:26:24 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5568AC061245
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 11:26:24 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so11093wme.4
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 11:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=qsPVaLB6dfkAopYl2Wh9yINdPnpSi/hhVdBeUJ6TIZU=;
        b=apnbRN4njAJ3ld1gauTtA51UgRgq3ANXNXLsgHaMQm2M5ravUz9+Quihoe+jxn96zn
         igfqhzseMees7vIR8hHqQJZMndYRK/QFGGkZDRfsGCQi1y/10NflgjIGMkSS37gHvzUs
         espuhX6XB6Su0lcylEvBFpHO6NWqcLQuVqKwNSdOJjvdNprIFy48QcP5QFOBsLKw0Tra
         lWWb/YCBn0e0nX9l6GLWEDzgNQ1rrX6X8woBNgAj8uZdiZLOToLnynMd3TQglZH3LxVx
         qbfSBGS9lvrmw53EvukN9QpbNaldVWiHR13JHsWcLt37vxPgvWr1dVqQ955r6iRUgt4v
         PLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qsPVaLB6dfkAopYl2Wh9yINdPnpSi/hhVdBeUJ6TIZU=;
        b=0he9/h1y/ggDvrPyWsI05v+FTtzR0Ow/JA8pulTwpv0npOJMVZvTTZjAvUi2k0auth
         r/e8NsHwTwVOw0LwXJF2inzhXklLm9PdC4KOjtbv1ngiSq51+UcjHuepw6iRMQssJehb
         aknBmNcAiiW4Uc3j+syIPyht7xdWLY3mXlea1mVeQpfMkohTWINzG30HOOMVEyl6JXxT
         2MiFmgLgprBL2YfXMCyhmhj5tpVDVJmLnP1yToM4uyiXxeMH94MQU6/HOVxrTBBO3SVE
         7ZQZCX2wN6Lxxu4sOiVOi4vakPDoq81JVaHekBqkdnT+3oSdU2pfwcXlTgmjxCG10TPE
         R9wQ==
X-Gm-Message-State: AOAM530J9uV5EIpSDpMNdJkqArIP9vk+IU86HmfI+CIqNtn3Qd1BhwRu
        565pPFYmsSp1TKrl33wDL1a6LClgkRQ=
X-Google-Smtp-Source: ABdhPJw+Ca4hjgXzO0WEdj/1tW1KBQke/DodUKDLjEXUaLzGa6tfazaCorGVmVM6amk4U4SSPZQFug==
X-Received: by 2002:a05:600c:1da5:: with SMTP id p37mr4228790wms.59.1641410782847;
        Wed, 05 Jan 2022 11:26:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c18sm3319622wrn.81.2022.01.05.11.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 11:26:22 -0800 (PST)
Message-Id: <pull.1111.git.1641410782015.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Jan 2022 19:26:21 +0000
Subject: [PATCH] submodule.h: use a named enum for RECURSE_SUBMODULES_*
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Using a named enum allows casting an integer to the enum type in both
GDB and LLDB:

    (gdb) p (enum diff_submodule_format) options->submodule_format
    $1 = DIFF_SUBMODULE_LOG

    (lldb) p (diff_submodule_format) options->submodule_format
    (diff_submodule_format) $1 = DIFF_SUBMODULE_LOG

In LLDB, it's also required to cast in the reversed direction, i.e.
cast an enum constant into its corresponding integer:

    (lldb) p (int) diff_submodule_format::DIFF_SUBMODULE_SHORT
    (int) $0 = 0

Name the enum listing the different RECURSE_SUBMODULES_* modes, to make
debugging easier.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    submodule.h: use a named enum for RECURSE_SUBMODULES_*

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1111%2Fphil-blain%2Fsubmodule-recurse-enum-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1111/phil-blain/submodule-recurse-enum-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1111

 submodule.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/submodule.h b/submodule.h
index 6bd2c99fd99..55cf6f01d0c 100644
--- a/submodule.h
+++ b/submodule.h
@@ -13,7 +13,7 @@ struct repository;
 struct string_list;
 struct strbuf;
 
-enum {
+enum submodule_recurse_mode {
 	RECURSE_SUBMODULES_ONLY = -5,
 	RECURSE_SUBMODULES_CHECK = -4,
 	RECURSE_SUBMODULES_ERROR = -3,

base-commit: 2ae0a9cb8298185a94e5998086f380a355dd8907
-- 
gitgitgadget
