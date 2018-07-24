Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 845B21F597
	for <e@80x24.org>; Tue, 24 Jul 2018 17:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388502AbeGXSZe (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 14:25:34 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:56119 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388413AbeGXSZe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 14:25:34 -0400
Received: by mail-wm0-f68.google.com with SMTP id f21-v6so3297266wmc.5
        for <git@vger.kernel.org>; Tue, 24 Jul 2018 10:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4K9n0kLcDk2az0uFljqlj7M0g0N0DDcKJesvQ2Ufhx0=;
        b=raJsWgY9kHAynnL/EP252sMTLPWBIj3jSyaIjhpKSBUM0ANC2NTJ8o4SJgvjguI49W
         0ZwN5AKnkBT0loLnG+f4YGYV4O3bVc+BKQNca0yHYOJQS2I3r3ybVCEVih+c7Hm1rRGT
         WUdXg36s8jZcUFEsLKN1Ohr0obs5T4bDb49JN1KARbrBwj7KfhMHIBZzbHhNUHf3V5mu
         fU2j8aWzE6O1vPWiA3As1VPrthRKQdOAIOJk+Ps+z6U5bpNZ9ctfqvnr8g0LKEvoMQOv
         aGZ4Fd0jzucgUpOSfkL3mHfaW6/QBC21VbQyk0B2Gcey20EOqmkZO+VuISG9vGkhn3py
         NByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4K9n0kLcDk2az0uFljqlj7M0g0N0DDcKJesvQ2Ufhx0=;
        b=f08u4WVCxsSjMpzicDhdU5+rgSdPGP7osrs7ak0EWKC08nNRBDIzHmh3QG7E6iQhWD
         kEHfNvytnDA6kFr4Ob45xWmWeeX4/kA6BX7N3q9imCCvI8JdjKOBUXqjZ1tjKG3Ie/9U
         TxBDOjoAs1Szc66KfRq2Qi3BV6khm311a+Oa7CNRqzjHtnLBnPIGuZtP3hvxvCo5l5K1
         /44jHSgX9iGgZqZK/v9X9M9qvTvBkzcTjEqcUPSjRoRWGMgfzwuv9AvgDuxH9u1fMS91
         vFJC7Aw8MgwdJG39fTKQMi9muZu/XAx13jzFfOLU9QOaU92qVFeOqX1NmtzpsO0FqooV
         aiVg==
X-Gm-Message-State: AOUpUlFejkDtMrv2C8MC2PVfUMzDG5Ez9dFj3WVlw1OuFN9miuzOFlFl
        CgrZWiZY+mcH3mmHwBJhu80=
X-Google-Smtp-Source: AAOMgpfdTRaC1OjdHT/T+1sDN/ktbatl+deMo5rvymavX4VNegJVYEbYLa7j1bqNliCZVLSexzLZuA==
X-Received: by 2002:a1c:dcf:: with SMTP id 198-v6mr2535192wmn.131.1532452684328;
        Tue, 24 Jul 2018 10:18:04 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z3-v6sm10488470wru.27.2018.07.24.10.18.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 10:18:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC PATCH 0/5] Add delta islands support
References: <20180722054836.28935-1-chriscool@tuxfamily.org>
        <20180724101627.GC3578@sigill.intra.peff.net>
Date:   Tue, 24 Jul 2018 10:18:03 -0700
In-Reply-To: <20180724101627.GC3578@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 24 Jul 2018 06:16:28 -0400")
Message-ID: <xmqqa7qgzh6c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>    I think this is inherent in the scheme (we're losing some delta
>    opportunities). But I think it's also made worse because the delta
>    window gets clogged with candidates that are forbidden by the island
>    config.

Hmph, and the reason why objects that do not even belong to the same
island to be usable as a base are in the object list in the first
place is...?

>    Repacking with a big --window helps (and doesn't take as long
>    as it otherwise might because we can reject some object pairs based
>    on islands before doing any computation on the content).

Ah, then yes, a large window with early culling based on the delta
island criteria definitely sounds like the right solution to that
problem.

>    I have replacement code (which we have been running in production)
>    that is more clever about the threshold, and also can handle gaps in
>    the continuity (so we might realize we need to send objects 1-5000,
>    then skip a few, then 5037-8000, and so on).

That vaguely sounds similar to what folks at $DAYJOB runs in their
Gerrit/jgit thing.

