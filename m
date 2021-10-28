Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A01C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 16:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60044610CA
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 16:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhJ1QYu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 12:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbhJ1QYk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 12:24:40 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B88FC061224
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 09:22:11 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id o4-20020a1c7504000000b0032cab7473caso4972128wmc.1
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 09:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=v8bgle3Tq2F6mibjz2jqkYkWsDKfQ7r5bulyeJU8EXc=;
        b=eU4aWsekgO0WcfQY7Vs+9Jxd6PIqov3g5XNXr4U0pcS5SEfFdz8kvWTw906CEJGxuU
         jW9nXdp+MVuetV1R5ffuLngsH4ITBjnasDtNAUznYkAk+N5Qnq7Jl9iojiIo9qtPUfXy
         NyjX4jSyRMuEigmK07jegaF3/4TqBm3aoXos27tKBKcg8ADBKPA+29jp6F8dE5TJXkri
         JqxEddFKLIQhashyYLUY0rblI8VWP8Dc0/RStUenwGsi2KxvCegyvdzK3mJg0Gs5/qmE
         qvgkzWvIINjiSTle9ABRcv/MSh3YNdH3alKFpAPTDS1QlOsIzE6cppAQjZDfnwEQ6KlB
         xs3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=v8bgle3Tq2F6mibjz2jqkYkWsDKfQ7r5bulyeJU8EXc=;
        b=t847DhfN0UFDBH/Y/k0a4iFnOQ7aJf+I3POIVtzIp1FvV0rjTdmUdrdbuU6rltWlv6
         5P1YUdTBbtYLDJn/MKntojf8d2mwv8EbHfdmezmHaHOqB4fK13HHifTEj7n2Bw1YPqKT
         AwqNgHKo3cla5/M4NbOoj3fbkA/kSWrhGGfbJZqWh5IwHc7ZS5fquJFdHW8mAmzrTHIJ
         QeXF1/kJutzqx9kxIh/lIUrcaMXpHsQsO0QjLT4U3FisRhpQkTt+qFL5Ick/TiEIq1Cy
         t2L4L/bTu2jkCkEM9XT5cJC1ZdKhwRNeXD/g5fO3hxeDwCWtXPxO412V5YBy7w3Rd4sa
         YjhQ==
X-Gm-Message-State: AOAM5339Nz/0DOinwDBRgl4n8qEYk21sIh3FCNPE1dEBKzIsd5bfxVB1
        1SdWGhiho/4MeJ6Tx4aJtI+b/kGUVaQ=
X-Google-Smtp-Source: ABdhPJxRIu3Ynw/ptRyYQHr08MskFfO0RWIu6Ig8PVs4QoMt0M2yA+TfFufJ/nqAn6PsuK2aIplVhA==
X-Received: by 2002:a05:600c:3511:: with SMTP id h17mr13305325wmq.144.1635438130179;
        Thu, 28 Oct 2021 09:22:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n5sm6377638wme.6.2021.10.28.09.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 09:22:09 -0700 (PDT)
Message-Id: <20900b019f835e9293fb5d70ae8dbdced3b781c0.1635438124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1066.v2.git.1635438124.gitgitgadget@gmail.com>
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
        <pull.1066.v2.git.1635438124.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 28 Oct 2021 16:22:03 +0000
Subject: [PATCH v2 8/9] doc: git-http-push: describe the refs as pattern pairs
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Each member of the pair is explained but they are not defined
beforehand.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-http-push.txt | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-http-push.txt b/Documentation/git-http-push.txt
index 78f2bb75523..7c6a6dd7f6a 100644
--- a/Documentation/git-http-push.txt
+++ b/Documentation/git-http-push.txt
@@ -63,16 +63,15 @@ of such patterns separated by a colon ":" (this means that a ref name
 cannot have a colon in it).  A single pattern '<name>' is just a
 shorthand for '<name>:<name>'.
 
-Each pattern pair consists of the source side (before the colon)
-and the destination side (after the colon).  The ref to be
-pushed is determined by finding a match that matches the source
-side, and where it is pushed is determined by using the
-destination side.
+Each pattern pair '<src>:<dst>' consists of the source side (before
+the colon) and the destination side (after the colon).  The ref to be
+pushed is determined by finding a match that matches the source side,
+and where it is pushed is determined by using the destination side.
 
- - It is an error if <src> does not match exactly one of the
+ - It is an error if '<src>' does not match exactly one of the
    local refs.
 
- - If <dst> does not match any remote ref, either
+ - If '<dst>' does not match any remote ref, either
 
    * it has to start with "refs/"; <dst> is used as the
      destination literally in this case.
-- 
gitgitgadget

