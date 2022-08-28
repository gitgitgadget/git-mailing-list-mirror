Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B77DECAAD2
	for <git@archiver.kernel.org>; Sun, 28 Aug 2022 06:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbiH1GyD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Aug 2022 02:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbiH1Gx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Aug 2022 02:53:59 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA82E52FC8
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 23:53:56 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id l3so5177579plb.10
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 23:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc;
        bh=uxJra4/45zAeohrkhls5+cUYP/AwSDSS/oSWV40wvn4=;
        b=kA8p60u2L1EgLgYIzSj1D9bCfnCxhW54yUFAgYZQgGrhC/ea5XW/7gmAV8VjEWzwqa
         LQMAtjLP1TSF273Fyiu/nGQOfPgW9Y1DXK0QNm6biE7DDL/6Uak8W3YJKHm6y7iv7jvO
         M2hdXFo2R6mDPI4wqhRlfHlhnBh12CeKszj6MlC6/m53Iskf+qjnszslhyeMgeV614QL
         dfir+yY/1pjJoDPNe5Odg1vAKjltwMkO5NaUjG6++PNABDtjFbpqFXlhmApg2HfjC5Ur
         ULvZm2o5OAwTKaUdtF4twFhlT96KcHdbDhrOpln6VgN3KoDO1FQPnO6iMhn0W7uscLCS
         4ybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc;
        bh=uxJra4/45zAeohrkhls5+cUYP/AwSDSS/oSWV40wvn4=;
        b=yqpmsgnEYtFLWpN5NESMD9+GlaxcbaYSsYHWlRF4aU/NWvOWW/GTaarw0B/3JsBulP
         C/JA/hCTSbFXO0iAJawAoIPz9TxXBTI+r0hVzKvfa+CMU/P0KPgbbytwC8Y9R1z77W4X
         AvqBzFlZIK4PP5MWDUSuYs03eqVz5yM9LBT76xtmMl68xZjW55qVkQES2DRDdR/4jexQ
         eLJMdhplLJB7/xz/Z2PjdxnNcIdoXLqetaxY9lc0+yiZxcYBmpiCZG0hA0+3PCN3Q8qq
         Y6OoEv9BDlPtPu5jZo+Pbf18rU+FIiw8cCLuxumutiD9iwb6ibczO4OC7lyRVBGx4Rp9
         lsQw==
X-Gm-Message-State: ACgBeo05hoPfqSW85LIpCKR2tX+KvFqljQCM+DX+WN2w6/RPVSzUCHwd
        qyCRpUVgWetRYjvjhW6VbQw=
X-Google-Smtp-Source: AA6agR7fiUzp3lxTD/I03tF30pcFMH1AA2T+FirWMBEKnhW67EtRru/hTapINteHNxNNXL39qtPodQ==
X-Received: by 2002:a17:902:8505:b0:171:3df7:dea1 with SMTP id bj5-20020a170902850500b001713df7dea1mr11268564plb.110.1661669635656;
        Sat, 27 Aug 2022 23:53:55 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id z5-20020a623305000000b005251f4596f0sm4717766pfz.107.2022.08.27.23.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 23:53:55 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 06/16] bisect--helper: make the order consistently
 `argc, argv`
References: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
        <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
        <c9dc0281e38bf9bc0bce72de172b5dbadbcbb1f5.1661604264.git.gitgitgadget@gmail.com>
Date:   Sat, 27 Aug 2022 23:53:54 -0700
Message-ID: <xmqqedx0voxp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In C, the natural order is for `argc` to come before `argv` by virtue of
> the `main()` function declaring the parameters in precisely that order.
>
> It is confusing & distracting, then, when readers familiar with the C
> language read code where that order is switched around.
>
> Let's just change the order and avoid that type of developer friction.

Thanks.  This did look disturbing to me every time I peeked into
this part of the code.  To some it may be insignificant detail, but
these things add up.  The result is much nicer.
