Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8AFC433F5
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 20:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353684AbiBKU5e (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 15:57:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353622AbiBKU4w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 15:56:52 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAA4D93
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:47 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id m14so17131676wrg.12
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hll4iptPRfp5+CtiV3N+rWx4j+APqCjk1v+7enRLtJI=;
        b=lBD4BUh/zDQZonoecYzTcRXPu0v/lfVQvW5rNiEL3I4YRgOXXbx4x9nt85LxX9qD+G
         XuiJtxfucl8hYK+AYdjBSNm8r5p4acJ1OOvBfF7EG6JVtYvSe0Gyow7NV6yy0AND7rEn
         EQeCEHrqYkSmq12taaRQspoQhf8bUTbpAqY3GR7m0B0Vc9Yn9H+pmbB3kp70QBD7Lzx2
         0Z9MR3/71sgokwIw+Zsuo3Iy6HT4wrsJlHW+Jqtftfm0mBj339PUPq87y0noXwpNr4Hl
         EcvP6iMuL+PlWQBsqrcezOErot5UQH1C1vYTu6SjDCYra0HdRIPASo5R6D0nia9/3i7V
         WKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hll4iptPRfp5+CtiV3N+rWx4j+APqCjk1v+7enRLtJI=;
        b=dcNha/+3i9qRz30lfF6ERXyCQl/fdjxY7p1cr0UIFZQpaAVf3cuAWnFh3ivH+imsUB
         oSYM831K5UxAMRUjaRI3roHOVptaljJslOe0KI6nds54ca/t+iPb7HlMXwGsnFneXcTJ
         Ko0+bE+H9We9YvfUin6GCwQ1E0T3srAkfq5He656BBi2LVlhFmNBlf9taOJvi8XROT4b
         hwVl7I2t/mnO3iaRW9QATa2TR3oDRLhJjNzQ3tsizWB+TG6RpfWbkgbfMZf2aO+a30Iv
         eKrnRXk5oqeK9G7bOwMdxeGAwe73T9mzJ8G06FOalSQ1jQ/PVDKFcYr7v2YAV5cCQosa
         ACyQ==
X-Gm-Message-State: AOAM531EuwLPBqb4DGzdv7kNU6yKak5wqDDFRJcz9Ooa3zG3E48qrJnJ
        Zs4Tm6esjsv2RTy+zC+Tl/n2wyNqecw=
X-Google-Smtp-Source: ABdhPJy2fbt6XONbdnfmTrr+YM48xwzu6ZSL7wdtaCkEmng33nLve7fv0MsOUzXxI05tOBs8lQRH7Q==
X-Received: by 2002:a5d:5906:: with SMTP id v6mr2583399wrd.528.1644613006008;
        Fri, 11 Feb 2022 12:56:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p12sm4797045wmg.36.2022.02.11.12.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 12:56:45 -0800 (PST)
Message-Id: <5117fbdfc6391b80ef25eb7553af1a7a86042048.1644612979.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Feb 2022 20:56:19 +0000
Subject: [PATCH v5 30/30] update-index: convert fsmonitor warnings to advise
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/update-index.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index fed24ea1fb6..f94a89d30c8 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1227,18 +1227,18 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	if (fsmonitor > 0) {
 		enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
 		if (fsm_mode == FSMONITOR_MODE_DISABLED) {
-			warning(_("core.fsmonitor is unset; "
-				"set it if you really want to "
-				"enable fsmonitor"));
+			advise(_("core.fsmonitor is unset; "
+				 "set it if you really want to "
+				 "enable fsmonitor"));
 		}
 		add_fsmonitor(&the_index);
 		report(_("fsmonitor enabled"));
 	} else if (!fsmonitor) {
 		enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
 		if (fsm_mode > FSMONITOR_MODE_DISABLED)
-			warning(_("core.fsmonitor is set; "
-				"remove it if you really want to "
-				"disable fsmonitor"));
+			advise(_("core.fsmonitor is set; "
+				 "remove it if you really want to "
+				 "disable fsmonitor"));
 		remove_fsmonitor(&the_index);
 		report(_("fsmonitor disabled"));
 	}
-- 
gitgitgadget
