Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED2EC7EE22
	for <git@archiver.kernel.org>; Mon,  8 May 2023 17:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbjEHR2Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 13:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbjEHR2B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 13:28:01 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4356EA7
        for <git@vger.kernel.org>; Mon,  8 May 2023 10:27:59 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f41d087bd3so14851045e9.3
        for <git@vger.kernel.org>; Mon, 08 May 2023 10:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683566878; x=1686158878;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yw2OBZrwzFzo9jeehJqb2CHuwbdEr31fSzsxTX3Z+tU=;
        b=Ym5ZnWAy5ZHdrmmSzYgUxx7N4XotboDSZ1GugaoQCIgRKnE4GCiGPvam9VnMqIJfCJ
         ZrsbgJgltMcHhCMw/TbkKtxlCp/qAM9UJUSPUZaSuuG6UhqyA6oalkFoiYZ8MKiAoUqt
         tvMb0vDfvaPIOoM7LFVFUFqIGmJy6SYI9QrjXzUyUNrcpncmUYrlxTifi4m7lnbsCNe5
         rD2iuttOEW1FD0dCFv0Cl5+PuAmjjMq2BhE135kh6RpRFMCqsxiBXquesfKw2R+msdyd
         WcmIx//BkDfEz0kkRrR4Ew2K6PZhFrNUatS2i146ElV6HL2kXdD6BmY8HSpAj/qrXsBp
         4Cbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683566878; x=1686158878;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yw2OBZrwzFzo9jeehJqb2CHuwbdEr31fSzsxTX3Z+tU=;
        b=eKYW8DDyaGfjhhAM8nvSp8HWvVCz+IkSQFoGPqwekqw5pgtGc42AMwQts1c389Ey5a
         fRdlI2fP7Gp+ZJeajfzCMylrLYmABX28MbOHqpQCip3+qjcMqeRR4HhHVFO70FviFEKf
         /OJwRdDL1vUKkxj8Ar+Y7fEsXNOfSm+P+PXq5Bb76zHhz/pepPM+11l9AJ1RhPzLrCIG
         qjkU6CF5sbe9adCYphgf5N1VaBBB6G1GIjSuA4+O0IcbwiCHXkevbax4RSI38RgpX6ee
         /KNJ3qImho8LrcNd/M7OdFm40/xYfsGSPIX0YSw4C1UMp2FoilL1JLyrnvsAkIGmHVlE
         7V6g==
X-Gm-Message-State: AC+VfDxv7NHIzTBAL1p+VGMyaiXDAjbbWJRbi9XdDBE1b5tCFZVFIOJM
        gTRRCNnk1XK1fpdIRd+Z2a0o/yR8TXc=
X-Google-Smtp-Source: ACHHUZ7dLspAFseOUaDUvC8d+ndD2STRsW83wrHVLOexV48/FPvskieWcU+zMVIWBf3aWzu4f73IFQ==
X-Received: by 2002:a7b:c8c6:0:b0:3f4:2220:28d5 with SMTP id f6-20020a7bc8c6000000b003f4222028d5mr3998178wml.29.1683566877983;
        Mon, 08 May 2023 10:27:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q1-20020a5d5741000000b003063b0c94c4sm11998223wrw.46.2023.05.08.10.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 10:27:57 -0700 (PDT)
Message-Id: <1ac58b0b07c21fe4494f5fbe5d4b0f9bc1a49ac0.1683566870.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 May 2023 17:27:48 +0000
Subject: [PATCH 09/11] doc: trailer.<token>.command: emphasize deprecation
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

This puts the deprecation notice up front, instead of leaving it to the
next paragraph.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 5ca758e363f..c9b82ceba34 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -234,7 +234,7 @@ trailer.<token>.ifmissing::
 	that option for trailers with the specified <token>.
 
 trailer.<token>.command::
-	This option behaves in the
+	Deprecated in favor of 'trailer.<token>.cmd'. This option behaves in the
 	same way as 'trailer.<token>.cmd', except that it doesn't pass anything as
 	argument to the specified command. Instead the first occurrence of substring
 	$ARG is replaced by the <value> from the trailer. See the
-- 
gitgitgadget

