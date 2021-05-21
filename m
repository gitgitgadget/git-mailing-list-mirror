Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C636C4707A
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67195613AF
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhEUWqp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 18:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhEUWqi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 18:46:38 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EE5C061343
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:45:14 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so19512619oto.0
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gfbHvtlRq11FJYnsvJy5U489QiIh3UR4mNbnDEZI4T0=;
        b=r0heu9HZ5SLsMFia3r+9pA3EYW9vLv1YP5YtNKvuN/63+pop05Yj129dAaCeLuY/t/
         b/FbFM+D5sOBriVaS+AnQJWrF6fP11gjZ7V68lG0OLCT6etQ0imAxSMbUX7r26V7JwLO
         lPYlHwB1vH/Mi4cKwHdEbhKCOukTB4Fgv6tkjb4HX5Pkj4esddiZf5rQv2RwJWnCTacF
         NjGDRRKzrTPpNVqd+cdf9KzPhr/bBmTsGcyXvPp7wtPx3SREf8yIExoQwEBkIXKHVbfz
         6SWGQmuH5dOAPFIm37w2dkOpBiUBAPzSp+eFP+3cQF0jTojhgCA/Lt5mFii6N7qGqh7h
         o3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gfbHvtlRq11FJYnsvJy5U489QiIh3UR4mNbnDEZI4T0=;
        b=Z2g8hVInctc9j0o8kBncTxMgcSCKa3cdnBW7IC+m8LsSVEkU6siYjWC5vRpXf25Hob
         hsM+VIgnEFgiosC6cB3c/1U23WNqjdBEvrIuah0quiO+WWZGec9CjaZ45b7Kdtp3So+D
         yq+QEwZcB6xqCrzHOkuEQdtKoyP5Gbs3NxtWBoM1sn/VidRTV0CqyC7MnOKQfDavNHIA
         VvYGkK+J6L05MepBwsyscEonZvSH/nUUTbY/O4VmhiVwFmKJWyZd53HSMJwFwdG0YmBw
         aIJTjnBmtA/H0BBicyGBpEtIGssdQF3WuaN/GW1sIK1aioClqcUmehPQ9WpWAWZco1WI
         VsGA==
X-Gm-Message-State: AOAM5332MyRIHgAXLAlHXC+JxA1/KGezCVidkBMtEtqKY+Dsxjl2ijV5
        Ea4ekhTR+3bh2kfA9pXF+R50eAlci5iL7w==
X-Google-Smtp-Source: ABdhPJwkYMmEWxuG95JRIfOF5pRKQY8AcgZKg6oYbrbDn02FAI6DUwnYZO268iXpOHk0t3H9/6x9JA==
X-Received: by 2002:a9d:4b18:: with SMTP id q24mr10225105otf.88.1621637114133;
        Fri, 21 May 2021 15:45:14 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id 67sm1516856otp.68.2021.05.21.15.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 15:45:13 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 11/11] doc: asciidoctor: add hack for old versions
Date:   Fri, 21 May 2021 17:44:52 -0500
Message-Id: <20210521224452.530852-12-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210521224452.530852-1-felipe.contreras@gmail.com>
References: <20210521224452.530852-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

\\ gets converted erroneously.

[1] https://github.com/asciidoctor/asciidoctor/issues/3456

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index e48a381b8f..3ab669dad8 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -38,10 +38,19 @@ Asciidoctor::Extensions.register :git do
 
   doc = document
 
-  # Override attributes for man pages.
-  # https://github.com/asciidoctor/asciidoctor/issues/4059
   if doc.backend == 'manpage'
+    # Override attributes for man pages.
+    # https://github.com/asciidoctor/asciidoctor/issues/4059
     doc.attributes.merge!({ 'litdd' => '\--', 'plus' => '+' })
+
+    # Fix bug with \\
+    if Asciidoctor::VERSION < '2.0.11'
+      postprocessor do
+        process do |_, output|
+          output.gsub("\\(rs\\\\", "\\(rs\\(rs\\")
+        end
+      end
+    end
   end
 
   inline_macro :linkgit do
-- 
2.32.0.rc0

