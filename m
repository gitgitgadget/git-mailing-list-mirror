Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED65C7EE2D
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 02:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjBYC0M (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 21:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBYC0J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 21:26:09 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767A83BD9A
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 18:26:07 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id bw19so1013812wrb.13
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 18:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJhOI5pH2/X7Uqaz8J/86RgsSNzaLLs6qLmjlPTEmeM=;
        b=SBdeRzYGkoiSwvDWVIJttVlRM2T8J6A6w2GYT8v7Jabh8tJx/0zcVm2ZPxiijOrP4U
         uPJ30FAp93+D5ZywTCVB8VfQKXNOATd3HMgWQSuo/U2OUnWuhh0guMRuGlgdB+FaT7w9
         rIEgMtIf2LejY+dhtZ0t8CMw5TLxBPqQ/htIWPePM0xWIwk/LVmjSY+uq1GTv745FOI3
         koTT7Y/kvh4tBPMRP/D+CQbVc4Z0CgCf/SQsbZ8yTtjFo+8LRXoFpwn/2aVlOoPWeGbV
         OoXN/ly9BnF6oqyMC9A+HSBtMEoMSCKfTVlQc8o76yruDaJNcwza4FJHXBbBBomrVyL8
         Rt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJhOI5pH2/X7Uqaz8J/86RgsSNzaLLs6qLmjlPTEmeM=;
        b=xAqZ+6Ymx05thL2IO7HK6uXN2lSc/aSHWfEqahSKrT9vPoOLZV2ph4Y81PIY1NANUB
         X6KUMAXYM6ivHGFXsGDAVi2Wsa3GR2GcyWT4DEEXeeospJrEI2mTQ1QujjdgDyjmGeum
         mimi1voI9mJoCLMO41qqqmc63togSZOcHFsbBSRXqwd4tVMCt7OEerGY+GOagZBz+RtW
         gp+TrFwR2VTZV9hq2a2k48G7+d4u4PVnrY1fu2Y7DRgSTJe44uJ1x9+2nxcZ/8UBmQYj
         wGpUiqKilSVKCDsl6xVJVd1NQj6T1WIBpqiSloqA+H4sLKbRIMw4z1dE2ypsCvAlTu7a
         /V1A==
X-Gm-Message-State: AO0yUKW94+bqT8ElhPnv2EQHUskEGq3pIJ5e18IXzhVl37GN7GLIljIV
        fn+C4S2A/2+j4Hz7ncvBSjTWg8n0V74=
X-Google-Smtp-Source: AK7set9Hr1CsB7KOyAPj3y4HnJPdhMyZYh/z0MyV3GosAUk17R1xIVZpqcP1bA99mE/OASa74ZbcFA==
X-Received: by 2002:adf:f883:0:b0:2c7:3f9:7053 with SMTP id u3-20020adff883000000b002c703f97053mr13373992wrp.52.1677291965379;
        Fri, 24 Feb 2023 18:26:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z3-20020a5d6543000000b002c7b8a0c423sm437451wrv.0.2023.02.24.18.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 18:26:04 -0800 (PST)
Message-Id: <b8aa14350d3411f63d6f02c2e2a857fd342cd8ff.1677291961.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1149.v2.git.1677291960.gitgitgadget@gmail.com>
References: <pull.1149.git.1677143700.gitgitgadget@gmail.com>
        <pull.1149.v2.git.1677291960.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 25 Feb 2023 02:25:52 +0000
Subject: [PATCH v2 03/11] dir: mark output only fields of dir_struct as such
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

While at it, also group these fields together for convenience.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/dir.h b/dir.h
index 2196e12630c..e8106e1ecac 100644
--- a/dir.h
+++ b/dir.h
@@ -212,12 +212,6 @@ struct untracked_cache {
  */
 struct dir_struct {
 
-	/* The number of members in `entries[]` array. */
-	int nr;
-
-	/* The number of members in `ignored[]` array. */
-	int ignored_nr;
-
 	/* bit-field of options */
 	enum {
 
@@ -282,14 +276,20 @@ struct dir_struct {
 		DIR_SKIP_NESTED_GIT = 1<<9
 	} flags;
 
+	/* The number of members in `entries[]` array. */
+	int nr; /* output only */
+
+	/* The number of members in `ignored[]` array. */
+	int ignored_nr; /* output only */
+
 	/* An array of `struct dir_entry`, each element of which describes a path. */
-	struct dir_entry **entries;
+	struct dir_entry **entries; /* output only */
 
 	/**
 	 * used for ignored paths with the `DIR_SHOW_IGNORED_TOO` and
 	 * `DIR_COLLECT_IGNORED` flags.
 	 */
-	struct dir_entry **ignored;
+	struct dir_entry **ignored; /* output only */
 
 	/* Enable/update untracked file cache if set */
 	struct untracked_cache *untracked;
-- 
gitgitgadget

