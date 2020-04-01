Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7394CC2D0F1
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 11:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 400702080C
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 11:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+PWJs0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732344AbgDAL3G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 07:29:06 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:46659 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732273AbgDAL3G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 07:29:06 -0400
Received: by mail-ed1-f43.google.com with SMTP id cf14so29162681edb.13
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 04:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1g7xJNEHljtESnR5/L4oArBHPSBJu5a8+IEAIVDCwIk=;
        b=i+PWJs0w535KuC5UgJCkDv80PwO6yFlvRsvdlszp9rx1+8GrAPpLyaFcSW7SI8IUgz
         yOK6l7G8/YifgSIWNrHSjeWVH901Y5wkicvYNoZplolqAylJ2BamzAA8teJbQu05lK/N
         nlX8Loo76Thhtgsxfu+ypIp5UpiYLeppQFb2Rn3541weGfH+Zo3Gp3LoygiDcEqMk0Q1
         7Bu4VoyJF6sDJLxhq63Ja5AHgePGp6/iSf8Sboqya/TioNdDZZsS54Hmvk7Etve6RYUo
         gmXhFKpla+np9CVjvr6QU+mnAvGHyI6KDrMcCHxeMpiVMmv/oRvsw85hDxqkRxqPD8Wo
         aefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1g7xJNEHljtESnR5/L4oArBHPSBJu5a8+IEAIVDCwIk=;
        b=KZ4YhUVLcpl6sLdBIlEyGXaG12NWBl3znCIcKW3GSH0hRBKogGGe7cupddf/hc++et
         7h40E/fTJd8ZQbJPFFRl9LY2NEIrvleWHyZTOMjJwiG6LOIoRizhhEQGcX1zWC0x0/wE
         YLWE8cnwJQunSX9qJT8VZjoYXtaRsTGX/JMwLfbDkvjlObZfIM2nlNkr1KSIy+B8NSdW
         cA1midI8O3H6qzOj/1EWbMY8xccfiO1O1UerYpGTSwKwWIMpFuScgg8yQ8rtFK3dQsy7
         iZ/tnBPurTjzP7h0mESYFExuVDK1cnQhy8VO0/jJo/MSZbotmPQFIZ3pCVhXZdKnaa0C
         qeyQ==
X-Gm-Message-State: ANhLgQ1V2lSYmiv2IodD1k7NCiTk9TZKg7bhfVxymjV4cAhm9MWz6DJs
        E62XSrGR5wYXSzzLE3Y+ap9XBdA3
X-Google-Smtp-Source: ADFU+vsAU1ToDTxNFuRMtBDgb3j4qR0KFLrXaOAOlpQvGPr5ngZvTEXXe37kyH+4U4mhTjjnOz/QvA==
X-Received: by 2002:a17:906:694d:: with SMTP id c13mr20374272ejs.268.1585740544355;
        Wed, 01 Apr 2020 04:29:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id rp7sm475854ejb.83.2020.04.01.04.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 04:29:03 -0700 (PDT)
Message-Id: <ca95b3a371e71f53fc7c3eebe8847572b4ab3f28.1585740538.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v8.git.1585740538.gitgitgadget@gmail.com>
References: <pull.539.v7.git.1582706986.gitgitgadget@gmail.com>
        <pull.539.v8.git.1585740538.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Apr 2020 11:28:53 +0000
Subject: [PATCH v8 4/9] Add .gitattributes for the reftable/ directory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/.gitattributes | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 reftable/.gitattributes

diff --git a/reftable/.gitattributes b/reftable/.gitattributes
new file mode 100644
index 00000000000..f44451a3795
--- /dev/null
+++ b/reftable/.gitattributes
@@ -0,0 +1 @@
+/zlib-compat.c	whitespace=-indent-with-non-tab,-trailing-space
-- 
gitgitgadget

