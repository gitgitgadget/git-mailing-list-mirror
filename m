Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DD0C433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 10:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 038D62081A
	for <git@archiver.kernel.org>; Mon, 18 May 2020 10:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dtucker-net.20150623.gappssmtp.com header.i=@dtucker-net.20150623.gappssmtp.com header.b="CEMMd23N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgERKEO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 06:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgERKEN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 06:04:13 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7056C05BD09
        for <git@vger.kernel.org>; Mon, 18 May 2020 03:04:12 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id 5so1703475pjd.0
        for <git@vger.kernel.org>; Mon, 18 May 2020 03:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dtucker-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J0vUfOdbd0WspuKYL+x/DNmSVCpT4NTQ/1rV7n59hWc=;
        b=CEMMd23NF0oWwu7ZQtyKVfXtv8NArnZTXdNPD43NTkQuZHkX2En/6ACjJ8/5pgCoLi
         hlP7cAp6Ff/jkSj85xG8HWyXpkUCcRfU4smK5AoYCHLtHvzaGgmLkbyitH5kfqQKKDRc
         OgW8dcJ+oTrP8U/Dx2hB5DILP6QuVeSzzlHvK7rzQjqY5FeEg2XaeC0nF8thRK9yOhgY
         zOUaHIJwJJXcTR+e98z8wj/edB94xKxxaPDA69quv/m9UEFX5GdMDczUUiRHeD3seQOl
         HqYhZkysudPel5gR+8SmgK75mXnYDs5jSp4cVjWlSZelweZ9mGrZbWnKtphz0mVfSGv1
         o2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J0vUfOdbd0WspuKYL+x/DNmSVCpT4NTQ/1rV7n59hWc=;
        b=TYgIbguoIviDN67uIjILpEJRHgChIop6kkwyarhu00ZOaZT1J/buk1SuVpf5E0bizP
         d2NP8fTBcmZiuQP1kQZFOgnHklunc1CFz1pCn6VQ7TbrqBvfrFAejcgrAGjlTXVEodpF
         aSE0qwc77fZYAXCTd4L5cm8sCPT77cAF6SMMTAxJmDOl9zXnRguQ9WbP2N22y4tWjBMe
         OaAgHxEJuRBSns+iZUcjgPRUkNpDD5IBYanS1VwaqUN0t1X60VUzyeVo/56X3Uthr+1+
         aZzCfMJ//0VNa4dhVUX/o6yMXUpWSUSkrurENwzbL3S4NkCZ0V8CBgaNX+8a2mEBksDV
         ECZQ==
X-Gm-Message-State: AOAM533qFmdC6NQhBRtf/BRaAIzT23HyvUEQwSInzq72eIa9zM9A5Tqu
        n6osZwp2WxneSsY2A5nL1ktij4TITVBXl25DTytQdptCJoXlE3UI6xTxEz19TtLbYyWIzwdQKDr
        WDQFeX+cQdhRwo2/99lt/oYxccuvmMsPin7cF3YaX9S6B0LytMLqfkrAit1gW7HE=
X-Google-Smtp-Source: ABdhPJyMu0mknLqfnE2Ut0uJAc9NK3KrMnixvgn/5G282RkxZAU3VA3KDAQStvyvgGtpItUMwkG08w==
X-Received: by 2002:a17:90b:238d:: with SMTP id mr13mr10975230pjb.236.1589796251764;
        Mon, 18 May 2020 03:04:11 -0700 (PDT)
Received: from fw.dtucker.net (2001-44b8-3110-fb00-0000-0000-0000-0248.static.ipv6.internode.on.net. [2001:44b8:3110:fb00::248])
        by smtp.gmail.com with ESMTPSA id k24sm8331507pfk.134.2020.05.18.03.04.10
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 May 2020 03:04:11 -0700 (PDT)
Received: from gate.dtucker.net (2001-44b8-3110-fb01-0000-0000-0000-0001.static.ipv6.internode.on.net [2001:44b8:3110:fb01::1])
        by fw.dtucker.net (OpenSMTPD) with ESMTP id 5d6de44d
        for <git@vger.kernel.org>;
        Mon, 18 May 2020 20:04:02 +1000 (AEST)
Received: from gate.dtucker.net (localhost.localdomain [127.0.0.1])
        by gate.dtucker.net (8.15.2/8.15.2) with ESMTP id 04IA413X029489;
        Mon, 18 May 2020 20:04:01 +1000
Received: (from dtucker@localhost)
        by gate.dtucker.net (8.15.2/8.15.2/Submit) id 04IA412Y029483;
        Mon, 18 May 2020 20:04:01 +1000
From:   Darren Tucker <dtucker@dtucker.net>
To:     git@vger.kernel.org
Cc:     Darren Tucker <dtucker@dtucker.net>
Subject: [PATCH 6/7] Check if strtoumax is a macro (eg HP-UX 11.11).
Date:   Mon, 18 May 2020 20:03:55 +1000
Message-Id: <20200518100356.29292-6-dtucker@dtucker.net>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200518100356.29292-1-dtucker@dtucker.net>
References: <20200518100356.29292-1-dtucker@dtucker.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Darren Tucker <dtucker@dtucker.net>
---
 configure.ac | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 14e09b04b6..87a39c5ae0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1164,10 +1164,16 @@ GIT_CHECK_FUNC(strtoull,
 [NO_STRTOULL=YesPlease])
 GIT_CONF_SUBST([NO_STRTOULL])
 #
-# Define NO_STRTOUMAX if you don't have strtoumax in the C library.
+# Define NO_STRTOUMAX if you don't have strtoumax in the C library
+# or as a macro in inttypes.h.
 GIT_CHECK_FUNC(strtoumax,
 [NO_STRTOUMAX=],
-[NO_STRTOUMAX=YesPlease])
+[
+	AC_CHECK_DECL(strtoumax,
+	[NO_STRTOUMAX=],
+	[NO_STRTOUMAX=YesPlease],
+	[#include <inttypes.h>])
+])
 GIT_CONF_SUBST([NO_STRTOUMAX])
 #
 # Define NO_SETENV if you don't have setenv in the C library.
-- 
2.21.3

