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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1B1C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 09:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B9426101A
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 09:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhFHJCp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 05:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbhFHJCo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 05:02:44 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4C3C061795
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 02:00:35 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so15224703oth.9
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 02:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FPhgeea0hgSTeQX95DzXixHWi+cAG4FdK580HtwyJbE=;
        b=lp8XlWc5o37x4LqL0+c2zPU4XdBcGT26Ch9V/zXWJuZDO4AhjPQ8DmPWI1x3XQhHee
         fGelUDrHFvNRjHNAWB9t1cCUWsocnIc9czLi36gg6bnIQmisNkA0LP75YztgBWgd13PH
         OBytxHZaR7Wn28y18RuWXk0KkH4Rw9PW4HWHLSmPhtO1Zoh9YmcgBr0Uo0wcwOklcpAn
         lphxBEJlo9mvXUqAomlwzwNtXKVTj5NJpLcP2Y9J1hidyztwkLajvH5EsrCbhOUTUZXc
         Dh2BTAOD4bkmSpHs93J50PWHlT3se3KQw5zWmPRDgfGk2n0vxaQ9tqB1k2ocB8gp8dXr
         UQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FPhgeea0hgSTeQX95DzXixHWi+cAG4FdK580HtwyJbE=;
        b=iOd7iljjKdaLY6TefCsDVd8PAQEDIAWv1ZXFSi4mjT2OqgQ4EKK4z2U+CW7Yj/d3lI
         rhKwDDz/MxBXz6e4XMcsKroAIx2qiWb0uXGZeRU2If1CShUyeXI7NShKhKvKGOTYUDRG
         TT+7mcVWQxo7fdG/v2LHXucpErTSR9W2ght0fe7zj0iKefl/t5MdP5gR1tVEdFCHGVVo
         0Zl+2g4LoNKyxyeKepsHAG3w2ZJwyKSba63441D1l7lDSsZrwxYfjeD688sAJWGhWK0F
         8ZCicHauIrQgdoptoQSLFKSPeni9sJf80v+jDCaQ7l+wrk9KpYl30+ADOtqm1kXqfbFG
         gf1Q==
X-Gm-Message-State: AOAM531ORA9YOMRowKOIr90Jq3ESAopPy3/K0gS+CQbkZI4qiR6eDwUt
        C9rnIhpNH79Po0zCtTiZre44HMex3AqfSQ==
X-Google-Smtp-Source: ABdhPJwb1SzwLSC1hxkgOxc2bxQjhzDpQaIHvZNYTxz44t3Mq9SGVbSMhhL3b6FsWK3KJJOTz4KB/g==
X-Received: by 2002:a9d:8c2:: with SMTP id 60mr17299895otf.217.1623142834369;
        Tue, 08 Jun 2021 02:00:34 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id 102sm2935130otf.37.2021.06.08.02.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 02:00:34 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 03/12] doc: simplify version passing
Date:   Tue,  8 Jun 2021 04:00:17 -0500
Message-Id: <20210608090026.1737348-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.2.g41be0a4e50
In-Reply-To: <20210608090026.1737348-1-felipe.contreras@gmail.com>
References: <20210608090026.1737348-1-felipe.contreras@gmail.com>
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
2.32.0.2.g41be0a4e50

