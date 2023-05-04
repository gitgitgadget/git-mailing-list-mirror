Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB48C77B78
	for <git@archiver.kernel.org>; Thu,  4 May 2023 03:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjEDDzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 23:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjEDDzl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 23:55:41 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7135D2108
        for <git@vger.kernel.org>; Wed,  3 May 2023 20:55:22 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-18f4a6d2822so8418933fac.1
        for <git@vger.kernel.org>; Wed, 03 May 2023 20:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683172521; x=1685764521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BRWoZFdkHc2QmV2f/hlTnzUgPlZfn9H2Z04FxEJfNA=;
        b=TNRxmGrGHYv3jFU9yK5UrVoEOVHvifKNdEkskqwBfniSxfYUHCrsdkFX8VJMdvoW1F
         LKgUPNAQQ+sQlrOvrHYpDvaaswThAi3DeY8FnOkbBd41b6NHoLLAsfPnvustyR6AWKkU
         9CL7VhcpiYRUZrbbIHUm6ZUswrNrv42ZOCJAtBIKIiEFYVDTGg6mZIbpmOBLy+daQQBG
         ilLewPZx5eGEKlDzz0cZRpmYRdjbP8Cz2NIOtvsAZP9qDNDYB+cAIcN65yscyGRhsC6J
         nUgJlTY4S2/vXdaZ49WuAMmdIfB8EGzdaMEH5waIPwgZVXKwL3XGRb2IRxu7FX+x11zp
         insQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683172521; x=1685764521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3BRWoZFdkHc2QmV2f/hlTnzUgPlZfn9H2Z04FxEJfNA=;
        b=DR5gi0DdSRBmobH3MmaCRkKXI51M3zLiaH00zvhdiU9ooGMbWs4miACwaG7OwCjBUL
         bqT6A198XkYAgXCtDkK0q1BqBBWzYaWz0miVz6vzgP9g0D4e95PmGWmgsCBKvxgjc8qE
         JLylbdM1Xk8o/lQDay1IIJh1WG5RWPazhFNRzhJpG3cl4Hqum8xMZsRUxdY7ZVC64JOp
         0WZ7GZo7SkEzqFE+3YtoZGYV1+a0835AEDGsHqNjZt/DnIFrkolQJUKBKipqgSpwytpB
         VXWn7bEPT+6CW3mvyr01m/cuOkL9oD+QWA70942X1hLRNl26kHV6MWCBSJua6FDHslfF
         mtoA==
X-Gm-Message-State: AC+VfDx9EWjGTlYPOyPWpeN+gfW5lphSAODWAkbbeL0so4hWld7oj8f4
        PYE/EcqlOxpbpo2F1Ht3yKQxaoxCwms=
X-Google-Smtp-Source: ACHHUZ7Ifg4RouBPbv3orK6rdwB+uOuIig9vn98vXZ4ndhQc5ZdSff7vTPu6FlZAvef96JnPf5K3TA==
X-Received: by 2002:a05:6870:738d:b0:187:f238:3db with SMTP id z13-20020a056870738d00b00187f23803dbmr414862oam.19.1683172521455;
        Wed, 03 May 2023 20:55:21 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id r16-20020a4ad4d0000000b00541cb3cf2d2sm2914956oos.13.2023.05.03.20.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 20:55:21 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] doc: manpage: remove ancient workaround
Date:   Wed,  3 May 2023 21:55:17 -0600
Message-Id: <20230504035517.329765-3-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230504035517.329765-1-felipe.contreras@gmail.com>
References: <20230504035517.329765-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This was added in 9b6f84d2c2 (asciidoc: add minor workaround to add an
empty line after code blocks, 2008-10-30) in order to deal with a bug in
docbook-xsl 1.72, but it was fixed in 1.74 in 2008.

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoc.conf | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 60f76f43ed..7e3de98cd7 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -30,27 +30,6 @@ ifdef::backend-docbook[]
 {0#</citerefentry>}
 endif::backend-docbook[]
 
-ifdef::backend-docbook[]
-ifdef::doctype-manpage[]
-# The following two small workarounds insert a simple paragraph after screen
-[listingblock]
-<example><title>{title}</title>
-<literallayout class="monospaced">
-|
-</literallayout><simpara></simpara>
-{title#}</example>
-
-[verseblock]
-<formalpara{id? id="{id}"}><title>{title}</title><para>
-{title%}<literallayout{id? id="{id}"}>
-{title#}<literallayout>
-|
-</literallayout>
-{title#}</para></formalpara>
-{title%}<simpara></simpara>
-endif::doctype-manpage[]
-endif::backend-docbook[]
-
 ifdef::backend-xhtml11[]
 [attributes]
 git-relative-html-prefix=
-- 
2.40.0+fc1

