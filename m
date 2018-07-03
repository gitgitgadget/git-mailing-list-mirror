Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CE0D1F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 22:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932382AbeGCWgo (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 18:36:44 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39407 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932079AbeGCWgn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 18:36:43 -0400
Received: by mail-wr0-f196.google.com with SMTP id b8-v6so3426150wro.6
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 15:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aCR4jRXXY2HWkwnb2C7L/2gWhPMfS1Z5FXsXWdoOsIM=;
        b=Qr8geBij0qVMsIWBgz9wyUtIbONU0ISpygZHhCXrZYhKEDr6EXD61ggVainGqOeHqy
         bpaZgQvhk7syE2MEhNk4qLvWfSnThVaT5Y+74f07yfgcwmUE8ME+hJz0C1ozqc8OgkXB
         o9XI4olK3aXhnJTDjg3nEo2ztVu2KwJnmlwkvpBqXJvl8OlQN2s4N7Rail4wT0XRVbDe
         mo14Sztd2A3GxejkKpffU1S2g31CxwCWb/pByqKAhDidBOtOtLSNDeyxKuItgvze57oQ
         BlBxtQrErZYw676kL2R0i1Aim5BqNmWhtUUeT6y15WmO7tzn1pK9i0oPE3k4Y4Q1colS
         3caw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aCR4jRXXY2HWkwnb2C7L/2gWhPMfS1Z5FXsXWdoOsIM=;
        b=fLNJFIl4yUOB6l3YV32WZXHVMUb0VjEwlwMJun9pfe7r1fxXs1geks3FsQUhqwTSMC
         bVaWb3fpxFVQ84DMVBoyPyLo6KeLMIDe0Y0ayq82X7xPW9VCFzeDoGnbRXDjZWFRxDL2
         KJhLVdNpYR+4Zlao3Szrq93tVAjF8/5A/rtPP0WTe2D12/s+pke8y1dJCNq1ZNyu+188
         Qqw0FMLvCXfn6zb8ly3tKyRU8vfmP+zqW3qnSJSgsM5s4K7vMSsSB2ktTW1+i678hbJD
         eLoTbe8DU19uHn3n38h0l0ln/TzNUliGiJ5YttaWHIwi6Pts6JZe+pqWtG6pTswTQm1K
         I1+w==
X-Gm-Message-State: APt69E2deG9vQMKW69UIiF8NkHhPbnsKSoTg7whNI7e1+nC7/r9PPqwq
        xzj8pNy9Iv50D6AjiKwWbtw=
X-Google-Smtp-Source: AAOMgpfDr0u+czKVDMHXk4RVdQYYoLmRONV7Xo1ZeqbMxFJE3ax70P6culBZnYrvt5qjHWrlildSyw==
X-Received: by 2002:adf:b445:: with SMTP id v5-v6mr23587387wrd.67.1530657402287;
        Tue, 03 Jul 2018 15:36:42 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 39-v6sm4363076wrv.79.2018.07.03.15.36.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 15:36:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tiago Botelho <tiagonbotelho@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>,
        Tiago Botelho <tiagonbotelho@hotmail.com>
Subject: Re: [RFC PATCH v5] Implement --first-parent for git rev-list --bisect
References: <20180622123945.68852-1-tiagonbotelho@hotmail.com>
        <xmqq4lhqpy80.fsf@gitster-ct.c.googlers.com>
        <CAP8UFD3oEjW75qsk4d_wqo2V8PmzMvZLshutw20CD7AU4b4ocg@mail.gmail.com>
        <nycvar.QRO.7.76.6.1806261540340.21419@tvgsbejvaqbjf.bet>
        <CAP8UFD1TeC4czp_8HCRw5CtjGO78A8gRezw_xspnm4MXuhQswg@mail.gmail.com>
        <xmqqa7rhi40f.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1806271254210.21419@tvgsbejvaqbjf.bet>
        <xmqqwoukgpr9.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1806281505160.73@tvgsbejvaqbjf.bet>
        <xmqqvaa2yjo1.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1806291317150.74@tvgsbejvaqbjf.bet>
        <CAADF+x3jd5G9+SP3UmhwqrR_T6BuD0PkQJ3x+NLpq2BJ_Ej-Sw@mail.gmail.com>
Date:   Tue, 03 Jul 2018 15:36:41 -0700
In-Reply-To: <CAADF+x3jd5G9+SP3UmhwqrR_T6BuD0PkQJ3x+NLpq2BJ_Ej-Sw@mail.gmail.com>
        (Tiago Botelho's message of "Tue, 3 Jul 2018 22:33:10 +0100")
Message-ID: <xmqq36x0ndza.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tiago Botelho <tiagonbotelho@gmail.com> writes:

> git rev-list --first-parent --bisect-all F..E >revs &&
> test_line_count = 9 revs &&
> for rev in E e1 e2 e3 e4 e5 e6 e7 e8
> do
>   grep "^$(git rev-parse $rev) " revs ||
>   {
>     echo "$rev not shown" >&2 &&
>     return 1
>   }
> done &&
> sed -e "s/.*(dist=\([0-9]*\)).*/\1/" revs >actual.dists &&
> sort -r actual.dists >actual.dists.sorted &&
> test_cmp actual.dists.sorted actual.dists

The distance in the current graph might be all lower single-digits,
but you need "sort -n -r" to be future-proof, as dist=10 would sort
next to dist=1, perhaps in between dist=1 and dist=2.

Another thing you missed in my message is that the above does not
say what distance value each commit should be assigned in the
history.  Even though the grep loop makes sure that each of E, e1,
... e8 appears at least once, and line-count before that ensures
that the output has 9 entries (and taken together, it guarantees
that each of these appears not just "at least once", but also
exactly once), nothing guarantees if they are getting relative
distance correctly, as the sed strips a bit too much (and that
relates to my earlier point why starting from a concrete expected
output and explicitly discard the aspect of the output we do not
care about before comparison---that way, we can easily tell when the
code is _designed to_ discard too much).

