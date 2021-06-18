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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6091C49361
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 21:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 850F161279
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 21:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbhFRVyu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 17:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234662AbhFRVyu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 17:54:50 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3E3C061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 14:52:39 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso11113031otu.10
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 14:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3LrHspE4DvZAjyMVfY+o2HKU++SQ5WNKRglpQdlE7Qk=;
        b=gjH3Fy+zoqpxo1b+Kt4hpqsePmtR7HJb+MVq9kbq38n6hD4MAdHrT4VNYI/JtoGH4L
         QOsfkVP3PZdNi0cMNx8U+V9/mBHpkcGwzWMcxTupaYM5FN+VQZyBOvkyEq5Ye5v0MnJx
         w1O5wd8CcMocs0LYzN6BvIgnRNtnDp1O2JEu+ocyN4RDAFZPmOnuJsJbrXcxb20Y5+M1
         7tGbygBQoJsm6sZpTO0AFWyxtye9654l9QQw9QKbF7A8jRRoAqE6ygO/xvWF6DBFWhJo
         bpje9UqHhs99GOuEq/5xORPUn6PwuIBubxGuJ+adyRq8uq+UPLqa+3GIves2+oZb68+p
         yucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3LrHspE4DvZAjyMVfY+o2HKU++SQ5WNKRglpQdlE7Qk=;
        b=A+hPrTMvoj/agAikYYvfEb4ivtsUsdN1gJmAS/Uw/uyPzYa9D1hryTChJ9yV+zCQEH
         F6oJZVqRHkZ1b1w3XdQcCbM6L9mZ+ucTMCu5Vc+HH/p+VnjfSl3NJa5IhmReSX2sGPrh
         XhWbYKLwXz/r2nJOCazhYzUxnxfUuunSAy8v+I3QRpPsp6oiwhg/GeR1Jaxg2IfddnNV
         FY9h4kGmoYquAQrXebnXqZ4P5EIXt88JTqidQyzobOrBIQHu5W9EbI/q3ZarZAvEOGUc
         Wlc10AqsoEjWoXpXM7DzdAkfqmK4jxCgwQBVGQrT6J05iXCi75pG5y7R4+1GDjSEyEP/
         mkXQ==
X-Gm-Message-State: AOAM533uXzN8RwBPbw+vfKldILK3QjF7lHRN02Xseg7h97tszWL1K6TI
        VZmXRP6wJbTkTb0aA3lTqVJGNud1yAG1tg==
X-Google-Smtp-Source: ABdhPJzHLSvKN5sVAo0mTfl/eMcJFdBjHdqyENuVjU6oRqEkUEGCWRQCk8glW/4L0ge59ymeTebuxQ==
X-Received: by 2002:a05:6830:25cc:: with SMTP id d12mr8312104otu.160.1624053158720;
        Fri, 18 Jun 2021 14:52:38 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id 7sm2033598oor.30.2021.06.18.14.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 14:52:38 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 3/4] doc: simplify version passing
Date:   Fri, 18 Jun 2021 16:52:30 -0500
Message-Id: <20210618215231.796592-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618215231.796592-1-felipe.contreras@gmail.com>
References: <20210618215231.796592-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code to pass the version of the man page comes from 2007:
7ef195ba3e (Documentation: Add version information to man pages,
2007-03-25). However, both asciidoc and asciidoctor already do this by
default.

Asciidoctor doesn't read manversion, but there's no need since both
tools just join mansource and manversion.

Let's do that ourselves and get rid of a bunch of code.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/Makefile                  |  3 +--
 Documentation/asciidoc.conf             | 19 -------------------
 Documentation/asciidoctor-extensions.rb | 17 -----------------
 3 files changed, 1 insertion(+), 38 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 84643a34e9..47053c78f8 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -137,8 +137,7 @@ ASCIIDOC_HTML = xhtml11
 ASCIIDOC_DOCBOOK = docbook
 ASCIIDOC_CONF = -f asciidoc.conf
 ASCIIDOC_COMMON = $(ASCIIDOC) $(ASCIIDOC_EXTRA) $(ASCIIDOC_CONF) \
-		-amanversion=$(GIT_VERSION) \
-		-amanmanual='Git Manual' -amansource='Git'
+		-amanmanual='Git Manual' -amansource='Git $(GIT_VERSION)'
 ASCIIDOC_DEPS = asciidoc.conf GIT-ASCIIDOCFLAGS
 TXT_TO_HTML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_HTML)
 TXT_TO_XML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_DOCBOOK)
diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 3e4c13971b..60f76f43ed 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -51,25 +51,6 @@ ifdef::doctype-manpage[]
 endif::doctype-manpage[]
 endif::backend-docbook[]
 
-ifdef::doctype-manpage[]
-ifdef::backend-docbook[]
-[header]
-template::[header-declarations]
-<refentry>
-<refmeta>
-<refentrytitle>{mantitle}</refentrytitle>
-<manvolnum>{manvolnum}</manvolnum>
-<refmiscinfo class="source">{mansource}</refmiscinfo>
-<refmiscinfo class="version">{manversion}</refmiscinfo>
-<refmiscinfo class="manual">{manmanual}</refmiscinfo>
-</refmeta>
-<refnamediv>
-  <refname>{manname}</refname>
-  <refpurpose>{manpurpose}</refpurpose>
-</refnamediv>
-endif::backend-docbook[]
-endif::doctype-manpage[]
-
 ifdef::backend-xhtml11[]
 [attributes]
 git-relative-html-prefix=
diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index d906a00803..70a0956663 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -23,26 +23,9 @@ module Git
         end
       end
     end
-
-    class DocumentPostProcessor < Asciidoctor::Extensions::Postprocessor
-      def process document, output
-        if document.basebackend? 'docbook'
-          mansource = document.attributes['mansource']
-          manversion = document.attributes['manversion']
-          manmanual = document.attributes['manmanual']
-          new_tags = "" \
-            "<refmiscinfo class=\"source\">#{mansource}</refmiscinfo>\n" \
-            "<refmiscinfo class=\"version\">#{manversion}</refmiscinfo>\n" \
-            "<refmiscinfo class=\"manual\">#{manmanual}</refmiscinfo>\n"
-          output = output.sub(/<\/refmeta>/, new_tags + "</refmeta>")
-        end
-        output
-      end
-    end
   end
 end
 
 Asciidoctor::Extensions.register do
   inline_macro Git::Documentation::LinkGitProcessor, :linkgit
-  postprocessor Git::Documentation::DocumentPostProcessor
 end
-- 
2.32.0

