Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715A8C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 20:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5408260FE3
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 20:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhJ1UxJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 16:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbhJ1UxI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 16:53:08 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DF3C061745
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 13:50:40 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so6110883wmz.2
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 13:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=As5zPCH7OBI2EjZyENdXYBbyh7weut22H3Fe+DIkjnk=;
        b=Y3HAEiKpPTZGNrzBG0Np/f4vSTJe2Xh1Fq/Njm1wwHNlLy4i2mv5jOxxbT5adEb8Wf
         SDNIsIU/qyRrNBxA8kpdKGckFFcKjfCrUPTKvb6yfb3IAIYnvdxruStqUE5ttzUbCUJJ
         WpMHgAMvYvbyiEd4YFuIy/Ue3wrea78CvX4s8E4udpakXUU3hRCq7HjZWSiW9j/bTQ9o
         TNevcePbhiPfOvdlZREtVAxKY1wGOBgYfKmHqzJvxsWpyGT7i/7Sw8U154TaTFc2agZ3
         mh+9xbMkhqB1o01v0gjSG/3b/gLOUnQycZpS5jPQikI+ik5hLOShiW2IChQSog3wodRg
         EJPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=As5zPCH7OBI2EjZyENdXYBbyh7weut22H3Fe+DIkjnk=;
        b=ebugVbzYKc5TbWJxEYsPLJLzr+GCJZrLnumz9ZG+n+sdlbbW9/w+EVsH04XpKaF9ts
         QfnPhA3+JakMSff0shh/egZKK/tBtHg1IK2GTbt6YEPefN68GMYyuxbkGYO17x/M5nLw
         Rxpvpe9ngC2ub1j8fbZQZLekcHW4LUOMqSAEMJp1L64MZgdyEi4N3aulFvDFm3RfbFnv
         1nUApriHBHqLL587cjTjZLw2lGXYqc8Sy46AYRnh5IXp/HnWWKt49B9NTijEW9VHNCAt
         3LxjVpFmzxTL1F1EyAecOwAchg3rs7TEF5ZSPJ4EvdcwG1xEbbbzmtQBwwMpH3X7LiLG
         xNRg==
X-Gm-Message-State: AOAM532zVa7/AZIHNqun0SAzLPlG6PsPcMNl961xcIS9XxBOlYCaf+ha
        EWMEFZsndfgegfrkXi0b7qo/WKwb1IA=
X-Google-Smtp-Source: ABdhPJyyK+4a6kvQASmzkKuBmZDY28c1YbaNuIYzEtC+kijPplKOfoJIYnzWKOaQFf/pZPzZu4B5SA==
X-Received: by 2002:a05:600c:2205:: with SMTP id z5mr15468135wml.133.1635454239616;
        Thu, 28 Oct 2021 13:50:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x21sm7042020wmc.14.2021.10.28.13.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 13:50:39 -0700 (PDT)
Message-Id: <068f897b973b1f8889145f97c42fe6233c272dd5.1635454237.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
References: <pull.1068.git.1635320952.gitgitgadget@gmail.com>
        <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 28 Oct 2021 20:50:31 +0000
Subject: [PATCH v2 1/7] test-genzeros: allow more than 2G zeros in Windows
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

d5cfd142ec (tests: teach the test-tool to generate NUL bytes and
use it, 2019-02-14), add a way to generate zeroes in a portable
way without using /dev/zero (needed by HP NonStop), but uses a
long variable that is limited to 2^31 in Windows.

Use instead a (POSIX/C99) intmax_t that is at least 64bit wide
in 64-bit Windows to use in a future test.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/helper/test-genzeros.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-genzeros.c b/t/helper/test-genzeros.c
index 9532f5bac97..b1197e91a89 100644
--- a/t/helper/test-genzeros.c
+++ b/t/helper/test-genzeros.c
@@ -3,14 +3,14 @@
 
 int cmd__genzeros(int argc, const char **argv)
 {
-	long count;
+	intmax_t count;
 
 	if (argc > 2) {
 		fprintf(stderr, "usage: %s [<count>]\n", argv[0]);
 		return 1;
 	}
 
-	count = argc > 1 ? strtol(argv[1], NULL, 0) : -1L;
+	count = argc > 1 ? strtoimax(argv[1], NULL, 0) : -1;
 
 	while (count < 0 || count--) {
 		if (putchar(0) == EOF)
-- 
gitgitgadget

