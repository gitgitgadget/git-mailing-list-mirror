Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F996C433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 00:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B972613F7
	for <git@archiver.kernel.org>; Fri, 14 May 2021 00:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbhENAcy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 20:32:54 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47206 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231687AbhENAcx (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 May 2021 20:32:53 -0400
Received: from camp.crustytoothpaste.net (unknown [138.237.15.37])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id EFFA460B19;
        Fri, 14 May 2021 00:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1620952273;
        bh=Mz8rZJob6Lp1hfrRovpS6VajLMa1wjjP+C/8qZLkp5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=yf97VSjZsIukBJHu9cYxxmSBul6twxsWFcsgIaQ+dqbKKAXsBzvlhNfUVXR8hu9II
         E93qjc0I/EUYQ/FBT0bUMBAG24zv9qYa09PHE3HkFrDk5RCh9EmZH5HuF2u1Hd1B4z
         FxwO3dC0f9AHOG9kW6UL5a9ibw2maR1JpsZNS+E94VC78OQfyGdp+oiFs8gYs6c8i3
         /qzkVX79c8/EPFb4mUuGhyaTxtcF2vh2Lb0KXxfHRZrU3S2TXlIpqnidJWQaua2gf6
         uLky0+VwY1dvGq8lqIzo5x4+/H73aAvv2oM4dZqkFAEwJZfwOD7xd5afevGKoSaV/y
         CsLPoB3tdfeiwpAYExG4UAC7zCmJ/dGOYWfdQZZzTKXNR3Pc7g9QivWj+NYFEP3oEv
         e6jQAfV6mtwnUyW1ZilcxFyNnd+7JHAv6wBhrMXbV88dsboG19XFONgfxQlTjLlOLT
         J/X5Ti6ErhGpMXaSpgoebyygbPQrJtPKnIZm57lp5Js9nGT28hs
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 2/2] doc: remove GNU_ROFF option
Date:   Fri, 14 May 2021 00:31:04 +0000
Message-Id: <20210514003104.94644-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d
In-Reply-To: <20210514003104.94644-1-sandals@crustytoothpaste.net>
References: <609b2828309fc_678ff2082@natae.notmuch>
 <20210514003104.94644-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By default, groff converts apostrophes in troff source to Unicode
apostrophes.  This is helpful and desirable when being used as a
typesetter, since it makes the output much cleaner and more readable,
but it is a problem in manual pages, since apostrophes are often used
around shell commands and these should remain in their ASCII form for
compatibility with the shell.

Fortunately, the DocBook stylesheets contain a workaround for this case:
they detect the special .g number register, which is set only when using
groff, and they define a special macro for apostrophes based on whether
or not it is set and use that macro to write out the proper character.
As a result, the DocBook stylesheets handle all cases correctly
automatically, whether the user is using groff or not, unlike our
GNU_ROFF code.

Additionally, this functionality was implemented in 2010.  Since nobody
is shipping a mainstream Linux distribution with security support that
old anymore, we can just safely assume that the user has upgraded their
system in the past decade and remove the GNU_ROFF option and its
corresponding stylesheet altogether.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/Makefile               |  8 --------
 Documentation/manpage-quote-apos.xsl | 16 ----------------
 Makefile                             |  4 ----
 3 files changed, 28 deletions(-)
 delete mode 100644 Documentation/manpage-quote-apos.xsl

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 891181c0f3..19dc5a2974 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -177,14 +177,6 @@ MAN_BASE_URL = file://$(htmldir)/
 endif
 XMLTO_EXTRA += -m manpage-base-url.xsl
 
-# If your target system uses GNU groff, it may try to render
-# apostrophes as a "pretty" apostrophe using unicode.  This breaks
-# cut&paste, so you should set GNU_ROFF to force them to be ASCII
-# apostrophes.  Unfortunately does not work with non-GNU roff.
-ifdef GNU_ROFF
-XMLTO_EXTRA += -m manpage-quote-apos.xsl
-endif
-
 ifdef USE_ASCIIDOCTOR
 ASCIIDOC = asciidoctor
 ASCIIDOC_CONF =
diff --git a/Documentation/manpage-quote-apos.xsl b/Documentation/manpage-quote-apos.xsl
deleted file mode 100644
index aeb8839f33..0000000000
--- a/Documentation/manpage-quote-apos.xsl
+++ /dev/null
@@ -1,16 +0,0 @@
-<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
-		version="1.0">
-
-<!-- work around newer groff/man setups using a prettier apostrophe
-     that unfortunately does not quote anything when cut&pasting
-     examples to the shell -->
-<xsl:template name="escape.apostrophe">
-  <xsl:param name="content"/>
-  <xsl:call-template name="string.subst">
-    <xsl:with-param name="string" select="$content"/>
-    <xsl:with-param name="target">'</xsl:with-param>
-    <xsl:with-param name="replacement">\(aq</xsl:with-param>
-  </xsl:call-template>
-</xsl:template>
-
-</xsl:stylesheet>
diff --git a/Makefile b/Makefile
index e499152ba2..f186fd4753 100644
--- a/Makefile
+++ b/Makefile
@@ -278,10 +278,6 @@ all::
 # Define NO_ST_BLOCKS_IN_STRUCT_STAT if your platform does not have st_blocks
 # field that counts the on-disk footprint in 512-byte blocks.
 #
-# Define GNU_ROFF if your target system uses GNU groff.  This forces
-# apostrophes to be ASCII so that cut&pasting examples to the shell
-# will work.
-#
 # Define USE_ASCIIDOCTOR to use Asciidoctor instead of AsciiDoc to build the
 # documentation.
 #
