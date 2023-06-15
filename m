Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B83EB64D8
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 02:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240986AbjFOCyU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 22:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242629AbjFOCyD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 22:54:03 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEA426B7
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 19:53:59 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30fb7be435dso3654510f8f.1
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 19:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686797638; x=1689389638;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HV9gWd+BdhnDBHe1pDK/e53XygDoCp4vblwLD4ouDAI=;
        b=QDL/erMk+FKD4J2BLDQQJ/fzP1MVwbehM8YhPvi44SRKmgw+tXgt8gRHte8bnhkB3C
         6TG9Mq11COf3M6DrX5BpmZJBpRLVgEPlMLVMTP6EZ6VSpDz++gYmsTi9HlFJB6LTPaIz
         pCnPlNtukZnNsjK2Ep2oWYXnN7wFDgWsxhEWEEPlZUCYdwTBpbAIl4mTMIFzacaXCI1o
         l3JzV1MFfFm6dxhyNep1/ovL1KiZkb49L4jKdYQ/+MqQImwfGHwZzKvgNGU1ZmpeiJDp
         m5U+c++AQI5ekUpO+5bojSN+bFixlglFD48t8LXcfY51MkWsipVZ3SnT127Qwjum26jH
         DwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686797638; x=1689389638;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HV9gWd+BdhnDBHe1pDK/e53XygDoCp4vblwLD4ouDAI=;
        b=XLBl2CNzSa5fC+gJZm+89iyV8T3vFJ/wrdvtpCnyweLsE/HFxbFd0hCji6nm42vZL3
         0q+/+a6qTChJJKXO+//EDhCnR9Vvu4Ygtj69Jtw8rRFoE8dWmrs/eGNGwWojFRjaM2h4
         dQMXjNTBoNVCgzys8yZF9ujCPJ9L30H3uGauVwPgyY2FTHl++7UXmRhyhFNmAEgNTvTQ
         sUOxbMi9mbQE1Nyqrw0NooRwuhm0F1MzxrtPM39M6Jbgvm/NYpQDNcsvoG3kUO7EiWCk
         X9sR50cASNVWEHb6WFmfQsNUXJjHFju9zfxCMqk+fV8AyVzhc7o0dDc3J9r+Xyx6kx0c
         MnvQ==
X-Gm-Message-State: AC+VfDxDrUbyL6AwTx7dx9NbBvzyL8Ltl1q0afT/PteMf8e0y9WgzpzA
        ik9aaGJ2MMa4CtV/kji1hTAPhy3lnvo=
X-Google-Smtp-Source: ACHHUZ6n0T4bwo64KO8410q/ZO1c1c77uAGfrC8ES4nBzYizERQ1/y8LpnipmP2EJe3WruElPEJGaA==
X-Received: by 2002:adf:eac6:0:b0:306:475d:92ff with SMTP id o6-20020adfeac6000000b00306475d92ffmr9403999wrn.3.1686797637959;
        Wed, 14 Jun 2023 19:53:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a8-20020a5d5088000000b0030f9c3219aasm17468629wrt.47.2023.06.14.19.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 19:53:57 -0700 (PDT)
Message-Id: <1a3755eacbe13fda2896659e115ff0692fe29cf6.1686797630.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.v4.git.git.1686797630.gitgitgadget@gmail.com>
References: <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com>
        <pull.1506.v4.git.git.1686797630.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jun 2023 02:53:50 +0000
Subject: [PATCH v4 9/9] doc: trailer: add more examples in DESCRIPTION
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

Be more up-front about what trailers are in practice with examples, to
give the reader a visual cue while they go on to read the rest of the
description.

Also add an example for multiline values.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 7e77cbb1cad..55d89614661 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -16,7 +16,18 @@ DESCRIPTION
 -----------
 Add or parse 'trailer' lines that look similar to RFC 822 e-mail
 headers, at the end of the otherwise free-form part of a commit
-message.
+message. For example, in the following commit message
+
+------------------------------------------------
+subject
+
+Lorem ipsum dolor sit amet, consectetur adipiscing elit.
+
+Signed-off-by: Alice <alice@example.com>
+Signed-off-by: Bob <bob@example.com>
+------------------------------------------------
+
+the last two lines starting with "Signed-off-by" are trailers.
 
 This command reads commit messages from either the
 <file> arguments or the standard input if no <file> is specified.
@@ -73,7 +84,12 @@ When reading trailers, there can be no whitespace before or inside the
 between the <token> and the separator. There can be whitespaces before,
 inside or after the <value>. The <value> may be split over multiple lines
 with each subsequent line starting with at least one whitespace, like
-the "folding" in RFC 822.
+the "folding" in RFC 822. Example:
+
+------------------------------------------------
+token: This is a very long value, with spaces and
+  newlines in it.
+------------------------------------------------
 
 Note that trailers do not follow (nor are they intended to follow) many of the
 rules for RFC 822 headers. For example they do not follow the encoding rule.
-- 
gitgitgadget
