Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA63EC11D00
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 00:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AEBB20659
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 00:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBclO4YY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbgBUAbv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 19:31:51 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46375 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729365AbgBUAbv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 19:31:51 -0500
Received: by mail-ed1-f65.google.com with SMTP id p14so207090edy.13
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 16:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xASVzxPzHOv6uhP0ajT/J85jrKIqguSgbQg6dv/QH2c=;
        b=tBclO4YY82h1fCxGBozz8Rai5IU/G21/bB4QiDDLVzLySHnKrfocIR5n9BksSOJXlS
         GXj5shUYYR4yHCs8IT/PovvAd1rQfK8f971jvx3OaSPHSYPJc1xz1IWYzlJ/hIMcZgD/
         Ju/vkjbAHHX+r/FSsC7Z9PhijZ16Pz4N9ba2opOeSPqOFuOVrnHQ3aWQX6/BZ3Ug+7CJ
         m/cAlDcoLekolJz8pSU9EsQhmwD1aShepf1WFbMZ4dx5tlI0WfBus+GEe5uwPDlYDEFP
         6ac0SKsk4e/lZJ0+niKG6LJPC5ZtnhnI2S52gVIV+s4U6b7S5OS0OQFtkiNHjH6lCsPb
         oZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xASVzxPzHOv6uhP0ajT/J85jrKIqguSgbQg6dv/QH2c=;
        b=Rwwb4luBqM6xYBwfWPJj+znTXPXCJrzwnnyFxhceS+qzu8/uMbyv4Gc0aEXCy7s4DB
         BOd7NVmEUSswPWspnwtizPXa2VQkO3WumH4OgBCLYh+cXmHo6D2Do0i5Bdu6wX1ClrbV
         KJ7XSyV7JJvkOGcEEw7QFwqlk7T017mB0fc1fkbB9MiuB6mwlsKrunCYOJSSjPRSd5rL
         p3+QqkaCxOTNGOjCStHfs4bNoOL2r9Wj8Ab6vp7SayKgpAXpw+0mGORy0iOGMp8Q1j6z
         Py15DqoLTief+M8TDaAelNERq3SpaCFp/c0rvrayzsvstCn0n+eAbhF2mhl8xg+kvpr6
         oprw==
X-Gm-Message-State: APjAAAUe7q28AVNXPNqapA8oP3/i4iN09gXYmqQ+AN1qhw4EDTks05FS
        Qlz+XEIGyLku06+++kyi0L94/zTPcJNRYwMoTVs=
X-Google-Smtp-Source: APXvYqx3VF1P/rctulTnYyhwk1b468rRGYUOgT2R0C6Hge6HtcdqJuO3WMWVhq7QGGWD+e3hfY0w96hT4ldPp5FLZPk=
X-Received: by 2002:a17:906:1956:: with SMTP id b22mr31973411eje.276.1582245109732;
 Thu, 20 Feb 2020 16:31:49 -0800 (PST)
MIME-Version: 1.0
References: <pull.548.v2.git.1581889150.gitgitgadget@gmail.com>
 <pull.548.v3.git.1582144442.gitgitgadget@gmail.com> <4ab141426f30dfea19518a78c1de7b5cfbd0802c.1582144442.git.gitgitgadget@gmail.com>
 <20200220013730.GA2447@google.com>
In-Reply-To: <20200220013730.GA2447@google.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Fri, 21 Feb 2020 13:31:38 +1300
Message-ID: <CACg5j262SM1i9FOn4Of2rFgxaur_mOSGs90QBG4fKbSrj05YqQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] advice: revamp advise API
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 20, 2020 at 2:37 PM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> On Wed, Feb 19, 2020 at 08:34:00PM +0000, Heba Waly via GitGitGadget wrote:
> > From: Heba Waly <heba.waly@gmail.com>
> >
> > +static int get_config_value(enum advice_type type)
> > +{
> > +     int value = 1;
> > +     char *key = xstrfmt("%s.%s", "advice", advice_config_keys[type]);
>
> Same comment as your other call for xstrfmt. I think you need to manage
> the output.

Got it.

> > +void advise_if_enabled(enum advice_type type, const char *advice, ...)
> > +{
> > +     struct strbuf buf = STRBUF_INIT;
> > +     char *key = xstrfmt("%s.%s", "advice", advice_config_keys[type]);
>
> Hmm, doesn't this leak?
>
> On the surface it looks like xstrfmt can save you a strbuf allocation,
> but if you check in strbuf.c, it actually allocates and detaches a
> strbuf for you anyways. I'd argue that it's easier to tell whether
> you're leaking a strbuf than the result of this call, so you might as
> well do it that way.
>

You're right.

> > +     SUBMODULE_ALTERNATE_ERROR_STRATEGY_DIE = 28,
> > +};
>
> Hmm. I wanted to say, "Our codebase uses ALL_CAPS or snake_case in enums
> so you could use lowers if you wanted" - but based on 'git grep -A4
> "^enum"' it's actually pretty unusual to see enums with lower-case
> members. Dang :)
>

Yeah I thought the same at first too but reached the same result.

> > +
> > +             advise_if_enabled(NESTED_TAG, _(message_advice_nested_tag), tag, object_ref);
>
> Hm, if it was me, I would have put this bit in its own commit. But I see
> that it's a pretty tiny change...
>

That'd have been better of course, don't know why I didn't think of that :)

> > +     //use any advice type for testing
> I think this might be misleading - your t0018 does quite a few checks
> explicitly for the NESTED_TAG advice. Maybe it's better to say something
> like "Make sure this agrees with t0018"?

I see your point, I'll need to think more about this one.

> Also nit, I've been told off a
> few times for using //c++ style comments.

Oh ok.

Thanks a lot, Emily

Heba
