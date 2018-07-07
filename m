Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2573A1F62D
	for <e@80x24.org>; Sat,  7 Jul 2018 09:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752699AbeGGJkX (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jul 2018 05:40:23 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:42122 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751693AbeGGJkV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jul 2018 05:40:21 -0400
Received: by mail-lf0-f66.google.com with SMTP id u202-v6so11648727lff.9
        for <git@vger.kernel.org>; Sat, 07 Jul 2018 02:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XtVPu2/ZFVvrvZH+bAT3PhY/3nd7G/AbfmfjZk0eviI=;
        b=P4veloa5uJm3hQvhgPe8bOP0SytrfP66WenLBm14Jr1PscTNXDnV3rezmoHfQS9kJu
         Bvi1WMJn4hQ0xZ1rKM3yxKwWG8Us9Rh7Fbf6GkEZFFnFuVArN6HC+hCF+29VgHO3C9Cf
         j7Jz/vqcf6OCFliRIeErCG9TUO5TXRAcZpbIxzR0vpyK/OnNumjHskPwGFc0EPEWy+FA
         o617HMgoBfmETnjW84Z+ojOXDopuSqT1g5FwhVACgW/6s9QurWnBoLnlq8Uvu+pDd8eW
         yOSMCeKEiTJ5+f6nLuXnFcLzExdIHuNAa+3l45pDdXujQ0PL+ezV7NEgUyM+FOHhX17L
         m/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XtVPu2/ZFVvrvZH+bAT3PhY/3nd7G/AbfmfjZk0eviI=;
        b=IE4Hr9Ao1n+F+MG1+ljLx4/P7wLxWuu/gQC0y9YAxzoTIjLFTekIQToV8uRXBUnSBQ
         q4pRq5PB48Gepj1fX+gcZVxrNxNcKljpaWgcuQWJdm852YnxDOuJiIlRAeWCM9M90gBs
         dIqAQZIxURvWKrklTDvW56fp7X34lQcv/SNT9s7B6Yjw+02ZFmc9xnN7VL0CSkcNgHGh
         Ech8rPp/OLjXr6cUcmz+Sa4dmlYg9U80WfiErgmhLDEYRj1t/fFrSZeKdi1T32kjTjWA
         f5MU5AbU2UnMphRrt/NUx2hCkLPVSgzcOeg0oJNaHrSOTwM/lL8DqFNBocDlutC9w6d4
         ouOA==
X-Gm-Message-State: APt69E0Nr0zRwbHHfD3mtonpXkBFKHtN0ywDzr2KyD2TyO06h/RQbFa6
        MsN14cuMo0oYZx+BptxoyGHGQo3nTWa+PCaNQzg=
X-Google-Smtp-Source: AAOMgpcxrgmeaSukSL1E+XAL7gSQJV7RgG9Pf/uND7OtMulX5wFVj7HOUNijSmyiWT78zuw6l0HeQO0xuqr5mUxQOEM=
X-Received: by 2002:a19:1366:: with SMTP id j99-v6mr9635033lfi.21.1530956420099;
 Sat, 07 Jul 2018 02:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180630133822.4580-1-kgybels@infogroep.be> <20180630145849.GA9416@duynguyen.home>
 <xmqqpo00mi7q.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpo00mi7q.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Sat, 7 Jul 2018 11:40:08 +0200
Message-ID: <CAM0VKj=u0OVad3QDRFOc+NWZ9TfwqAwmZ47s=5e5jGZaPQRH6g@mail.gmail.com>
Subject: Re: [PATCH] gc --auto: release pack files before auto packing
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, kgybels@infogroep.be,
        Git mailing list <git@vger.kernel.org>, kilobyte@angband.pl,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Michael J Gruber <git@grubix.eu>, Jeff King <peff@peff.net>,
        tboegi@web.de
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 6, 2018 at 6:39 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Duy Nguyen <pclouds@gmail.com> writes:
>
> > On Sat, Jun 30, 2018 at 03:38:21PM +0200, Kim Gybels wrote:
> >> Teach gc --auto to release pack files before auto packing the repository
> >> to prevent failures when removing them.
> >>
> >> Also teach the test 'fetching with auto-gc does not lock up' to complain
> >> when it is no longer triggering an auto packing of the repository.
> >>
> >> Fixes https://github.com/git-for-windows/git/issues/500
> >>
> >> Signed-off-by: Kim Gybels <kgybels@infogroep.be>
> >> ---
> >>
> >> Patch based on master, since problem doesn't reproduce on maint,
> >> however, the improvement to the test might be valuable on maint.
> >>
> >>  builtin/gc.c     | 1 +
> >>  t/t5510-fetch.sh | 2 ++
> >>  2 files changed, 3 insertions(+)
> >>
> >> diff --git a/builtin/gc.c b/builtin/gc.c
> >> index ccfb1ceaeb..63b62ab57c 100644
> >> --- a/builtin/gc.c
> >> +++ b/builtin/gc.c
> >> @@ -612,6 +612,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
> >>              return -1;
> >>
> >>      if (!repository_format_precious_objects) {
> >> +            close_all_packs(the_repository->objects);
> >
> > We have repo_clear() which does this and potentially closing file
> > descriptors on other things as well. I suggest we use it, and before
> > any external command is run. Something like
> >
> > diff --git a/builtin/gc.c b/builtin/gc.c
> > index ccfb1ceaeb..a852c71da6 100644
> > --- a/builtin/gc.c
> > +++ b/builtin/gc.c
> > @@ -473,6 +473,13 @@ static int report_last_gc_error(void)
> >
> >  static int gc_before_repack(void)
> >  {
> > +     /*
> > +      * Shut down everything, we should have all the info we need
> > +      * at this point. Leaving some file descriptors open may
> > +      * prevent them from being removed on Windows.
> > +      */
> > +     repo_clear(the_repository);
> > +
> >       if (pack_refs && run_command_v_opt(pack_refs_cmd.argv, RUN_GIT_CMD))
> >               return error(FAILED_RUN, pack_refs_cmd.argv[0]);
>
> With
>
>   https://public-inbox.org/git/20180509170409.13666-1-pclouds@gmail.com/
>
> the call to repo_clear() on the_repository itself may be safe [*1*],
> but if command line parsing code etc. has pointers to in-core object
> etc. obtained before this function was called, the codeflow after
> this function returns will be quite disturbed.  Has anybody in this
> review thread audited the codeflow _after_ this function is run to
> make sure that invalidating in-core repository here does not cause
> us problems?

It does create us problems, unfortunately.

Among other things, a call to repo_clear(the_repository) does this:

  raw_object_store_clear(repo->objects);
  FREE_AND_NULL(repo->objects);

Later on cmd_gc() calls reprepare_packed_git(the_repository), which
then attempts to:

  r->objects->approximate_object_count_valid = 0;
  r->objects->packed_git_initialized = 0;

but with r->objects being NULL at this point that won't work, and in
turn causes failures in several test scripts.


FWIW, the original patch appears to be working fine, at least the test
suite passes.
