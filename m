Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B828C7EE25
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 12:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbjFLMyk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 08:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbjFLMx1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 08:53:27 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7557810E0
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:17 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-307d20548adso2919467f8f.0
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686574396; x=1689166396;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c24uSQ9nKgDHUqXbXwvgV+/kOTkn9VdgClatDZCr/fs=;
        b=Qun4rw/N9WXDjwRq+j1Ak/Xtddvx8Tm2DnIc9/W61QyKozxo/nGpPmvKiT1QMWDmPd
         OJi1Mz3z0M40N3h5UpWkYF7wtQz9vBJ1HPFmFxFyQ6pOG7GuSN98mZz1Sva+It7zovXc
         NNm8qqGX52CBpBQ5RkM2q9k64QvOtheEr7oehuZRMkO7xC5/NGwg+da3WGlanmlF6ffV
         jjK6i4Ui07cfiNTVLIJLEeUj1ZcVpr9X4av/x/VDJAH31JTzZy8/k0058p2RUadE4Hct
         Q5DJy6pSppabTYWU+TzPy018InbbuJx6PvGgkgp/vGiWyY5w07ix4mHscIQqwsU45m+T
         0oQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574396; x=1689166396;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c24uSQ9nKgDHUqXbXwvgV+/kOTkn9VdgClatDZCr/fs=;
        b=Dg1TujdmO5afaXiklXpMwwVvwpy61DoKZ5CxWYZ9TRu5A/ohJ6P76wVGpQmyntJZit
         YDkqF4YQ/XEp7R/L14/XkIa7TUVM+3Ia/pTA4CzhBHhk/OY+m39vy6E4/4Zqv72psFbd
         hElYaJYPxvKgPRVHYYI2HRaRykTIMLhq1mAzaivsZ6BAYPgoZNztqJBAx+Q/Dqweij20
         knDHZd4aX16VCC+xhuibm+uEpLfNFBEH26YzJXSwnBDwb12IEKefqeYR5E/i2m08T246
         Pb1iF6E7PBT2DzB/XfYPHAc9GiWWTWfeEl7j0YY1yBSD0FFl/pxL7ob4q1rdTkUoiOMa
         ba1g==
X-Gm-Message-State: AC+VfDyCcmOz7VPiMban/CHqn6qfLp8IHzTJHQiwqaQIAXwoyu7/O9hQ
        skIpABe7CataWaB4BnbAM42GO2T69y4=
X-Google-Smtp-Source: ACHHUZ5nd0X/ittpf5dp++14rDXSwNJcaerKKtRDXgpg8fnxn2F8FpxzvaBQZQj/td5FX7W4mOD2Vg==
X-Received: by 2002:a5d:5088:0:b0:30e:3d53:7e5b with SMTP id a8-20020a5d5088000000b0030e3d537e5bmr4704876wrt.57.1686574395700;
        Mon, 12 Jun 2023 05:53:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s3-20020adfdb03000000b003047dc162f7sm12457070wri.67.2023.06.12.05.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 05:53:15 -0700 (PDT)
Message-Id: <da2cc42cbd4d6085079e1bc2152e4503072bef90.1686574374.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
        <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jun 2023 12:52:53 +0000
Subject: [PATCH v2 25/25] diff.c: mention completion above add_diff_options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Add a comment on top of add_diff_options, where common diff options are
listed, mentioning __git_diff_common_options in the completion script,
in the hope that contributors update it when they add new diff flags.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 diff.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/diff.c b/diff.c
index 3c88c37908d..64c93c0f0e2 100644
--- a/diff.c
+++ b/diff.c
@@ -5491,6 +5491,10 @@ static int diff_opt_rotate_to(const struct option *opt, const char *arg, int uns
 	return 0;
 }
 
+/*
+ * Consider adding new flags to __git_diff_common_options
+ * in contrib/completion/git-completion.bash
+ */
 struct option *add_diff_options(const struct option *opts,
 				struct diff_options *options)
 {
-- 
gitgitgadget
