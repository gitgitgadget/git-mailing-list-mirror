Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08789C43217
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 03:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E132A61B66
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 03:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344719AbhKPD1w (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 22:27:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244496AbhKPD00 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 22:26:26 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64594C126D04
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 15:51:11 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso531249wms.2
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 15:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Wx/NRBAYoIBhOKGldB61QZt0lf65wQv8k/Ky8embUfk=;
        b=Pj4O+6n8gLYHIlA93DRRbsozvYEN81vS9wst1So30k4LO29Hs7qHqHxfaVhTcCcIxH
         wToR+BeAD/qtC5AfF8dQg/frjNPGEGHtX8BnwJSttQoKNxpM5rXAA/Y0eYyPUytGbqXH
         OHow9qS0nsx/SlaDQQPIBEbWTOSfREqp9Y6B3iEmp0AYlPOXevrtkdorhSmyjqgAe6vP
         +s/96+9PQan95x6hrrxQAP9PMzj1ZRjoNLSE7a6PZx8+PBV8OYtl6s9VGHLUEayX02+t
         jWRI+Rr+bOWBg8FBeCzwut5ZgdUZVRdqRekzPPvaRo1ii1NIckgARgKFDLcln85wFrqu
         3eAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Wx/NRBAYoIBhOKGldB61QZt0lf65wQv8k/Ky8embUfk=;
        b=rJmOVO+ddM8y8pMI9j/WB56NIH8RTUrUqlCI7jfsAE8/5O8NoBazKm2wxQjqahv03A
         xcPKmNGYeih9J/5HglK31SnEVkVhAiv+9WVZn9qpF0iO+ZgSurFBjph0rTp7hXY8mMh1
         j0JbhNxYlcbPcGSgEeE7JipAleNcgPurek/XREApgmGiequSe+3ppSxwLqQEtbbMtrG6
         q76M9ri74WVLwt0dHpBVkSnzwUyMMfGXuOlAoLV1GQrXT6pou3Q2GxwH2UKwmRYxmnzI
         KT38s+9V1nGPqvQdZU77eBw0X5TMuHIxb3p46dm9FOZ/JyM5b5yptN43XwAoyyK6HUGu
         0zGg==
X-Gm-Message-State: AOAM530uR6auIexbG3wG3TaXiRtqMKvTLXPx0q/IEofSq/l0vZGcEnVA
        9VTs4cC/WQ+LUcWYLluLCRy7LHsSw9E=
X-Google-Smtp-Source: ABdhPJyrLGwtb99NYnn55YnxBSnva5YMVe3LREkIUt94a1fMLX1v4T2tP+INNE32/OjOBIhvaB6NJQ==
X-Received: by 2002:a05:600c:3b1b:: with SMTP id m27mr2704261wms.125.1637020269932;
        Mon, 15 Nov 2021 15:51:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b197sm658436wmb.24.2021.11.15.15.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 15:51:09 -0800 (PST)
Message-Id: <cfc6a347d08ce465f260990010267e4e71d469eb.1637020263.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com>
References: <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
        <pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Nov 2021 23:51:01 +0000
Subject: [PATCH v9 7/9] unpack-objects: use the bulk-checkin infrastructure
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
        Elijah Newren <newren@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

The unpack-objects functionality is used by fetch, push, and fast-import
to turn the transfered data into object database entries when there are
fewer objects than the 'unpacklimit' setting.

By enabling bulk-checkin when unpacking objects, we can take advantage
of batched fsyncs.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 builtin/unpack-objects.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 4a9466295ba..51eb4f7b531 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "bulk-checkin.h"
 #include "config.h"
 #include "object-store.h"
 #include "object.h"
@@ -503,10 +504,12 @@ static void unpack_all(void)
 	if (!quiet)
 		progress = start_progress(_("Unpacking objects"), nr_objects);
 	CALLOC_ARRAY(obj_list, nr_objects);
+	plug_bulk_checkin();
 	for (i = 0; i < nr_objects; i++) {
 		unpack_one(i);
 		display_progress(progress, i + 1);
 	}
+	unplug_bulk_checkin();
 	stop_progress(&progress);
 
 	if (delta_list)
-- 
gitgitgadget

