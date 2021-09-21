Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE712C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 16:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A59DD60295
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 16:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhIUQ6Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 12:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhIUQ6O (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 12:58:14 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C81CC061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 09:56:46 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id j14so6684670plx.4
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 09:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=LycN7RGulo0uMw39wUfFdQ4/3M76sPsUtHPaYvL5QFA=;
        b=QyzTpUiK9MEdSqJEzjhmpJufVONt+FSEMbCFayhrtajF8rbcXMgP2iTLy+aUFKLfA4
         q8JCie/23iyCx67dBAp3feUydosJo2XECycDM2enR9Zgt36lQ+nelfzYxk5roBjmKo/3
         fP4oa7Y3gklGo7mPlpx/3o1D/XXFdP1P9yCWM553gYkBZ1BkXBsuIaera5cWSacbxmUQ
         FHdcODm2OqlBI1tOATTmS0RdiYXCjzj4dxfoIn/l3eAuyq7XNDHUNeU5U5tw4jqeSxZe
         X9uOxsWVZG7Wfnqusn3dgDZlKYAlB5kYyskzew9pXebB1DUIAyrigXMZANzIv6yVQ8e0
         kD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=LycN7RGulo0uMw39wUfFdQ4/3M76sPsUtHPaYvL5QFA=;
        b=uAc7rvi1l0R5WFiBa9QO63Y4OrB4tp6T1T50cfvBK1lY+8i6/clL56ULALhIUGvUYE
         8l6Sl0jEpLXdNKttVQ9/3e8Ma9Ar+7j+rqvxkiWSQexqvMrJYxykfRsp262/BwmnE+lQ
         MwTKmvHjwWsmfyp9FByaet7Wg3p/wDQa24XRUKtKd0tye5Imbz1a4ixiuYxX1J1wx92o
         LldfzgbM3cnAkBX9ZepZa63Ifijaz94O5Kpx+BFLr6npfIW3CZrnzyxZH+4vBFTKyvpI
         2Fb0rnfMZfcZ1qZ1G8d/SGTMvg9boDR4Ljrda+i0ZP15CpwvVyFLQ7yp+tpZvE8BM/Ri
         hEmg==
X-Gm-Message-State: AOAM531YjGmQIwr2TkKwQ5gQ8+9XArPnEDjEafxETnuLPQq5Rx9g+gBU
        gxSYXqWYQkvRCyZQgiVAVVs=
X-Google-Smtp-Source: ABdhPJysfc9q5X3VG1mXa0K4TsRyUd60J1P8rlLopbjGiHeX0XUiL5Y7DV0o0KtqH2HenA9Axkhi0w==
X-Received: by 2002:a17:90a:7d05:: with SMTP id g5mr6381663pjl.14.1632243405433;
        Tue, 21 Sep 2021 09:56:45 -0700 (PDT)
Received: from atharva-on-air ([119.82.121.152])
        by smtp.gmail.com with ESMTPSA id k127sm18927203pfd.1.2021.09.21.09.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 09:56:45 -0700 (PDT)
References: <20210805192803.679948-1-kaartic.sivaraam@gmail.com>
 <20210918193116.310575-1-kaartic.sivaraam@gmail.com>
 <20210918193116.310575-2-kaartic.sivaraam@gmail.com>
 <xmqqzgs7azlq.fsf@gitster.g>
User-agent: mu4e 1.6.3; emacs 27.2
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>
Subject: Re: [PATCH v2 1/1] submodule--helper: fix incorrect newlines in an
 error message
Date:   Tue, 21 Sep 2021 22:22:21 +0530
In-reply-to: <xmqqzgs7azlq.fsf@gitster.g>
Message-ID: <m24kadlvef.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Junio C Hamano <gitster@pobox.com> writes:

> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
>
>> A refactoring[1] done as part of the recent conversion of
>> 'git submodule add' to builtin, changed the error message
>> shown when a Git directory already exists locally for a submodule
>> name. Before the refactoring, the error used to appear like so:
>> ...
>> As one could observe the remote information is printed along with the
>> first line rather than on its own line. Also, there's an additional
>> newline following output.
>>
>> Make the error message consistent with the error message that used to be
>> printed before the refactoring.
>
> Makes sense.  Atharva, an ack?

Sorry for the delay in looking into this, I just left a comment. After
that minor nit is addressed, it's an ack for me :-)
