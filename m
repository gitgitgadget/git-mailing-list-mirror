Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF20C07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 17:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0A9E6128E
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 17:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbhGMRx5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 13:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhGMRx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 13:53:56 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C24EC0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 10:51:05 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 128-20020a4a11860000b029024b19a4d98eso5619535ooc.5
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 10:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9aKnJBeMhVWmw9NSFBb2cOx5+2uU9oWODJsqp6WM8+w=;
        b=Lh7vZP5rGSStK5vTWJsazc9ire0NU0AwGpGGNeiCqejW7W8kaQpL3ibHOMRrTDt4aQ
         3JQAj0P4dL9Z71UEXOkzdxxa5/GfbLEd3Vi/cbj+IkI+QESbdwyyffAEMP6hLX6booWt
         e6kn5uchXa2vGXG5k8kgAnH23SYrHgSwq60P3/hbUkA4Q58Pb019NVynRQOsuWdXfBjt
         +3JSJHM+8bGFEvPGfavTZa5UIjxHOJQ+aNqtw5IZs5/gphlYzzf6WA0cSQDXRsDNHa9y
         11kK2PxNBjuNZxZBJYKPafSKL5e4oX/p22ixLsgziBXqqLXCM2kuizkPxmdOQjg3SnZO
         4alg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9aKnJBeMhVWmw9NSFBb2cOx5+2uU9oWODJsqp6WM8+w=;
        b=fN8Xn9Zdd8n0UIqDHoclZPYlH/maF/SYp7iIuoxQkQltHgehatblSESINC6yZwC7rv
         IvalI3DHwb8EMkUfUb7ycnZPOZ8H05Fe6ZJmcNDCGSLXAIJhgttU+9zBwqRH6o2WkvUN
         WV/Jk7Y/Fyv6c8zndGRqzxhlBy1EoI/6CXq2g4NBrNoyXQUmWQ1yl00Rg1RCXATyJpkC
         1A7p5h2SX5PLA7wtohQVJKIWZha+ffY+ZElKUlpMfbR+lz3T59YFiUlUVJuRwrM/8n9a
         yMbMPwB+9drAZv+VIB0mHRrCwqbdTo3LmjTu13/xIuUAtGclEQtYxvx/nS55Wn0pFlER
         qfMA==
X-Gm-Message-State: AOAM533S9YSnHxsY/SE6f8niUJuWjwrT79lkBPsy9EgSAoA7H1qTUCZZ
        Mfqqh0yg4c8x12Tog+QEVpR7+f6ScBYGd/1/lao=
X-Google-Smtp-Source: ABdhPJzwsELfnRzQa5gKroLgBVpru284RN25zPVRoXJ2qY83EbO6LhMVryEys+RWXDOgPgBKTQ24b/5Se7nYwbwrvbQ=
X-Received: by 2002:a4a:e923:: with SMTP id a3mr4441078ooe.45.1626198665059;
 Tue, 13 Jul 2021 10:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com> <f1ef9656fc3adf079c8e40a74baeb5356bcf1586.1625150864.git.gitgitgadget@gmail.com>
 <87h7hdbpgb.fsf@evledraar.gmail.com> <c6793033-9bd4-e108-4a53-56c1dbd24a60@jeffhostetler.com>
 <CABPp-BF+GiAZVxeC+MAr6pSssRpSi2pNwHLrxUp9HvrOhUBieg@mail.gmail.com> <xmqq1r822jj8.fsf@gitster.g>
In-Reply-To: <xmqq1r822jj8.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 13 Jul 2021 10:50:54 -0700
Message-ID: <CABPp-BEWL3U0gsmoHsCMQqy5a81yLSWi5U=AeyG023D2u+echw@mail.gmail.com>
Subject: Re: [PATCH v3 24/34] t/perf/p7519: speed up test using "test-tool touch"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 13, 2021 at 10:47 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Tue, Jul 13, 2021 at 10:10 AM Jeff Hostetler <git@jeffhostetler.com>=
 wrote:
> >>
> >> a quick test on my Windows machine shows that
> >>
> >>         test_seq 1 10000 | xargs touch
> >>
> >> takes 3.1 seconds.
> >>
> >> just a simple
> >>
> >>         test_seq 1 10000 >/dev/null
> >>
> >> take 0.2 seconds.
> >>
> >> using my test-tool helper cuts that time in half.
> >
> > Yeah, test_seq is pretty bad; it's just a loop in shell.  Is there a
> > 'seq' on windows, and does using it instead of test_seq make things
> > faster with =C3=86var's suggested command?
>
> Unless I am misreading Jeff's message, I do not think that makes
> sense.  Counting to 10000 in shell loop is trivial (0.2 seconds),
> but letting touch invoked 10000 times to create (or smudge mtime of,
> but I suspect that is not what is going on here) 10000 files takes
> 3.1 seconds, and of course a native binary that creates 10000 files
> with a single invocation would be faster.
>
> > I'd really like to modify test_seq to use seq when it's available and
> > fall back to the looping-in-shell when we need to for various
> > platforms.
>
> So, if I am reading Jeff correctly, that optimizes something that is
> not a bottleneck.

Oh, indeed.  Sorry, I misread.
