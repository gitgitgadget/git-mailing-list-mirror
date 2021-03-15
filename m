Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888D5C433E0
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 22:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 534A064F07
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 22:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbhCOWCJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 18:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbhCOWBs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 18:01:48 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F2CC06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 15:01:48 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id t83so26069344oih.12
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 15:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BbVO6JDl28WsN1kdTWzHPz/YpL5xrU/NO9Hno+uSKGw=;
        b=kqPbIlNWTMeEII49Kp8p5YA41sCxOUCirZJiQcTairFzp/9QD/+Kw5IssSvNpdUVTJ
         gsxq5jw1WPh/YwaLGSICq+wDHJ7DvHmM2nKc29vvohjuPEs4nQ8VUSWMsxgx17HvM3Ra
         IUOENiMGro5Ig0mo5W0I8dh2i+zosKcCSHq8NR31NNqIB6DqLoEM0KCOn98/CWmNA+cP
         d4vQRV5c17Jae0T8jXPyK6LSnK4jKHaoZ5KlJCWkKNKC+OxiT6Pt0K146dFIPQSx5ids
         IUrAt8gDUd9z0msKSFh5LJz+D1Sf0mrIAOvPGSr9K9IeKZtA7yLoo8PmQ9j+K6bg2DHM
         Hqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BbVO6JDl28WsN1kdTWzHPz/YpL5xrU/NO9Hno+uSKGw=;
        b=tHGnSJ8K1z1sLVJaabcgI9kJW8w93lR7oH54YsbDP3OAROJ7cL2MSjfdcV2pDSucff
         kmHjJqIYoS6Tgs++2dSIk1+uebJaoGp24oITDRPHBeyp2IZ6IHmRh66yZ1B+WdYaczkE
         cvUu5xTtAJaKFfvi19/VkiT9/oFIGAUFEiy0g6hZ3mS/juzT9VrSOX0YlaTeDWIX+gKw
         /et3PSKtvUMi0vjBOxdgXTsYUa/ZcCD9TJofrpu54fSVd6GoZaV6T0Z705sg586tEPZh
         KA0K1YjH7mtRRV+DSf0YDAWrrUf/cY0qTHztIGcP51ZAhD31XTl+1zbYNwYercszshSJ
         I3Pw==
X-Gm-Message-State: AOAM530kPIgRuCCroVns6+ULw93OfdMLF9pBdDM/BSYhvey8mmr1DZIc
        6Ie/qmDYUyHsIZypV1BIFGvNJGKNMv5UoZ4bJf8=
X-Google-Smtp-Source: ABdhPJzUpnG7WyOHW2Kqdm21ZWna2saENERaRcOPyuQjLgbRJ/A1UmM0bPG6X2E09oTyFvHniz6LTXlVCrdzKiWmmoY=
X-Received: by 2002:a05:6808:647:: with SMTP id z7mr301112oih.93.1615845708051;
 Mon, 15 Mar 2021 15:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <pull.903.git.1615760258.gitgitgadget@gmail.com>
 <dda5b537a3f0706ebf933e2b2efd996267e9d9b1.1615760258.git.gitgitgadget@gmail.com>
 <CAPig+cT9aAPGzysqAz2OBrZP-7Ci+h+W5wFgnRm8bsde9K6zdw@mail.gmail.com>
In-Reply-To: <CAPig+cT9aAPGzysqAz2OBrZP-7Ci+h+W5wFgnRm8bsde9K6zdw@mail.gmail.com>
From:   Nipunn Koorapati <nipunn1313@gmail.com>
Date:   Mon, 15 Mar 2021 15:01:37 -0700
Message-ID: <CAN8Z4-VFekryNYczJBkFQpkLJngcHJ5JBH0tb5ObNsrc241uSw@mail.gmail.com>
Subject: Re: [PATCH 2/3] fsmonitor: add assertion that fsmonitor is valid to check_removed
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Nipunn Koorapati <nipunn@dropbox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Unusual 4-space indentation rather than typical 1-tab.

Thanks for identifying - will fix in the next patch series. Perhaps in
a separate patch we could add a unit test that validates the codebase
for such style?
