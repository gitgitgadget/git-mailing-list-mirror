Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B90CE1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 21:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbeGPVjp (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 17:39:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41039 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbeGPVjp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 17:39:45 -0400
Received: by mail-wr1-f65.google.com with SMTP id j5-v6so26745418wrr.8
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 14:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cEChYDquqhb2mkmCr8m+PbTtSBryMyeGKj99DE5Phuc=;
        b=IDE2gUEFWkWfiP0o6+FJStlc3rQwl1y088fdl/Y4sS+GHGybv1yLIFLfBuawe8J64s
         wVYViKWXuKeOfZyD2Yj6Sd7lLE0B49k0ewSf/MQ+gCMBPvdEa/RC4KlDZ1UNcgw1sAEH
         3VOe8oMsS4Kl25SyrN1FHKI9WncRnFeNyCalni5cn8UyIuNJ/rDvJ0nFlOnk40Yhdh69
         Zkd/FssDgw0fwHJaON8pA7JVymK0Bl2oidXGGv3xhoYEolMkjzMr0qMafPzwc+E5/1Tk
         lsYpaLt0xEcLBkFi5cwek+Wlz71/7RhXy+G2y1LEk5Qb5ibSzhEDaLhhkuMRQVETgsGe
         grdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=cEChYDquqhb2mkmCr8m+PbTtSBryMyeGKj99DE5Phuc=;
        b=TdCGCb7UY+bQlLXecM+eLErz/U/d83EmH4bi7BGL89ThTR0y230E96T7QTpFK/e9KB
         VxfygilMCOBwjawQDP9EFCTtw7nCDT54nM42+28KTYwWprJI/K5k60WRwLbxaVe1rSL/
         cZi84Ly7YEyb65E1D6a9cBqYxIdLNimzWXN7WndwuUTnINlCrbMb33BSLNNGjSexizsn
         iObMsm1P+uTmHQLIyxI197V7N3rbHjOTM1FQOZJ6RgmnFOp9PNLTS2PMMZBSJlY7P/5Z
         jXqcLH9bpRulRnyXlB9Eib6ToziIG9g9xHiuaAQf46XI1iUMxpi5Wv7iIq4O8MMHdvsV
         I5yQ==
X-Gm-Message-State: AOUpUlED5gVscWuY/QqOsvPDbAV3heCOzHL+KrB6XbJFBLMkt++tfCzt
        0nyUmeceCuHHaqYM/YtPYY4=
X-Google-Smtp-Source: AAOMgpeU0ZUAmEWuCQIdHx0rlZHRgE+OUntcTnFzSN3LG+f5ksRQBTIhGELJ5vD7EeeHEoDc4FIZAw==
X-Received: by 2002:adf:8e89:: with SMTP id q9-v6mr13411221wrb.261.1531775432526;
        Mon, 16 Jul 2018 14:10:32 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y11-v6sm4960625wrr.84.2018.07.16.14.10.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 14:10:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Vitali Lovich <vlovich@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: rev-parse --show-toplevel broken during exec'ed rebase?
References: <CAF8PYMjub1KK_ZK0hijTNBACSa6SaFyu1dJgrXd5fJU5Hc_dhg@mail.gmail.com>
        <xmqq7em01ns9.fsf@gitster-ct.c.googlers.com>
        <20180713184732.GC968742@genre.crustytoothpaste.net>
        <20180713201949.GA17670@sigill.intra.peff.net>
        <xmqqsh4jt5d0.fsf@gitster-ct.c.googlers.com>
        <20180716183942.GB22298@sigill.intra.peff.net>
Date:   Mon, 16 Jul 2018 14:10:31 -0700
In-Reply-To: <20180716183942.GB22298@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 16 Jul 2018 14:39:43 -0400")
Message-ID: <xmqqefg2sx88.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Jul 16, 2018 at 11:14:51AM -0700, Junio C Hamano wrote:
>
>> Porcelain, but I suspect in practice always giving GIT_DIR and
>> GIT_WORK_TREE would work well for many existing hooks.
>
> Yeah, that may be an option. I don't remember if this was discussed in
> this thread or elsewhere, but setting GIT_DIR is a regression for hooks,
> etc, which do:
>
>   git -C /some/other/repo log
>
> or similar. I'm not sure if that falls under "actual regression" or
> "just how it happened to work in the past". I'm not even sure it worked
> that way _consistently_ in the past.
>
> The best practice if you're switching directories is to do:
>
>   unset $(git rev-parse --local-env-vars)
>
> though I highly doubt that most people bother.

Yeah, that is exactly where my "in practice" comes from.  I think I
caught and killed another potential regression last week while it is
still in the draft status during my review ;-)
