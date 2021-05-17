Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D93C43460
	for <git@archiver.kernel.org>; Mon, 17 May 2021 10:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0AB36008E
	for <git@archiver.kernel.org>; Mon, 17 May 2021 10:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236333AbhEQKQw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 06:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhEQKQv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 06:16:51 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0393BC061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 03:15:34 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id di13so6198831edb.2
        for <git@vger.kernel.org>; Mon, 17 May 2021 03:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=RhBE36FQZdJWJ/6rRdXdPfI2rzdCwlUYdUCqMyK6+7E=;
        b=gp1l/+MSAnTHbGHa/eYt8iM52hO6J5re+gfht9j5NTjQ1wTNMROM3qxh7YUl13nT4A
         duUaoZ/0Ao+sI/cKRmOoHa/w91g/bYknYLhWHmA6n/i00LQW/vFno5gdwkgjZNWPZTkz
         y2OhP8ppw4tUq92V2lqFoiGlgly5uTDfMweGyGitu22OUzE/wJ7ATaqtggDCP+VN0oVP
         ysBNbzWnXFz3UFrZ5jmUo/j3qma8b5saqHtQ4f/s4YHtftWxkD5oud4FwmscF7dh7vqe
         nyr9ZT0IF7vORTBGqhtx6xOBYNYX7MUPaDC87EHiD+BBVdpFaQATdDl3V04ij2ct+iqr
         6hzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=RhBE36FQZdJWJ/6rRdXdPfI2rzdCwlUYdUCqMyK6+7E=;
        b=uZ5PLQlP/HCJ72e6YQuz2PKb44IqyXfYvU8OU4WMSYqJ3ySgZoTHpHXDDIfhK/xt75
         5FEJgPAEa3mFAy349MRlMSBDsSWvt6jqse3EPXa7GJ/aGx7QhE4zBB6uXQ8LGu5gZudN
         oWnabSCIqCTG0TDoUCqZjW4yeGHxJ6dRAG8Uobfh95ytYl72Oe73F8rnXJ59ohXyyx66
         IVs4lb6SDA1kEL4KQRykkRSXwJN3/M24HCVBZjFAuWw6UgFjFn5ZzGVYCjSaW6yAN05K
         EV9ho9DukoTqra0fbu7bmdpC1qR/2gdjssMs4p66/7d/NPGy0m/5g6pPIEu64SC/t/ZA
         mLQQ==
X-Gm-Message-State: AOAM5334808Gsh6ZMx2Qy5NLJ3TSvN0yMOV3REnRxYSd51hytf6ososE
        QRaOHlYUL/Fkb2Qigk4A388=
X-Google-Smtp-Source: ABdhPJx6ro8ePxVUn92743q94eK/y6grNjs/Dty6/BwDBFAjISXZrpLYiwg7PzJYH9fSRFwPDGtowg==
X-Received: by 2002:a50:8fe6:: with SMTP id y93mr70941536edy.224.1621246532674;
        Mon, 17 May 2021 03:15:32 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id bm24sm4040001edb.45.2021.05.17.03.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 03:15:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Rebase options via git pull
Date:   Mon, 17 May 2021 12:11:39 +0200
References: <87r1iakbyn.fsf@osv.gnss.ru>
 <CAMMLpeQ8_isyDtP34p+_tEK3JAasfro7dJbVrTVPZ7C4q0kT6w@mail.gmail.com>
 <YJ3LJ++lsAuSkCUJ@danh.dev> <875yzlu8gt.fsf@osv.gnss.ru>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <875yzlu8gt.fsf@osv.gnss.ru>
Message-ID: <87zgwtr7i4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 14 2021, Sergey Organov wrote:

> =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gmail.com> writes:
>
>> On 2021-05-13 18:49:03-0600, Alex Henrie <alexhenrie24@gmail.com> wrote:
>>> On Thu, May 13, 2021 at 7:23 AM Sergey Organov <sorganov@gmail.com> wro=
te:
>>> >
>>> > Hello,
>>> >
>>> > Is there a way to specify additional options for "git rebase" when it=
's
>>> > invoked via:
>>> >
>>> >   git pull --rebase
>>> >
>>> > ? What if rebase is used implicitly due to "pull.rebase" being set
>>> > accordingly?
>>> >
>>> > In particular, I'd like to be able to:
>>> >
>>> >   git pull --rebase --no-fork-point
>>> >
>>> > but it doesn't work.
>>>=20
>>> It would be cumbersome, but you could run `git config rebase.forkPoint
>>> false` before pulling and `git config rebase.forkPoint true` after.
>>
>> Or, for this *specific* case:
>>
>> 	git -c rebase.forkpoint=3Dfalse pull --rebase
>
> That's nice, thanks! Doesn't solve entire issue, but definitely better
> than nothing.
>
> Probably add generic cmd.<cmd>.opts config support, so that I can say:
>
>   git -c cmd.rebase.opts=3D"--no-fork-point --empty=3Dkeep" pull --rebase
>
> Thoughts?

It's been discussed before (but I did not dig up the discussions,
sorry). It's been considered a bad idea, because our commands are a
mixture of plumbing/porcelain commands and switches, so we want to be
able to reliably invoke say ls-tree with some switches internally,
without config tripping us up.

Of course we could make this sort of thing work by selectively ignoring
the config, but such a thing would be equal in complexity to the effort
of assering that it's safe to introduce new rebase.* config in the
codebase for every switch it has now, but with a less friendly interface
both for git itself and users.

I.e. instead of rebase.noForkPoint=3D<bool> we'd need to to getopt parsing
on some cmd.rebase.opts string.

I don't see why in this case what I suggested elsewhere in the thread
wouldn't be viable, i.e. you specify --rebase or --merge to "pull", and
that affects how we interpret the rest of the options. I haven't tried
it though, so there may be hidden gotchas there I haven't thought of.
