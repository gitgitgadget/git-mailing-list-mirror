Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4713C001DE
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 03:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjGZDF2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 23:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjGZDFP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 23:05:15 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6A11BE8
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 20:05:06 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbc63c2e84so63328805e9.3
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 20:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690340704; x=1690945504;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5fOw66Oz/l74QmvF25VG2PF3rAhwtQYaMAuXKwfkGw=;
        b=cgnkNUOEt98/ydwJRzs9GFu5xpyoaw+5IJVl9IuWsW8ofiyPDpZDmU1BbDRY7bAZhA
         RK63ytB3X60jpoGZL9PNeJ0KC1dFL4NKzkoWiJpupXiTfaW7VdQCFftQmpxh7LLlku+m
         XWo2JOaq8WHfw4zYGqa3zoNyllQlJau56nrI/SoOe7vFawkbGdO2iNuvzIkHBzaZF75e
         GP4iGJE8R2+uOG8eQXse9NfcLKOsrpv2Uf9sOZx+sp6H1e8Ul+ZCLLgGSD6CnySBrHud
         ZNL9/ADQr12oZx1MzBPsLCEodb5Fv5TJ//jxszO3PVaA1s6xhbUsXOciyEZrLChB/5zS
         m/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690340704; x=1690945504;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5fOw66Oz/l74QmvF25VG2PF3rAhwtQYaMAuXKwfkGw=;
        b=AGAW8GPT4KMs6cLwZ1xEoRuMb2SGDcGhNAljJoA5IBftZAV2Oq6d4QSb6UgD13NRst
         T0IXlQL/Ghv4nBIP38RjrvjXRZP3BBIBUImNoMAoy1+TvSDja+X/GOR0uSTF1gqdCAmr
         wLixnrGD0KlwH04XdwFbiWGLoNMm/QK75MPTmv7KEuI2RiBIjaTS+paAJhlW19PNVvaX
         +dVmSxZskwwKjI9up+E5urv8Q5d1SomJ0EE3X9PxWeYhB7T1RutpiQxSlpMSipd/DFKW
         qp12iPqu1IHj94c0G/yshpFskJldRlltSZdDbJYLM/mV0p88hJGPhS/KnCy+wJ4X62e1
         xYyQ==
X-Gm-Message-State: ABy/qLYk96GEFSJkjQBJCKjCo1xp6/AObdcHDRl/lpnznLMTitx7RaaM
        Hb8zZCoMz2z7bnJD3XCETNxhvff/4a4=
X-Google-Smtp-Source: APBJJlHJoupCIvEscdPPinIZ8nG3rnMLn/3/dPLo8F9zFWOrnz1+xkl/5VLhgxiV+1M+jFaDQeSMrA==
X-Received: by 2002:adf:fc05:0:b0:314:36c5:e4c0 with SMTP id i5-20020adffc05000000b0031436c5e4c0mr466515wrr.11.1690340704540;
        Tue, 25 Jul 2023 20:05:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y19-20020a7bcd93000000b003fc06169ab3sm660629wmj.20.2023.07.25.20.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 20:05:04 -0700 (PDT)
Message-ID: <69fef8afe64156a1f54e9e1b7bbcc73d2867695c.1690340701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1556.v3.git.1690340701.gitgitgadget@gmail.com>
References: <pull.1556.v2.git.1689314493.gitgitgadget@gmail.com>
        <pull.1556.v3.git.1690340701.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Jul 2023 03:04:59 +0000
Subject: [PATCH v3 3/5] SubmittingPatches: de-emphasize branches as starting
 points
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

It could be that a suitable branch does not exist, so instead just use
the phrase "starting point". Technically speaking the starting point
would be a commit (not a branch) anyway.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 7919a362e31..f1d1446764b 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -7,8 +7,8 @@ Here are some guidelines for contributing back to this
 project. There is also a link:MyFirstContribution.html[step-by-step tutorial]
 available which covers many of these same guidelines.
 
-[[base-branch]]
-=== Decide what to base your work on.
+[[choose-starting-point]]
+=== Choose a starting point.
 
 In general, always base your work on the oldest branch that your
 change is relevant to.
@@ -317,8 +317,8 @@ Please make sure your patch does not add commented out debugging code,
 or include any extra files which do not relate to what your patch
 is trying to achieve. Make sure to review
 your patch after generating it, to ensure accuracy.  Before
-sending out, please make sure it cleanly applies to the base you
-have chosen in the "Decide what to base your work on" section,
+sending out, please make sure it cleanly applies to the starting point you
+have chosen in the "Choose a starting point" section,
 and unless it targets the `master` branch (which is the default),
 mark your patches as such.
 
-- 
gitgitgadget

