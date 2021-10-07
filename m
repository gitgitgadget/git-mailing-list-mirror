Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4001FC433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 06:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FD1F610A2
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 06:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240255AbhJGGxC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 02:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240216AbhJGGw6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 02:52:58 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAE4C061755
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 23:51:04 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r10so15729718wra.12
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 23:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wSphJW77NGZ6yJKzBcFZADojysIOmdufyA8AVJIS2Qg=;
        b=NICwwqmfzdT3FrczvPwpR2HqtgX8DItlJB+0jiP6glvLR8kbONAca5Qb0K6xrujiGG
         SCKSqRHmc1nj4Xww0vd2VVh/vk0x/TKCg4QPx/Z5j5Tuh9VHpx83TdzQxwZcNsvmfRI8
         lbfi4UNw5KwGDLean6dC42yuSy1a8/p+Z9X3f6l+ZFzFf4D64pQ7NngFvyMnp3XwiWzt
         BHZPmIhBjdjz20GWsHP/rQW3EGKW42mP8CNHUYIfKkkz9a5U3/Q9+IBLTzS0D5QjufYo
         TS92naKnvAmbLV2TDspjW+BNJj1aSGTuYsXKJT+0clumqZBKMMHzkdVX7d6ltIVrkI/L
         4Mtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wSphJW77NGZ6yJKzBcFZADojysIOmdufyA8AVJIS2Qg=;
        b=ks5f+grt9GQMCjE5Qa4Tplkh1MZF2LSZERBl1tT0rX7/4Z/2tK3fSxxIIxuQX78lXL
         dt41L+LJXGfFtDK4kFAsNX2amu6kTwYtP3yOe+NxxHECR1xo5esg2EEFk8Ghvs/64swA
         LaWCGb/jh2FvHylBo1sSGQZvW8WsV64C2xl9rrZK+24OWTphD/cW0Va4/I2S0+gWlh/j
         TwOL+n97e2ojH+exazKfPD8028fVXLf2pV5YzcBtKaNlxYk/Y451BLAj0jLCTGDAQeu5
         YHwIhBrhTgqSswDWW1WHM36PRSChz7l4LUL0KWBJE/mvK+xMyIVQy8d4FMyMv/Us2CNK
         gbjA==
X-Gm-Message-State: AOAM532Qg+CZdZzOqIEs4NHHyc00mVTsYquFvFC6AVdIQ1tMGzT5PbC3
        +xGCl5kDg/Uc+/4Kq80re/JUW9DDKSk=
X-Google-Smtp-Source: ABdhPJwzAmPgGwgqoYpW6tM5ZDtQ1dePbBo9jevY/bOmFBbEH/XtWqEoN2PDhe8v86YFByqxZHddJw==
X-Received: by 2002:a5d:6481:: with SMTP id o1mr3299587wri.140.1633589463582;
        Wed, 06 Oct 2021 23:51:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n7sm23192714wra.37.2021.10.06.23.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 23:51:03 -0700 (PDT)
Message-Id: <9d1c05f5f414b77a4edd741b738f47d4b9e3c56a.1633589461.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.git.1633589461.gitgitgadget@gmail.com>
References: <pull.1054.git.1633589461.gitgitgadget@gmail.com>
From:   "Johannes Sixt via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 06:50:59 +0000
Subject: [PATCH 2/3] userdiff: permit the digit-separating single-quote in
 numbers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>, Johannes Sixt <j6t@kdbg.org>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Sixt <j6t@kdbg.org>

Since C++17, the single-quote can be used as digit separator:

   3.141'592'654
   1'000'000
   0xdead'beaf

Make it known to the word regex of the cpp driver, so that numbers are not
split into separate tokens at the single-quotes.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 userdiff.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index ce2a9230703..1b640c7df79 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -57,11 +57,11 @@ PATTERNS("cpp",
 	 /* identifiers and keywords */
 	 "[a-zA-Z_][a-zA-Z0-9_]*"
 	 /* decimal and octal integers as well as floatingpoint numbers */
-	 "|[0-9][0-9.]*([Ee][-+]?[0-9]+)?[fFlLuU]*"
+	 "|[0-9][0-9.']*([Ee][-+]?[0-9]+)?[fFlLuU]*"
 	 /* hexadecimal and binary integers */
-	 "|0[xXbB][0-9a-fA-F]+[lLuU]*"
+	 "|0[xXbB][0-9a-fA-F']+[lLuU]*"
 	 /* floatingpoint numbers that begin with a decimal point */
-	 "|\\.[0-9]+([Ee][-+]?[0-9]+)?[fFlL]?"
+	 "|\\.[0-9']+([Ee][-+]?[0-9]+)?[fFlL]?"
 	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->\\*?|\\.\\*"),
 PATTERNS("csharp",
 	 /* Keywords */
-- 
gitgitgadget

