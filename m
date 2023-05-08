Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A3EC77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 17:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbjEHR2K (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 13:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbjEHR17 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 13:27:59 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBCF5FF5
        for <git@vger.kernel.org>; Mon,  8 May 2023 10:27:57 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3063afa2372so4408032f8f.0
        for <git@vger.kernel.org>; Mon, 08 May 2023 10:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683566875; x=1686158875;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4XuQ5rItvstgVqXa2LTkbSyy61Uog65+NnkzjrB9CY=;
        b=EbawhBEBW5nl+R2zjoTpkCrRGO6esU1GSp9dWE/A0vE/LUQBvnS2YJbFUVtTpjawOi
         6fZ8iKf1+vRxXwsdNhxAxo5K9q+MCDz6xtJgLFygtgOx95fP+Dasv9HcEmY1ulse0+N2
         O6O2m7FUF+/990VvOidq40Y1+yo0R6nX+zbvsTXhmRvuu8vaCMKwfRR3r1ChdA9vYwpU
         qeiSyOU0kZtt11VV1HJqXe0Bzgqa0e0StOCmwfxd4AfjHXI1An/+aMOcfSNUFEPY+nYi
         Plr5je5gT3LrFeBByNXdxOi87lNKeC6rdZNittchu9tZlWA36qs9bD6a2gibSyagQcu7
         YWow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683566875; x=1686158875;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4XuQ5rItvstgVqXa2LTkbSyy61Uog65+NnkzjrB9CY=;
        b=AvCVrcFVx49J0TqaeJl+Hrbx6vDTvdGkdv4vM9+bTQJmrLpEk6x3JUijbbhuqpvf5X
         67dyhA2OFlmFZ2aRkU3QHXxiBtfRar8zU8aJiB9TyQC9dQT321PDBYeUnejh70Rl6V3a
         ou1UZuTdHVMj+lYAl0NegKyScuJ0mQrjk53hCQaaz6PLFC9cPzV+k4glncImbQsP4oar
         RRYv6nRzR3c+7IzIk0n42nfwTLCWq9GCHySC/kRiCCbkHTKgVla5KfWJyPn5TsphJ/Ae
         b4BOKPz0U688l+hm5blfHlW9NrhOc4b+nh16LZ21V6rJFYVWf2nz7Qn7Pp6luYQe1D/t
         d9Yw==
X-Gm-Message-State: AC+VfDw8JtbxndANLcVuxB2ao7x2oRCrh+Fd8wlwP0uLYnkJNBeOVd+G
        AxQu4kAcoWfk4NsL8X+7pDdFpRJvUqY=
X-Google-Smtp-Source: ACHHUZ4KdUGcRpEOuuJexXlO/CBml7WEHZ6WUbX6Es1bEKH3Yidcx0xOgYYctK6Q8tgd0iiL00teJQ==
X-Received: by 2002:a05:6000:124d:b0:307:8800:bbdd with SMTP id j13-20020a056000124d00b003078800bbddmr5612698wrx.64.1683566875754;
        Mon, 08 May 2023 10:27:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i6-20020a05600c290600b003f18992079dsm17369928wmd.42.2023.05.08.10.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 10:27:55 -0700 (PDT)
Message-Id: <8e36d1bd1f0c8ca6b1210a537f4bb8403fab7c47.1683566870.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 May 2023 17:27:45 +0000
Subject: [PATCH 06/11] doc: trailer: trailer.<token>.cmd: add missing verb
 phrase
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>, Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

The phrase "is specified" is implied. Make it explicit.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index e80a9cd161b..c4675d9d3bb 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -248,10 +248,10 @@ for the same <token>, 'trailer.<token>.cmd' is used and
 'trailer.<token>.command' is ignored.
 
 trailer.<token>.cmd::
-	This option can be used to specify a shell command that will be called:
-	once to automatically add a trailer with the specified <token>, and then
-	each time a '--trailer <token>=<value>' argument to modify the <value> of
-	the trailer that this option would produce.
+	This option can be used to specify a shell command that will be called once
+	to automatically add a trailer with the specified <token>, and then called
+	each time a '--trailer <token>=<value>' argument is specified to modify the
+	<value> of the trailer that this option would produce.
 +
 When the specified command is first called to add a trailer
 with the specified <token>, the behavior is as if a special
-- 
gitgitgadget

