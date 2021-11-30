Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63793C433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 06:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbhK3G4m (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 01:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbhK3G4m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 01:56:42 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5324AC061574
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 22:53:23 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id x6so82124625edr.5
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 22:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9emPHnWQEfeTlL8RiDQQR0V7XdxSSU1nb3FAWil9b20=;
        b=DKp5jffhgB8PQbQzJc3BeCXc9V+/p52eDQYT2LHYZwZ4z6NV3A8Rdpag8TZtnaX4MU
         gLkjYLvQ8uW360RFkM7zSn+KRNRKBaqwr1Gsv4giHPZL/l5DhEVUmtKygEHgU/6a+4cf
         QX0ONOjp+37/60jSjp1iD/tjVGOYD2BZ3N/FDUPYquKKZ/9QgNOYhiFnGWTKfsAwfG8g
         pz9OFe8aguOGen8EV7+LGO3faZlGmVB8aiaGnTGZzzigaOfv/6674JLL0tw5b2yxDYBu
         QOztv2EWkkdY2X/kWrllGazAGAbaAEo1QzXq8jsOC+XAwr73lzTNOdQzp1AV8XHfGQ1R
         XF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9emPHnWQEfeTlL8RiDQQR0V7XdxSSU1nb3FAWil9b20=;
        b=ld9YryHeRzNiMQ3fZrFIWhTOaovlj/xheFgF7TPTmQl+e//FLaREEWe4RiFc513Ayj
         dahT5CwfOnvTfaJZIlBzUp0EOBtvKRPC/vs2L5cj2IDG8tadMW5B+Y4jR3gZdcmBlRUu
         PrNyfLJYZDEzMaDPy90JeJSMP0CcMuDjDTiZUzflhWd89UdiGh8woBLeUhZFOVonzDrE
         W65r9vTg7fvMtyGW3AKgoSM1BZOCJ3s1lVlBMofNk/THHUE0Ew753N3ajEtl9/WljgGm
         qCinCXHUCP4BCIAVD/qSo6nOmwv5dp5kLdycznHkYzbcJmc0rnyjuxitkca/JGnkEUfx
         SWAA==
X-Gm-Message-State: AOAM5310n9Bap7IsKUfyWw0S8glmm9FjAFADC6orwEzJvJZ/K/jlqrKc
        T/2BsnDswtQhgvxzWM9dKp0silNMuzeNOy1JP+4=
X-Google-Smtp-Source: ABdhPJyVpDzlHODKeIMP3X7Onx6D/1GythiaZRAYmpqFZOWv3iU2h48z3Oo7oc9EKolHXZBqJy+m+N21YTQvNuuWXnY=
X-Received: by 2002:a05:6402:5cb:: with SMTP id n11mr82408294edx.279.1638255201946;
 Mon, 29 Nov 2021 22:53:21 -0800 (PST)
MIME-Version: 1.0
References: <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
 <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com> <a45b3f088025795d11a78055f90b8632d435d74f.1638225434.git.gitgitgadget@gmail.com>
 <xmqqilwa2l8f.fsf@gitster.g>
In-Reply-To: <xmqqilwa2l8f.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 29 Nov 2021 22:53:10 -0800
Message-ID: <CABPp-BHQsQqjCwjCUk-bSe_i52Wza-QgTDbHVsLn90D8q5FkuQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] t2501: add various tests for removing the
 current working directory
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 29, 2021 at 10:47 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +             # Although we want pwd & git status to pass, test for existing
> > +             # rather than desired behavior.
> > +             if test "$works" == "success"
>
> Don't double "=" here.  We are not writing for bash.  There are a
> few more instances of the same mistake in this patch.

Yep, also pointed out by Eric.  I've got a v5 queued up whose change
is just fixing this, but I'm waiting a bit to see if other items are
spotted in review before sending.

Thanks for spotting.
