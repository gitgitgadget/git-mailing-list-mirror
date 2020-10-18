Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C37BC433E7
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 00:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19D6120E65
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 00:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifcMaCLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440049AbgJRAy6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 20:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440034AbgJRAy5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 20:54:57 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2D1C061755
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 17:54:57 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id f10so6896829otb.6
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 17:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rK8uHET0CwThrvAnD8x8rcQD3WqAmrjjKpj2MtqsBp4=;
        b=ifcMaCLLDu8kjxsyXf9x0MHaBOsDsFfd2MUE4bX74DS3LD0hpnl4B/TzPOf6Y5Y9g9
         /p8nkt3qwe5B/2yf4lsuuWybSrY4KrUuVEZnWbvT2Ax0v6KBXLmWE0ab8hi4Tsu4aCvW
         tst5twLeNt6ViljO9ImaSY46FPVHMVt7H7lsyet88dbbW0z8fMo0DfGFkih9ZROXP4kg
         lWgDLIeVcNac8EuFmLVqc5NUUDoHLZgptgo1NYS2w+R33FqgV9J6Yz/cNywEUtQSfksp
         nexTWZbaRW/cLAEJJkH4Z0fmBP3tVYzsszlTwMJZGm/TgMx0QFaFNjfE07wCwtHvp9Q2
         QhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rK8uHET0CwThrvAnD8x8rcQD3WqAmrjjKpj2MtqsBp4=;
        b=DPGp+QRdft785YEw/LknSyQDdgm9z5JGNzvXSjP3cafLedashA1F1hvZ2XIxvLsNpE
         /0M5FwCfm7bKH5Swxss/OWQtC1fMA7Uw/OR9rnXm4nHdbrEU06MAD8JKLd20M8qaVuOZ
         pX0tAp6j31eal0uGQ4IlNqlAare3I4zhVSSURghI1ipkMApSUDwmwS8zl+61X0E0VMuG
         ky3qtiQMyyY/2eOpIvQxBxuVvkLVZEtJZfVHF3HHeMEbnZhy2u5LYuG1bb4Z/PABypo+
         X9eDyGjVfwQiEIIsbT+dSrEA/g7YxcUiFxa0eAppy0EyL8sAmkacZxQVuz1LNqJHc0v5
         fhZg==
X-Gm-Message-State: AOAM5304zs/CM91FVpMlOE/JM+wadcpfMEkKnTnXfdDj3Px3GM9Sh5yi
        BkdeSEk1nyuh1MPuIf7pyW56xx++cOguTZBgEA4=
X-Google-Smtp-Source: ABdhPJyAuQopwFox6MhHuF0VJVSdcU6Tun+v3VeFcmktfAkrtdJHmrU2u9E8+Lf0rkjVPWsCsN+Nk5/IMB7GJDCuZ4U=
X-Received: by 2002:a9d:2c4:: with SMTP id 62mr8274827otl.102.1602982495494;
 Sat, 17 Oct 2020 17:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <pull.756.git.1602968677.gitgitgadget@gmail.com>
 <13fd992a375e30e8c7b0953a128e149951dee0ea.1602968677.git.gitgitgadget@gmail.com>
 <xmqqeelw8p8i.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqeelw8p8i.fsf@gitster.c.googlers.com>
From:   Nipunn Koorapati <nipunn1313@gmail.com>
Date:   Sun, 18 Oct 2020 01:54:44 +0100
Message-ID: <CAN8Z4-W=+D-P_qCYijGMnStY-EGwKFx-+AYzjACDPAXnLRAA8A@mail.gmail.com>
Subject: Re: [PATCH 1/4] fsmonitor: use fsmonitor data in `git diff`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alex Vandiver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Utsav Shah <utsav@dropbox.com>,
        Alex Vandiver <alexmv@dropbox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> run_diff_files() is used not just by "git diff" but other things
> like "git add", so if we get an overall speed-up without having to
> pay undue cost, that would be a very good news.

Agreed! I may be able to write perf benchmark tests to highlight
benefits to git add as well.

> 20% of the working tree, running refresh_fsmonitor() for the entire
> working tree is still a win, but if we are only checking less than
> that, we are better off without fsmonitor, or does a tradeoff like
> that exist?

My understanding is that refresh_fsmonitor is
O(delta_since_last_refresh) - so for developers
with large repositories - this cost will amortize out over subsequent
commands, so I don't
think it's worth investigating this tradeoff here.
As a user of large repositories, I expect that my major source of
fsmonitor activity to be user
intent (eg git pull, or intentionally copying/editing a large number
of files). After such a command,
I expect my next git command to be slower - that would be unsurprising.

I think the tradeoff could be made for small diff requests, but I
don't think it's worth adding complexity here -
as that user will just have to pay the cost on their next git command.

> > +              *  eg - via git udpate-index --assume-unchanged
> > +              *  eg - via core.ignorestat=true
>
> ... what are these two lines doing here?

Intended to indicate potential ways that CE_VALID might be set. When I
was reading the source
here, it was pretty difficult to determine how this would be set.
Agree that I picked unfortunate wording.
Thanks for the suggestions. Will update in the next iteration.

>
> would probably be what you meant bo say.
>
>         When CE_VALID is set (via "update-index --assume-unchanged"
>         or via adding paths while core.ignorestat is set to true),
>         the user has promised that the working tree file for that
>         path will not be modified.  When CE_FSMONITOR_VALID is true,
>         the fsmonitor knows that the path hasn't been modified since
>         we refreshed the cached stat information.  In either case,
>         we do not have to stat to see if the path has been removed
>         or modified.
>
> or something like that, perhaps.

Sounds good. Will clarify. I like your comment better as well.

>
> > +              */
> > +             if (ce->ce_flags & CE_VALID || ce->ce_flags & CE_FSMONITOR_VALID) {
>
> Would it become easier to read, if written like this instead?
>
>                 if (ce->ce_flags & (CE_VALID | CE_FSMONITOR_VALID)) {

I personally find this more confusing because it involves multiple
bitwise ops, but this
is potentially due to me having more mental practice thinking about
boolean operators vs bitwise operators.
I'm more than happy to align with the common pattern of the repo. I'll
change this.

>
> Thanks.

Thank you for the thorough review!
