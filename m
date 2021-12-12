Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9C8C433EF
	for <git@archiver.kernel.org>; Sun, 12 Dec 2021 17:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhLLR44 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 12:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbhLLR4u (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 12:56:50 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3BFC061714
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 09:56:49 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id v1so45725278edx.2
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 09:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=o8NgbNqypJqI0P7wzcBs1uT6Bz/F7M/BRPsDaRulxOc=;
        b=LzQwWEZkLQFKvuWWDXz5lPLzigEM5udG3v2BqFr7+0oTZYqpz0BmBLqmJohMox3oIb
         ZikWtBoVib7VhKXM0FxkXXkmSG0Y6800skt1KL4Bj03zKVZGkn8piM/yvPq/ZhZWLVRr
         lc4/alk/AX20LEx73sFW2iihajrevWS4Vm5OD5vr8L56yYEOgpFaGJjStqlECNCmTJXH
         +ayIVxXuDEOxftll9xRJtyWfiAodNviu34dPZ3BOmvcsqREbI9Aj0AwtE2pj+ugAAAMs
         cLhmYgN0MV2McMbb3MgwJKj+TsN6Uf7YN5JKX8xNpT/b2KgR9q/VbS64jt+hExCeSQ7R
         nBog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=o8NgbNqypJqI0P7wzcBs1uT6Bz/F7M/BRPsDaRulxOc=;
        b=Q+oAhbqwPQqgyHs0Qp/evAzJLbTMBzPESAtM9ifcsTxlF0ttLUoix4D8mMQ515NEY8
         MTR0d29xY6HoXPKIKcmmX1qpeP5dUcAJBUL7ERqXLOEhKMPO5q1UFxpVIBiPOlF5rwcn
         G0rXCFyZKuU7guBrTsl6k85eKQ+57LAWRtt2jGVO0MEi2yK5MjBRx/HzBFb8TCmy0d7N
         XtKWw64Gam2rMHvjYJAFOxy9565YSSaAuSBLd2kJGIjNmMGgnOwIf1xYiJ9Ed38qn8W6
         X4f1G/sBQNCGzZ5wOix4/g5p8MT/v4b3t4XjoHW6DfVtr3h020EAWMC8Yx5mGTvk7XDX
         iPnQ==
X-Gm-Message-State: AOAM533dQFDcRx9p6K/+y+/coLgCLwEwX5Phel0R/+0fxx0D41RgCtcO
        03ucb0Mz1JePOremj9nBC6k=
X-Google-Smtp-Source: ABdhPJx0EeQvKwfWF1rBcKuZSiq4rSASZ4sHC2dZsLRq1jCDYCZQjwz/pE7X3IR8ZmJmmpdtX+2eag==
X-Received: by 2002:a17:906:fa87:: with SMTP id lt7mr39205594ejb.426.1639331808142;
        Sun, 12 Dec 2021 09:56:48 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z22sm5137120edd.78.2021.12.12.09.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 09:56:47 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mwT5b-000YFG-0R;
        Sun, 12 Dec 2021 18:56:47 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 02/10] range-diff.c: don't use st_mult() for signed
 "int"
Date:   Sun, 12 Dec 2021 18:44:43 +0100
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
        <RFC-patch-02.10-bd7d014c531-20211209T191653Z-avarab@gmail.com>
        <YbLL/YWbjc/sPRyH@coredump.intra.peff.net>
        <211210.86lf0sdah1.gmgdl@evledraar.gmail.com>
        <YbM85W3N0ySi5k+H@coredump.intra.peff.net>
        <nycvar.QRO.7.76.6.2112101526540.90@tvgsbejvaqbjf.bet>
        <211210.868rwscxcw.gmgdl@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2112111453040.90@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <nycvar.QRO.7.76.6.2112111453040.90@tvgsbejvaqbjf.bet>
Message-ID: <211212.861r2hbtb5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Dec 11 2021, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Fri, 10 Dec 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> But I'll happily admit ignorance on how the actual guts of range-diff
>> work, I just wanted to fix a segfault I kept running into locally at
>> some point, and figured I'd submit this RFC.
>
> I understand that it is super tempting to avoid spending the time to
> understand how range-diff works and simply make changes until the
> segmentation fault is gone, and then shoot off several iterations of the
> patch series in the hopes that it gets merged at some point, and that
> maybe reviewers who do spend the time to become familiar with the logic
> help avoid introduce new bugs.
>
> However, as a reviewer I am totally unsympathetic of this approach. I do
> not want to review patches that even go so far as renaming functions when
> they claim to "just fix a segfault" and the author even admits that
> they're unfamiliar with what the code is supposed to do, without any
> indication that they're inclined to invest the effort to change that.

What you're eliding here is the context where I say that I must not be
getting something because you're apparently endorsing the WIP
s/int/intmax_t/g patch Jeff King inlined upthread without a
corresponding change to COST_MAX.

Don't those two go hand-in-hand, and changing one without the other
would lead to a subtle bug?

> If all you want to do is to fix the segmentation fault, and want to skip
> the due diligence of studying the business logic, then just fix that
> segmentation fault (I strongly suspect that using `COST()` after modifying
> it to use `st_*()` would accomplish that).

Well, this is an RFC series for a bug that I encountered & which seems
to be fixed by these changes, but in an area which I'll happily admit
that I'm not confident enough to say that this is *the* right fix, and I
think both the "RFC" label and both cover letters make that clear.

> No need to inflate that to 5
> patches. Unless you're thinking of the commit-per-author count as some
> sort of scoreboard where you want to win. In which case I am even less
> interested in reviewing the patches.

Can you mention specific things you'd like to have squashed? I do think
this split-up makes thinsg easier to review.

E.g. if we're using the COST() macro in range-diff.c then splitting 4/5
from 5/5 means you don't need to spend as much time mentally splitting
the meaningful changes from a variable rename (which is required for
using that macro).

I agree that 1-3/5 aren't strictly necessary. I did try to do this
without those, but found e.g. reasoning about changing the
one-giant-function in linear-assignment.c harder when it came to the
segfault fix, and likewise the mechanical change from "int" to "size_t"
is (I think) easier to review & reason about.
