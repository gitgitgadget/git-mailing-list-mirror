Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F83CEB64DA
	for <git@archiver.kernel.org>; Sat,  8 Jul 2023 01:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbjGHBGS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 21:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbjGHBGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 21:06:09 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F3F212D
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 18:06:08 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so27960145e9.3
        for <git@vger.kernel.org>; Fri, 07 Jul 2023 18:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688778366; x=1691370366;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kAShDloEwZOOctxV4C0zs/HnE4QRhndj0mHCwQnrCM=;
        b=dVGv8zG7eQoThM98sfmIsLrTLaZnWdyfMjAV6TkJ1jEsabnsTTHcCJixhRpWZ6txC+
         hdt6Kx4NJ7M52tQyC8PlYhOd3GJDou1a8HYqGwfuz3a18ZnFDnbI2ghl2aucd+DKMTjw
         mns8pZi133Ih6EfiSp08Wt94BQwThT0bJPx6325jHq0bcDFbbowv91xV6HPYJkK+4G+l
         L9xwpIo32tZds8KKAj1EbnRiEXfvbbVn6I/mpYbJw2X7ICaj0aMbRmWfUdZqB4Vr+NZ8
         JOBWSTdjBKxbw4QYqMkgHGt0bdrtxl7hzyFedAqdODexssxoUVcYxJrRUAlGxWb2x1bJ
         JPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688778366; x=1691370366;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8kAShDloEwZOOctxV4C0zs/HnE4QRhndj0mHCwQnrCM=;
        b=hWLfmzz/doaeV7K9MDn/aUVp35+TEJIGlf48BiNjzO7JIrPCQPF+XDi1UKc8vPsKAs
         rXrCdc6+I8uDt4aEwRf/NUrZ7uQf8rwsy1eIm02kZ89YFcE8gVaPknl1JdW/H+fCTaRU
         ghM1IdOEnwWEodduAckDj0tfB5NZpY9QlO447NTW1pkG2khxAibyeQQFeuNTTgt8xCND
         8u0fFmNwX1B2jhH7QWjbsFgx+H17JFSdjCnYokOgXra2PxQLloT2vrSv+Ds1PFaxpCKG
         e9JMvOmBcXNZEVzzzBm5mHhQMpECcJ64LGR657RxCEV7JVi9O/bJk0urr0FVeTx3sDbT
         0LRw==
X-Gm-Message-State: ABy/qLYSu2C2ql3CgTtLFasfuhAhDD9DaCiDTaFt0jFTcJSaxp9KgSs5
        L63q8LUqdMU+HAU0jddntswx2iHi3Tg=
X-Google-Smtp-Source: APBJJlEj77ysWd+ccbXeafRarCFvuiWgFl1Sc1A7QjSWo+75KniGksvuyBZysfvH/0peHZVPYHpyWQ==
X-Received: by 2002:a7b:c389:0:b0:3fc:9f:e75c with SMTP id s9-20020a7bc389000000b003fc009fe75cmr2120035wmj.11.1688778366434;
        Fri, 07 Jul 2023 18:06:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n20-20020a7bc5d4000000b003fa8dbb7b5dsm3773464wmk.25.2023.07.07.18.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 18:06:06 -0700 (PDT)
Message-Id: <1db7a1be27fa51113dcb54013297cda7b6b441d7.1688778359.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1556.git.1688778359.gitgitgadget@gmail.com>
References: <pull.1556.git.1688778359.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 Jul 2023 01:05:59 +0000
Subject: [PATCH 5/5] SubmittingPatches: define topic branches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>, Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index ef39808f568..6fb96e6537f 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -17,7 +17,12 @@ The following branches are the typical starting points for new work:
 * next
 * seen
 
-These branches are explained in detail in linkgit:gitworkflows[7].
+These branches are explained in detail in linkgit:gitworkflows[7]. There are
+also "topic" branches, which contain work from other contributors.  Topic
+branches are created by the Git maintainer (in their fork) to organize the
+current set of incoming contributions from the mailing list, and are enumerated
+in the regular "What's cooking in git.git" announcements.
+
 Choose the appropriate branch depending on the following scenarios:
 
 * A bugfix should be based on `maint` in general. If the bug is not
-- 
gitgitgadget
