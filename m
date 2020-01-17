Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A65C33CB1
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 14:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F4C21D56
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 14:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ZGJWm/km"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgAQOkS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:40:18 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:33513 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgAQOkS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 09:40:18 -0500
Received: by mail-ua1-f68.google.com with SMTP id a12so9032143uan.0
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 06:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ok9QkapI2Kt37vAqpwks4JpnsOws5Y1SEow/35s8Sk0=;
        b=ZGJWm/kmC+2eENUaHVsCvV2UCGZU1LUuFJhbPwhcYIBn7vgpheTHVLPvUP4TCxNgOR
         t4j/TF9SLnzI1d+Rs7BrFP1BXFJnV0gt7tmEk3HfzHow/Y/M6nxBJXpj5PXYQcugCCrC
         fGgtM4fLy8VSzZ0dFAND/OLQJDpiAtqJ+qldK/yLCSWY4FkKh2vT8r0kY8Df5CkJWEsh
         yvgt6NaBGaWwncQd6szWySJF1jAHz3SgOlLxLL/UZrSZDok6fYHAuhFHOeljuUJj12cv
         Adh0So+33aGmq4s2QNHbIbtOKjJlXy516PEZ3F61rl24tQlG5mptRfQdqaESGWgyBTL1
         nd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ok9QkapI2Kt37vAqpwks4JpnsOws5Y1SEow/35s8Sk0=;
        b=bQfyqDvOInrw+Ojc4S+pYaFpx75lFnheYeonNnjFJSKNrCQKCtjcK5Ko3wlv38eX1E
         s7wRswTfFu7cEeUv7QKjSE+H3FbpqMd6AjbXT8fNUL6lpiroPvdJjCp8b1kfInF0WHr7
         pjQfGN78TooLcyqGCcCjq9aqI/FVGEhBhx4EXY0SG6RWPQikjznSBoG5hXlxUhrRsktb
         N4dSIRfpy8SGR6HiwtfbQBl+1y/X8PHU8G9meIvnZlhwGqIx951LA23yd1KTdbDyIhju
         /J8E+iQMfoNgMUTWClHA0xIsHj3hppf3JalnNW9Y9U3t0b8PitDS3Jg3VylwE45AxzaU
         kC3w==
X-Gm-Message-State: APjAAAUjPN0AzgQgDiiv2gN+lVqdmtUa9PNqogpIi+Qkt2zpGZ1PS3dA
        wPRMJqqZv9T4F0baFnrww0oVui3Wl1FyaApA/hE=
X-Google-Smtp-Source: APXvYqy8SiTaGnSEU5l7zNOGOqUOpAhG8G4jMQzYfU4iSoQ2OmmenswZfAjvJwugP57UUfpHb70ufcTwBTFh/KSlXPk=
X-Received: by 2002:ab0:60ba:: with SMTP id f26mr21499266uam.51.1579272016883;
 Fri, 17 Jan 2020 06:40:16 -0800 (PST)
MIME-Version: 1.0
References: <5a8791ef1e262d2078a4ca26b87bfbd777bd4432.1579209398.git.bert.wesarg@googlemail.com>
 <ffc8ffc6ede731b182d32a81d044428566acc625.1579253411.git.bert.wesarg@googlemail.com>
 <nycvar.QRO.7.76.6.2001171245300.46@tvgsbejvaqbjf.bet> <CAKPyHN0eTa9LC35oqsy0Dce0qpOJAx159HR+QyguDt_NZ2he_w@mail.gmail.com>
 <nycvar.QRO.7.76.6.2001171428170.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2001171428170.46@tvgsbejvaqbjf.bet>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Fri, 17 Jan 2020 15:40:04 +0100
Message-ID: <CAKPyHN0qY5odXi2wAv20D4nsNM0r4qO_8JOx9DHiGchJmS8cbw@mail.gmail.com>
Subject: Re: [PATCH v2] remote rename: rename branch.<name>.pushRemote config
 values too
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Jan 17, 2020 at 2:30 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Bert,
>
> On Fri, 17 Jan 2020, Bert Wesarg wrote:
>
> > On Fri, Jan 17, 2020 at 12:50 PM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > Hi Bert,
> > >
> > > On Fri, 17 Jan 2020, Bert Wesarg wrote:
> > >
> > > > When renaming a remote with
> > > >
> > > >     git remote rename X Y
> > > >
> > > > Git already renames any config values from
> > > >
> > > >     branch.<name>.remote = X
> > > >
> > > > to
> > > >
> > > >     branch.<name>.remote = Y
> > > >
> > > > As branch.<name>.pushRemote also names a remote, it now also renames
> > > > these config values from
> > > >
> > > >     branch.<name>.pushRemote = X
> > > >
> > > > to
> > > >
> > > >     branch.<name>.pushRemote = Y
> > >
> > > Should we warn if remote.pushDefault = X?
> >
> > AFAIU, the value of remote.pushDefault wont be renamed yet. So you
> > suggest to issue a warning in case remote.pushDefault is X. But as X
> > does not exists anymore after the rename, the value of
> > remote.pushDefault is invalid. So why not rename it too?
>
> If this setting was usually a repository-specific one, I would suggest to
> change its value, too. But it is my understanding that this might be set
> in `~/.gitconfig` more often than not, so I recommend a warning instead.

than why not rename it, if its a repository-specific setting and warn
if it is a global one? If this is detectable at all.

>
> > > > @@ -305,7 +309,7 @@ static int config_read_branches(const char *key, const char *value, void *cb)
> > > >                               space = strchr(value, ' ');
> > > >                       }
> > > >                       string_list_append(&info->merge, xstrdup(value));
> > > > -             } else {
> > > > +             } else if (type == REBASE) {
> > > >                       int v = git_parse_maybe_bool(value);
> > > >                       if (v >= 0)
> > > >                               info->rebase = v;
> > > > @@ -315,6 +319,10 @@ static int config_read_branches(const char *key, const char *value, void *cb)
> > > >                               info->rebase = REBASE_MERGES;
> > > >                       else if (!strcmp(value, "interactive"))
> > > >                               info->rebase = INTERACTIVE_REBASE;
> > > > +             } else {
> > > > +                     if (info->push_remote_name)
> > > > +                             warning(_("more than one %s"), orig_key);
> > > > +                     info->push_remote_name = xstrdup(value);
> > >
> > > It makes me a bit nervous that this is an `else` without an `if (type ==
> > > PUSH_REMOTE)`... Maybe do that, just to be on the safe side, even if
> > > another type is introduced in the future?
> >
> > I'm not a friend of this last 'else' either, but it was so to begin
> > with. I'm all for changing it to an 'else if'. Though while it is
> > impossible that 'type' has a value different than one from the enum, I
> > would be even more comfortable with having BUG at the end.
>
> My thinking was: even if this was a bare `else` before, why not fix that
> issue while we're already in the area? I like the `BUG` idea.

Glad I can squash this into this one, instead of making it a single
patch out of it.

Bert

>
> Ciao,
> Dscho
