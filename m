Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8926C2D0E5
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 13:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA5E2074A
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 13:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EndLmap6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgC2NSf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 09:18:35 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37325 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbgC2NSe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 09:18:34 -0400
Received: by mail-lj1-f196.google.com with SMTP id r24so14975628ljd.4
        for <git@vger.kernel.org>; Sun, 29 Mar 2020 06:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=76lvnEzPJQPUsZPkI4RevKPH2vywTjX/bvCjEQZfd0g=;
        b=EndLmap6XgTg6AdEpe+y4pgd9GCOS44QQ3Qs6aLuXZk2R8QoiUgvGG3N9ppYBM9QEo
         MIwcAAU4beeZz4efDZQ+jK2YagPchoRlQardgVEeUsL9rCXWN0AbpjRhdUqH5cXNBxSU
         UGLqxRD7POKULLJHfY7weW98H5Q15dsHqs9WSI8SU/uZc/I1WDtAV0wbhlNq2vYVTeuX
         QvNwQKl7bfX7Jr1wkmwlEwdjrOjfFXO4791H5c80kYsIbMqNsezNdJFmB8mSVTMN5AER
         QBYLKJsr357/xCE8NBUSry4sQaQM+geL1JTnH8ADr6DxfOVX+VP7j61XzrRzEsRCV1pf
         yFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=76lvnEzPJQPUsZPkI4RevKPH2vywTjX/bvCjEQZfd0g=;
        b=ULTFGPCd1Bb8QflFbG0lZrjwv80RxuZbx9cVTuMdu3jpRKvQpKLuykrNGBZmkfE7Y3
         G5QPkkC/Qr0uvg6TBtR1y1tto3RiXdCmZBCHoSmV6R91ND0CV0nsZfl78XxO8N2vDYs6
         rkAM/J57F2SL67GfbmJWJC6KInTS9KlZOWySVi37IJzmjTU2+llU8lxm5bvGhxkt40A1
         4waVyC24EbxE4Jyldq/WPjPN3NKO0ChDoRAXIZUOqIXvRkpxgzT2vjjP6kxHm4Yb/WYX
         OweXJrAvv88p1XdTp+EGxVOsXv5XzrFO8Q8VYvOj9RCE6VbJwo+P4XCvhV/03uFtDz55
         3K5w==
X-Gm-Message-State: AGi0PuZi2PFEMILtL9F7qaxtqe15vx4ohC08rntIN9kVZY+If9kUOPq9
        w+KRhuhUvSH3Wks47uMljXbnJg6P
X-Google-Smtp-Source: APiQypJlUzlO1xH7cVV5WWswQncxKYu0cYleneVyi9NfMtgI8YHnaufeQkLNqNv0uwUqZ7IWzrphrg==
X-Received: by 2002:a2e:8146:: with SMTP id t6mr4625323ljg.236.1585487913107;
        Sun, 29 Mar 2020 06:18:33 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id d16sm1247742lfm.91.2020.03.29.06.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 06:18:32 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 4/6] manpage-bold-literal.xsl: stop using git.docbook.backslash
Date:   Sun, 29 Mar 2020 15:18:08 +0200
Message-Id: <28263e58b91706b34c651b5ab1475f1496a5c2cf.1585486103.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1585486103.git.martin.agren@gmail.com>
References: <cover.1585486103.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We used to assign git.docbook.backslash one of two different values --
one "normal" and one for working around a problem with docbook-xsl 1.72.
After the previous commit, we don't support that version anymore and
always use the "normal" value, a literal backslash.

Just explicitly use a backslash instead of using git.docbook.backslash.
The next commit will drop the definition of git.docbook.backslash
entirely.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/manpage-bold-literal.xsl | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/manpage-bold-literal.xsl b/Documentation/manpage-bold-literal.xsl
index 94d6c1b545..e13db85693 100644
--- a/Documentation/manpage-bold-literal.xsl
+++ b/Documentation/manpage-bold-literal.xsl
@@ -8,11 +8,9 @@
      this makes literal text easier to distinguish in manpages
      viewed on a tty -->
 <xsl:template match="literal|d:literal">
-	<xsl:value-of select="$git.docbook.backslash"/>
-	<xsl:text>fB</xsl:text>
+	<xsl:text>\fB</xsl:text>
 	<xsl:apply-templates/>
-	<xsl:value-of select="$git.docbook.backslash"/>
-	<xsl:text>fR</xsl:text>
+	<xsl:text>\fR</xsl:text>
 </xsl:template>
 
 </xsl:stylesheet>
-- 
2.26.0

