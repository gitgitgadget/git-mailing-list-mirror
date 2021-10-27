Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048CDC433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 04:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D76A0610CB
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 04:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbhJ0Ebk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 00:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbhJ0Ebj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 00:31:39 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16287C061570
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 21:29:15 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id y14so1565117ilv.10
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 21:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7cjE+VkAGOyFetBESrXLXDHykN7khDDuhKcRiqjrXQ4=;
        b=JG3WZEtilY3HE7wWStBW8IJaENoPALEHpw/IIgStNWqgd27LDfYSFoTEu01fA9Y59i
         cDbJszsE1KZ6eYNLI0j2kdTYhUX3GaLHkiApsPbjl1b9JDxY6ior/l+Nm2tN9vE/UriA
         ApYev6tgEv8hLgPhpQ0zwLsSsDOGvfZVCZR0Qng/5qUvge3VezTl+FFozQpe7fnmrNEM
         5dhKvrS2i4MGB6xLL4q6USrx6XMtLg8/+Y/IGl75yZNCzq6ZsXIl8ek/hUjZoklQYPqJ
         BFJVrS/z8oRQ/aQExnPFZAQOkPbP2jCEE2EXRiqNuRYr5socNkARRDDoJtYED01RkUuq
         l+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7cjE+VkAGOyFetBESrXLXDHykN7khDDuhKcRiqjrXQ4=;
        b=CFVF1uyLOfGpNcx1BVofXV3VD+zN7siVw2OiBDMRLFxj/n63VEE64JJ9jrC0uimEve
         Nah3V5ElgaeJsPBR6U3zl+ZRuzyT9H85IN1n+6OqB4/9kiORxtndJOvU1SfqRz0QKUc9
         yywbZoYHKx/fhufoY1MPS0xqLdd4/NjWVHAU51L1R2+voeRjav2YTmnuYt0hHs9RjbAG
         a4mxe6DHv5LspYX3Ywd0SW/4cFSj8USqp2/2eRocDqbmJ1bfsOB5UYqc8Te8Wi9G40Y5
         5U1udpATYgPBnx7T2KB592ijLywkPslOY/fVTiAxVtpA7nV3gW/UXIf49vqgtI66imC+
         zDCA==
X-Gm-Message-State: AOAM532utAN2IqiC8L2UOccPzVQltKGj0o6YSr8bghiVagxMQvtj6XNp
        wyNU0FU3gQGrnivCs1X+pbPPWGZdu4TtEAcxRFo=
X-Google-Smtp-Source: ABdhPJz3p1Dgc8ILPypafmauwWamL1mvQ8/zRhP895AlDmRl0HOZbT8qVTToWzuJO//mI132+MnNFhBbEZrHvwfdDqk=
X-Received: by 2002:a05:6e02:1aa5:: with SMTP id l5mr16150576ilv.268.1635308954405;
 Tue, 26 Oct 2021 21:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1117.git.git.1635210227532.gitgitgadget@gmail.com> <xmqqee87xy39.fsf@gitster.g>
In-Reply-To: <xmqqee87xy39.fsf@gitster.g>
From:   Robert Estelle <robertestelle@gmail.com>
Date:   Tue, 26 Oct 2021 21:28:48 -0700
Message-ID: <CAMmwyQpVHuo0zuCZ9YmSn4=J0njeRNF3ooxyZ5nggL3HRxx8fw@mail.gmail.com>
Subject: Re: [PATCH] color: allow colors to be prefixed with "reset"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Robert Estelle via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Unlike the "default" patch, I quite do not see the point of the example(s).

Yeah. This "reset" one was developed mainly as a hedge in case there
were concerns about the "default" one. You're correct that the
"default" one provides a finer-grained capability, and if we had to
choose, I'd go with that. However, the two are mutually compatible (no
conflicts, even) and complementary.

This "reset" approach seemed easier to go through since it just
generalizes the treatment of the existing "reset" capability without
introducing any new names or even SGR sequence numbers.

(The immediate goal of was to have some way to control from a color
whether to inherit or remove an existing background).

> Instead of saying "reset green", can't we already say "set bg to default, and set fg to green", thanks to the other one?

Yes-ish, however, "default" is just a color name: and like other
colors, it doesn't imply any attribute (bold etc) resets. Like, if you
turn on bold, and then change the color to red, you'll get bold red.
If you then change the foreground back to default, you'll have bold
whatever.

Instead, with "default", to avoid inheriting you could write:
   green default no-bold no-dim no-italic no-ul no-blink no-reverse no-strike
resulting in an ANSI sequence like: `\e[22;23;24;25;27;29;32;49m`

It's just a mouthful. `reset green` results in `\e[;32m`, which does
functionally the same thing. It's just the combination of "reset
everything" (``\e[m` or equivalently \e[0m`) followed by a color
(`\e[32m`).  I considered calling "reset" something like "only" since
that reads more clearly to me, but I also felt it was not worth the
cuteness when "reset" already existed and was defined consistently.

> Or does "default" do too little to deserve a name that implies "go back to default", e.g. by not defeating the 'blink' attribute that was set earlier?

I agree that "default" feels ambiguous. Within the current
positional-name format vs. e.g. "fg=green bg=default bold=on", I had a
lot of trouble thinking of a name that wouldn't be. However, "default"
is the same word as in the ANSI spec, used in console_codes(4) (see
heading "ECMA-48 Select Graphic Rendition here:
https://man7.org/linux/man-pages/man4/console_codes.4.html) and
ncurses (https://man7.org/linux/man-pages/man3/default_colors.3x.html).
I also explored a few terminals' settings to see if there was a better
name: usually they'll just refer to it unhelpfully as "foreground" or
"background", but when they're otherwise named it's usually like
"DefaultForeground".

Other names I'd considered had their own problems: "unset" could be
confusing alongside the existing "reset", "clear" could be confusing
as a foreground or in the context of translucent terms, "no-color" is
usually just untrue, and "normal" is (very confusingly, IMO) already
special-cased as a no-op word.

Best,
Robert

On Tue, Oct 26, 2021 at 2:42 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Robert Estelle via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Robert Estelle <robertestelle@gmail.com>
> >
> > "reset" was previously treated as a standalone special color name
> > representing `\e[m`. Now, it can apply to other color properties,
> > allowing exact specifications without implicit attribute inheritance.
> >
> > For example, "reset green" now renders `\e[;32m`, which is interpreted
> > as "reset everything; then set foreground to green". This means the
> > background and other attributes are also reset to their defaults.
> >
> > Previously, this was impossible to represent in a single color:
> > "reset" could be specified alone, or a color with attributes, but some
> > thing like clearing a background color were impossible.
> >
> > There is a separate change that introduces the "default" color name to
> > assist with that, but even then, the above could only to be represented
> > by explicitly disabling each of the attributes:
> >   green default no-bold no-dim no-italic no-ul no-blink no-reverse no-strike
> >
> > Signed-off-by: Robert Estelle <robertestelle@gmail.com>
> > ---
>
> Unlike the "default" patch, I quite do not see the point of the
> example(s).  Instead of saying "reset green", can't we already say
> "set bg to default, and set fg to green", thanks to the other one?
> Or does "default" do too little to deserve a name that implies "go
> back to default", e.g. by not defeating the 'blink' attribute that
> was set earlier?
