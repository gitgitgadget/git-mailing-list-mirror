Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45AFC433E0
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19A062311C
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 17:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lufia-org.20150623.gappssmtp.com header.i=@lufia-org.20150623.gappssmtp.com header.b="DMOtOnsB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbgHFRWu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729975AbgHFRF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 13:05:28 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5050EC0A3BDC
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 06:50:03 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bh1so14457911plb.12
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 06:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lufia-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=yha7tWopbSUXoC00qnJSk4icNdvRhXJ4VEvajshUoHY=;
        b=DMOtOnsBryEN+be4zFL74f3B0lwTEPZ5YUnq/UXCXYXGe7creJxFUxbA4PGsb4FwtX
         UsiP2u3HEtKPmSzG0SJjbnui0sxNQWBmyKHJ2w1g2gwAH0SOegneyGkWQqCNY8y2gyA3
         FCr9qfW/I5ChdF4CYBJHnIuDdou3gIxpQLCSJud2lg+Aa4wjHKsxGtLcix+5Z/DoInsK
         ntgBg9Z9mJa9N7sh9Z65ZeGg5XPfMUaQW35gjQ/AuK85lfiCbxa8WEaPp10FWNt3yJud
         UST4PpKYViRLKWGqIZjNZ+kJL0grWL3IkpwZAa9sfS8NkwaSh8fEKLUq6ugtKMa57rpm
         7Kyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=yha7tWopbSUXoC00qnJSk4icNdvRhXJ4VEvajshUoHY=;
        b=YOmaRFok2dd/KasoAwJILU+OL+LwR8JwCmvsTryQxH0Ff07vNhUGPKjuH5kB1lIPyx
         e3jyl0Yk3fmUbomE37vlmbuFdb5PouPU0pc9nYfrK5egystoUrESiXjkuCyQ/D1FXxYs
         wzNMJ1RprvjdK/gEphfZm4v2Cg3R36xIWMyCLAdCAoE3ZTotTIkSU5lC3FAip2bRWvfp
         tB9e+i3D+aLyz/+rDkNu+vDiNT0x3uD8SzLhJ998KjdeJhG/T3qYj41rjuMRZh35D46m
         OBCCge4QEYl5NSFe2Vs9WAvG+PsColQbZz3MIQgHn+AdAj5tdgX1LL+p37mkSrZF+Anm
         N6bQ==
X-Gm-Message-State: AOAM530o9c4bYLN7gWS41GUTqK6KcEm2xb6K4Pp0WYY2g0Adk/+tqsZv
        EriejlrruE4bzfdiMYJvRpFbR9QECly8myBW+UsnhxY4hSgpQA==
X-Google-Smtp-Source: ABdhPJwkfX1sVKiBDmYxSlzB+KFEGVZU30ED4LxqKDxpocrrZ84z0jBrsEm6N4vGPtGUgbUfj2tKkaYTjATX9zEwpsQ=
X-Received: by 2002:a17:902:868a:: with SMTP id g10mr7781822plo.156.1596721795706;
 Thu, 06 Aug 2020 06:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <pull.694.git.1596675905.gitgitgadget@gmail.com>
 <d15ed626de65c51ef2ba31020eeb2111fb8e091f.1596675905.git.gitgitgadget@gmail.com>
 <20200806020407.GR6540@camp.crustytoothpaste.net>
In-Reply-To: <20200806020407.GR6540@camp.crustytoothpaste.net>
From:   Kyohei Kadota <lufia@lufia.org>
Date:   Thu, 6 Aug 2020 22:49:43 +0900
Message-ID: <CAFMepcn-yWtke7eE006a5RGO6uaScWb2xZe4H5M8X4F_T4Rhbw@mail.gmail.com>
Subject: Re: [PATCH 3/4] Fit to Plan 9's ANSI/POSIX compatibility layer
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        lufia via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, "KADOTA, Kyohei" <lufia@lufia.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On 2020-08-06 at 01:05:03, lufia via GitGitGadget wrote:
> > From: lufia <lufia@lufia.org>
> >
> > That haven't any commands: cut, expr and printf.
>
> Is this ANSI/POSIX environment the one mentioned at [0]?  That page
> describes it as supporting POSIX 1003.1-1990, which is a bit dated.  I
> think we generally assume one has the 2001 edition or later, so you'll
> have your work cut out for you.

Yes, the layer I told is APE.
I guess originally APE might be introduced for porting Ghostscript to Plan 9.

> > And its sed(1)'s label is limited to maximum seven characters.
> > Therefore I replaced some labels to drop a character.
> >
> > * close -> cl
> > * continue -> cont (cnt is used for count)
> > * line -> ln
> > * hered -> hdoc
> > * shell -> sh
> > * string -> str
> >
> > Signed-off-by: lufia <lufia@lufia.org>
>
> I will note that usually the project prefers to have a human's personal
> name here and in the commit metadata instead of a username.  Junio may
> chime in here with an opinion.

I see. I will rename them.

> >  command_list () {
> > -     eval "grep -ve '^#' $exclude_programs" <"$1"
> > +     eval "grep -v -e '^#' $exclude_programs" <"$1"
>
> Is it really the case that Plan 9's grep cannot deal with bundled short
> options?  That seems to be a significant departure from POSIX and Unix
> behavior.  Regardless, this should be explained in the commit message.

This is awful.
But now, APE's grep (/bin/ape/grep) is a simple wrapper for native
grep (/bin/grep),
its option parser is a very rough implementation.
https://github.com/0intro/plan9-contrib/blob/master/rc/bin/ape/grep

> >  get_categories () {
> > -     tr ' ' '\n'|
> > +     tr ' ' '\012'|
>
> Okay, I guess.  Is this something we need to handle elsewhere as well?
> The commit message should tell us why this is necessary, and what Plan 9
> does and doesn't support.

Yeah. I will edit the message.
Plan 9's tr(1) handles only \(16 bit octal) and \x(16 bit hexadecimal)
escape sequences.
If another character after leading backslash, tr(1) will replace \c to c.

> >       grep -v '^$' |
> >       sort |
> >       uniq
> > @@ -18,13 +18,13 @@ get_categories () {
> >
> >  category_list () {
> >       command_list "$1" |
> > -     cut -c 40- |
> > +     awk '{ print substr($0, 40) }' |
>
> I can tell that you haven't gotten the test suite working because I've
> added a large number of cut invocations there.  I suspect you're going
> to need to provide a portability wrapper there that implements it using
> awk, sed, or perl.

I see. If I'd like to put those wrappers to the repository, is there
the best place for them?

> > +if test -z "$(echo -n)"
> > +then
> > +     alias print='echo -n'
> > +else
> > +     alias print='printf %s'
> > +fi
>
> Let's avoid an alias here (especially with a common builtin name) and
> instead use a shell function.  Maybe like this (not tab-indented):
>
>   print_nonl () {
>     if command -v printf >/dev/null 2>&1
>     then
>       printf "%s" "$@"
>     else
>       echo -n "$@"
>     fi
>   }
>
> Notice also that we prefer the standard form and fall back to the
> nonstandard form if the system is less capable.  I don't know if Plan 9
> supports "command -v"; "type" may be preferable, but isn't supported by
> some other shells (e.g., posh).  For portability reasons, we may need to
> try to run printf and see if it fails.
>
> This is also going to need some patching in the testsuite, since we use
> printf extensively (more than 1300 times).  I do hope you have perl
> available.

In fact, Plan 9's ape/sh is pdksh, so it supports "command -v".
However I think, like the above comment, it might be better to create
the printf(1) wrapper.

---
kadota

> [0] http://doc.cat-v.org/plan_9/4th_edition/papers/ape
> --
> brian m. carlson: Houston, Texas, US
