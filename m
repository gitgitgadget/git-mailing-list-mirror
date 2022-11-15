Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987E6C4332F
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 18:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiKOSJK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 13:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbiKOSJH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 13:09:07 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8ED4E0C
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 10:09:06 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id 63so11276455iov.8
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 10:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=grdhw9AAEOsSthJqY9pHe+jQ9hrWCHVmzAZ8jUde2vQ=;
        b=MwLhP+7kNT/2LAN5a8ugRk3FPgFjJbx6nfHisbA0vlpp/P/T+e/ReCSVRuDVB1o3GI
         b/TzMJvsE1vk58kDMIfHxwNtzcaWrl5gfYrCfyvVTwqo4yfjWDZiDMq6eKMCZI6MxvcS
         I3UaFPmQ89o4U9MM5po8Ouw9wIgt72vId5w2P01R2xRTkPyqmmV3HastdXcZ/4mWgO89
         8+gRXxoVPcL66RrQcch4wY34VhHrUtl8rcf9xBOMakVj747syNK9fvLUu9nrl0ERjbKM
         2YHeirSm1i1PTOcWuw1goClT3P+1sClhi/cdmp7IRLG0/VStvLDm6LAIeFiL4G7JXWeu
         bYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=grdhw9AAEOsSthJqY9pHe+jQ9hrWCHVmzAZ8jUde2vQ=;
        b=x/3rg4cXDYxm5nI5qp7M8oedinoTlBT2sGstVJ2VrKxftE395ZHrJKLh60SCAaGsuB
         JSs07n/3K+d5eO58BolOPX5tZdvUQMlRjnBK2vTErkOD30CQgk/zBvUNmcEZBl1Jvxk+
         B8ALC8vEvi1+IdMZZcUZ4duokMepe1HAmEDTW6d2ScV5xgAcN5IiGXEhIqUrsK6tohdS
         zjUPa0+3Dp0aIjMtNhqjvrctn3KKdc1Sd1P0MtL6572y8y4hwk/XU/ANVOMLt/rALGy5
         S8HL54NLVzjK97tN50EjooT24GapMfP53SO2KsNZRCA93sS1SG2bxZ093/kcrD4pymjp
         gf1A==
X-Gm-Message-State: ANoB5pl1TTr8R6lXomQ/R9KSYT6SkQ9XeZGkK87BsZURdhgt9Uj9mIYU
        RefYEwcNPeyde0BCWjnOFRmZAOVVxuwQRTmTbYk=
X-Google-Smtp-Source: AA0mqf42k6JsPhqmDP0X352X4Dgb77Shn0Fwe2hpyIE0+MqktqbuAGk1cuCSUSBik8YwQH7BUj3BwfYQnAfrlCupCfs=
X-Received: by 2002:a02:7150:0:b0:363:7cf1:3e2c with SMTP id
 n16-20020a027150000000b003637cf13e2cmr8407841jaf.182.1668535746087; Tue, 15
 Nov 2022 10:09:06 -0800 (PST)
MIME-Version: 1.0
References: <pull.1384.v4.git.1668055574050.gitgitgadget@gmail.com>
 <pull.1384.v5.git.1668110679098.gitgitgadget@gmail.com> <CAPig+cTO3NPg_Kx3dZhFMEtbMe9hRvaumZYxMnSJRyXqUA=p0g@mail.gmail.com>
 <CANaDLW+Ec0kY4AW5dGvnCaHgcvFOZQZO5EAi595KbVKj7KDg3g@mail.gmail.com> <CAPig+cT2+nitwD64FzG=6FvO7eUn3q-cq_CmmYeOXxOMyzvUnw@mail.gmail.com>
In-Reply-To: <CAPig+cT2+nitwD64FzG=6FvO7eUn3q-cq_CmmYeOXxOMyzvUnw@mail.gmail.com>
From:   Rudy Rigot <rudy.rigot@gmail.com>
Date:   Tue, 15 Nov 2022 12:08:54 -0600
Message-ID: <CANaDLWLT45GWgMLwj6Ec3nZf-A+Wx5YAkx7pFbmG-AAFf-oxaA@mail.gmail.com>
Subject: Re: [PATCH v5] status: long status advice adapted to recent capabilities
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Rudy Rigot via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That makes a ton of sense, I agree with your thinking. Thanks for
that, I'll do exactly that.
