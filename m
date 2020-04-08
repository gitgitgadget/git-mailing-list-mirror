Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E20C2D0EA
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 14:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3689206F5
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 14:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFOswzDL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgDHOZ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 10:25:58 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46898 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbgDHOZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 10:25:58 -0400
Received: by mail-ed1-f65.google.com with SMTP id cf14so8719299edb.13
        for <git@vger.kernel.org>; Wed, 08 Apr 2020 07:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=etNqsKayiseZ5oWmm5t8mJc9+bcCitycbBkjwUKAzMU=;
        b=CFOswzDL/sYnIg+GNWo1dunsSh8Dx7M2MOBMB3ofatp2xAs2rs/l7e919qEPdK6f/l
         Z9uODMpOaIKuZ4jCH8Y+h13DmXa4h38zSKj0zRLnvph0LBMAvA1T9BEIUQZfJ9yDx0r3
         8WIXs9cyvUWKwsTNrwl5FGQr+Zqh4Ubk68CMI08+IYKJJl+NZ7aR38thKmgLQZAL1Sd4
         I1NqB6qivjomnA/jOlQUiliKwh0JvpXR/Z3YBIii4GbPpxddeLnRnD9rLbVi4rd+DM95
         fxBMl/xYB82hEGKsAmjaloStsMJg7HVwt117SYptaXtqXFQb3doIuQymU5H0zSeseJhq
         FQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=etNqsKayiseZ5oWmm5t8mJc9+bcCitycbBkjwUKAzMU=;
        b=o23wmQW8GphivEPBO3ImACe5u/PQOOY5kfuiPp91yluHy7wT7DnIf7kbCyAqgVjZyK
         jbgicVY2u5Rq4XzsP0ME3fiCsNowvPkmrQjhzUMIyv9Je6ppg6q2knxgVS4hRzlnR+Cb
         xMS0Z+UhgzWHixutXcjZFIOQkKXsjAmVn+GFfEg/ycCH0b053j75fDFFP0BUxLq5Z/vd
         FVUhNghK/A31qqDby9o2juy8A2MtC56qkZ8gZKRsWkcPMXOL216PuMyIAYQmAwQVhfn/
         Sw12r7VO76qLezsYABCqAwgkdzXeEd/EC0okQlX3FWDBcGwVvyH03aN2ac8OAOtVJBf/
         AfvA==
X-Gm-Message-State: AGi0PuZwwCIYF4j+BDR55HUcaOBWGY16HJFS526AM1fuwOHOBlBGR8K9
        /+zHWZfcCJxWTLAeDOkQyQ9ER0BR
X-Google-Smtp-Source: APiQypLNo1W6Vp55HrQpjyeAdSypHbBbhHVaBEcl24RUnjeuw4vM+u3zfhX05NnigJC8iP5XJ1SJxA==
X-Received: by 2002:a50:cf8e:: with SMTP id h14mr6802040edk.369.1586355950492;
        Wed, 08 Apr 2020 07:25:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id qu11sm596170ejb.12.2020.04.08.07.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 07:25:50 -0700 (PDT)
Message-Id: <pull.600.git.1586355949189.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Apr 2020 14:25:49 +0000
Subject: [PATCH] subtree: fix build with AsciiDoctor 2
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This is a (late) companion for f6461b82b93 (Documentation: fix build
with Asciidoctor 2, 2019-09-15).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Adjust contrib/subtree to AsciiDoctor 2, too
    
    This is something I had to do because the Git for Windows release
    process now offers only AsciiDoctor 2.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-600%2Fdscho%2Fsubtree-and-docbook-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-600/dscho/subtree-and-docbook-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/600

 contrib/subtree/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
index 6906aae4414..6fa7496bfdb 100644
--- a/contrib/subtree/Makefile
+++ b/contrib/subtree/Makefile
@@ -25,14 +25,16 @@ ASCIIDOC_HTML    = xhtml11
 ASCIIDOC_DOCBOOK = docbook
 ASCIIDOC_EXTRA   =
 XMLTO            = xmlto
+XMLTO_EXTRA      =
 
 ifdef USE_ASCIIDOCTOR
 ASCIIDOC         = asciidoctor
 ASCIIDOC_CONF    =
 ASCIIDOC_HTML    = xhtml5
-ASCIIDOC_DOCBOOK = docbook45
+ASCIIDOC_DOCBOOK = docbook
 ASCIIDOC_EXTRA  += -I../../Documentation -rasciidoctor-extensions
 ASCIIDOC_EXTRA  += -alitdd='&\#x2d;&\#x2d;'
+XMLTO_EXTRA     += --skip-validation
 endif
 
 ifndef SHELL_PATH
@@ -78,7 +80,7 @@ install-html: $(GIT_SUBTREE_HTML)
 	$(INSTALL) -m 644 $^ $(DESTDIR)$(htmldir)
 
 $(GIT_SUBTREE_DOC): $(GIT_SUBTREE_XML)
-	$(XMLTO) -m $(MANPAGE_XSL) man $^
+	$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $^
 
 $(GIT_SUBTREE_XML): $(GIT_SUBTREE_TXT)
 	$(ASCIIDOC) -b $(ASCIIDOC_DOCBOOK) -d manpage $(ASCIIDOC_CONF) \

base-commit: 9fadedd637b312089337d73c3ed8447e9f0aa775
-- 
gitgitgadget
