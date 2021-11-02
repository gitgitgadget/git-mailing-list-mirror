Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FECC433FE
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 15:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA06560F70
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 15:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbhKBPsv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 11:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbhKBPsu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 11:48:50 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEDAC061714
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 08:46:15 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r8so21170409wra.7
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 08:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=As5zPCH7OBI2EjZyENdXYBbyh7weut22H3Fe+DIkjnk=;
        b=GnSfQf/eCejYXiUSe09GG2qUFSniNPZw5NN4AIJkPXyR/a520Vgc9FNnVpdNJ58ZZy
         O40fH/xnRaXk2aOW+0R6g4xI/TTYR1CZBPAx2gIZUUF6SDwavzQpfqLgoQ0uL16hvlsX
         njsQiG+xLzawiHSqPDZKSMZK60iR/q405voZa4E3JkL5SXU6DhfMAuSD+qdYmXAnk1++
         PKV+Sue3OupYERKQ5czYixf5hzXP0igPpe+Ri75VaGO2KWucnjwNVSezMeLLTuNpFBIB
         by7jHJmyGtpBYatXo0NIAuQIqHEjo+5nakLaitPYtgH8tNEunEeS2x+i0Kw9USzMW+WK
         mcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=As5zPCH7OBI2EjZyENdXYBbyh7weut22H3Fe+DIkjnk=;
        b=S96Jrn9lX2OQZ+GHSNZIA5XagSr7FlWjNGyh7GXdIb58ITk01Cl0H6i+9ExvEP2Q9v
         jWZd9eyKl7mSNAsTqJ50dGNhG/8MvDHZCiqbWrqcQBnjInAZaIfKR/y+VNDxuZup2mMj
         UwBSvSGHoxrx8Yt/sKIt2fx0uAYIvsWSBDyOIz1Ty4tbXo6OC3CqF8uS/RwJbk8Ag9L3
         1lfAdOI3bbCsDqSI2LIQ/ll4CkcrsiF0tbduDJyc37kdmcNlytlMJQTOgE4JwRn4UQfq
         bblGuHuBa/XKWR5TompNTBN6iHSzUcaBU762xFTX5K6jBae3nrJpYMCNUH28dv+JoTnb
         dSOw==
X-Gm-Message-State: AOAM532ioAmZO07dYm5AE5K4SSO/y6YpkOMyqG/IYWmfhTjFAW0/8k7+
        x7ckUzz8Tm3ZRQFw/jWbZTnx7OQSDVI=
X-Google-Smtp-Source: ABdhPJw19a6rjEsurXwl2goLCaaTCHnwWL+2o0MopPQVG6frFNZshfy/YDIomDhi5Q/TtNU3ez/xBw==
X-Received: by 2002:adf:ef84:: with SMTP id d4mr36314334wro.175.1635867973371;
        Tue, 02 Nov 2021 08:46:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f18sm18089287wrg.3.2021.11.02.08.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 08:46:13 -0700 (PDT)
Message-Id: <068f897b973b1f8889145f97c42fe6233c272dd5.1635867971.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1068.v4.git.1635867971.gitgitgadget@gmail.com>
References: <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
        <pull.1068.v4.git.1635867971.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Tue, 02 Nov 2021 15:46:04 +0000
Subject: [PATCH v4 1/8] test-genzeros: allow more than 2G zeros in Windows
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

