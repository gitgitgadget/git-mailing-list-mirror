Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C502CC433ED
	for <git@archiver.kernel.org>; Sun,  2 May 2021 23:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93CC661182
	for <git@archiver.kernel.org>; Sun,  2 May 2021 23:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbhEBXUl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 May 2021 19:20:41 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48]:33546 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhEBXUl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 May 2021 19:20:41 -0400
Received: by mail-ej1-f48.google.com with SMTP id t4so5276828ejo.0
        for <git@vger.kernel.org>; Sun, 02 May 2021 16:19:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8NhHKXGUnK8WDQ9NnlvvqgB2LhMhJxxN+3IrsGGvWbg=;
        b=HBO+FnuEwD1N4N6p0Mr27mp7Vi4cQbzBTMgoC0z+Lrajz977Ixb6r4xnWkNu5jNQu4
         T7/IVAk4Iq3ODkDd7DwpF8AGc79BEISidLjlIFktGX7Xa4V5hcF5iTdlYMo3v10IkOj6
         b8lZz5oEVUsGz6zIDMgQGGMxFjLCVH6UxVNqSF73HN89kwWeZgKxkfsPKHk5G3szKwfy
         yNBWAy4wCTzs0ENJ2oczogLKxA1oSZAgwZs4+d5zISxoKrsEBb0Xw6JPrqZfCUaFPuPi
         I3vU1eM18fSobD0BUPy2RxtwQamYpK18zzOjvvgD06c2/9iU3yTMyurUfFlTaad1u67p
         Ouqg==
X-Gm-Message-State: AOAM5328r97LQ94FYE7sNQMHGCX39g6XeGJCCRllmLepfteUKEGUuo9C
        Dw0u069nWgJAlO6kMPkUhdkcdAJSoOZrVgVerworxwpppr4=
X-Google-Smtp-Source: ABdhPJw9epGkReRvffmQ//1I/1pJ/JT2dGPZeCShTj9aLKa+obvy3wkUgDdage5/sTRFdMlgDJLanvZmyLfErtZkFIg=
X-Received: by 2002:a17:906:90b:: with SMTP id i11mr14178726ejd.168.1619997588072;
 Sun, 02 May 2021 16:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <gitgitgadget/git/pull/934@github.com> <gitgitgadget/git/pull/934/c830744540@github.com>
 <CACZqfqA8u8cRM5xSdnArUW7tGOJX9dVO41FsmQU4-d2NyiNCiA@mail.gmail.com> <CAPig+cS+b-SV6SUkhWMui7_vTEeJYumDDDM10DdrkNqpgm=z_A@mail.gmail.com>
In-Reply-To: <CAPig+cS+b-SV6SUkhWMui7_vTEeJYumDDDM10DdrkNqpgm=z_A@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 2 May 2021 19:19:37 -0400
Message-ID: <CAPig+cSz6TDs6=URFcmi8w0zdvTKV9k2346LHpiWbqKm4tXzRQ@mail.gmail.com>
Subject: Re: [gitgitgadget/git] git-merge: rewrite already up to date message (#934)
To:     Josh Soref <jsoref@gmail.com>
Cc:     "gitgitgadget/git" 
        <reply+AAQFMLC42KHLQTLKSC5H3XV6TILQ3EVBNHHDGQXBRY@reply.github.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 2, 2021 at 2:52 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, May 2, 2021 at 1:49 AM Josh Soref <jsoref@gmail.com> wrote:
> > Eric Sunshine wrote:
> > > diff --git a/notes-merge.c b/notes-merge.c
> > > - printf("Already up to date!\n");
> > > + printf_ln("Already up to date.");
> >
> > Should this have `_(...)` decorations?
>
> Yes, indeed. I'll fix it in a re-roll and mention it in the commit message.

On second thought, I don't think I will make this change since none of
the messages in `notes-merge.c` have been marked for localization yet
-- and there are a lot of messages in that file -- so wrapping just
this one message in `_(...)` would be inconsistent, and marking all
messages in `notes-merge.c` as localizable is outside the scope of
this series.

So, at the moment, I don't plan on re-rolling this series, and
hopefully Junio can pick it up as-is (but, of course, will re-roll if
someone spots something which needs fixing).
