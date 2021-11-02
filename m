Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4783C433F5
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 15:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EBDF60F5A
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 15:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbhKBPsy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 11:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbhKBPsv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 11:48:51 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD5CC061714
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 08:46:16 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 71so13678621wma.4
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 08:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=IWZ+wQFISLCSuKsKparVaIZmh4E35bF5Bk/+BvEvB5Q=;
        b=OUQRCW8hnOQfDQJ4ECOC0+tSfI3NtqRU6XBRbmt9mHLavxX+PNSz6q6rX5gY6vztw9
         Ch2Ruxtf7B6Le9J1ZMoEzKhfGSmC8/AIn8KFbA5Kjy1dWkmaHy+3vUxSSgkegXThphdq
         cBtPEWXVQJRV+yAsrgYKnSb/I9RDkrx9zVNsXvdR3Ghr0yWTEFljd2Fvy9CPr4T4I1yM
         58webXl65YzCnGf5o5IhFhMFPnCqWf2FEYgMlykm0zaJZ0fyNYAJdYmf6oD+hTRcUD78
         fskAR8HMzJb58Jn3TliWxv4x/imUpJAujXKwZcRaqWdXQsi/50EMDoCp+Ejz3NaCl8M/
         q9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=IWZ+wQFISLCSuKsKparVaIZmh4E35bF5Bk/+BvEvB5Q=;
        b=a5Z5pr3w1COPONAy0XncOJDDV/JBqOAOaYKT+xg94qUkWIvW2tCMIH3sNb8xFaT0s7
         bHlZy5Qqhd6wd/FhU/lzfesYBFpv2VqpwF+MkcRguqaR1Lkl14UjfDA/i4Iy/SgpIDvx
         k36LwbNzAjS3iFOpoUjrczAqgSPw9J9xXDqhRCrOJIYVH74OPseRO3iJJbB1aPmnjbWu
         3cj8mLqpRA7zvi+3HY/1V/87T/UTYn5bHaqCTAetZWE7YE0JMPy6qy3ojEDUhJGzlIM5
         NEy0bzOeAYGjCR2CTivwzgjXGpji7nu7QC0/+6De9CnkraVJ8pUSP/LzOxXr2J/WUhpp
         NLNw==
X-Gm-Message-State: AOAM532giyhGSQf9aWIABwU7LrdqdYFrteQTN/fIdjcy7leg/z3WronW
        SESPvAEYpa9J8VuMir5iJW25kgGOKIw=
X-Google-Smtp-Source: ABdhPJyHa5L8vu76igaXdnw6Wq5o33tocO9aud82CKwcpB3zF3Uy3GPDBFBNGsXcFGdrC+9TciovuA==
X-Received: by 2002:a05:600c:2f17:: with SMTP id r23mr8279053wmn.93.1635867975006;
        Tue, 02 Nov 2021 08:46:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m21sm12293850wrb.2.2021.11.02.08.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 08:46:14 -0700 (PDT)
Message-Id: <489500bb1dcaffecab42672658990cfc26d52d7c.1635867971.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1068.v4.git.1635867971.gitgitgadget@gmail.com>
References: <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
        <pull.1068.v4.git.1635867971.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Tue, 02 Nov 2021 15:46:06 +0000
Subject: [PATCH v4 3/8] test-lib: add prerequisite for 64-bit platforms
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

Allow tests that assume a 64-bit `size_t` to be skipped in 32-bit
platforms and regardless of the size of `long`.

This imitates the `LONG_IS_64BIT` prerequisite.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index adaf03543e8..af1a94c2c20 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1642,6 +1642,10 @@ build_option () {
 	sed -ne "s/^$1: //p"
 }
 
+test_lazy_prereq SIZE_T_IS_64BIT '
+	test 8 -eq "$(build_option sizeof-size_t)"
+'
+
 test_lazy_prereq LONG_IS_64BIT '
 	test 8 -le "$(build_option sizeof-long)"
 '
-- 
gitgitgadget

