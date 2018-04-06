Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DABB91F424
	for <e@80x24.org>; Fri,  6 Apr 2018 06:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751399AbeDFGmC (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 02:42:02 -0400
Received: from mail-pl0-f44.google.com ([209.85.160.44]:38714 "EHLO
        mail-pl0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbeDFGmB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 02:42:01 -0400
Received: by mail-pl0-f44.google.com with SMTP id k6-v6so79785pls.5
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 23:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nK/qUBJchOFKSyTTsK+0K2qjZiln1x261vgWR5gC2VA=;
        b=NsEYiO1tgz3Iec3ZnSBfAq/lVYVEFXS5Z1f89QSVTcMvjk2Tz4o8d9Zp5B7OJdm8Pr
         fKo5OxRBciopbCZj7V0jJuWmfnLI6hXhrA52C6hph/DMp+so/s1/rHpvk3wHROMZ1Odl
         kbGM7vP8UOzMjTiqLKHO3ZiBG10QC7KOGYKQd3PbzPbo4yPg9P8PxDTsiO57XXpr3B+N
         peQDa4mOijKCXRPb1Q93rM3fKPrfAgRCMojjMfGumg1oz2sU3JUQ/Oe0rfYVHu6x+x9L
         IyxBtw/gJThra3gNLQyuxrRcrQVn+mwQWlPHPnI+PMrwCTyFWIB3Gz7jQtZyeNtrCeMf
         UlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nK/qUBJchOFKSyTTsK+0K2qjZiln1x261vgWR5gC2VA=;
        b=jgIF1ptOIpot5UCb1oqpkWJvOqpTCalvnviDYkV69q91h+7i/tcNMEODQPwdy9Dcxq
         XiaqKhW6bTuq9zxQ7L1Ytavy790/Qez4+4M6l874j43f594D2+GmHhWNWHRjDAsBogi5
         0FRYXUgEoFDDU/Sxo0u2ShG463ASS4b24vd3VqrPjmWV5IjPfcvHiltqme2ZHECS/dXk
         vfrT2wuNR9hIj5yIrDDMwiNso4GZUY5/V1i1tQWUz3Fx+gc/6T6nsF0DioSX7+K7HR/D
         hQcBoTq9B/zGDq6XdncRIXKoOBdW6sOrLFNyaGs9MTD4kjUHFmkBAxys+2rrWxTgngIT
         l73A==
X-Gm-Message-State: AElRT7GKDmWbRZoVCWkB0Bzmxtwtkz2jVf203jK84dZ1BDO9AQApY/nH
        RuNbikxi05FuuYvQhCFysGYjm3+yye0=
X-Google-Smtp-Source: AIpwx4+ffw4zAaO1XYaF0IfWMPJKMBZOBxh+5VKAsZZVj4NXRXaO100Ka7gD0zGjgKdAlccFVlsLgQ==
X-Received: by 2002:a17:902:30f:: with SMTP id 15-v6mr25242620pld.365.1522996920936;
        Thu, 05 Apr 2018 23:42:00 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:3d01:699f:f606:da49])
        by smtp.gmail.com with ESMTPSA id x4sm18736316pfb.46.2018.04.05.23.41.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Apr 2018 23:41:59 -0700 (PDT)
Date:   Thu, 5 Apr 2018 23:41:57 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 2/2] builtin/config.c: prefer `--type=bool` over
 `--bool`, etc.
Message-ID: <20180406064157.GA3500@syl.local>
References: <20180329011634.68582-1-me@ttaylorr.com>
 <cover.1522992443.git.me@ttaylorr.com>
 <20180406052907.GD60769@syl.local>
 <CAPig+cSYuWReTFfnN8Wg2VGKcOk5SPHHWpTdW6yks67mkOjY0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cSYuWReTFfnN8Wg2VGKcOk5SPHHWpTdW6yks67mkOjY0Q@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 06, 2018 at 02:14:34AM -0400, Eric Sunshine wrote:
> On Fri, Apr 6, 2018 at 1:29 AM, Taylor Blau <me@ttaylorr.com> wrote:
> > builtin/config.c: prefer `--type=bool` over `--bool`, etc.
>
> This patch isn't just preferring --type; it's actually introducing the
> functionality. Perhaps:
>
>     builtin/config.c: support --type=<type> as preferred alias for --<type>
>
> (Not worth a re-roll.)

Thanks; I like this more, even though it is lengthy.

> > `git config` has long allowed the ability for callers to provide a 'type
> > specifier', which instructs `git config` to (1) ensure that incoming
> > values are satisfiable under that type, and (2) that outgoing values are
> > canonicalized under that type.
> >
> > In another series, we propose to add extend this functionality with
>
> "add extend"?

Thanks for pointing this out -- I fixed it in v6.

> > `--type=color` and `--default` to replace `--get-color`.
> >
> > However, we traditionally use `--color` to mean "colorize this output",
> > instead of "this value should be treated as a color".
> >
> > Currently, `git config` does not support this kind of colorization, but
> > we should be careful to avoid inhabiting this option too soon, so that
> > `git config` can support `--type=color` (in the traditional sense) in
> > the future, if that is desired.
> >
> > In this patch, we prefer `--type=<int|bool|bool-or-int|...>` over
> > `--int`, `--bool`, and etc. This allows the aforementioned upcoming
> > patch to support querying a color value with a default via `--type=color
> > --default=....`, without squandering `--color`.
>
> Drop one of the periods in "...." if you happen to re-roll for some reason.

Great catch, thanks.

> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> > diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> > @@ -9,13 +9,13 @@ git-config - Get and set repository or global options
> >  SYNOPSIS
> >  --------
> >  [verse]
> > -'git config' [<file-option>] [type] [--show-origin] [-z|--null] name [value [value_regex]]
> > +'git config' [<file-option>] [--type] [--show-origin] [-z|--null] name [value [value_regex]]
>
> It's pretty confusing to see bare "--type" like this which makes it
> seem as if it doesn't take an argument at all. Better would be
> "[--type=<type>]".

Agreed; I have made this change in v6.

> > @@ -38,12 +38,13 @@ existing values that match the regexp are updated or unset.  If
> > +The `--type` option requests 'git config' to ensure that the configured values
> > +assosciated with the given variable(s) are of the given type. When given
>
> s/assosciated/associated/

Ditto.

> > +`--type`, 'git config' will convert the value to that type's canonical form.
> > +ensure that the variable(s) are of the given type and convert the value to the
> > +canonical form.
>
> Meh, looks like some sort of editing botch here. I doubt you meant to
> repeat "canonical form" like this.

Ditto.

> > If no type specifier is passed, no checks or transformations are
> > +performed on the value. Callers may unset any pre-existing type specifiers with
> > +`--no-type`.
> >
> > +--no-type::
> > +  Un-sets the previously set type specifier (if one was previously set). This
> > +  option requests that 'git config' not canonicalize the retrieved variable.
> > +  `--no-type` has no effect without `--type=<type>` or `--<type>`.
>
> The final sentence doesn't really add value; I'd probably drop it as
> extraneous. (Subjective, and not worth a re-roll.)

Hm. I like the completeness of it -- I think that I would prefer to
leave it in, unless others have strong feelings.

> > diff --git a/builtin/config.c b/builtin/config.c
> > @@ -61,6 +61,33 @@ static int show_origin;
> > +static int option_parse_type(const struct option *opt, const char *arg,
> > +                            int unset)
> > +{
> > +       [...]
> > +       if (!strcmp(arg, "bool"))
> > +               *type = TYPE_BOOL;
> > +       else if (!strcmp(arg, "int"))
> > +               *type = TYPE_INT;
> > +       else if (!strcmp(arg, "bool-or-int"))
> > +               *type = TYPE_BOOL_OR_INT;
> > +       else if (!strcmp(arg, "path"))
> > +               *type = TYPE_PATH;
> > +       else if (!strcmp(arg, "expiry-date"))
> > +               *type = TYPE_EXPIRY_DATE;
> > +       else {
> > +               die(_("unrecognized --type argument, %s"), arg);
> > +               return 1;
>
> Pointless unreachable 'return'.

Removed -- this is a habit of mine from Git LFS. We have a function
similar to die(), but Go doesn't know that it will terminate the
program, so it forces me to write a "return" after it.


Thanks,
Taylor
