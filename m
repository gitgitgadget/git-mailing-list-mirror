Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41962EEB57F
	for <git@archiver.kernel.org>; Sat,  9 Sep 2023 06:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbjIIGQd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Sep 2023 02:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbjIIGQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2023 02:16:27 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE291BD3
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 23:16:23 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-401b5516104so29327205e9.2
        for <git@vger.kernel.org>; Fri, 08 Sep 2023 23:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694240181; x=1694844981; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0clGRogIIw7XeXpgA3wV1NJMDeWtrzEiRUflXCU6ms=;
        b=a8MRNz3Xm0faz+ILIcGEJ7BTljjTcjAH6SX7cso6y1sRiY4O5GqsmbZ9orCcAIMZ3X
         IO6QKwlULmuCXXQp9MDJRapnJeN61OEGNSRqWQ++pz1GEfqutyDeezkddOye5jS70JYS
         IRs4nRdzsFcZvJz/sdNwbvddTEgN7II2emjGZb5UnTjEvLn2JjRrYFFFDR5w4rx9CB9E
         YC1Op6J9IphQxHtDAciOmat1swTmyx8hGFFUf+94rVBwLx2VxO1Fpd6AACdrlyjnR8hW
         X8RioeKjthsZAyLuVSUkT8+wIcTfeUj7jgzKZn/OB6oMdnL+XibZosYG7AOggsXZ7if2
         lpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694240181; x=1694844981;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G0clGRogIIw7XeXpgA3wV1NJMDeWtrzEiRUflXCU6ms=;
        b=hnk0rMiffAOCG6vrRRRNiFYtxvLNpwEJJXB5VD3I2kqkP4v6gkB8XEbnsUeZxvsf0s
         HMo9VDXUFHkI1B5c3EFG8ppgUsyVmUet6kOkcEJhHm0MvouIHdsnR4JL+WNPhmOkEm8+
         HPX6A3hM4wBgZ5uwfGdbFs5OUyEOi4nJtFjs846e6tmwHyowY5F7Kv7t6EmbEhMKi/ms
         IpikWAJ2qtNFD4tRoi2qdwF0FFIOeahZNWUbDmdNHt4t4jlsmWBa3AUlNby0LqUV6LAR
         mytURVy2joXhwTORO5K0QjwtmAPbDeMgitkG1clV59sJSE49sl1S6l28hj192fVIgyym
         m0pA==
X-Gm-Message-State: AOJu0YwdAjg9Pd6HTht7+dl+sdL6Jfcm3vSsGD7qo2TTR0QcOxlfZsTm
        pQ4fR5mDToc331Kkk1lPi2RsP7wDH44=
X-Google-Smtp-Source: AGHT+IFdT0zwBqkUR7aWBmOf0r7gUKF+VemEmvT2wqDE/C1BuqY4yp82VQgJU+/DpnuQQ91hocVNdg==
X-Received: by 2002:a05:600c:3b1f:b0:401:b204:3b85 with SMTP id m31-20020a05600c3b1f00b00401b2043b85mr3436554wms.36.1694240181664;
        Fri, 08 Sep 2023 23:16:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c249200b003fe1a96845bsm6922256wms.2.2023.09.08.23.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 23:16:21 -0700 (PDT)
Message-ID: <f5f507c4c6c4514af7dca35e307ca68e72435afb.1694240177.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
        <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 09 Sep 2023 06:16:15 +0000
Subject: [PATCH v2 4/6] trailer: teach find_patch_start about --no-divider
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Linus Arver <linusa@google.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

Currently, find_patch_start only finds the start of the patch part of
the input (by looking at the "---" divider) for cases where the
"--no-divider" flag has not been provided. If the user provides this
flag, we do not rely on find_patch_start at all and just call strlen()
directly on the input.

Instead, make find_patch_start aware of "--no-divider" and make it
handle that case as well. This means we no longer need to call strlen at
all and can just rely on the existing code in find_patch_start. By
forcing callers to consider this important option, we avoid the kind of
mistake described in be3d654343 (commit: pass --no-divider to
interpret-trailers, 2023-06-17).

This patch will make unit testing a bit more pleasant in this area in
the future when we adopt a unit testing framework, because we would not
have to test multiple functions to check how finding the start of a
patch part works (we would only need to test find_patch_start).

Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/trailer.c b/trailer.c
index b6de5d9cb2d..f646e484a23 100644
--- a/trailer.c
+++ b/trailer.c
@@ -812,14 +812,14 @@ static ssize_t last_line(const char *buf, size_t len)
  * Return the position of the start of the patch or the length of str if there
  * is no patch in the message.
  */
-static size_t find_patch_start(const char *str)
+static size_t find_patch_start(const char *str, int no_divider)
 {
 	const char *s;
 
 	for (s = str; *s; s = next_line(s)) {
 		const char *v;
 
-		if (skip_prefix(s, "---", &v) && isspace(*v))
+		if (!no_divider && skip_prefix(s, "---", &v) && isspace(*v))
 			return s - str;
 	}
 
@@ -1109,11 +1109,7 @@ void trailer_info_get(struct trailer_info *info, const char *str,
 
 	ensure_configured();
 
-	if (opts->no_divider)
-		patch_start = strlen(str);
-	else
-		patch_start = find_patch_start(str);
-
+	patch_start = find_patch_start(str, opts->no_divider);
 	trailer_end = find_trailer_end(str, patch_start);
 	trailer_start = find_trailer_start(str, trailer_end);
 
-- 
gitgitgadget

