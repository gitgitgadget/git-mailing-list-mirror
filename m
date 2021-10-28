Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABFBC433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 08:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96A20610C7
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 08:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhJ1I51 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 04:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhJ1I50 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 04:57:26 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E45BC061570
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 01:55:00 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id bm16so5055522qkb.11
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 01:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IJYOTYn5O1UDJ8kTxeTiYgjyDuwGAoxPbJbAc4xUQ3c=;
        b=JkVMfm81V0KBO0d0MKsc0DH+fV5XoLR9/Ru6Fs1rhGk+QPG1muANwXV1Si5KbZ8zbO
         2/iuEc5pukk3Tp/CUAAu5YTAnk0YI2wmzLvXewCzsPnstn0qdX7Y9JJPMDvK791VldtN
         lYuz/xgqAcsfr/PK+lzflmacyMWunz8VcXRpP2rXc+6yYXYBT+mawTIIw9fdkr91QuUo
         t1IYfSxPuN4G1u1/pUO5yom7csJk4Jz85R30ejMy7K3/xgOXMh9oTHtTFgfDFo1U0hRX
         N3fRnrmnKnFa5o3ygh7ivzoJGRfW8fZNB5HI59upiV3Ih7aJIVTKMgjO33OFA3kvbt0j
         a8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IJYOTYn5O1UDJ8kTxeTiYgjyDuwGAoxPbJbAc4xUQ3c=;
        b=COGk+Z1eFD+O0IetdSOTsGsBLZzRdkaypj6ot7sLXXDnjsYGflmY4XcZ/VfErzdi65
         mdDy4DKoYuVAIBzod+rJIfAj6ffK9JmJblE8HL98e2gs7EfF7S01EjsT1yf+23Uwuwgj
         RS8wDxRFRuH4hS+SsNlvMuEK2Wdv0yp2mi7Ch2cUMa12ervwHJs5QK+B0o+PKrnD5P2C
         sNS9k+IROGWcy/aqC+agqYKGZko8mG+4AihgLvpV99MffXxQFdmB7zkkOzXQO/C5soe/
         Q3jkvvp4tWFEnh0f3tPxwyTTvte1hXvFu7cHcwd3eBfxuEMGRpJxhn9/RRuyfazWmC8N
         a5bw==
X-Gm-Message-State: AOAM533AoTGQ0brTLBKr7MBLhhNcV4x3LFHbVE4VujEZevvdaiPL6LDL
        cSiiqlYZXVrhuv2B3REfQOJmqld9wtQ=
X-Google-Smtp-Source: ABdhPJwRopg8xmkFIYTnMd4rHh/4z4GSP6T6mH7pjLu2I5UHcOqA2r5rYcweYWO8nucdCl+OcYWYBA==
X-Received: by 2002:a37:464a:: with SMTP id t71mr2398721qka.361.1635411299153;
        Thu, 28 Oct 2021 01:54:59 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id s13sm1660572qki.23.2021.10.28.01.54.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Oct 2021 01:54:58 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     vtbassmatt@gmail.com, johannes.schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] helper/test-genzeros: allow more than 2G zeros in Windows
Date:   Thu, 28 Oct 2021 01:54:46 -0700
Message-Id: <20211028085446.78536-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.1155.gbdb71ac078
In-Reply-To: <CAPUEspi_nxpYzJOjJ0osRRLVQ42uPRA9=9eWp3NBtbpeVtJZng@mail.gmail.com>
References: <CAPUEspi_nxpYzJOjJ0osRRLVQ42uPRA9=9eWp3NBtbpeVtJZng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

d5cfd142ec (tests: teach the test-tool to generate NUL bytes and
use it, 2019-02-14), add a way to generate zeroes in a portable
way without using /dev/zero (needed by HP NonStop), but uses a
long variable that is limited to 2^31 in Windows.

Use instead a (POSIX/C99) intmax_t that is at least 64bit wide
in 64-bit Windows to use in a future test.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/helper/test-genzeros.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-genzeros.c b/t/helper/test-genzeros.c
index 9532f5bac9..b1197e91a8 100644
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
2.33.0.1155.gbdb71ac078

