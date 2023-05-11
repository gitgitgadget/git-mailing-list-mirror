Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32CDC77B7F
	for <git@archiver.kernel.org>; Thu, 11 May 2023 21:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239324AbjEKVTm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 17:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238915AbjEKVTl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 17:19:41 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EABD2D62
        for <git@vger.kernel.org>; Thu, 11 May 2023 14:19:39 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f42c865535so36631195e9.1
        for <git@vger.kernel.org>; Thu, 11 May 2023 14:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683839977; x=1686431977;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHRQknyIxF3+lTVfNovqlnPtcirZttRbNMIjXEH1Qss=;
        b=DONf56Up3uqsRz0jERs8btj1oK+O/ZMF2pSO3Ua0gYdoTGvnw1CaceIs7EbdzkBLxs
         er23U82MT3cJ4SbIUgEpH18moVIZ4YXN/FDyTO6Ibc0cvu2J4sqJzyXDk/kYcbQ7Zk3N
         /VxL5qU0ecNOisC49cJqYaMB7nE6izybEJEOBntxTR8zETXEFJ+iKDzYCpGnRZuMmE9r
         n4rh5pi9+hOxiOEd+KEIFH1C185IxvZl050K/NA/TwwQCZbRjMSyANeuhClsMGqQFElg
         O9HOrGO42FhVTTdWElFK6RRBpGGBOcmO5wa3v64Ux3e06jOh8VTZ5uCz7MHcrSpxCoEc
         /V6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683839977; x=1686431977;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oHRQknyIxF3+lTVfNovqlnPtcirZttRbNMIjXEH1Qss=;
        b=Utc95NWq8y9/gi8owWdbY9LowTzcbg2cJctobLdsVYuLlH51eBLaisI6V39PneADJQ
         jfaHVOg1S9tGlbnOj08GCC7ESnEuHQpjB+VUHmDYNH938AW13rq2AzEgTaG+AWwBn5XU
         cHRKIMvXvjWupscrJVslHMGXdrWRCazawe/3x6zXlWjudCVVXtEQ54eSmkyh9EQrHdfa
         ZN1B2Efy4HzUi5VqZjZEtfvnnOVym2hLpDyXBqj9baKQ6gzP6yvqzv/uhlCrq6Gfzuyt
         RC6OllSe8hxwI/g/T1dVCGcCgJlu/OZlsQaC887cP8yppuTmMNi0gm4MCsBNdGjPHurj
         KxyA==
X-Gm-Message-State: AC+VfDz43Waf8QslGSjhPX4l30V42JI97F6FBrVo1mpVOX0rZK8ZHKvl
        AhCNvUEXswa/JZ8cfJDgu1NwogCMIL8=
X-Google-Smtp-Source: ACHHUZ5pPOR8t3BfynFmKsugXG/o6YD2u5xBKNAUVMySuUWPIPg5C3o9SmyO+jXhd82vvI2UC6EIqw==
X-Received: by 2002:a1c:720c:0:b0:3f4:27ff:7d54 with SMTP id n12-20020a1c720c000000b003f427ff7d54mr9034883wmc.3.1683839977421;
        Thu, 11 May 2023 14:19:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c3-20020a7bc843000000b003f31d44f0cbsm26876801wml.29.2023.05.11.14.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 14:19:37 -0700 (PDT)
Message-Id: <65e6fbdec9248f24fbc0b40ce15c628f0167d901.1683839975.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
        <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 May 2023 21:19:27 +0000
Subject: [PATCH v2 1/9] doc: trailer: fix grammar
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Linus Arver <linusa@google.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 22ff3a603e0..1a1d6288b17 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Help parsing or adding 'trailers' lines, that look similar to RFC 822 e-mail
+Parse or add 'trailer' lines that look similar to RFC 822 e-mail
 headers, at the end of the otherwise free-form part of a commit
 message.
 
@@ -249,10 +249,10 @@ for the same <token>, 'trailer.<token>.cmd' is used and
 'trailer.<token>.command' is ignored.
 
 trailer.<token>.cmd::
-	This option can be used to specify a shell command that will be called:
+	This option can be used to specify a shell command that will be called
 	once to automatically add a trailer with the specified <token>, and then
-	each time a '--trailer <token>=<value>' argument to modify the <value> of
-	the trailer that this option would produce.
+	called each time a '--trailer <token>=<value>' argument is specified to
+	modify the <value> of the trailer that this option would produce.
 +
 When the specified command is first called to add a trailer
 with the specified <token>, the behavior is as if a special
-- 
gitgitgadget

