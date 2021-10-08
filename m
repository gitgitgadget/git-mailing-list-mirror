Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE7EC433FE
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 09:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2BB460F6C
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 09:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236610AbhJHJS2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 05:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235467AbhJHJS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 05:18:27 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D527C061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 02:16:32 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id y1so5733305plk.10
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 02:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bvvqHjr1wnifEIbWSWxB1Y+hVY30eZCIDzqqw6u3iPI=;
        b=Xl10l4tbTNUN2B+whNN5QuEwCJxiSficZaQGBazQ8DDJhqq1aJa4CeOaYSfwv8QFBJ
         cCtlY2g+IM++lPfUdElP4OEEn/cepeoSNe1Vw0gRstWj5qRvboVGhdu0r7/ibBY7l3ah
         2Qe7f3qFV2HN3VK/gpKHJF8XxoJWXHQsSHA++BRr354hw2dmsINadrII+6ztpFk9qyUC
         N1nfDEqPwD8Pf2i4JMtjaA3ssCUpsLjEtUQzM1tOQ1R9dfFwUXt5Pv7H2ZNVHGyYk1hR
         PFWDbxRmQ69OJUFaM5kNrkJbku53/w5FKWOVuoo8Yx1yCEYHPvMSD8T65F+cAJMTVa0N
         mINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bvvqHjr1wnifEIbWSWxB1Y+hVY30eZCIDzqqw6u3iPI=;
        b=kvOvP9Fe1iGFhSY//f5N6Rv2D0+qhywm9TxBRITuJU5xPMfbxAJR50vSRDkivsGA/q
         sbW1Kd4VpbF6wqKcKnGGovjnExDLmSa1XeiIBKVInRV9ADnonq6r5+etQxmD+RQSLyGp
         JHCXMKeNVkCQuKAHI0KybDmGmTtT6ahTNj8xuHAkjKVJOTj8qb5BXAFxx4k3zB6rYwY7
         VdHTp1ekPznjLDMaFiUjSxP4TCllDoU4wlQmhBCyoO+2wokZo+SMNyDd1bZ5TbG6GWTh
         3gPECqJpRj0/HvqV05KIiTRYBedSGPMOIW4c51lWNVbKrX/Ft8pkqmIbSX4cxk0Zec9V
         JpcA==
X-Gm-Message-State: AOAM532jgdB6ZsuxHFBO8Qqr6pQJeUsqmrcSvDTUhlhkgXf4Dwjkuwl5
        y6TX+I36UrxzkihUqWSRpJ7Si76ji3E=
X-Google-Smtp-Source: ABdhPJy+yiTFgvlvNizOx8ZW3nYQNmW9L3wrbebZMMy6GiTOBC4ARgYdxK5EiAhvqf72SalifG4baQ==
X-Received: by 2002:a17:90a:4502:: with SMTP id u2mr10920998pjg.186.1633684591731;
        Fri, 08 Oct 2021 02:16:31 -0700 (PDT)
Received: from ubuntu.mate (subs28-116-206-12-49.three.co.id. [116.206.12.49])
        by smtp.gmail.com with ESMTPSA id q2sm10495908pjo.27.2021.10.08.02.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 02:16:31 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        "Dr . Matthias St . Pierre" <m.st.pierre@ncp-e.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v5 1/2] blame: describe default output format
Date:   Fri,  8 Oct 2021 16:16:13 +0700
Message-Id: <20211008091614.732584-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211008091614.732584-1-bagasdotme@gmail.com>
References: <20211008091614.732584-1-bagasdotme@gmail.com>
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

