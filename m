Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B89C2D0A8
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 09:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5D832371F
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 09:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeZN8tS/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgIWJjA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 05:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgIWJi6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 05:38:58 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EC6C0613D1
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 02:38:58 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id f1so6525162plo.13
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 02:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/OA852YvvEb3sow70b0eYaOPFRAhD5IR13DjJ1Pxp68=;
        b=PeZN8tS//JlwD9E83QgaLJom4+os4V4wC0lxaIZlKZcT3QG7DGgud+BUlgqO2R8RlN
         FBZvixF2IwM2KkOBKmOx0SJyLyeSkbh6IFPOAs+KP8ANP/ZBW/m+QkUPO1jwz8FV/+OO
         FihzmKL6L+58BvF5eo5mIV1sVEM9pDIPHmk8/xDFyCQ3XoKTsTxZiBJA7CE/TdfY1up8
         GFecZotJ0Tw8xMIk078BUCbzZQPsZ3qYWxUdAWETkzadi59f9t14RPjD1FuLW4CwXgIh
         ylq5V8PSw2n7g8CGSc0KuzE92zd3NTrGs4tffMr/gF0G9RLl4+ZJoC8DCvfcmVNaFkER
         28kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/OA852YvvEb3sow70b0eYaOPFRAhD5IR13DjJ1Pxp68=;
        b=Xu5nXlCoq/L/Ln52YgfvJHKdnFo1XtS4Si09Q+K1Cm0aoDM9eho9gZZZv/aOWV/EVg
         06VNiJ8FMwRf3oqtm0fB5GsF5C0Nj6XJukWaToXRKiMypDJa/Ap8z5lv09WlMsAQN6pa
         0XoOZ1aqceJfl4aFA/Fgqs/TyjdA0+V0IoF9QYtJVivVkzwYWAIeZADeo21mO3MDgCjH
         Tv0O3op9v0PtcAmXFrQASdWWmIMGOZaO0Kw+OSw6PrzjkhkzdqBnP4QBJy9oJgUnWvEY
         YH2oBRXx80QkWA2aJMrC2HkKEzFP8X9JARYbIcoMn/vOmpzw9CkNqu3jX5BqCjtP0kjG
         bHUw==
X-Gm-Message-State: AOAM533be+5L6qSI1atuw8wvAd/T4kDhQjzu8uBtuJb/sg9gBTbsovrx
        nxnVb5CKkajGdhCzv4mpilMGa9olutg=
X-Google-Smtp-Source: ABdhPJxNuyNUuv/ClaJ8NlwBZ3QlcbGgHnngVr1+1p7F9OpDvkE9eD2K1iCo4AVK9ZEBiVQwXWSRBA==
X-Received: by 2002:a17:902:fe0e:b029:d1:e5ec:28d6 with SMTP id g14-20020a170902fe0eb02900d1e5ec28d6mr8590275plj.66.1600853937927;
        Wed, 23 Sep 2020 02:38:57 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id gm17sm4564464pjb.46.2020.09.23.02.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 02:38:57 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Chris Torek <chris.torek@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: [PATCH v2 3/3] hooks--update.sample: use hash-agnostic zero OID
Date:   Wed, 23 Sep 2020 02:38:45 -0700
Message-Id: <784135549f2fd23a5135cb2b6c2c5ba525885814.1600853895.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.28.0.760.g8d73e04208
In-Reply-To: <cover.1600853895.git.liu.denton@gmail.com>
References: <cover.1600427894.git.liu.denton@gmail.com> <cover.1600853895.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The update sample hook has the zero OID hardcoded as 40 zeros. However,
with the introduction of SHA-256 support, this assumption no longer
holds true. Replace the hardcoded $z40 with a call to

	git hash-object --stdin </dev/null | tr '[0-9a-f]' '0'

so the sample hook becomes hash-agnostic.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 templates/hooks--update.sample | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/templates/hooks--update.sample b/templates/hooks--update.sample
index 5014c4b31c..c4d426bc6e 100755
--- a/templates/hooks--update.sample
+++ b/templates/hooks--update.sample
@@ -60,7 +60,7 @@ esac
 
 # --- Check types
 # if $newrev is 0000...0000, it's a commit to delete a ref.
-zero="0000000000000000000000000000000000000000"
+zero=$(git hash-object --stdin </dev/null | tr '[0-9a-f]' '0')
 if [ "$newrev" = "$zero" ]; then
 	newrev_type=delete
 else
-- 
2.28.0.760.g8d73e04208

