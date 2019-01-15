Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DA981F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 18:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732510AbfAOSXv (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 13:23:51 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50706 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730905AbfAOSXv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 13:23:51 -0500
Received: by mail-wm1-f68.google.com with SMTP id n190so4362509wmd.0
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 10:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Ao7DdwDM1jNVrnG4MS0g+h3d3+axE2e9I1r4QklTm1A=;
        b=fL5DS1q7Chc6Sg/16tJ8QtTu7tTdnF+PeJLDo50pweVlRzWM13iE3sG7RHg4dMfwcF
         bu/XjW0aMV/9L/okCA6t+56A2gzir12MDF8ppoIaP2auOU6w7yOC+rwngtZ6hSvNKIQ0
         u7AtxoU/ASZPE94lg+NRxYUc6vfl+ABBRhR5Kq8bDPWWQb9nLnS6xSU5L6HjUoLq8/Ag
         DJ2A65autSMZRzYsKLUlTw0gRhMPcRZ+SCiG9Xz9wdZhWGNnyvcT/GKMgoyV3h0gGDjb
         IkEJ3Cch31QOXNB9s246f/4IZUCVETo6QMAOD6Gcy8CdCw+zZ2CNlOVMA0nmzu8S9Izh
         DO4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Ao7DdwDM1jNVrnG4MS0g+h3d3+axE2e9I1r4QklTm1A=;
        b=IWzv03c5jbEjVVfrAhyJ7bdRl0zH4HyWmqoeYYryDe5zRnlb2PE1VOG25J/5zo5ekt
         lFzhoprd06fsAx/WaPcyhE0UAcqNlxeWGdTkAUstKhh0ZwaEwZFjawkzvjJfWfyuLoz0
         +T2NjZ0FnYmdW5EglX/O0d6Trwl4X840FwmcG2SuqlwxRhGechWf8Oy30QtnXJizi4Bb
         1fF/aEoH4/VXEQ4rBR7I/zpgirJUeU2JCwMLxKlU9Y7zTLiWmNiQSY/2ooKIq2Iop87Z
         Utjw07ZflWNEXAlNNWnNJohO9jB1Fki2V7CW4nVEOJ2GWxuG+tU0Sd2d9j21LYLvmIpM
         yEVw==
X-Gm-Message-State: AJcUukf0gBPctgM4oXV1HtRGF1kU75bQSKUSGYYNjOkkUh0dTCMHgTTm
        TBfQr+t9WCIryxAn5snwzFU=
X-Google-Smtp-Source: ALg8bN5T7M3Mqg4VpHmxK1zPQX7jEhu9pA1F/x7o1R8Lz+COB+DkBHn9RSXBERNW47boOCYV9NHYug==
X-Received: by 2002:a1c:7011:: with SMTP id l17mr4286223wmc.34.1547576628746;
        Tue, 15 Jan 2019 10:23:48 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o15sm62682763wrp.12.2019.01.15.10.23.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 10:23:47 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        jrnieder@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 3/6] pack-objects: add --sparse option
References: <pull.89.v3.git.gitgitgadget@gmail.com>
        <pull.89.v4.git.gitgitgadget@gmail.com>
        <ab733daff5398fd07ff051c323f51b70efbc2e57.1544822533.git.gitgitgadget@gmail.com>
        <xmqqmuo6yghg.fsf@gitster-ct.c.googlers.com>
        <8c50e066-b132-cf6e-ed0f-ce843cf3a634@gmail.com>
Date:   Tue, 15 Jan 2019 10:23:47 -0800
In-Reply-To: <8c50e066-b132-cf6e-ed0f-ce843cf3a634@gmail.com> (Derrick
        Stolee's message of "Tue, 15 Jan 2019 10:06:53 -0500")
Message-ID: <xmqq4la9u6do.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Instead of "we must stay dumb" I wanted to say "we are not dumber (in
> this case)".

Thanks, then what we aim for are compatible ;-)  I do agree that we
should make sure we will not ever become overly stupid.

> To properly test "these objects are included," do we have an
> established pattern for saying "this file is a subset of that file"?
> Or, should I use something like `comm expected actual >common &&
> test_cmp expected common`?

Yeah, "comm -23 must-exist actual" would be a natural thing to use
when we have two sorted files and want to see what is missing from
the actual output among those that must exist.  t6500 and t9350
already seem to use the tool, so it should be OK from portability's
point of view to non-UNIX systems.


