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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82262C48BC2
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6762260200
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbhFURBA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 13:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbhFURAw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 13:00:52 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63218C0219AA
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:26 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id v11-20020a9d340b0000b0290455f7b8b1dcso5388469otb.7
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3LrHspE4DvZAjyMVfY+o2HKU++SQ5WNKRglpQdlE7Qk=;
        b=KYxYjXhvhFcNoBh1+8INK1rLk3QWitFrGKCOXjnFb7iSxDrieZ5Ys5F4VKWOC5VXPc
         JpegjMzUbZSgz+PuDbUFQfyJ2LQRfNrQu1NKqp2qA1+87WOCjQ98LR8/LLW9+3esAzI+
         pGLoLEJKGCJLOQpqlatTTacOM0BUwikUaGfzbhUQy9bFXNaGrcxiK47NuxANvsMCEr3a
         ZnDkpbniQVCN+PsXtPF8+iVgKRGljTGC4uh+neKGweLrQOhsld5LoBRTVbwfXxlwItTr
         xLoRKmd1oMWou1QtjlG5upWaZLZa4+SZbccIbcTRmomrTL0GhczSm0fSim7Pjwtg1Di3
         YlDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3LrHspE4DvZAjyMVfY+o2HKU++SQ5WNKRglpQdlE7Qk=;
        b=dMfzxbXDjgUOLFCxx+dhUPTh0P/K0HAdJG3gUw5AF6Gxx4xncS703K/9ptcXKCWgLc
         iEUFd0OHSaJb6jxbRdlJ4covYrHCvuih/i7onjq/Nr7eJh5LqIvIRz38ZjiLbMkuu8Fo
         2ETQDxYaA8vgdlkeHWbWmzfzf2k0hzGxUNiMH5rruDOlId1csBEyyMIe0Kd8iW3EnqdV
         n/QKOqPpTZJPT3DMR1IWHCPgVI6uJOu9MWrM8FxV9XJTjSeaU7HjKtiBbJ/Tbp4Srnmu
         /UJaSca4YOHU+aDLCxFw0foDNkJ1ZkAqp8ar9fkraSt8vuZMRTeTAM2RzZ2h7iZfj2z/
         7XPA==
X-Gm-Message-State: AOAM532eRh1iznD1ktxOgzOkSWFJ9RtnDbr2JxTL+GEgnweeFOx7fFhb
        Fi5ts3J4LH6KZAAHVBTvZEP6dw2n5Ou5Kw==
X-Google-Smtp-Source: ABdhPJznnsA4GlRM6a4DMKNDqVSUPVmLvq8T5CiLLgEMcOwZ0HY/JKSdD+1XRV5IGElCgIZRHQvX+w==
X-Received: by 2002:a9d:3644:: with SMTP id w62mr21990763otb.205.1624293085541;
        Mon, 21 Jun 2021 09:31:25 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id l25sm3663454oie.57.2021.06.21.09.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 09:31:25 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 03/23] doc: simplify version passing
Date:   Mon, 21 Jun 2021 11:30:50 -0500
Message-Id: <20210621163110.1074145-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621163110.1074145-1-felipe.contreras@gmail.com>
References: <20210621163110.1074145-1-felipe.contreras@gmail.com>
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

