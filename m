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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3E2C04FF3
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72D4A61176
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhEUWbL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 18:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhEUWbJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 18:31:09 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFF9C061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:29:45 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so19411707otp.11
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vzi5E1pnutPnbX/jB18hiQvx2Ay2ZOUs5JyfprDkkfw=;
        b=uQtVoJw0evS/1L2LPixSLmpjEOjgTpT0jFvYpv0dG102P+1YbF87UX/dBVCwa6dIht
         ISCwTAheGp9NFYXtW2xsyKo9Nn2gXA0RMIj5GWzOEoj+oWx5uJXLODzWb5UHRoQnMZ7M
         7ex4efbyxXPZqY5X5BOmvx7mxG9OdMj1zOANFZ2NrpP40xRWKNuxCzUSJhxtDzWtyyzM
         gcDAxKjQ3FBPwfQyIe65j0akSPRCO4R43sdM46VvgdG346LoaIxDgQtvoM+a1YzR6u0j
         kzM5yQN0XURouRTG8zlAwnwG6000oXu7pmuclFc1XRqsHywsqpBzk6SB7Pfs86pCmue8
         UHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vzi5E1pnutPnbX/jB18hiQvx2Ay2ZOUs5JyfprDkkfw=;
        b=nUlh+mtYotm3p0yH0FRrPGaecWxJ1K+UrMmjtn+57HWE7VG7ch8Pq74mM8Tv+XrEPS
         JmY9l6sXh1RnEi5oar7hDl/MfsteNz0hf0KzbfrL1GVHRSdLRqdD0WABziACkySiw7v2
         r0VDijOQjGFwVdEndhuP66VnWDxrxvGVeC7nxGzV1fwvdTO7B+/Db6si7kLMhTeD8S0z
         7RLHUlbrXuL+uioSzkMDu8PnKWjJ8V7Fx+rJRuNP8RWnmX93YoFISEUGUBmTOLcDNrk6
         qvSbxjI1wNUwxXzOHaTDuSH6g4D9V5MGTNxtHB9OK0uKvTjxGJrn9uPJ/gqzJbSC6rlb
         SIWA==
X-Gm-Message-State: AOAM530Y5ZTd87q6vRneOw2UXYyOKh6umeEX0LyHtJW88xAZmYtdC5xJ
        JkgXalE1RDG/0WTJfdQSBAyTGI1bNVoJ4g==
X-Google-Smtp-Source: ABdhPJxZACMZgxKHg2co+Bz/6Bxi2CkoKcShtfuk21AsxmF3urhwWhuMf2OQrig2o4k03sNwmCGe7Q==
X-Received: by 2002:a05:6830:140c:: with SMTP id v12mr10187715otp.310.1621636184492;
        Fri, 21 May 2021 15:29:44 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id 73sm1039974oty.40.2021.05.21.15.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 15:29:44 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 1/5] doc: refactor common asciidoc dependencies
Date:   Fri, 21 May 2021 17:29:37 -0500
Message-Id: <20210521222941.525901-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210521222941.525901-1-felipe.contreras@gmail.com>
References: <20210521222941.525901-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 2aae4c9cbb..46d9b98dac 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -139,6 +139,7 @@ ASCIIDOC_CONF = -f asciidoc.conf
 ASCIIDOC_COMMON = $(ASCIIDOC) $(ASCIIDOC_EXTRA) $(ASCIIDOC_CONF) \
 		-amanversion=$(GIT_VERSION) \
 		-amanmanual='Git Manual' -amansource='Git'
+ASCIIDOC_DEPS = asciidoc.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
 TXT_TO_HTML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_HTML)
 TXT_TO_XML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_DOCBOOK)
 MANPAGE_XSL = manpage-normal.xsl
@@ -354,12 +355,12 @@ clean:
 	$(RM) manpage-base-url.xsl
 	$(RM) GIT-ASCIIDOCFLAGS
 
-$(MAN_HTML): %.html : %.txt asciidoc.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
+$(MAN_HTML): %.html : %.txt $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(TXT_TO_HTML) -d manpage -o $@+ $< && \
 	mv $@+ $@
 
-$(OBSOLETE_HTML): %.html : %.txto asciidoc.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
+$(OBSOLETE_HTML): %.html : %.txto $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(TXT_TO_HTML) -o $@+ $< && \
 	mv $@+ $@
@@ -371,7 +372,7 @@ manpage-base-url.xsl: manpage-base-url.xsl.in
 	$(QUIET_XMLTO)$(RM) $@ && \
 	$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
 
-%.xml : %.txt asciidoc.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
+%.xml : %.txt $(ASCIIDOC_DEPS)
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(TXT_TO_XML) -d manpage -o $@+ $< && \
 	mv $@+ $@
-- 
2.32.0.rc0

