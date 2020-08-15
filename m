Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1595C433E1
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 22:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFD822053B
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 22:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6jH/BJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgHOVv0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728717AbgHOVvY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:24 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF20C025574
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 09:06:28 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v9so13017000ljk.6
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 09:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=st1tO+BI/Oct8X73aTNOqbXEhpW4uy5q+Qup+UN0cKo=;
        b=n6jH/BJXxNuKW+3IXIpjJj6A2uvlxfSs5hQS0uqZOwz9EZAarJmjaWs1tSeduATHsl
         6W2XI7IA9Vc7zutmvfs+XcHGiqn5KHWwKrQXw3s3shG0BICgfR2P5On2BSqtjzofPxi5
         gUoIsY/KW1UHnaGHKs0sVVSW1hAEGJ7yoYeGnl5HxB8zkIZpDMaewW4k2BGjYFe+mMw0
         Fdow4LbjY56c7lGaM/uFpDb0xjoFGaNxqbcFNcUovWai++KE0Wjhaj5YKgpyqUw87zmo
         JwbIaEjjrKlGo7Vc0Eaf8MZ+ziYnHoq9gp7aTPy9+0J+08Ult2TPgegyaLGSr5xu3l/v
         7V6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=st1tO+BI/Oct8X73aTNOqbXEhpW4uy5q+Qup+UN0cKo=;
        b=iClkx4NNL5W/p+ImubGf7SxKMY6n5EH1T5C5pg4ZKbMzPMnY0F1PNAmtsd9jUxhgit
         S7tyv4bp+AivUgMwrlJx5Oy7hjv9lWYAjeAHJRUpqur0gfjG7KVT2suhNVk+BpOKD5ji
         toUXBtTXYh7TyITmkfJNaEzrqz7g5R0ftTTJpY7xEkhcZbXbZDS6YjVyhktu1jqVxr2L
         ImBnyzh4l9zBaSTRen8+bBs4eMo3mxFtHnBSAuD6+amTF9y6X+2dA/f5rxw6WxmZHst7
         C3WO1iMTv6+YwObxj6XOlng+6EOITRjZtGDbYDs344n7yi6iXw7wBLPV+MXsWJFZkiuR
         4hmA==
X-Gm-Message-State: AOAM5314EigziVKY4Cjc3owm5qGdAvmiVdrV7gmPTLkSSJukAIj++ND5
        NsGAWTd+Xnl76JgxcIg1E/Dfaevhpzs=
X-Google-Smtp-Source: ABdhPJwa6ipC9lHTUn2MU6UnJo7aFuqBuCyTORpBA3L+l2X9KmVb0oqAs+X/+Y/V2lxlmVNZOwqJSg==
X-Received: by 2002:a2e:810c:: with SMTP id d12mr3522011ljg.34.1597507586269;
        Sat, 15 Aug 2020 09:06:26 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id a1sm2670493lfb.10.2020.08.15.09.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 09:06:25 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/4] http-protocol.txt: document SHA-256 "want"/"have" format
Date:   Sat, 15 Aug 2020 18:05:59 +0200
Message-Id: <2e9f6b92946dc2fa645adc72f32d5d05a1720185.1597506837.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <cover.1597506837.git.martin.agren@gmail.com>
References: <cover.1597406877.git.martin.agren@gmail.com> <cover.1597506837.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document that rather than always naming objects using SHA-1, we should
use whatever has been negotiated using the object-format capability.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/technical/http-protocol.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/http-protocol.txt b/Documentation/technical/http-protocol.txt
index 51a79e63de..96d89ea9b2 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/technical/http-protocol.txt
@@ -401,8 +401,9 @@ at all in the request stream:
 The stream is terminated by a pkt-line flush (`0000`).
 
 A single "want" or "have" command MUST have one hex formatted
-SHA-1 as its value.  Multiple SHA-1s MUST be sent by sending
-multiple commands.
+object name as its value.  Multiple object names MUST be sent by sending
+multiple commands. Object names MUST be given using the object format
+negotiated through the `object-format` capability (default SHA-1).
 
 The `have` list is created by popping the first 32 commits
 from `c_pending`.  Less can be supplied if `c_pending` empties.
-- 
2.28.0.297.g1956fa8f8d

