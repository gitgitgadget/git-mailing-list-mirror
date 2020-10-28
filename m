Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84ED8C388F7
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 00:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D93420EDD
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 00:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDN8SXjT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389402AbgJ2ABu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 20:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgJ2AAU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 20:00:20 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E608C0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 17:00:19 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id k65so1438435oih.8
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 17:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nBLZkEPbAWGcnMfTgFmqkFmvEuSgjQtn3OVicrRnUl4=;
        b=BDN8SXjTQ4gF5ZlIJQSVgJyx9+wfBxxE5NpCLByt0/kH12dAwy73TsasATFQ8tI3fv
         763osr6PPGWE75HqNXCoS43doGNnYMwT4vSiE3pO2N/bXOoww89nzW8DJQTY6gxwAke7
         2y9aLVfwsItwpqo7riQjQP3oJK8/mJC7B4TBb3SNYmLNYUf1lMvTGF9sgOymHfMbXV26
         ABvxS15+y7RJfYui+SGMkhsjz8ZsYTzFppMRfPeOMJyxVIZnCi9/ysy8pjzNF/WQByQE
         xZr0TPl35dw2NxjixSuj9t6vhGGq/84RiSVIXWL5yrOBc4M5r+Rdr5NU6HJKv1f0e+5w
         YEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nBLZkEPbAWGcnMfTgFmqkFmvEuSgjQtn3OVicrRnUl4=;
        b=hEsPWcMuk2VLJotimn3m3tpxIHlzZ6VDAVKyuLiTkgcJYyKVgWV2ZtwHcy62aevEmJ
         lSgssKqKR9geVWZH4DUoqAJFU/Pgb9PfcX7IBGqbntVhqLhUR32Pr4F0FvOh32JyQ7Ng
         mJ/SVNSXDuYpI9zr/VC1PKEpsWAu4WvymTohaTQTjezMJ0CdorRZH7OJo1JAhGcvKzVa
         7b1491BrmWXyXPZyyuvNhVLXD8q2ZWY1PNVrANvyjr4x/FlF6l7BMY/p3y9TTVZuxe2C
         X+/CzRQCx4TVYY8ERwa6XeFvVPsliz95NIQWnMBBBI8fZsQXI3UUvXn9WBF+oPhkbDdM
         ngVw==
X-Gm-Message-State: AOAM530jQLk8J1WBKugRUrK+Q2Krk/Ig+8Os1E9k6ceQxtpVqxB7vFWg
        o3yM0qliS6KG63JBCZsFbESIxtWlbmVBKilO
X-Google-Smtp-Source: ABdhPJyD3JL4yg5iVQZui5AN5Ce/vZILciVyNy+jNgKHDpKhOnvKt1nhzjQPW9B+3Afw2E1XuqSzQQ==
X-Received: by 2002:aca:54c2:: with SMTP id i185mr3347268oib.169.1603850847711;
        Tue, 27 Oct 2020 19:07:27 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id b17sm2348640oog.25.2020.10.27.19.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 19:07:27 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 08/29] completion: zsh: fix for command aliasing
Date:   Tue, 27 Oct 2020 20:06:51 -0600
Message-Id: <20201028020712.442623-9-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201028020712.442623-1-felipe.contreras@gmail.com>
References: <20201028020712.442623-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A lot of people want to define aliases like gc='git commit', and zsh
allows that (when not using 'complete_aliases'), but we need to handle
services that call a function other than the main one.

With this patch we can do:

  compdef _git gc=git_commit

Additionally, add compatibility for Zsh Git functions which have the
form git-commit (with dash, not underscore).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index ccf384ba35..f524c6042a 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -243,8 +243,12 @@ _git ()
 
 	if (( $+functions[__${service}_zsh_main] )); then
 		__${service}_zsh_main
-	else
+	elif (( $+functions[__${service}_main] )); then
 		emulate ksh -c __${service}_main
+	elif (( $+functions[_${service}] )); then
+		emulate ksh -c _${service}
+	elif ((	$+functions[_${service//-/_}] )); then
+		emulate ksh -c _${service//-/_}
 	fi
 
 	let _ret && _default && _ret=0
-- 
2.29.1

