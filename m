Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E0AC7EE22
	for <git@archiver.kernel.org>; Mon,  8 May 2023 17:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbjEHR2G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 13:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbjEHR15 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 13:27:57 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323A05BBA
        for <git@vger.kernel.org>; Mon,  8 May 2023 10:27:56 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f315735514so178735475e9.1
        for <git@vger.kernel.org>; Mon, 08 May 2023 10:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683566874; x=1686158874;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AssUO8Z9C5J3VDWNfO7V03Rki7Rts3xu6fvPb1FBxq0=;
        b=l4Wvl0tlKAL8EMTSXOSusSSEd8TZLBi0LACSn9OK8K39rFtrfWdA/IyYi5J5cK0Wp8
         /ukmnrs/Otg1ZCPvtEcEu4mCEgzbkncc9/rSux0OlNdRe4+3Js7rvKsrYvb80G7GtzRa
         4s+dqE4WNsXNaG8SevzKGaKyqb4rKXmNY3/zt8SKtytZ5mQxhMYzsifFtjyTnB7rnxMS
         Fdopw5awqBH18y4eVK5W3ZcLvi27cwmMSDktdDCKR9XTdQr/dsZqqGWjVFBZ1VbYyOgV
         66lXjRlVdK7PbqW+KRT6YF2eDOhlW7gV7I6EyJJ64+QbLFoJWgcYEyd7zn3Tug+krat7
         /TGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683566874; x=1686158874;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AssUO8Z9C5J3VDWNfO7V03Rki7Rts3xu6fvPb1FBxq0=;
        b=FJJC2+GgXqp11YNp+vdHdatSF6Zd/mUCNw1ClEw06iPEDPryajmqtCefyKXIzEGZAU
         mfG69QHvtX8AtITaY/hK/2N5BPWQcztoB8Abs5Woeg+Gcm+3pvLhArI2x7uHzzQlClx4
         7HM5+e6EM5JLFgxzo4pb7xBk1ToVKluLqUH3yWoS329t7ZPKSCB50MMVH+QHNT9A/WdD
         t7HTRZv8pfUgaC3vRTb+b57b4ihfey5rf4k2sEmMHxZHTw2kmpOE62pnGy3GfcddBz4m
         XP5BUh7KNEeaDCJggee9v+4wimjtW2GYEIfkz0b/LtYrVP4UP7G6C/CwRlYAyhey90rn
         vcpQ==
X-Gm-Message-State: AC+VfDxOONJRBMYOW9Kt8PA6/Ly/n9BtoILCjztVKb+lSUD9MM3yDuZ3
        D2/02aqA7lYww7lgNudOq7Gt4CL2XJQ=
X-Google-Smtp-Source: ACHHUZ6Ul6SA4LzpacfkDgF0PMIbJXnGC4U17bbJ4BWjRYrFvNeNGwkHIBvRF0lpONR5R8xnEI3w9w==
X-Received: by 2002:a7b:cb93:0:b0:3f4:2374:3511 with SMTP id m19-20020a7bcb93000000b003f423743511mr3614877wmi.10.1683566874440;
        Mon, 08 May 2023 10:27:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q4-20020a5d61c4000000b003063772a55bsm11838295wrv.61.2023.05.08.10.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 10:27:54 -0700 (PDT)
Message-Id: <0c10e40794d208ba408a2b1c394fdbd6caa7a92a.1683566870.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 May 2023 17:27:43 +0000
Subject: [PATCH 04/11] doc: trailer: explain "commit mesage part" on first
 usage
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

This phrase is used for the first time here, but it's not explained what
it means. So explain it just in case it's not obvious.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 3e60a6eaabc..7d6e250f37e 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -22,9 +22,9 @@ This command reads some patches or commit messages from either the
 <file> arguments or the standard input if no <file> is specified. If
 `--parse` is specified, the output consists of the parsed trailers.
 
-Otherwise, this command applies the arguments passed using the
-`--trailer` option, if any, to the commit message part of each input
-file. The result is emitted on the standard output.
+Otherwise, this command applies the arguments passed using the `--trailer`
+option, if any, to the commit message part of each input file (as opposed to the
+patch part following a '---' divider). The result is emitted to standard output.
 
 Some configuration variables control the way the `--trailer` arguments
 are applied to each commit message and the way any existing trailer in
-- 
gitgitgadget

