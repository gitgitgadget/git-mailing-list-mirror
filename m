Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87989C001B0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 21:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjHJVSd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 17:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjHJVSP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 17:18:15 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677582D5B
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:18:13 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3180fd48489so992938f8f.3
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691702292; x=1692307092;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgOZP2UTxk6qof7UeF3G3H6T/61SdqkS7V9hwZKLdag=;
        b=K0maW9Zc+a7SGOCUs9R790FsgNiKm4tcMOrfI4yEq9egFTtA8JV26Y9lFlqrUF3Gmp
         /Kh+vhltXbieMA6ApqYDm5S4U1FfYQLNdyvxPjfrYOSn2qqOmuBditNFUqn6KxTGOgXu
         Pwn2iNq97g44CzJBoyN++DLyFOBCvuRm0+iW9DoeYLP2ftVQIMJiRV+IsVhF2iJS6eZ1
         u6RDM/F7XY/Y9dhrUUEN+g9XiiixeNatOOCl+uNIyqMvc6ILBAoN/3uXsejZDOrAd+IR
         5CGr8mpXjLFC79krJWbXs+16FGCF61YFI0uHGleBfs2UzjLjNsaGkhFHtW4fKsp3WhKv
         vNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691702292; x=1692307092;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgOZP2UTxk6qof7UeF3G3H6T/61SdqkS7V9hwZKLdag=;
        b=eJEIwRjyWSZjPJW0VeYYn/E6t8Dq8uAiADK3rE7tPtQspj5aDQb8+YdguGzACCdnKB
         OU9JksNo3xj4AOeP73yXA5oLBraZ1EsN+60PiPhpbVuNyE3vtuaIw03tGMlBTTrTi5g7
         8pvC2rH5MwlZzP/dnB7/oocR3kl8yyFzr3K104g8VVsTSlWblXZ7Abu/CnEryaK1V4WT
         T6+IqLV+mRm5lawEaMAkyk+uOaBqBTUIWbyYVGuyDnlEk8G5rJuZXDBrEkmHyZ3R6k69
         Ntnxp3JIjIXg2fBC4O9SxpledJJbBZJk+CPh60EuYJ1JrVkNnpSu7sWP3L/wc10RPWbp
         gv0A==
X-Gm-Message-State: AOJu0Yy4NMctblMVzs2Zd7MwS7CNtyXvxsc5Es98PZQKoOruBtMkMwOS
        rRYzV8a49E6enew79Dqdvw1HXMJ58D4=
X-Google-Smtp-Source: AGHT+IHoaf/o1lHWOBuY54Tc8qjMsX0dTk67+SxKLbHJNspFLAtCU/u1Ar+uf5Rf2b6aue7rhjMIgA==
X-Received: by 2002:adf:f30b:0:b0:317:5dca:895 with SMTP id i11-20020adff30b000000b003175dca0895mr2912058wro.71.1691702291762;
        Thu, 10 Aug 2023 14:18:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d10-20020a056000114a00b00301a351a8d6sm3201474wrx.84.2023.08.10.14.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 14:18:11 -0700 (PDT)
Message-ID: <66087eaf5bd2abc416628cdcf166b8bd7e9cbf2e.1691702283.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
References: <pull.1564.git.1691210737.gitgitgadget@gmail.com>
        <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Aug 2023 21:18:02 +0000
Subject: [PATCH v2 12/13] trailer doc: separator within key suppresses default
 separator
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Linus Arver <linusa@google.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index a288ff111cb..25433e1a1ff 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -255,8 +255,8 @@ trailer.<token>.key::
 	but this can be changed using the `trailer.separators` config
 	variable.
 +
-If there is a separator, then the key will be used instead of both the
-<token> and the default separator when adding the trailer.
+If there is a separator in the key, then it overrides the default
+separator when adding the trailer.
 
 trailer.<token>.where::
 	This option takes the same values as the 'trailer.where'
-- 
gitgitgadget

