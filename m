Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FCBC47257
	for <git@archiver.kernel.org>; Wed,  6 May 2020 21:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40C132078C
	for <git@archiver.kernel.org>; Wed,  6 May 2020 21:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bn7kGVcS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbgEFVsj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 17:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730029AbgEFVsj (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 May 2020 17:48:39 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0D2C061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 14:48:39 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x77so1824868pfc.0
        for <git@vger.kernel.org>; Wed, 06 May 2020 14:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P1mIXTyxQXGDDIcHxeiomhmFzzers4Cd+5PsN1wDPv4=;
        b=Bn7kGVcSaNsj1m/v6WDFm6LE8lpR/AqdaIL/BbSRX0iClJYcpiPzQciGtugdTIWEPO
         kHqpPS0fRRFqosZWTl+oKn11c0X9yxcVl3qiCtaWdtVpCXdaihTIaqLyFgTyLyLzw95m
         9O8DbSv5AaABiVE7y+QXll4cwsNB9YwpO04vpDwCsr1Ju2wVRdiV7QXOcGMxQDbvx79z
         45jpAvmpYm5FWdyaI93WfECDJBZKzdTn/55XSrFBp3GKAyAh2HS3jEFvAWZZOH3kXbdv
         3E2mzNtP/1eHfGYw6A88vdsapETYfs9vL18sa+cKSKhYknNWzym0fSc/rMgv6jgZf/jK
         D2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P1mIXTyxQXGDDIcHxeiomhmFzzers4Cd+5PsN1wDPv4=;
        b=bHx8etNj6vsxJwDl5NzBkOj6E6E3Eyv1yNMN62lRJbqnnUfImJ9LSV0ehYFZAwuBaK
         BXj2yCbuARJDVpjvUuWzTC80pLo8oLzB07ocOPU4GIJQIK17Q1ZrSNnuRE6hfGWXoUKJ
         9E3tSoc4Hr9Fp1PKbCCO3S2Cu0MFwmuijKBGIsEIgIX7yCHwbrVE0uGDbIjOEYSPB5Dm
         HDnCTGgw9bK5tYIO/XgJokRtPB4xc0Jl6d6HxX0+kWCAQMliwDmi0nusHLUpCFFR0+0P
         LcbgoMtOKqL4OcY1yL3xruoZ6R2CUSlKO+pWF52+gbgs6EQtGnlK+UnACMdLvPuCvhA9
         6mDg==
X-Gm-Message-State: AGi0Pub27B1LModCMdfGaGdWPWKoguyRLpyL5fRn8xr1XKNwyLp2mHHc
        FLJSRK0iF59jICAXpICTvDO3Yk4A
X-Google-Smtp-Source: APiQypK0COmJrUKypgTbPl0SyWXTjmaBNY7golqOgA3v1YG20SxYzjHRsm6IcLzYqpU6gZymvgYE7w==
X-Received: by 2002:a63:4846:: with SMTP id x6mr8710286pgk.209.1588801718558;
        Wed, 06 May 2020 14:48:38 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id z7sm2703432pff.47.2020.05.06.14.48.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 May 2020 14:48:38 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2 1/4] credential: update description for credential_from_url_gently
Date:   Wed,  6 May 2020 14:47:23 -0700
Message-Id: <20200506214726.81854-2-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.686.gfaf46a9ccd
In-Reply-To: <20200506214726.81854-1-carenas@gmail.com>
References: <20200505013908.4596-1-carenas@gmail.com>
 <20200506214726.81854-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

c44088ecc4 (credential: treat URL without scheme as invalid, 2020-04-18)
changes the implementation for this function to return -1 if protocol is
missing.

Update blurb to match implementation.

Reviewed-by: Jeff King <peff@peff.net>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 credential.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/credential.h b/credential.h
index d99ec42b2a..f51703d9ce 100644
--- a/credential.h
+++ b/credential.h
@@ -177,8 +177,8 @@ void credential_write(const struct credential *, FILE *);
  * Parse a url into a credential struct, replacing any existing contents.
  *
  * If the url can't be parsed (e.g., a missing "proto://" component), the
- * resulting credential will be empty but we'll still return success from the
- * "gently" form.
+ * resulting credential will be empty and the function will return an
+ * error (even in the "gently" form).
  *
  * If we encounter a component which cannot be represented as a credential
  * value (e.g., because it contains a newline), the "gently" form will return
-- 
2.26.2.686.gfaf46a9ccd

