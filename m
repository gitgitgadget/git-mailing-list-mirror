Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D116C433EF
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 10:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD8C163210
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 10:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237573AbhKOKmb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 05:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237554AbhKOKm3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 05:42:29 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8D0C061766
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 02:39:32 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so12030892wmz.2
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 02:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rdZ+Hyhdeez5sYovoNl4c+4e/sjVspsttzqtSN0P6X8=;
        b=NGLetI7Wk+GkOFTguwF8S1Z7XYBcwekQttYxBYwlPp3Qv7DJU3Q61lCGN3xpj4DJxP
         JwuaBXy4CVZXg6iyP4bvQKfBSD2YV4oMLYTtEnYeEGe8Bq3Wooa39peuHdj8V/OHE0Iq
         up6RZDQzHXwXE5yubeBuj4jzAzx+8Rffy5OUybAk0WyuoQXOfAq9m4zgYWXX0ROJFL9Z
         wBaFkQSjvmXruwFs5fYO/ZWwuVDTeq2jaqNep1YdRW0Fik/o+fJaDk38hNzEYPVhEJLY
         vrvg8JYcd/qYLbG87DLyfThZsRjeG3WBuoT2Nxt1RZVdtNx9MSPiKjcGQkFFTsfWToJd
         1TFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rdZ+Hyhdeez5sYovoNl4c+4e/sjVspsttzqtSN0P6X8=;
        b=6KrBsyJoLlMksImhUSLSBG3WQ/i0MQ7ZJ2aDoAWDG96WnPVDF2o/vO+R/LtS8t25dq
         9eRsrPe8dGxjCb1EYRONmmKbCPmyPYpofbt/BxTnaG/clDMuqnXsN7M0n+R9DzgDMqh5
         pzsr19vPJdCDrWV/5wDDCCEzuyvgavQw+iiawee9sFsdxR+LTciykX5+VOIISvfb/Yfy
         3CTk5xLlUrtBpmHRzZ6NoKXCyt9lkNKdg9/NFWmmDkdP62CHwfYMXz2Xd0cEOu+F/Y+H
         vFnvanR9T5ku+nDwucQbAP40IPRQUJBjFWPZ2OcH5AKV93rO02sL0wZZNQ8qtOj7Ao6K
         8PLw==
X-Gm-Message-State: AOAM531xPard51x1PZJDZEqXDNlih97E9Mt1gAzV0BPV1KKOkCKUTOd/
        GazylD3XZ2jMtHVe0Ryb1sDrnxQpmMA=
X-Google-Smtp-Source: ABdhPJzxmbLs5rsXfkRwmoZl/PE7E8HDY1cTms9nkwLVZmPRJHQWkNiv0S95UGmExfPjur2rHq+l0A==
X-Received: by 2002:a1c:96:: with SMTP id 144mr5570302wma.126.1636972771321;
        Mon, 15 Nov 2021 02:39:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h17sm13961925wrp.34.2021.11.15.02.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 02:39:31 -0800 (PST)
Message-Id: <9f1b3dd6d0b2d3f22fe960b0c3aaa3d888d26c88.1636972769.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v3.git.1636972769.gitgitgadget@gmail.com>
References: <pull.1076.v2.git.1636700040.gitgitgadget@gmail.com>
        <pull.1076.v3.git.1636972769.gitgitgadget@gmail.com>
From:   "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Nov 2021 10:39:28 +0000
Subject: [PATCH v3 1/2] doc: git-format-patch: describe the option --always
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Aleen =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Aleen <aleen42@vip.qq.com>, Aleen <aleen42@vip.qq.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Aleen <aleen42@vip.qq.com>

Signed-off-by: Aleen <aleen42@vip.qq.com>
---
 Documentation/git-format-patch.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 113eabc107c..be797d7a28f 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -18,7 +18,7 @@ SYNOPSIS
 		   [-n | --numbered | -N | --no-numbered]
 		   [--start-number <n>] [--numbered-files]
 		   [--in-reply-to=<message id>] [--suffix=.<sfx>]
-		   [--ignore-if-in-upstream]
+		   [--ignore-if-in-upstream] [--always]
 		   [--cover-from-description=<mode>]
 		   [--rfc] [--subject-prefix=<subject prefix>]
 		   [(--reroll-count|-v) <n>]
@@ -192,6 +192,10 @@ will want to ensure that threading is disabled for `git send-email`.
 	patches being generated, and any patch that matches is
 	ignored.
 
+--always::
+	Include patches for commits that do not introduce any change,
+	which are omitted by default.
+
 --cover-from-description=<mode>::
 	Controls which parts of the cover letter will be automatically
 	populated using the branch's description.
-- 
gitgitgadget

