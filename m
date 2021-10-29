Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413A2C433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B8C660FC3
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbhJ2VSH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 17:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbhJ2VSD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 17:18:03 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA72C0613B9
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 14:15:33 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k7so18538149wrd.13
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 14:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lkFiB/b95qi8AtHUtHivDCzc+U5s9+av6l7/Pw0pRgU=;
        b=eIXpRJNg4nz4qsbCZZwALZ6Aa8vQNr81vPRC/5zi+IER6CEmZ2qGyEpu45AoExCwku
         bW9sBqkPLwFpdK9YsXLiFmRDod4ZQirFYMRwgm/49XDvTMuTBge+XHI0Yy1fy5c5g5Ed
         5V5pp+G43YlOY0G0m6SOdMIVidxYvAYFWP1ZkYhr7utCDgCrLSsh9skJGaZv4l+4/MRq
         Z9WvF//uySCGP69Q4iBBzyhfx4swHMfDYbg7yiqfrxMKYWBrO4mkpdF4vxgfc9Qm2a45
         FdH/s7t4qix8v4aoavqd7vXX768OwuQRT532FE37uDCBBhSotXDOn6+JmE8J98QXLoL+
         6hNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lkFiB/b95qi8AtHUtHivDCzc+U5s9+av6l7/Pw0pRgU=;
        b=YGC0Yp/Tr7BDx9WNFjqSZrgePqDeqsOHDr2ZdQ5pUyHNzJMysNNKl52DvbrnLMqTDw
         M5CIjz/rPMGV69CvGCsX69mTHF7buXPNrAXnyWZX4SS47mDv5RD2/rB2jxI+6FX5vyy+
         42fE+a71GoNiG3cwpePlf2VUWWDms8z44LJ0//IIz8tt9eYkQ3RG43J9oDmhhR4hKwEO
         EX7XMUlrtMGiOQvyYI/r2wKE/x2TKQDWxUWBnWFgm+dgUtjmec3JKz5DJWFgZ8tNyP1R
         m2YAZL6rNdsN8SWQoGt+k87pcg5ug2zMVsRgl3aISBWMDODTguzjPNQeC9PcGkXv7fHc
         IJbA==
X-Gm-Message-State: AOAM530AoorlQ5cbhVJHE9mrIAteo0duRaBIeQlsf1szFFjMtHZjIkRU
        Ne4SLM4+yyRMWxOM65s+xeCWwZVMFqM0iA==
X-Google-Smtp-Source: ABdhPJz7ySYzo2/Fo0j3qxnribi7DjpSLSDiYt9NnHEt8mG9anhqAzPMURDTyNj5RpaB1X8kelPq1g==
X-Received: by 2002:adf:f0c8:: with SMTP id x8mr654321wro.290.1635542131751;
        Fri, 29 Oct 2021 14:15:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s3sm6641629wrm.40.2021.10.29.14.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 14:15:31 -0700 (PDT)
Message-Id: <57b2079f30a3b8cbaf83c93510abd5b1ad7fff61.1635542128.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1065.git.1635542128.gitgitgadget@gmail.com>
References: <pull.1065.git.1635542128.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Oct 2021 21:15:27 +0000
Subject: [PATCH 4/4] doc: add docs for newlineafter flag
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Provide documentation for --newlineafter flag

Signed-off-by: John Cai <johncai86@gmail.com>
---
 Documentation/pretty-options.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index b3af8506086..7de51c660fe 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -32,6 +32,10 @@ people using 80-column terminals.
 	This is a shorthand for "--pretty=oneline --abbrev-commit"
 	used together.
 
+--newlineafter[=(decorations)]
+	Used in conjunction with --pretty=oneline to add a line break after
+	decorations
+
 --encoding=<encoding>::
 	Commit objects record the character encoding used for the log message
 	in their encoding header; this option can be used to tell the
-- 
gitgitgadget
