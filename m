Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336EACE7AB8
	for <git@archiver.kernel.org>; Fri, 22 Sep 2023 19:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbjIVTvL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Sep 2023 15:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjIVTvB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2023 15:51:01 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2991B4
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 12:50:54 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-405524e6769so1667235e9.1
        for <git@vger.kernel.org>; Fri, 22 Sep 2023 12:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695412253; x=1696017053; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ulgQYUGi+JBz8qvi42GHcPiDQBz2Gpnh8r/yTU3Dk3Q=;
        b=DMK4ncxC2eUQ/Pd1fewf05tC4d1M1O4HAim/Q8tUaGx4QzH0d4SO6AHDtNvsKziVN2
         MlyyaP1d3Tcj/qgSQxtFgVaxVWNjvQeDR6pm2J2UYtJzMA/6A0dprFT3YVVcDgtacXMz
         up+xp6hck3OwuvFGTQ0T4EcWEEcdG7OQ24Lz3cJb4H3PvjcV0LLDsOov95UuT9a8AxcT
         9xg7/EjcQJNzthlUOWWRnlEOaXllAevkpnIrL/Fh8sAGMGHRwK8BcOmh97h5qye6OkFR
         Z8V6dOwu8L4XVpkkC1kgi/0rOOt+xkrfL9kD7H5MU3xYVN8ij41CSZu0SjGQBAxJxnSQ
         brTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695412253; x=1696017053;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ulgQYUGi+JBz8qvi42GHcPiDQBz2Gpnh8r/yTU3Dk3Q=;
        b=VW3x0mpGqdhUQVmBUK+KbKI6M/tEBR9amcxfkacCdvheeNbFtRcWAmi7jwHlcd1j17
         FBe7k0RzjjTG2kag+MjJkZDYsEDdhkS3hIykeXsvxL11JHP8BZapLakNu/bdZh5ytg3l
         VX9r4hDUwsLs3izHURoXJW10OVqgnuMtlKQG1waKQCYEtGXE8LYRZkFwGGFLEuhhKfBQ
         pndDEkb3zxrBjJ/nD85Z55Ip0jtCM/z2a0lrg4famwtUej6OGiFp3EuJ/g+Dinb5WC86
         BzfvxA47lw7vsf7H04cN7Rn7cpP/TW4UeMrTcrEKEQ70LF79P6hj6QdSCJyWfiO0trD5
         O2xQ==
X-Gm-Message-State: AOJu0YwODKJd46BebRXht7h2nXaH/ywobisdKCccnrNJQCbBKpnSU8JA
        HUg+dAra/oAa/RAnLsaOp3G6rS0DMlc=
X-Google-Smtp-Source: AGHT+IEpdEmTqWTg/iDm/DigGWVsUaT9/UY1FJVTTjqh0LqPbx+41YYFEAgiI+8DhqW6DyGyy/2XzA==
X-Received: by 2002:a7b:cc88:0:b0:405:409e:1fcb with SMTP id p8-20020a7bcc88000000b00405409e1fcbmr449150wma.5.1695412252739;
        Fri, 22 Sep 2023 12:50:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c45c900b0040550c20cbcsm414506wmo.24.2023.09.22.12.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 12:50:52 -0700 (PDT)
Message-ID: <a784c45ed715c5066961f1566f2e91eb597d89a3.1695412245.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1563.v3.git.1695412245.gitgitgadget@gmail.com>
References: <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
        <pull.1563.v3.git.1695412245.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Sep 2023 19:50:45 +0000
Subject: [PATCH v3 9/9] trailer: make stack variable names match field names
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Glen Choo <glencbz@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Linus Arver <linusa@google.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/trailer.c b/trailer.c
index 9a3837be770..739acafc4e9 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1134,8 +1134,8 @@ void trailer_info_get(struct trailer_info *info, const char *str,
 {
 	size_t end_of_log_message = 0, trailer_block_start = 0;
 	struct strbuf **trailer_lines, **ptr;
-	char **trailer_strings = NULL;
-	size_t nr = 0, alloc = 0;
+	char **trailers = NULL;
+	size_t trailer_nr = 0, alloc = 0;
 	char **last = NULL;
 
 	ensure_configured();
@@ -1155,12 +1155,12 @@ void trailer_info_get(struct trailer_info *info, const char *str,
 			*last = strbuf_detach(&sb, NULL);
 			continue;
 		}
-		ALLOC_GROW(trailer_strings, nr + 1, alloc);
-		trailer_strings[nr] = strbuf_detach(*ptr, NULL);
-		last = find_separator(trailer_strings[nr], separators) >= 1
-			? &trailer_strings[nr]
+		ALLOC_GROW(trailers, trailer_nr + 1, alloc);
+		trailers[trailer_nr] = strbuf_detach(*ptr, NULL);
+		last = find_separator(trailers[trailer_nr], separators) >= 1
+			? &trailers[trailer_nr]
 			: NULL;
-		nr++;
+		trailer_nr++;
 	}
 	strbuf_list_free(trailer_lines);
 
@@ -1168,13 +1168,13 @@ void trailer_info_get(struct trailer_info *info, const char *str,
 							       trailer_block_start);
 	info->trailer_block_start = 0;
 	info->trailer_block_end = 0;
-	if (nr) {
+	if (trailer_nr) {
 		info->trailer_block_start = trailer_block_start;
 		info->trailer_block_end = end_of_log_message;
 	}
 	info->end_of_log_message = end_of_log_message;
-	info->trailers = trailer_strings;
-	info->trailer_nr = nr;
+	info->trailers = trailers;
+	info->trailer_nr = trailer_nr;
 }
 
 void trailer_info_release(struct trailer_info *info)
-- 
gitgitgadget
