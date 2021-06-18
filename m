Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C07C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 20:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CCD961284
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 20:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbhFRUdR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 16:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbhFRUdO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 16:33:14 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD1CC061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 13:31:05 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so10946936otl.3
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 13:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OtoIKwAkT66XRKBPXvKRN0Azn+T9eWSZ2Zg428wY4wQ=;
        b=b0NCI7QnIWwW8zp/s2zR9qR+pqY9xaf97QUXnhcHLN09nvnMsrftqqHHzawJE6vDmn
         rQZcZBtqRidzWlCKndCbJEGrkS3hstjSVM3X6KecRVV06/btHBYZoE9bC+Ye/lf8tdHC
         36E5SiFcO48ASju1C6ixq+uq8aF16zK59IZCjIAll/ccfg0VaedSMiGHrsCZH0eXaHZl
         NWeMLAA8E7cLWLUD/xvuvTODHXh5vUG2WxuPzckF5rvFOZmTkv2rH8Nj/tle0B3D0DHg
         548o2JCF3L6rHoUBv+1yXRnoEeg/0T/BZy+LQ2ZzRA4Yw0F/O+JGYUlIIjZyebvui+4W
         P2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OtoIKwAkT66XRKBPXvKRN0Azn+T9eWSZ2Zg428wY4wQ=;
        b=f4xrchg5n2uD9S4jjxPbEuie9rEhJtS9a1PPgIlZksmSVmkOd7yZZRopgoyXn4rgdS
         3ia/d381voCMz9usNAScqjAiRpBdLcVaSeiKFGsX3j2KoP6GguxAFztUbR96+bJaGmxQ
         kT/JfDFcUFLtCFZ1+Nj2SE7f1V8IboRldm8o/AfbIPUGZjMp2mzkRF48v/bx+4Erfu9X
         snWHGkONXmJmYyKNcIesqs4pN+ZZlvAxGRhPLPuZFyPiyHViLVLf0lJqQtGjdZwuiNOW
         727T9Wut0COz9v7R+It0tmzcBQKGbQSwg6h3Ne8vtFCq4xvKa6f5sM0LDzLyN5odArA0
         rGbg==
X-Gm-Message-State: AOAM530v3aCmWoND6/d2ePnEBa2v9kIij7Qel5Qio/3GV5tkRIVZGF48
        1GpESms9MCGJ3fQ7RbkOx7IhETpsvnJ1RQ==
X-Google-Smtp-Source: ABdhPJwP+Dej6medo6thzYvUKRKGDEyMgJulAVbdRyLopnmT7Jvr86EP4VVH2JhOWIFhTn4/gaimlw==
X-Received: by 2002:a9d:7a89:: with SMTP id l9mr11340938otn.124.1624048264293;
        Fri, 18 Jun 2021 13:31:04 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id 16sm2225641otm.57.2021.06.18.13.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 13:31:04 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [RFC/NOPATCHv3 3/4] doc: use XML-style escapes only for HTML and XML
Date:   Fri, 18 Jun 2021 15:30:56 -0500
Message-Id: <20210618203057.790320-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618203057.790320-1-felipe.contreras@gmail.com>
References: <20210618203057.790320-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <sandals@crustytoothpaste.net>

Additionally, we don't want to use XML-style escapes for the litdd and
plus macros, so let's only use the XML-style escapes in HTML and XML and
use something different for our man pages.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index d3103c3dde..53ef100a7a 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -183,12 +183,15 @@ ASCIIDOC_HTML = xhtml5
 ASCIIDOC_DOCBOOK = docbook5
 ASCIIDOC_EXTRA += -acompat-mode -atabsize=8
 ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
-ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
+TXT_TO_HTML += -alitdd='&\#x2d;&\#x2d;'
+TXT_TO_XML  += -alitdd='&\#x2d;&\#x2d;'
 DBLATEX_COMMON =
 XMLTO_EXTRA += --skip-validation
 XMLTO_EXTRA += -x manpage.xsl
 ifdef USE_ASCIIDOCTOR_MANPAGE
 TXT_TO_MAN = $(ASCIIDOC_COMMON) -b manpage
+TXT_TO_MAN += -aplus='+'
+TXT_TO_MAN += -alitdd='\--'
 endif
 endif
 
-- 
2.32.0

