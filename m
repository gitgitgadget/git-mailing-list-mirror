Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE15DC433FE
	for <git@archiver.kernel.org>; Sun,  3 Oct 2021 10:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B30061B30
	for <git@archiver.kernel.org>; Sun,  3 Oct 2021 10:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbhJCK4Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 06:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhJCK4X (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 06:56:23 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267ACC0613EC
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 03:54:36 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id r2so13815061pgl.10
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 03:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bvvqHjr1wnifEIbWSWxB1Y+hVY30eZCIDzqqw6u3iPI=;
        b=AOL+NpHXL5t6qEem7tBCPXSc0RvLQ4nwfYvgSDZ/2ZkSyn2vg1lTFjEhizCZioFXZ3
         /aZ7A61GPgUU34ayYvXiZarnXkGZNWMnGIitnrg7KtcHdltrbW4GWc5KYie2gsVzF1bA
         POmsCpaI172hiNAj9kUg7EXQs46mgE5VA412R/sgvzyUx+yrEFIL2Ti+Cp6FVt57499A
         gbcYbumBAZ5GOksqOQ7842A+pO57lzXfNQ9zATtDqaIdADYFCyI5mNX/yyl24yJR/21p
         keVSYf/jqs15OAk0YaV/KBDG3qMGSI5/VyydQRQbGnjl/plWH2KZGTGvxFYttugH5nkx
         c8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bvvqHjr1wnifEIbWSWxB1Y+hVY30eZCIDzqqw6u3iPI=;
        b=ANpprK5nSRKNimsSB5st7CLNqERAC0+frn/wvFUlfJ0IKduy39OiTVZ+5+PhwNxwqs
         lKvfv/ZhyAf3vt9hv14iHCq7ZQUUyEfeqZu+xDcpxrsynSIUnLhjtcDBS9//TqZlvyRn
         6d/eIHAchdpTQJzQp/Kcheg5acZRB4fQbkDXVudns4m1Fn2mlVpKwH4mAGJMecAPZh6c
         XAdQWILDMga+ZG/TyPYpw7QIPNPaVe6Fk2VU1XgxTyvJAylzIFRQBSpPGBqpsZA4M65Y
         p8YK5C+lZCijC1i2avtPUI7tS2mvUUXiijuSjnzdRRtTAp/6Yc21Sc+d6NpLe7tQxxgA
         d8dg==
X-Gm-Message-State: AOAM533Azb/Le/yM4lmdUs/b58i09xS1DQkQVHrXTo+K9PA6BPV3f7/B
        RxD/tyxO3MCpEP52EXnPznv+W710BEGAAg==
X-Google-Smtp-Source: ABdhPJx59nsD+jrpvWGXT2oZhbkFw0UjCb/dQhEA3CBA52oQYf7rb568j+B0VX3Cyp7AcS15QFX4kA==
X-Received: by 2002:a62:2c51:0:b029:329:932b:9484 with SMTP id s78-20020a622c510000b0290329932b9484mr19004794pfs.13.1633258475498;
        Sun, 03 Oct 2021 03:54:35 -0700 (PDT)
Received: from ubuntu.mate (subs03-180-214-233-29.three.co.id. [180.214.233.29])
        by smtp.gmail.com with ESMTPSA id u1sm11263163pju.2.2021.10.03.03.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 03:54:35 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Dr . Matthias St . Pierre" <m.st.pierre@ncp-e.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v4 1/2] blame: describe default output format
Date:   Sun,  3 Oct 2021 17:53:27 +0700
Message-Id: <20211003105327.215996-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211003105327.215996-1-bagasdotme@gmail.com>
References: <20211003105327.215996-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While there is descriptions for porcelain and incremental output
formats, the default format isn't described. Describe that format for
the sake of completeness.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/git-blame.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 3bf5d5d8b4..08008f4a60 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -93,6 +93,19 @@ include::blame-options.txt[]
 	is used for a caret to mark the boundary commit.
 
 
+THE DEFAULT FORMAT
+------------------
+
+When neither `--porcelain` nor `--incremental` option is specified,
+`git blame` will output annotation for each line with:
+
+- abbreviated object name for the commit the line came from;
+- author ident (by default author name and date, unless `-s` or `-e` is
+specified); and
+- line number
+
+before the line contents.
+
 THE PORCELAIN FORMAT
 --------------------
 
-- 
An old man doll... just what I always wanted! - Clara

