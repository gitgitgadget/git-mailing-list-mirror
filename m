Return-Path: <SRS0=E3tc=7P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E871EC433DF
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 19:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B910A206A2
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 19:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwJJXH7l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgFBTpx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBTpw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 15:45:52 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B5AC08C5C0
        for <git@vger.kernel.org>; Tue,  2 Jun 2020 12:45:52 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id x1so13947483ejd.8
        for <git@vger.kernel.org>; Tue, 02 Jun 2020 12:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Zw0m2kLxtsX7VZtbpO5kh+KRG8B3Zfsyq8eK6gMBhn4=;
        b=FwJJXH7lg8EJ7KH/F3EcuCppGhhnOPDx3W6LURwSFNLQk4FqG8karYLdxg+egZslnF
         3Zred9QSkCedVIEHh6+eTyD17LZAtPHsIry8atcOIqMohiZUvHLUiDDf0MOFDP/GXzxI
         4293JwM7MINfXiUdSrQdru1OqHXEo+9b43l1tPIkmyOYkY1KceKvhxWnDm7BriWuXhO+
         leWFpjcQEl0IJ8Nz+1a3jBoloxMwf0RUO0m2p9UejxxnhXo4CkKR0U/r/THVmZmc+gu4
         TGyNAo/b4nt4LhwZ2V3q8a8GQbq53ADMsCI6nc0kxDB03bTmA98INILbxVv3FnW18ZYU
         AYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Zw0m2kLxtsX7VZtbpO5kh+KRG8B3Zfsyq8eK6gMBhn4=;
        b=GzJRZpyrIl6ck7yV/PyRo8uA81i6ErH0v/UxlmQYA9R9Mq1lob2cWpfbbmQ4RoLHsN
         0nWuoTgTU2l1vkAir7/C5msjDPsWorrd/MWDKKc71JPMMmFuG5ygNnrk1mg2O/1mhgsn
         6pcYJrDS0z7JfMfplf2B6Xgf0C7DtcnxdbsSC+N0xyWOg/VMGmfWrmWrV7Ox83iVHvWv
         5AEjngqRyRz2EYRDufcINzqszXAQzJW5rCDrRUR8IWp1XHmAQimwlqZE2Vfi6c1BEUaa
         MrCAyViVxCa2CZReW3AQnz649DglOaEdKBm7xGj4TdSeRqD9tvpzDST5MkD+H9o+EOJw
         hhzg==
X-Gm-Message-State: AOAM532gUqShQUXsMftVv84x/G96LA7YIpvOwmjG48p2JzdVWcVMTRrN
        O2b4qF5v/XLVr7iJAXcRXo4xQGfCbvfJQvrA5r0=
X-Google-Smtp-Source: ABdhPJx/0YApq/sGphdtTBjtCruA4yL1scPgfZziyltsUmz1RHPKIXyAYXHDGON3be2q9bL9gCYgY7a7YqoPa6tRONQ=
X-Received: by 2002:a17:906:4406:: with SMTP id x6mr24651237ejo.160.1591127150805;
 Tue, 02 Jun 2020 12:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200523163929.7040-1-shouryashukla.oo@gmail.com>
 <20200602163523.7131-1-shouryashukla.oo@gmail.com> <1b851e49-3bb1-3b59-7f24-b903c5514391@gmail.com>
In-Reply-To: <1b851e49-3bb1-3b59-7f24-b903c5514391@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 2 Jun 2020 21:45:39 +0200
Message-ID: <CAP8UFD3Qe3iDe+ymKsqv9HarFLYDohXmUGbkNwZ4MdVQ=XP7yQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH v5] submodule: port subcommand 'set-branch' from
 shell to C
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 2, 2020 at 9:01 PM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> On 02-06-2020 22:05, Shourya Shukla wrote:
> > Convert submodule subcommand 'set-branch' to a builtin and call it via
> > 'git-submodule.sh'.
> >
> > Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> > Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> > Helped-by: Denton Liu <liu.denton@gmail.com>
> > Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> > Helped-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gmail=
.com>
> > Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> > ---
> > Here is the v5 of the subcommand. Thank you Danh for the feedback! I
> > apologise for not replying on time. I have taken into account Danh's
> > suggestions on the `quiet` option as well as done the fixup Dscho
> > suggested (fixed by Junio here:
> > https://github.com/gitster/git/commit/77ba62f66ff8e3de54d81c240542edb42=
a2711c7)
> >
> >   builtin/submodule--helper.c | 44 ++++++++++++++++++++++++++++++++++++=
+
> >   git-submodule.sh            | 32 +++------------------------
> >   2 files changed, 47 insertions(+), 29 deletions(-)
> >
> > diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> > index f50745a03f..a974e17571 100644
> > --- a/builtin/submodule--helper.c
> > +++ b/builtin/submodule--helper.c
> > @@ -2284,6 +2284,49 @@ static int module_set_url(int argc, const char *=
*argv, const char *prefix)
> >       return 0;
> >   }
> >
> > +static int module_set_branch(int argc, const char **argv, const char *=
prefix)
> > +{
> > +     int opt_default =3D 0, ret;
> > +     const char *opt_branch =3D NULL;
> > +     const char *path;
> > +     char *config_name;
> > +
> > +     /*
> > +      * We accept the `quiet` option for uniformity across subcommands=
,
> > +      * though there is nothing to make less verbose in this subcomman=
d.
> > +      */
> > +     struct option options[] =3D {
> > +             OPT_NOOP_NOARG('q', "quiet"),
> > +             OPT_BOOL('d', "default", &opt_default,
> > +                     N_("set the default tracking branch to master")),
> > +             OPT_STRING('b', "branch", &opt_branch, N_("branch"),
> > +                     N_("set the default tracking branch")),
> > +             OPT_END()
> > +     };
> > +     const char *const usage[] =3D {
> > +             N_("git submodule--helper set-branch [-q|--quiet] (-d|--d=
efault) <path>"),
> > +             N_("git submodule--helper set-branch [-q|--quiet] (-b|--b=
ranch) <branch> <path>"),
> > +             NULL
> > +     };
>
> I'm having second thoughts about my suggestion[1] to include
> the short option for '--quiet' in the usage. This is the only
> usage in submodule--helper that mentions that '-q' is a short
> hand for '--quiet'. That seems inconsistent. I see two ways but
> I'm not sure which one of these would be better:
>
> A. Dropping the mention of '-q' in this usage thus making it consistent
>     with the other usages printed by submodule--helper.
>
> B. Fixing other usages of submodule--helper to mention that '-q' is
>     shorthand for quiet. This has the benefit of properly advertising
>     the shorthand.
>
> C. Just ignore this?

The `git submodule` documentation has:

-q::
--quiet::
        Only print error messages.

even though the Synopsis is:

'git submodule' [--quiet] [--cached]
'git submodule' [--quiet] add [<options>] [--] <repository> [<path>]
'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
...

So I prefer B, and maybe updating the synopsis, as I think most Git
commands have '-q' meaning '--quiet'.

[...]

> So, according to this, I think the usage should be ...
>
>      git submodule--helper set-branch [-q | --quiet] [-d | --default] <pa=
th>
>
> ... and ...
>
>      git submodule--helper set-branch [-q|--quiet] [-b | --branch]<branch=
> <path>
>
> ... respectively.

I don't agree. I think `git submodule--helper set-branch ...` requires
either "-d | --default" or "-b | --branch", while for example:

git submodule--helper set-branch [-q | --quiet] [-d | --default] <path>

would mean that "git submodule--helper set-branch my/path" is valid.
