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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7834C04FF3
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD9E4613D9
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhEUWil (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 18:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhEUWij (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 18:38:39 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E22DC061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:37:15 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id s24-20020a4aead80000b02901fec6deb28aso4919825ooh.11
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ehDHJukYh7b8FbgY3eX3Ifyv88n/KEhHnL/0usgot2w=;
        b=ERjE1/uJPlrRtOA3fgfImejeNTGwA9G/mC9BAA7IUmmY5MeKda+ONwTTHAYzqMNNpb
         t7sWlfGT98frAPMUiDpf06JFHPkFC2ON/PDCuiFispwHIR2NpBnEJqGIyfAXMFUsS6cI
         06Nc1jPN7pcJW90db7qHO3WRcoH+9QbrM+yuV/BhONiUB7viPU1Jm9jY5ioQl2fB72QB
         CnPZua+XcQE6+KWoXumTwgKOyj9VS3YHh7e2YuQic0If2HNVgbg9kvaGJXOAf1KT2E12
         6xkMsiH3V1FhQzH0yDm2akGTJ0hncT1Ya88qbLDt1IWas3GhUUmhLAbkBLkwtGHAFHcg
         sYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ehDHJukYh7b8FbgY3eX3Ifyv88n/KEhHnL/0usgot2w=;
        b=i/D3zBK3sZlfBWdNB/ZHxwwyHEg5KmNpi6cssTEdZ0EYNqf8oMULLMgH26Zb5yS05U
         9cDQ5jkbuqdm0uxyLe4P7BzLoOoj8Iqcw+5RTTcQVJ2XGS/w8ViFwT57iBMh5UQpf2x6
         mBYLUxx5yifYr03tbT+JBiSuasd9h3F9fFxLZns0fc0X6ZO1O3Xw/T3Ky6/lRsmCqYR5
         KHXr5RjZMrricHby9FPO2e2Q6Bg4YnJANZcPwTHiuciRCAmP2WdaiPQg8Mhn0PehKgtX
         imctOf8HqJ+enNvScSVJmYRISAWfaC6ydiiSHHoLMrNcXs92gycUfA/WS6/o1WYbvjhM
         qVCQ==
X-Gm-Message-State: AOAM533DNMe5Lz5Yb/LDiFtOjA+44/dmNRRbfgYzL6mkjkNEgUv3u76k
        /mzrf8jFTef0f+Mn3Vc+3Ym8A3SAPr7FXA==
X-Google-Smtp-Source: ABdhPJzuaHyOLmv3tspeGQmgh/9dkS5GtFI/3/vEHudQXyQw8gwG3aOJ3qpgOavN5nRjsZLEAbk7QQ==
X-Received: by 2002:a05:6820:611:: with SMTP id e17mr10145447oow.0.1621636634211;
        Fri, 21 May 2021 15:37:14 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id n13sm1439410oop.8.2021.05.21.15.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 15:37:13 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 07/12] doc: asciidoctor: reorganize extensions
Date:   Fri, 21 May 2021 17:36:56 -0500
Message-Id: <20210521223701.526547-8-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210521223701.526547-1-felipe.contreras@gmail.com>
References: <20210521223701.526547-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no need to create verbose classes, we can do the same with a
simple block.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 34 +++++++++++--------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index 3dea106d00..f998a42249 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -1,26 +1,22 @@
 require 'asciidoctor/extensions'
 
-module Git
-  module Documentation
-    class LinkGitProcessor < Asciidoctor::Extensions::InlineMacroProcessor
-      def process(parent, target, attrs)
-        prefix = parent.document.attr('git-relative-html-prefix')
-        if parent.document.doctype == 'book'
-          "<ulink url=\"#{prefix}#{target}.html\">" \
-          "#{target}(#{attrs[1]})</ulink>"
-        elsif parent.document.basebackend? 'html'
-          %(<a href="#{prefix}#{target}.html">#{target}(#{attrs[1]})</a>)
-        elsif parent.document.basebackend? 'docbook'
-          "<citerefentry>\n" \
-            "<refentrytitle>#{target}</refentrytitle>" \
-            "<manvolnum>#{attrs[1]}</manvolnum>\n" \
-          "</citerefentry>"
-        end
+Asciidoctor::Extensions.register do
+
+  inline_macro :linkgit do
+    process do |parent, target, attrs|
+      prefix = parent.document.attr('git-relative-html-prefix')
+      if parent.document.doctype == 'book'
+        "<ulink url=\"#{prefix}#{target}.html\">" \
+        "#{target}(#{attrs[1]})</ulink>"
+      elsif parent.document.basebackend? 'html'
+        %(<a href="#{prefix}#{target}.html">#{target}(#{attrs[1]})</a>)
+      elsif parent.document.basebackend? 'docbook'
+        "<citerefentry>\n" \
+          "<refentrytitle>#{target}</refentrytitle>" \
+          "<manvolnum>#{attrs[1]}</manvolnum>\n" \
+        "</citerefentry>"
       end
     end
   end
-end
 
-Asciidoctor::Extensions.register do
-  inline_macro Git::Documentation::LinkGitProcessor, :linkgit
 end
-- 
2.32.0.rc0

