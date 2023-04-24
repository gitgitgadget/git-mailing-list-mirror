Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD94C77B61
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 14:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjDXOwY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 10:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbjDXOwL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 10:52:11 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E715A9ED9
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 07:51:43 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6a5eea94963so4503069a34.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 07:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682347903; x=1684939903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kF0H5Zxji5weX+BfEysXYJOUgrsIXlveaMwAaQCH7Y4=;
        b=jvuU5Jr7BPuU+y25udWtezd3qHi1POozJyF48WRqRt5FRE8EZoHsWx95q7N8tVym+x
         3jBqD3KYLDOVLe4pwI2J3eNfbAt0+Fku7I2pbbbymR1TKPDzjRofLJckyhfcvI7dlR5k
         WzM3aBFWnR/SFm9oEddqQnyqfvDFs6moY+XXxS5MEbIux/MOiFlJ0qsAXGCyKoOgu2sJ
         pz+MvZ+dx4VMmkEu/oEMa+wzwA/3YbAUHMTX0SMQoDYatJmgGUF2lv1dvvWK7fuvsDXZ
         JLNrI95UTv/buBbl0hZSPv56F65f5Vku8wI4lTCDn+AAdlVAZaC5qaZXhjm/ketzLpvX
         J+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682347903; x=1684939903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kF0H5Zxji5weX+BfEysXYJOUgrsIXlveaMwAaQCH7Y4=;
        b=emFCi70hUNj+owJ+0+VIVClrjqaIVee2PCke1HpZxNdlg7pZIq52G6iZuSLF9fKBgK
         pdJLpnMBW3HzBeFcX8w9OaplUTrSyNMstlxA81KlUyTasJ2xas51mD/EtHXuK4ZQr3c2
         vwkSTiktgzu+BNsCfEoriDb92ZdfrN8P78eIugDBnq5oysNpTmbnuZolJWH9HlATnMDK
         ghYqhUCPcMGPKtAPbglOOMXJqO0mzbZaNnedzAg1vZ8qj3GXFx+K68QR000XmQkfxIix
         JgH/MHxF048n838ixl+UmFo2qnC2qH/Ldf195NKkg3tuTtwHLb/dBHunctCO7UsmnHCK
         0nPA==
X-Gm-Message-State: AAQBX9evpYV5iZygLQKomr183WlT1N7dZP+ZIFE1QPnPRMHqbU51P9+k
        ddHxLxB1ynQaSeCDKH2/XKDOs7akzy0=
X-Google-Smtp-Source: AKy350ZccxrxDnQpvnkfEDf5z1zJzAMXTDVJKV8DXJ/aO1z7wd1wwQE+vhMS+HEljwhQV7kvOEZ4yg==
X-Received: by 2002:a9d:6282:0:b0:6a5:f20b:f6e3 with SMTP id x2-20020a9d6282000000b006a5f20bf6e3mr7175577otk.1.1682347902641;
        Mon, 24 Apr 2023 07:51:42 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id f6-20020a9d5f06000000b006a1287ccce6sm3565112oti.31.2023.04.24.07.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 07:51:42 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH] doc: remove asciidoctor hack
Date:   Mon, 24 Apr 2023 08:51:41 -0600
Message-Id: <20230424145141.11964-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The hack was added in 7a30134358 (asciidoctor-extensions: provide
`<refmiscinfo/>`, 2019-09-16) in order to deal with the fact that
asciidoctor doesn't pick up `manversion`, however, we don't require
`manversion` anymore, since 9a09ed3229 (doc: simplify man version,
2023-04-07).

So we can get rid of this hack without any functional changes.

The caveat is that we now require asciidoctor v1.5.7, which was released
5 years ago.

Cc: Martin Ågren <martin.agren@gmail.com>
Cc: Jeff King <peff@peff.net>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 17 -----------------
 1 file changed, 17 deletions(-)

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
2.40.0+fc1

