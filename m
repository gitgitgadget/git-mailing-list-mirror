Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF383EB64D8
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 02:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242535AbjFOCx4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 22:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbjFOCxz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 22:53:55 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0653F26AF
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 19:53:53 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31110aea814so736922f8f.2
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 19:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686797632; x=1689389632;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKnHkWHPlF4MPLsuzOkdEOFk4KoJE6veAx4v7vS/i/8=;
        b=JPlZAASeyBO/51qwuMlrI2vviVYkYj6ZbG3mspeYK+RhFLhk6ogM5a9909DsMz6ul0
         TuRGPP7mPNRBNGOTK4S1upKHzEkp4p5yQ/qmagDCY8Q7rRK1JBTuaO0A0hZD1Tf3i42d
         K6OApTQwjvdRBbAhpkgEfVM05XlwsQqDPWB061qt4gPj5KG4ApEmI8By46YN0XkDbcDk
         lNa0wZ4wgBN44jkjcD+Fv3TLb+EagTZkik5IOmbFVmUPmZ7OokJLAB0aV7xfW1m9GkXj
         7WXL4hGVFhSxS53BT6jyRmnfje9amgodixxy7Xkv8hbESQUfW3RW/n1VxSOxBUWIE6Mq
         EDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686797632; x=1689389632;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKnHkWHPlF4MPLsuzOkdEOFk4KoJE6veAx4v7vS/i/8=;
        b=aN8LEcEGL4nNlmphvgr8wdx6TtpD3muNu4OYjDZugDGWEI7ieWqtN3h6YxeUSlRboQ
         Sl5+UgQxQCqnk0PHaELVqF9D0ve9TMI6OvXOHAFD7J0KP/ERJP+hT56b11pQR/nISXt+
         gdEBRK+Ya7d2A2RmQKAWVR86rtVZJp94CU8lOVxE/p0IqwXybsTanOPobVBeWkiDl08P
         WRlemyDitCLX9an7hVjZ1qWWCTRP1PV/ugF3fQptE6dtG95WSUYwZyfZl/VZ9MfzgB7L
         NL0/hjamcafM7Mw+0ql1MOtl+OyYzty0Zs6t4d4K8lSVvYM77udxkktqKsdGQ6T2Uz3C
         HRug==
X-Gm-Message-State: AC+VfDy9HTovPwkMecEYBH7/o1yriskQ8iSM46lnNxAfklDMfkEi5JUM
        FHQsHy/VpYJ5p4DBJ6O2L/pMT04iDcQ=
X-Google-Smtp-Source: ACHHUZ7tUlc21tASm/fdj3Q1kHidoMM2oHcU6ugKDQsmXbdoq2oJ5x4u1AprrF2omREujEedEUfxnA==
X-Received: by 2002:a05:6000:1089:b0:311:143c:7bd1 with SMTP id y9-20020a056000108900b00311143c7bd1mr575665wrw.49.1686797632049;
        Wed, 14 Jun 2023 19:53:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h14-20020a5d6e0e000000b003078354f774sm19582405wrz.36.2023.06.14.19.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 19:53:51 -0700 (PDT)
Message-Id: <7d504700b91c175c952a16f0d82e642393ce7c84.1686797630.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.v4.git.git.1686797630.gitgitgadget@gmail.com>
References: <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com>
        <pull.1506.v4.git.git.1686797630.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jun 2023 02:53:42 +0000
Subject: [PATCH v4 1/9] doc: trailer: fix grammar
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Linus Arver <linusa@google.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 4b97f812be8..35faf837892 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Help parsing or adding 'trailers' lines, that look similar to RFC 822 e-mail
+Parse or add 'trailer' lines that look similar to RFC 822 e-mail
 headers, at the end of the otherwise free-form part of a commit
 message.
 
@@ -249,10 +249,10 @@ for the same <token>, 'trailer.<token>.cmd' is used and
 'trailer.<token>.command' is ignored.
 
 trailer.<token>.cmd::
-	This option can be used to specify a shell command that will be called:
+	This option can be used to specify a shell command that will be called
 	once to automatically add a trailer with the specified <token>, and then
-	each time a '--trailer <token>=<value>' argument to modify the <value> of
-	the trailer that this option would produce.
+	called each time a '--trailer <token>=<value>' argument is specified to
+	modify the <value> of the trailer that this option would produce.
 +
 When the specified command is first called to add a trailer
 with the specified <token>, the behavior is as if a special
-- 
gitgitgadget

