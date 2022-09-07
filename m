Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCB2C54EE9
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 18:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiIGSMK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 14:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIGSMH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 14:12:07 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B732C00D0
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 11:12:06 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id f24so15419093plr.1
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 11:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date;
        bh=AGxbOD3Y3VDBaWdkjtdpwcqZpjhpJtuuZ1OWqCOWCK8=;
        b=JyiLiKmgjKEOJDj30x5bmr8c3JfBSrgciDGZToUA4OD4fQWOvOKWBKyegooxQGw2oA
         m/vJ7r3dfZpOaBkUA7i3/cVz8TJuP94Vsr9CZbdtV9+e6/fw9YNtubTrsZaexLgpc4Ea
         4zCMkLw2dL1t9C9nAhtBaKbnIn2xhNZWqxVL72Xgz0UAOKovC3mm5kXPMyky7YcYs14S
         yRjL1aVNwp9q/9daNcMgz9eQP0Iftcthl0TZHbMsF8qn5qYtW4CCAAUAQampSYUG//CR
         74+pQK2OvauIsv2PaqgafZNIA/BuwzRtYUcaC5wl8/oIUkESO42/iiKQ6QeqRxZHSbrr
         PnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date;
        bh=AGxbOD3Y3VDBaWdkjtdpwcqZpjhpJtuuZ1OWqCOWCK8=;
        b=g54mO8BDCyGlE/6fPOCCHr6s5jKtPMkeBNNH/Qs7AboGD4b1soyjd4p39p4fuSSdd2
         qmMRuVML2rjGhrGIMGGe8ErP5gok2ZRUS/2IpE1vcEO1tvkVcvvGtOp/hMrSqLd4TtsI
         /6P1CUDZkJPX/UohSh8TmYOlYrgr26T4vS1ldNzS75Ec/o3RydRDjgCv518tRDDiaW/N
         i1eup17TC37H4n37qZLUQPekdiz6hfj/ZrJuQtgfqteF9DfHDZPUEQGOfxmfJFUF0yHD
         kXk6uK41PTQX2yEV9GDXtCD+2Y6b3NrWXrcKaup+U0yAYknl0MK2tlgA3eJj6pyjlkc+
         j4Sg==
X-Gm-Message-State: ACgBeo2dmePg1Bmzw5f+QqWj+yOGmHEZsxL59VB79NbR7D3U+XbhQfPu
        ZTqHbkN5CzPzzEGYYNQBbDY=
X-Google-Smtp-Source: AA6agR5UPEvIGtcubymCzZL+z38mm/yqC6Kop8Em1vGxhNv1A7aNFu6IPsJxb67jUF/ZEQivOmC8wQ==
X-Received: by 2002:a17:903:41c3:b0:176:b990:6c28 with SMTP id u3-20020a17090341c300b00176b9906c28mr5003101ple.94.1662574325421;
        Wed, 07 Sep 2022 11:12:05 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id z6-20020a623306000000b005321340753fsm4467628pfz.103.2022.09.07.11.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 11:12:05 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 2/7] t3416: set $EDITOR in subshell
References: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
        <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
        <d6f2f716c77cbd0a19b3b6032f69f6dd9b257e96.1662561470.git.gitgitgadget@gmail.com>
Date:   Wed, 07 Sep 2022 11:12:04 -0700
Message-ID: <xmqq5yhzvytn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> As $EDITOR is exported, setting it in one test affects all subsequent
> tests. Avoid this by always setting it in a subshell. Also remove a
> couple of unnecessary call to set_fake_editor where the editor does
> not change the todo list.

True.

The fact that we need to do this makes me wonder if we want a
restore_editor (or a hardcoded "export EDITOR=:") that allows us not
to go to a subshell, as going to a subshell has its downsides (e.g.
we cannot use helpers that rely on being able to modify globals,
like test_commit and test_when_finished), but for now this looks OK.

Thanks.
