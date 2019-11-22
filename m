Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9DCC432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 23:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E63D20714
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 23:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdzIYZtn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfKVXL2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 18:11:28 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:40586 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfKVXL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 18:11:27 -0500
Received: by mail-wm1-f45.google.com with SMTP id y5so9456012wmi.5
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 15:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=EOG1rGaowLQDcBeckX9ABpI/RANedv4O+J+nUPGMTak=;
        b=LdzIYZtntDLVSphtVeHv/GtmzPGIn15PZLBcvRaQADw9Ieuz0to6hTL/3R9AxSE/Ct
         nofh+NhAiu36pZ+pvjH5WnNtmjxVZZbZln5U0sSk35OT93cgMxVAnI0hN8CTCNpFju9+
         rsimHd2XmwPwNC1/lcW0NwhIoQCkAnm/AZpy9op6pLB79Quhvyo3VVkcGYGnHPEhY39V
         L54mTdqZvFCTkBdOVSMxNAaORjaflqmUoM+ss0lCUAWbJ2l26FSbbZP0Zs7e6LsUMZDA
         cA9xUhmsV0aAZ442ynEUzqq8A6no1YMMFgnFfA0Bwi7WE1MYU+bMI+wmBSpd725O9fy6
         FQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EOG1rGaowLQDcBeckX9ABpI/RANedv4O+J+nUPGMTak=;
        b=cLJ0/pQF/APofZ8zGuq1nJN1GNKK0ZHMpQTrp/GPII19soXduGhOFt/W6tmxBSdQcn
         t4UbGV01GKlN4jZQkKut/xLFotbVrrK7RtGVo0Kqw7pqtvksiSfkBQpbGi/gyiW/Txbe
         XN0Vu16Olfo6Rvg4nqOieer6OzHkANqIshCwWfFXX69C9+/npBdesq9fZcKkCRumvKwL
         vvL76Hrf1Yf7JlJTxlCqPaBg+JTVdPoT79ytSVVR0e8jOt7BJWI76+y7A0QO2dfDppWT
         ej0WeBAw6MPAMGF4pWsy+o+pXYVJ3QNdRQR2M0vHnqo+Y8i2CLGLzGu5tL3ALR/TYXmI
         nD4g==
X-Gm-Message-State: APjAAAXbOun6PcXqcteT2TMkWWHWntrtebvKKbdTSJTIwXQFkXOTB5X/
        nLoyNmwEikomiqmnXUUio8BU7w2m
X-Google-Smtp-Source: APXvYqxNqymcNY/KU5+MIlH5aG3xn7PiZ5e4eifsKnNMXbFKdjgx9PKBKShwQnawjMYdd9KkrIizmw==
X-Received: by 2002:a7b:c18c:: with SMTP id y12mr19005001wmi.145.1574464286209;
        Fri, 22 Nov 2019 15:11:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y19sm597799wmd.29.2019.11.22.15.11.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Nov 2019 15:11:25 -0800 (PST)
Message-Id: <pull.470.git.1574464285.gitgitgadget@gmail.com>
From:   "Manish Goregaokar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Nov 2019 23:11:24 +0000
Subject: [PATCH 0/1] doc: Correct man page for the SHAs reported by 'submodule status'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation is currently incorrect, it talks about the checked out
SHAs when git submodule status actually reports the superproject's tracked
SHAs.

It's possible (but unlikely IMO) that we should change the behavior of the
tool to match the documentation. A flag for this behavior may be useful.

Manish Goregaokar (1):
  Documentation: Correct man page for the SHAs reported by 'submodule
    status'

 Documentation/git-submodule.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


base-commit: 5fa0f5238b0cd46cfe7f6fa76c3f526ea98148d9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-470%2FManishearth%2Fsubmodule-sha-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-470/Manishearth/submodule-sha-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/470
-- 
gitgitgadget
