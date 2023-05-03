Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DA6C77B78
	for <git@archiver.kernel.org>; Wed,  3 May 2023 17:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjECRRk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 13:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjECRRi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 13:17:38 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF81F44BE
        for <git@vger.kernel.org>; Wed,  3 May 2023 10:17:03 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-18f4a6d2822so5536561fac.1
        for <git@vger.kernel.org>; Wed, 03 May 2023 10:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683134220; x=1685726220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OM1qkTjY6zSqPQTpySbCWbpZ146WeE3qiZS/N/FlAEc=;
        b=G4/k3MC1HeA4y16Nuq8UdNuFHqCoWnflhhDfMpLbt+BWc/KWw8HNMURhbVj7cnHMiy
         iX43lrrL5T73zL2dBj7w5TVTAYlfZDIbyZLvKjGzZI6GMxWtcrKm/BNJ/tfmHFHAy1s8
         3hH7RiQpJMTbnEPWF8yStHBmIZD9GkeBVn6sQ6CMvGcw92nry+VCxG2uBHOduhKf6TMG
         WPBpXahC9UH5jusg4urdvyv8lbpkFXzHsusWPWOJc/CtGrT456dvtwTE6zB75JH21Fs+
         91cOpJWTOXQF5rMb9HMhUI4kwZPUXlRXB8YEK8yOhCVE82dDYbJSceuPJPAszahD25d6
         uw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683134220; x=1685726220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OM1qkTjY6zSqPQTpySbCWbpZ146WeE3qiZS/N/FlAEc=;
        b=HolxDtr/hOjiFvWmIzxL9QydviUJuhX7m/2ENJaZmr8zb/qbxazngfCvv+FeXFspMy
         dtwdv7+c/vENBAKL2QwEFv+R9KaBY683A7F6hxf0AC8QOPDbSCn6Vj5G6BDuFt3ScYRB
         u1YEcV7szBWxIYJp4WCdoghYg1pI/1gwP8Tc09dO+6W7ndhruRZAV1BRvb44KU05s/Uw
         g34M1rB6k9DVgi91emVXPiiRY3e0lqcCsiw4c17Vr2Bv2p/4WbeuQoMWXUekmqcSrARG
         JMu+HbU4uzoGX/4jnVCj7dOJvxXHi3s2Tsa2SgW5Uy5ZVN5TxsGe/IRAAF1TuG6LnA12
         5RZg==
X-Gm-Message-State: AC+VfDyVEKwwYmaJm3yEdaW9+1D5ZnwpS3/l1jKskSUiOBf5BhY7pmwK
        CU9IfdUmAlvF4feQX2OFfLiN0NQgDBo=
X-Google-Smtp-Source: ACHHUZ4HrPlwpsrEo0wUfMrpQi+7y1Oq5yQUrQff7qz97hl7NO2XpqZXNbsbNGWqLznVjBT49+ttnQ==
X-Received: by 2002:a05:6808:1903:b0:389:1c4a:5722 with SMTP id bf3-20020a056808190300b003891c4a5722mr347300oib.11.1683134220228;
        Wed, 03 May 2023 10:17:00 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id b5-20020aca2205000000b0038c06ae307asm757629oic.52.2023.05.03.10.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 10:16:59 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2] doc: manpage: remove maximum title length
Date:   Wed,  3 May 2023 11:16:58 -0600
Message-Id: <20230503171658.8996-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230503052926.217219-1-felipe.contreras@gmail.com>
References: <20230503052926.217219-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DocBook Stylesheets limit the size of the manpage titles for some
reason.

Even some of the longest git commands have no trouble fitting in 80
character terminals, so it's not clear why we would want to limit titles
to 20 characters, especially when modern terminals are much bigger.

For example:

  --- a/git-credential-cache--daemon.1
  +++ b/git-credential-cache--daemon.1
  @@ -1,4 +1,4 @@
  -GIT-CREDENTIAL-CAC(1)             Git Manual             GIT-CREDENTIAL-CAC(1)
  +GIT-CREDENTIAL-CACHE--DAEMON(1)   Git Manual   GIT-CREDENTIAL-CACHE--DAEMON(1)

   NAME
          git-credential-cache--daemon - Temporarily store user credentials in
  @@ -24,4 +24,4 @@ DESCRIPTION
   GIT
          Part of the git(1) suite

  -Git omitted                       2023-05-02             GIT-CREDENTIAL-CAC(1)
  +Git omitted                       2023-05-02   GIT-CREDENTIAL-CACHE--DAEMON(1)

Moreover, asciidoctor manpage backend doesn't limit the title length, so
we probably want to do the same for docbook backends for consistency.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Since v1 the example diff in the commit message has been indented and an
extra paragraph explaining the situation with asciidoctor manpage
backend was added.

Range-diff against v1:
1:  b356b40db1 ! 1:  ea17191bd5 doc: manpage: remove maximum title length
    @@ Commit message
     
         For example:
     
    -    --- a/git-credential-cache--daemon.1
    -    +++ b/git-credential-cache--daemon.1
    -    @@ -1,4 +1,4 @@
    -    -GIT-CREDENTIAL-CAC(1)             Git Manual             GIT-CREDENTIAL-CAC(1)
    -    +GIT-CREDENTIAL-CACHE--DAEMON(1)   Git Manual   GIT-CREDENTIAL-CACHE--DAEMON(1)
    +      --- a/git-credential-cache--daemon.1
    +      +++ b/git-credential-cache--daemon.1
    +      @@ -1,4 +1,4 @@
    +      -GIT-CREDENTIAL-CAC(1)             Git Manual             GIT-CREDENTIAL-CAC(1)
    +      +GIT-CREDENTIAL-CACHE--DAEMON(1)   Git Manual   GIT-CREDENTIAL-CACHE--DAEMON(1)
     
    -     NAME
    -            git-credential-cache--daemon - Temporarily store user credentials in
    -    @@ -24,4 +24,4 @@ DESCRIPTION
    -     GIT
    -            Part of the git(1) suite
    +       NAME
    +              git-credential-cache--daemon - Temporarily store user credentials in
    +      @@ -24,4 +24,4 @@ DESCRIPTION
    +       GIT
    +              Part of the git(1) suite
     
    -    -Git omitted                       2023-05-02             GIT-CREDENTIAL-CAC(1)
    -    +Git omitted                       2023-05-02   GIT-CREDENTIAL-CACHE--DAEMON(1)
    +      -Git omitted                       2023-05-02             GIT-CREDENTIAL-CAC(1)
    +      +Git omitted                       2023-05-02   GIT-CREDENTIAL-CACHE--DAEMON(1)
    +
    +    Moreover, asciidoctor manpage backend doesn't limit the title length, so
    +    we probably want to do the same for docbook backends for consistency.
     
         Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
     

 Documentation/manpage-normal.xsl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/manpage-normal.xsl b/Documentation/manpage-normal.xsl
index a9c7ec69f4..e7aa5df2fc 100644
--- a/Documentation/manpage-normal.xsl
+++ b/Documentation/manpage-normal.xsl
@@ -8,6 +8,9 @@
 <xsl:param name="man.output.quietly" select="1"/>
 <xsl:param name="refentry.meta.get.quietly" select="1"/>
 
+<!-- unset maximum length of title -->
+<xsl:param name="man.th.title.max.length"/>
+
 <!-- convert asciidoc callouts to man page format -->
 <xsl:template match="co">
 	<xsl:value-of select="concat('\fB(',substring-after(@id,'-'),')\fR')"/>
-- 
2.40.0+fc1

