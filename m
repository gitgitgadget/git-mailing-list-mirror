Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B42AC43461
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 12:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0358613C4
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 12:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343939AbhDFMVd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 08:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343928AbhDFMVc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 08:21:32 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FC4C06174A
        for <git@vger.kernel.org>; Tue,  6 Apr 2021 05:21:24 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id u9so16232892ljd.11
        for <git@vger.kernel.org>; Tue, 06 Apr 2021 05:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=LcR6o9VYfvm0fntkzy/NTfSNLrMBvtbH8J/tjEcmWm4=;
        b=mYZIisBfAT2AvW77QZWK1IZTyfLT2rbmY9gXZYexcrlKsRQTtbhhfPEyAXQ03bvzhD
         WIbApuoQvKjjJNuT7loL07WuvPMyg+NTc6/1d6FEgIrwtBnHxDjyG0qL31hkTc1cFqQe
         szdig9QkXJgMWz8A85YWNAJS7RuBA6Nt/j3XtTLMZDVT0UpeojXT+dubDf7fHzjk+82J
         nlcZ2LyeoaenVhoxgGkJmRFSaocwo4epEqv/wegRkUWDFmLXJZDJM3k/0AXRvo3eHT0e
         rNfLY2p7610UucRUPK9/Tmc4bWeJHzrb4zzWc8aqq4IIUJMkZfPP4J+MLM0milvIbX1Z
         kiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LcR6o9VYfvm0fntkzy/NTfSNLrMBvtbH8J/tjEcmWm4=;
        b=XAEG8s+OQ81zj++2X/XFEO7EiFgXoUeUbHBo1aMJGeQs0BxEWE/ks8uGcbpATES3ZL
         zmv3WCxcitbiJx2IpGY25nGKHhStDiZI/06BlKhLi1p3Isc3vZBkbeBKKOWZUE1U5MpC
         pCz2P0FxMkTP7hDOev3qX7WPtwjPRcbVLkvu1TaNK9qnmLL7ZAZcFyQrVFC7gEDnfO/4
         H5oi3PPhqQebwp1tuarDixkOV9MW3b2OEIiJdYwIOx6v5YYstm+TQaFXZq3fxod0Z77N
         u4AjGmHFGhXk6cKQ62MqgbS7Z3PJR4DTPIjkaeEkUf5Ph1XqldK5QshhldzPwWJc3JYC
         /HsQ==
X-Gm-Message-State: AOAM533y5LFIXBYoWDeYFybDarKWzIx0xjxnGv1om1USobyqLJbu7gwl
        1LBZ4WYRWXDoUhOB7CU6vzwHHXw0/Hpr7WsCFjDZeMyM+eGpQw==
X-Google-Smtp-Source: ABdhPJyuwbk7kyi34YDOSM32ZW76KD72c49R1MvV0JRGq+L0C4ZydlJachy/BXjMU1r5kxijSK4RXI7Q3R3huZE8yY0=
X-Received: by 2002:a2e:9a98:: with SMTP id p24mr18971394lji.86.1617711682771;
 Tue, 06 Apr 2021 05:21:22 -0700 (PDT)
MIME-Version: 1.0
From:   Andrey Bienkowski <hexagonrecursion@gmail.com>
Date:   Tue, 6 Apr 2021 12:20:45 +0000
Message-ID: <CAAunPhfjUSO0Po4sO7Hwxjq7_p0ke7VOD=XRizG1Fqkzymcgmg@mail.gmail.com>
Subject: Subject: Encoding of git diff --name-only stdout
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi. I want to parse the output of git diff --name-only and git diff
--name-status, but the documentation https://git-scm.com/docs/git-diff
does not say what encoding it is in. Is it always utf8 on all
platforms? If not is there a flag to make it so? Once I get an answer
to this question I'll submit a PR to add the missing documentation.
-- Andrey Bienkowski
