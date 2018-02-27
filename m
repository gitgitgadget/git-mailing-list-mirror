Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A3711F404
	for <e@80x24.org>; Tue, 27 Feb 2018 22:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbeB0WIR (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 17:08:17 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:45863 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751797AbeB0WIN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 17:08:13 -0500
Received: by mail-pf0-f179.google.com with SMTP id j24so143031pff.12
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 14:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BL1kRvUt+sam/QsDe7liGyc76YuFliaVd30Y6w+BUh8=;
        b=uFi5Ew/D36SSqHqWTTd7i76kmfynf9bLOVAV73CsOwBifBg/KrwjzF07733X5Y/IqP
         XTWKpCyjGfcw6XaPiUV5qXIQ95qEDK7Aep/lyYInkrKsSY3lzsdr3O2gHl+APbeyV8yM
         nnuvAXTENPQ/QoLlPAqPpAzSa/mXGE21J2gIEO66lzjaume+fV7xhCME/PN38UL1je/D
         T4lTWRjVj8O6dcg8KuEPpdebZum8GlKsV6gn1t1d9droQCEN5bYzh/WEQFUtOkvj9Si3
         7/g8dc9kHBRTZuC2XvKNLp5PZ36QopNtB7QaZREJkMZ0r/BH68T53XLZas4oJkowC20Q
         bTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BL1kRvUt+sam/QsDe7liGyc76YuFliaVd30Y6w+BUh8=;
        b=KF5iQ/m2NtkJYYeEpGNoTZHQ7m+R1M88nHPWEUaP0FPMKb+bRU6fU40gKRyEPakDRa
         Y1w2UmIl4/ps9jgKHiHUXs64pejbyuu+th2TIDb6TI27C6Of/NsKihWG55V1tisbM6uu
         TjPu0rwtxSNXzfxog9K2r3UQUhBoMCwniDFkeAFLxTPMl4Iy1EV2cL3unGzPzrmpXbzp
         FFtFbWrhvI58EBtQ/yFtxqTu2hSoUt9G37/LcgO1SF5Rsafm5aFNUmHJxRKqN2FEb95j
         KKnL4bNpeW0qQNeqV73yJwmQIQ88Zprq1Cpb8bBQgR8CCN7sYVYTLGt9LPUL5GaDuu+3
         qoUw==
X-Gm-Message-State: APf1xPDz2blFv2wMjgJSmf5cwlbHw5Iyc/dTCZjigCWMTs6tXhd2gaXV
        gWsRU8frTyI2jRcOPLZETWcQglrYt/nwQ9kXmnQ=
X-Google-Smtp-Source: AH8x224h3EP8KLvTErLsiF28WaafxSdnt/6AXhnafozu6S9uIOr3TZ0c++l7vTOjiC0EdkiiksgW8yt0tdgm/FvjAgc=
X-Received: by 10.99.43.73 with SMTP id r70mr12714254pgr.316.1519769293303;
 Tue, 27 Feb 2018 14:08:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.236.191.144 with HTTP; Tue, 27 Feb 2018 14:08:12 -0800 (PST)
In-Reply-To: <20180227214430.GC6899@sigill.intra.peff.net>
References: <cover.1519763396.git.martin.agren@gmail.com> <5d657ac87d1e71fd95175faed2b591fa609b8f1c.1519763396.git.martin.agren@gmail.com>
 <20180227214430.GC6899@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 27 Feb 2018 23:08:12 +0100
Message-ID: <CAN0heSr_4Sd5-yAUQ-SG+=NZrwFrAFqY66aYk0DgMEZ_s53iGQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] sequencer: always roll back lock in `do_recursive_merge()`
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27 February 2018 at 22:44, Jeff King <peff@peff.net> wrote:
> I want to note one thing that confused me while reviewing. While looking
> to see if there were other returns, I noticed that the lines right near
> the end of your context are funny:
>
>         if (active_cache_changed &&
>               write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
>                   /*
>                    * TRANSLATORS: %s will be "revert", "cherry-pick" or
>                    * "rebase -i".
>                    */
>                   return error(_("%s: Unable to write new index file"),
>                           _(action_name(opts)));
>           rollback_lock_file(&index_lock);
>
> At first I thought that rollback was a noop, since write_locked_index()
> would always either commit or rollback. But it's needed for the case
> when we active_cache_changed isn't true.
>
> So I think it's correct as-is, but I wonder if writing it as:
>
>   if (!active_cache_changed)
>         rollback_lock_file(&index_lock);
>   else if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
>         return error(...);
>
> might be easier to follow. I'm OK with leaving it, too, but thought I'd
> mention it in case it confused other reviewers.

I also hesitated at that one. There are some similar instances elsewhere, e.g.,
in builtin/merge.c. There's also rerere.c, which does a variant of your
suggestion.

Martin
