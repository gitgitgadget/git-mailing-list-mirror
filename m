Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFF2C433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 11:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhLTLQJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 06:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbhLTLQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 06:16:09 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB90BC061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 03:16:08 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id y22so36861660edq.2
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 03:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=UDiKx2jUxaREy0yGE3baINmVsvt+78n7pZPL2vO6ihA=;
        b=X7cYHn7U7EhseFg5faXGkuQC+/6oUl4hAssOCHR6FHhxqwPo4piIMFXDmnfXpaWSZU
         qyIa9sv70chdPsVOr7V/pDhfH2bE9hN+iH0z/2am4Oavo/askixX688oKcPKh50pHZ4c
         sIGa+HxkxYbBGA9vqNKRIS+UH8RPaIbMVSq6ViVbAoRCoGZqMB39+ApQ3R68GXPfaXaO
         NSIqDYkQr3fRYMjXpMubYqr043FeCkkDCvMhQcvSlDBKJA/snCpLzXlEUvqAZEOJvPV4
         x7YHoIa81kloi98h6rKLZ7zOIZ2rdD7OxLxIVacPG4zpA+PrKRrNGO6EOybpMRunuumE
         1k2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=UDiKx2jUxaREy0yGE3baINmVsvt+78n7pZPL2vO6ihA=;
        b=LrNDcTuuHwz1iBSMXx4tlfN9iVa9fPTdCL1iquPU+3QoDCFspKXY3FoebeXkoCZwLG
         81QgAVb086cFRsrW9cPejxXYgizq4q/ACO0DDG9YRK3ijIUaZDIOwhyHXNq6ZYWhHu6Y
         9x1jp1TDSkJNiw8DeSEmBG/TJYVOkAGReOmr69xhWKW4T8HnXianMpWCpzfCIUoPWgAz
         j+OdOYnYqKQ9FUYkBu14T1hDapND7AoZUqAdgvcC5fU87Zs4pdZEFn9rEnwT4EHFH5sU
         4nseRdnl1O62d5HNmNwznt7hOSjqCgMyEP/A3cwp3iUSZSz0tk16Nwa/P6g9FdKUstSr
         RzqQ==
X-Gm-Message-State: AOAM531W3fMfjuDiPPjhQccU4sAIk6LKi0SeZg9qLlbfGuImhNnTstHC
        kOU1lfO9kL0t8v5UZA5kYxh5/7Rvk5k=
X-Google-Smtp-Source: ABdhPJyKNEH0Rg0NF95gI3Hlq8gwReag4bnEol8ptiHCOC6bZP1+NAQgC+jMHmnvIjHVMwKN2/aF7Q==
X-Received: by 2002:a17:906:1706:: with SMTP id c6mr12589861eje.343.1639998967045;
        Mon, 20 Dec 2021 03:16:07 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id qp24sm5147621ejb.84.2021.12.20.03.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 03:16:06 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mzGeD-000MZM-QU;
        Mon, 20 Dec 2021 12:16:05 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Sean Allred <allred.sean@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Custom subcommand help handlers
Date:   Mon, 20 Dec 2021 12:11:16 +0100
References: <CABceR4ZW4rRWZnH0ZBkWty_H84Z4CmXque_LO+1edETEWrO8PQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <CABceR4ZW4rRWZnH0ZBkWty_H84Z4CmXque_LO+1edETEWrO8PQ@mail.gmail.com>
Message-ID: <211220.86k0fzwmq2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Dec 18 2021, Sean Allred wrote:

> Hi folks,
>
> I've got a custom subcommand I'm distributing in my company to
> integrate with our bug-tracker. It's a pretty robust utility and has
> its own help function, but running `git foo --help` doesn't pass
> --help to my git-foo utility. I asked a question[1] about this
> scenario on the Windows fork and they directed me upstream.
>
> It sounds like `git foo --help` is internally consumed as `git help
> foo`, which forwards requests to info/man/web handlers per config.
> Being on Windows and knowing my peers as I do, the vast majority of my
> users won't be familiar with info or man. The HTML documentation used
> by the web handler is in a Git4Win-controlled installation directory
> that I'd really rather not touch/maintain. I really just want `git foo
> --help` to call `git-foo --help`.
>
> What's the best way to go about this?
>
> In the event the best next step is to start a patch, does it sound
> reasonable to simply not perform this `git foo --help` -> `git help
> foo` transformation for non-builtins? Or, while I don't relish the
> idea, would some kind of config option be needed?
>
> Best,
> Sean Allred
>
> [1]: https://github.com/git-for-windows/git/discussions/3553

I don't know if there's a solution that'll please everyone here, but
it's definitely not narrowing this to built-ins. E.g. "git send-email
--help" will expect to show the manual, so will "git annex --help".
