Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5FFC433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 23:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21EDD61357
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 23:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243317AbhI1Xeq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 19:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243286AbhI1Xei (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 19:34:38 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDA0C061745
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 16:32:58 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id s21so1095081wra.7
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 16:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Wx/NRBAYoIBhOKGldB61QZt0lf65wQv8k/Ky8embUfk=;
        b=AcsxNiC0qcjXCsa6+mTTAjdswRwvXxCf61sUumbQ6Ld7pSrsA4widX12RLsFlsqEgy
         CDslov7zOS4XRtk9yMd+fZ+Cntt1RrHfio8FbWMDlGKh7VK44/dGrdZAlpYXrJ3LbM6u
         kJJHu8EBICGm2bbd1+lRaF6RQNlbFW5591yNCMQUZxMAT6oKXO9zt05XJsL3sPCfmaUz
         o20x9K6A1kZC+XYaDORD4NkrTsLosRpBZUJ58sIp3VObL7Pde2dvQb8bCTVjwTdHbY8H
         njDeVspZpGDky2QcfiTOdkEhu0OGwxgX3orWYkH5+Ipiox0MMEJP+le2VZrvNTWAYYr2
         dTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Wx/NRBAYoIBhOKGldB61QZt0lf65wQv8k/Ky8embUfk=;
        b=vcVGmoKt8alXcCUpbqsNkFopTnkaQBqlgSVqtc4VkNQlY3RP27HbOKShbB4ky50wJH
         cYo43QLNuJ8ozoR59Z0bTRWw5vVf9iMEUzX645E15qtoAmH6kUhYS8FIFFZJu92jdCzF
         WRKKnzyE9O1eDt2e27uPByM022Asu6DGNN6e7hgGyapKvv/Agx/HSCO+jr8zwQQjxkp2
         JpoHN9Pejd0iFY4uxK9VVlH3Bx1FgxIGfXlLkUFYSr0fkRbEAV+vE6CY22kb5bPyt6dK
         S5Xpg4prC9MNH7BxR76ukiAgXcV/bZup6YfZR3+sZWJ5QsqBl/w4ks4fssw+46q0uVOt
         D7xQ==
X-Gm-Message-State: AOAM531Ntk3ZW//BGEmqyhqvsrFvGVuQ2R5iVCenExHLMFIuUc+XeIU7
        ZO80jUJK07pg2VWgcXrZ2alwpRT6G5Q=
X-Google-Smtp-Source: ABdhPJyh9ifLZZrWErKzCiNf/qKuIUvsCo83gyH2l3pzQgLFgnFl/AlUIi2XVGe4yXlKzy/SQVVJWQ==
X-Received: by 2002:a5d:6245:: with SMTP id m5mr3351633wrv.148.1632871977253;
        Tue, 28 Sep 2021 16:32:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v191sm365079wme.36.2021.09.28.16.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 16:32:56 -0700 (PDT)
Message-Id: <1eced9f9f9a882749eb4210908e6561c51c48d87.1632871972.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v7.git.git.1632871971.gitgitgadget@gmail.com>
References: <pull.1076.v6.git.git.1632527609.gitgitgadget@gmail.com>
        <pull.1076.v7.git.git.1632871971.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Sep 2021 23:32:49 +0000
Subject: [PATCH v7 7/9] unpack-objects: use the bulk-checkin infrastructure
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

