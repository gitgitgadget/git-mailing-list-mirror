Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8C7C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 09:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37B0A61263
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 09:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhFHJCu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 05:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbhFHJCt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 05:02:49 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBBCC061574
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 02:00:46 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so15225293oth.9
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 02:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f1t7zOZhVPCUxouHSRryjqnFh7JxXhD3yg2wCAlDRtI=;
        b=Vio/GiZW3XQXH583MSCMNHSv/s8Oq4gAUWtBqWMww/8k/4Hnqf55mtBozXc7i+IrKx
         85He8AZmeIceD9QCkOIskpvyAsjKk4QcpCOJPQLDNvPbiw6OPRKYy3au2ZZrJ1Il15OJ
         zzc+LOHMdG5ByW7tT01L1p679AKKfg4ti0p2ksDYgnKbgF37ZLZrDWTp3e2aIYFllpcT
         qckaVQ+9RRwqhQWhoX3++JCB+lHjvjr9Sp3jkLHRJ0YlpwDhGOGhp3KTSygji3JcZRs+
         zA1pe0umtnXByFzWKGIZo7G2kAUWLxiRG+yeMMGYPVYIjSNTTy/zBl19Yl3j1eosf4gz
         EoNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f1t7zOZhVPCUxouHSRryjqnFh7JxXhD3yg2wCAlDRtI=;
        b=OOYwBMnygdWH4hBw/+n6Vxtr2eGNNAzwP1xZhCZRx9CZJ29p5YghBVJdvAJIfq53Np
         YnpSCoqqVtJ71f/IlOZLp/pl0qWo9Wz+CgN3o0a+ZORifYdsqa0UMqwWKXtBbNYTeTGt
         WMBJgZy3wVUC54gHv5z3Oi7HT0dH9bekckiYOpDg1mMGZ8Py9cVhzT8L/uRXjLy4VH1d
         kxXt06JuvF1nW24u37IIfKf93cIXJOr7oPfvpEo32bGu4cPg5b1DcTVnV+O7tH6aUYSz
         0QCFVfcbBTT4DKrvlMv3JVdtug3PriZQG5M5Kp3765ZO4UKXcmGwsOfPULh5rQbzVoVB
         AWLw==
X-Gm-Message-State: AOAM5322cpvSSrG/mw4B58dOLccYO6AhRxinMvOEo9ozduP9nplKCZEN
        Nh4pGxCDIKQNP23Z34IBHBGbAq5oruAk/A==
X-Google-Smtp-Source: ABdhPJxh0Mk/2SnrpHP8NVD1rwWkls+UrUur/hJlBZo6Y7Fb1OD9imdX3jN/Jrj2os9H0JA1P5Aybg==
X-Received: by 2002:a9d:4c0a:: with SMTP id l10mr18132914otf.363.1623142846082;
        Tue, 08 Jun 2021 02:00:46 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id c205sm2744962oib.20.2021.06.08.02.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 02:00:45 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 09/12] doc: asciidoctor: refactor macro registration
Date:   Tue,  8 Jun 2021 04:00:23 -0500
Message-Id: <20210608090026.1737348-10-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.2.g41be0a4e50
In-Reply-To: <20210608090026.1737348-1-felipe.contreras@gmail.com>
References: <20210608090026.1737348-1-felipe.contreras@gmail.com>
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
2.32.0.2.g41be0a4e50

