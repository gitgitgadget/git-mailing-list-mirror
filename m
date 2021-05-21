Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D69EC4707A
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83A2A613D8
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhEUWio (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 18:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhEUWil (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 18:38:41 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C63C061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:37:18 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 80-20020a9d08560000b0290333e9d2b247so8883623oty.7
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GlTK0LbCLdZHM3tR8WpR9GRnFxhsvXWBAS9HWgerdoM=;
        b=Fmk4YmXNr8YBuZRn9QRQdf87+Bi1cnLW8Tk6EyPKzeDwKCNiCSBPwHaMUnZLFj+mGe
         46TwgcVWgj0TIYUUP/Z1AQtNfyFEbCeXSJiJNVFdjQCfXCOUxw8pjk40D3w+nIfEPzdm
         qb+DSzcJPa02oHpgilr1CPhPe83Q8Idmf/Gpdqou+wY9r/e7DGVyutXJzYsUqXdxp9cy
         l/mEqrSgP1yYNrvvb7ZPxuIcWYbYnGpF6kbOY5O/Sw7JO/rm/JrdlL/M2REhY0DjMoYB
         PZ6f2St6f957fateFUPUcAwNKicRFEVTzs3twu9vETV0MKIBsgPapy3MBIPhqJnvOd58
         kZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GlTK0LbCLdZHM3tR8WpR9GRnFxhsvXWBAS9HWgerdoM=;
        b=JtZYm+8MY+XBRl1353CPPmx8DVZaFjpDURBU+ifrqteI/VyqYGafcIMc4cNvz7P5Ce
         wZqesHH5sQMfDoQzyRq1YUncLEQg8XTJ5HQE5E5KwEzrD6bBd3I4kSxBxgVjYPpvrPdj
         kzDIocQ3jCHZ9QD+0+/OOGF/iOTS58DpdAJc9yAsvOyWZr6wRpjUkI0Xu2o6K0rtJu52
         4JGhtozfpZl4fCB8A0CZ9iMRr1tvEAHi7DOVMp2Va51T7v2XLKr9D15qHWoopN63Q6Q1
         z+5kUFfhIN7gaLPDuEWIHNhhcpnRwiRFsG8PsRn3LaZjw2mFrcchFtLTziJGfI1wPv1r
         10RQ==
X-Gm-Message-State: AOAM530Q8ftEwz3F10jr66tqJ0xRGG5tB7AiYDFVQsz52aHQNqw8oV1k
        cX/o/4sw9Fhi8TDdgaZ8B1ngahj5RafG/g==
X-Google-Smtp-Source: ABdhPJyRrKvSivelAKYCeCrJnCVKDS5iHMYV5pv1j6o7o4cF4/ktgVetpapWh30F2hmtW8hO1RbV6Q==
X-Received: by 2002:a9d:7303:: with SMTP id e3mr10529788otk.216.1621636637271;
        Fri, 21 May 2021 15:37:17 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id d65sm1568736otb.78.2021.05.21.15.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 15:37:16 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 09/12] doc: asciidoctor: refactor macro registration
Date:   Fri, 21 May 2021 17:36:58 -0500
Message-Id: <20210521223701.526547-10-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210521223701.526547-1-felipe.contreras@gmail.com>
References: <20210521223701.526547-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is no need to execute extra code every time the process block is
called.

In Ruby the lexical scope is shared, so we can define variables in the
register block scope, and all the rest will inherit those variables.

Based on the doctype and basebackend one of three blocks is selected for
the inline_macro. However, the conditionals will be run only once.

In the end Ruby will only run the code between `process do end`, nothing
else.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index c77b6de350..a678704e17 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -2,15 +2,21 @@ require 'asciidoctor/extensions'
 
 Asciidoctor::Extensions.register do
 
+  doc = document
+
   inline_macro :linkgit do
-    process do |parent, target, attrs|
-      if parent.document.doctype == 'book'
+    if doc.doctype == 'book'
+      process do |parent, target, attrs|
         "<ulink url=\"#{target}.html\">" \
         "#{target}(#{attrs[1]})</ulink>"
-      elsif parent.document.basebackend? 'html'
-        prefix = parent.document.attr('git-relative-html-prefix')
+      end
+    elsif doc.basebackend? 'html'
+      prefix = doc.attr('git-relative-html-prefix')
+      process do |parent, target, attrs|
         %(<a href="#{prefix}#{target}.html">#{target}(#{attrs[1]})</a>)
-      elsif parent.document.basebackend? 'docbook'
+      end
+    elsif doc.basebackend? 'docbook'
+      process do |parent, target, attrs|
         "<citerefentry>\n" \
           "<refentrytitle>#{target}</refentrytitle>" \
           "<manvolnum>#{attrs[1]}</manvolnum>\n" \
-- 
2.32.0.rc0

