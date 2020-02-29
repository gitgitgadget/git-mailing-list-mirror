Return-Path: <SRS0=C4D3=4R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94382C3F2D2
	for <git@archiver.kernel.org>; Sat, 29 Feb 2020 00:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59ED72468D
	for <git@archiver.kernel.org>; Sat, 29 Feb 2020 00:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qbyj9d2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgB2A7E (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 19:59:04 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:34709 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgB2A7E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 19:59:04 -0500
Received: by mail-ed1-f51.google.com with SMTP id dm3so5554956edb.1
        for <git@vger.kernel.org>; Fri, 28 Feb 2020 16:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=65ZYLV8Yewh3xipITwgLnU7ohHOr1NHDbWoa+x3SN6E=;
        b=qbyj9d2lVY+uiMDrFgAlM20ovXhY0r9nR1zASa28WutY2MHm/sJ8RL+wNj7ReZOQhz
         eiWt1qwAYP/1NTGkF+w8ytkBclJzbn4TPpDZb6OQDqSMPZPwwe0rBhEU3ScSpvZvm04j
         0T29VEiAMv+ux9TIPAy8T7eU9rU0E7CQ4xM7o3u5gw/XHHlViHfXG9Eust+rsUtTzUyX
         +SYd3y0wg0DkvRaMre2UDtJyAmXNBbeMZhHsDTvfwOtQHXWpuzk4PiPIYXbYG6Gv4UQR
         KslXzDG8yBXFXMWnQ+LFGs2qfk1gn7lTp4Fs6cQbMdjAKK6yGIAiudIdUZcVGPAZtPD0
         4CZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=65ZYLV8Yewh3xipITwgLnU7ohHOr1NHDbWoa+x3SN6E=;
        b=dv8ReQ9k0iQB58yZCDzersIqsOgpTo2ovq/5TzlaKzE67ysWuK7emLTh49sJjc1rnu
         lIVoK7kruBd5FsKXi+03RXO/2XpsaoP/o1SY67ZuFMrE9Q/WqeF2UjGoKjVdixXdaAN+
         cMYYwfa6GKDx+Ospgb7Cc7FPpLC34rLf0zqUij6bDueEdPNY+mjbLLFeBH+O/sDl6P08
         m0w1Mf1cLPXuKqfQMbE3LAKZhVn1BdHLkxuGOhhXIrqOPwBtbJHVNbYC1L0JVJIf25zT
         LjQpvKUnEHBm4jE4btiOBQs3nlCKwiZ4LWGPKhKjtG51lLLZBaMPDTO/lPL9NPKsg8w/
         aS1g==
X-Gm-Message-State: APjAAAUHpSSYGlY34B6f3xlvLIeEkX24eykiLncm/lHjUswWB5yG6jCn
        g1SF9gvEX3vu++dzn/iN4YyxC+ETHzB2fBUG/QQ=
X-Google-Smtp-Source: APXvYqxxGFQXIHD6oLNQSi4qyu/rD0oYgL163IHOT/VM+w+BUKe6QEnUitPR5pgK/FBRFTjA0EvdycP3TEOpfS0QWy8=
X-Received: by 2002:a17:906:edc7:: with SMTP id sb7mr6166110ejb.367.1582937942917;
 Fri, 28 Feb 2020 16:59:02 -0800 (PST)
MIME-Version: 1.0
References: <pull.548.v5.git.1582628141.gitgitgadget@gmail.com>
 <pull.548.v6.git.1582778112.gitgitgadget@gmail.com> <176e38a841d1bbb138ae31b6db34fb597f9188b2.1582778112.git.gitgitgadget@gmail.com>
 <xmqq7e07g3hr.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq7e07g3hr.fsf@gitster-ct.c.googlers.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Sat, 29 Feb 2020 13:58:51 +1300
Message-ID: <CACg5j25odrJXOt7o5QadSWBAyYnKbSOWKNOjRKCRXPcVjqyheQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] advice: revamp advise API
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 28, 2020 at 9:49 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > diff --git a/advice.c b/advice.c
> > index 258cc9ba7af..8d9f2910663 100644
> > --- a/advice.c
> > +++ b/advice.c
> > @@ -32,6 +32,40 @@ int advice_checkout_ambiguous_remote_branch_name = 1;
> >  int advice_nested_tag = 1;
> >  int advice_submodule_alternate_error_strategy_die = 1;
> >
> > +const char ADVICE_ADD_EMBEDDED_REPO[] = "advice.addEmbeddedRepo";
> > +const char ADVICE_AM_WORK_DIR[] = "advice.amWorkDir";
> > ...
> > +static const char *advice_config_keys[] = {
> > +     ADVICE_ADD_EMBEDDED_REPO,
> > +     ADVICE_AM_WORK_DIR,
> > ...
> > +/*
> > + * To add a new advice, you need to:
> > + * Define a new const char array.
> > + * Add a new entry to advice_config_keys list.
> > + * Add the new config variable to Documentation/config/advice.txt.
> > + * Call advise_if_enabled to print your advice.
> > + */
> > +extern const char ADVICE_ADD_EMBEDDED_REPO[];
> > +extern const char ADVICE_AM_WORK_DIR[];
> > ...
>
> Hmph.
>
> Even though I said that I would prefer it over the current one,
> in that it allows the compilers to catch typo, and over the one
> in v5 which uses enum, in that we do not have to go through
> enum->string->hash conversion all the time, I have to say that I
> am not very happy that we'd need to make a consistent change to
> three separate places.
>

Unfortunately we'll have to make changes to three separate places
until we implement a way to generate the documentation from the main
list or vice versa, which we agreed in v2 not to do that now.
https://lore.kernel.org/git/xmqqftfam5ux.fsf@gitster-ct.c.googlers.com/

> What's the ideal long-term outcome?  The reason why I suggested
> during the v5 review an array of structure, a field in which can
> be the .disabled field, was because it would allow us to later
> extend the struct to help users.  Wouldn't it be nice if we can
> do something like:
>
>     $ git advice --list "^fetch"
>     fetchShowForcedUpdates      enabled
>     $ git advice --list --verbose fetchShowForcedUpdates
>     fetchShowForcedUpdates      enabled
>         "git fetch" by default spends cycles to compute which
>         branches were forcibly updated, but it can be turned off.
>         To avoid mistaken sense of safety, however, a reminder
>         message is issued instead when it is turned off.  The
>         reminder can be turned off with this advice key.
>
> Such a future enhancement will become possible by assiciating a
> help text for each advice key, and the data structure introduced
> in <xmqqsgiymupf.fsf@gitster-ct.c.googlers.com> was meant to be
> the beginning of it.

Ok, you convinced me, will send a new version.

Thanks,
Heba
