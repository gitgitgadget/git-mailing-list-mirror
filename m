Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44625C56202
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 01:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC20D20770
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 01:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMgrZvaV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbgKZBC1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 20:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730030AbgKZBC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 20:02:27 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36168C0613D4
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 17:02:27 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id 64so277285wra.11
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 17:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wqim1FqWw1vQDa2ftglarfEyDLjUiUMfrhhU8JT5vhc=;
        b=ZMgrZvaVKLQ3PkdBa7cv5qG8lhR2RGHYl2j9nXeY9G8Pa4TXhCv50LS0NH7sJXcWI1
         Wtm7RUQsx52m8g4qjw6T55G6mmuevGocDMCagoWHYdriFrt9CpkMRQav7CZ0OpGM2Wn1
         MbVTA6PnuOUIg/T5XDkNutQwX9fylJeq2Hw9i11dlllD1JD/jfSmdfViWjsgkbVE3CFd
         fayLSlK04ZJGAiRhvlPgXek6bKXxdSkC2j7KX6zDw/NkYTtpxVkODYJInbipcctXLSGR
         YyJ1cusGqqyQcIlju0pVmqsTR9FDvNZUI8uUeJqgoWieEybTN2oCqlXx2qB2e+dBP1w+
         U+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wqim1FqWw1vQDa2ftglarfEyDLjUiUMfrhhU8JT5vhc=;
        b=S76rj/82HoXxBJYy99A6PrpJl++IWkYDG01ViLcXWH2ELBQ/HXMN08GRn18K+knWJc
         Ps8EBb48qtc8d2NzisHgB63P6HfEZ2+hjm5vqi2eEd5MhXLfmr8fmOlzksN7wQ43scUT
         QjykxP+dHZUTdccDlAca48pbr8W06cf/73BON3L9eIBDiWOepkI2dDDR9vLgVZ4ao7tL
         Ypip6sq4hXIMPG2eloJIaCbUvgbr6zuusmxayQxpkUfLnJpNRJdTbU4xDj7RGgm64MtL
         ESBhdLiPc8OV2CClV/ot3BcwUPrU0ib0VGDgwrfm0n7Lino7ArJazxkEfv3TmYKmyemX
         Prwg==
X-Gm-Message-State: AOAM532tZupTWde9QPV2Uxdih4kXPtsiDg5pt4+WHXpOOg4xImko270Q
        rTmeS6s8MK6Bab0fBGyNOHUofiAUSCW/h5l83aY=
X-Google-Smtp-Source: ABdhPJzA5IoNJWF12mZRlzAzK2L83wPmuNYuGOR/fmPUBjBh3S/z7IgjSW+Hu6DvCUizmZJF0fl8FNlNlR0qqByCHyY=
X-Received: by 2002:a5d:67c2:: with SMTP id n2mr596854wrw.139.1606352545928;
 Wed, 25 Nov 2020 17:02:25 -0800 (PST)
MIME-Version: 1.0
References: <20201123191355.GA132317@mit.edu> <CAMP44s3cKVxKa0gOPfi3XRKbGbV=DweFE5pL0HM+v0kECFyPWA@mail.gmail.com>
 <20201123202003.GB132317@mit.edu> <CAMP44s27oEjScrJjeDVoNcWcvRsn173L_Kx+TOPfchOwge9zUQ@mail.gmail.com>
 <X7wuMvHRURK1QS/Q@coredump.intra.peff.net> <CAMP44s0QOcMnYQqFFSE1jV_T6=e4=xTM0zr_06C6+aYb7oqb4A@mail.gmail.com>
 <X7xWSs3/vVqKl6sK@coredump.intra.peff.net> <CAMP44s1Z4tDXO4jstGMtYVOYzkQQnZMHp45pYPOimk+=jwFHcw@mail.gmail.com>
 <X7xgow4pchnhf2iY@coredump.intra.peff.net> <xmqqy2irjy4f.fsf@gitster.c.googlers.com>
 <X7xw0xb9UnGKbS8m@coredump.intra.peff.net> <CAMP44s08mEyYqbjOeTeS46CngrbQMqP2=cMr1dtRLLk_BLAq3w@mail.gmail.com>
 <CAMMLpeSoGtqeCm6u-zrHqvPhW7brvNk_kwde3uqmbPcP1JgMHg@mail.gmail.com>
 <CAMP44s2z3vv2LwoMesydVL3qWrJh0VvHSUy+FpnqguoipRRD9g@mail.gmail.com>
 <CAMMLpeQvofhPjcJ19JrqJs1W3YoQSP+hOainuZJa=QeJzYc+5w@mail.gmail.com> <xmqq7dqagtgx.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq7dqagtgx.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 25 Nov 2020 19:02:14 -0600
Message-ID: <CAMP44s0M00sBvdjD0jc0X=1=PJepC5fNndw73sceOpbDCw5dFQ@mail.gmail.com>
Subject: Re: Pick the right default and stop warn on `git pull`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, Jeff King <peff@peff.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 24, 2020 at 6:39 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
> > We'd only need a warning if both pull.ff and pull.rebase are unset,
> > since that's the only situation where the behavior would change. And
> > providentially, we already have a warning in that exact case, although
> > we should probably tweak it to explain what the new behavior is going
> > to be :-)
>
> If we were starting "git pull" from scratch without any existing
> configuration and command line options, pull.mode might present a
> simpler end user experience, but I have to say that pull.ff and
> pull.rebase that are fairly well ingrained in docs and users' minds,
> the above plan sounds like a better option to reduce the cognitive
> overhead for users.

Is it? From forums, blogs, and answers in Stack Overflow what I mostly
see is "do not do git pull".

> >> And yes, it should be possible to do what you suggest, but have you
> >> tried? I suspect both the code and the documentation would be quite
> >> convoluted.
> >
> > Yes, I have written a very simple patch that implements the behavior
> > that I am suggesting. I will send it to the mailing list later
> > tonight.
>
> Let's see how well the comparison between two approaches play out.
> Thanks.

I tried to remove pull.mode from my patch series, and it mostly works,
except if you:

1. Have "pull.ff=only"
2. Do a "git pull --no-rebase"

When you have "pull.mode=ff-only", doing "git pull --no-rebase" ("git
pull --merge") that mode is overridden, and the merge succeeds.

If you have "pull.ff=only", you would have to do "git pull --no-rebase
--no-ff" for the merge to succeed, which I don't think should be the
default.

We could change the semantics of "pull.ff=only", but that would break
existing behavior, and it starts to get convoluted.

Cheers.

-- 
Felipe Contreras
