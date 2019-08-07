Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EC3A1F731
	for <e@80x24.org>; Wed,  7 Aug 2019 09:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387430AbfHGJuJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 05:50:09 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36348 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387396AbfHGJuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 05:50:09 -0400
Received: by mail-ot1-f66.google.com with SMTP id r6so101829271oti.3
        for <git@vger.kernel.org>; Wed, 07 Aug 2019 02:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=13avb9WkUFOCJnZaF3q2SO57Aczo0bZqu4+sPrNYS+c=;
        b=pVPouf2bmcQHhfk1Ysaho7WfIoV4vBYJrGHXMYbDtychJkjikkX7YihBHbZmLyreWu
         sCQ/Ipl033Z2ehRtzvSe8ge3sMX0+X3/qV7WyhPBfakZ7I3LotiOGVQngMHBlsVS5VvM
         y3+yJurKKdSelW8wmH+dXJsQ+OawXUK0WwyM3SDxK7MbZll8ftB5ZGgUl4mrogb7k6HW
         ufPvge5o4IBH77iZ2IlI/6eNehOZ6R6KBGQ0uTXqTSo5Kw3Agb5XX6xvtpJaWPGxk1Nm
         1exxzGgvLIyGXEnF4ed6LM7e4GJxItNV0JVri+8IUbhf5Uck5Vh8RtcGs8pLu3TK+1m9
         X1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=13avb9WkUFOCJnZaF3q2SO57Aczo0bZqu4+sPrNYS+c=;
        b=lFhROOQalYC6z6iNeFTJGCvnb31PRNPMx15zYn4OA4VMaLi1hR7SDlAHiy/6myYKzb
         x8QeFf91geCZNff4uHCfz7cqibwD4wLVakg7LM/qOX9mDL3P7JBCKA+4GOE8gVAq3isd
         IepEbmHdCrSWHsAMlrglnXkRMYG9TuodxOT8G00O0/g0jt+nTZWFxdwP6Uso76sHEXCy
         wqfJjJrXDFeSsZzdOASw/qW5RrJffRFUljuGj4H0sDLR4OKvxGDEO1XpcdZskxRg4YjB
         AUplbNxKyscHN8AMe54UtvEU3MXmgxMJfUCqMELpT0B8N4grFrvY4/Vcmlxz0suFepoZ
         X6Iw==
X-Gm-Message-State: APjAAAXqiyATY2e7xesVhuQl8VcmaoCYPIEuGMssFz8nuDGuKalN9ACc
        zH7lF1JegeldELf+iAAsuA0DwYc+Ly3qtsyCDqk=
X-Google-Smtp-Source: APXvYqxvQfywoz/hsI86jabfy11qqO7zUWxFTWnDuGWzXhGXE9GlZccnW/fYm1tczLYE+6Lyex6QvnWBo8l3rGLEeFw=
X-Received: by 2002:a5d:890d:: with SMTP id b13mr7925741ion.124.1565171408060;
 Wed, 07 Aug 2019 02:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190806085014.47776-1-carenas@gmail.com> <20190806163658.66932-1-carenas@gmail.com>
 <20190806163658.66932-3-carenas@gmail.com> <ab8a378c-0a60-9554-b2dd-ecb3d05229cb@web.de>
In-Reply-To: <ab8a378c-0a60-9554-b2dd-ecb3d05229cb@web.de>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 7 Aug 2019 02:49:56 -0700
Message-ID: <CAPUEspip98Mq8FrKTOkEikZhaLPprZXf=E2x3d0b7=c7e5+Gyw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/3] grep: make PCRE2 aware of custom allocator
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        avarab@gmail.com, michal.kiedrowicz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 6, 2019 at 10:38 PM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> Am 06.08.19 um 18:36 schrieb Carlo Marcelo Arenas Bel=C3=B3n:
> > Move some of the logic that was before done per thread (in the workers)
> > into an earlier phase to avoid degrading performance
>
> Which logic is moved?  In the patch I basically only see additions.

the decision of if we want to create a global context or not, which is now =
being
done only once per pattern.  "moving" there was to imply the logic now
was no longer going to always use state in the struct_pat that then
will be evaluated at least once per thread, but could use state
globally and reuse some of the work (as I did for the generation of
the chartables in a later patch, that I had yet to send)

> >, but as the use
> > of PCRE2 with NED is better understood it is expected more of its
> > functions will be instructed to use the custom allocator as well as
> > was done in the original code[1] this work was based on.
> >
> > [1] https://public-inbox.org/git/3397e6797f872aedd18c6d795f4976e1c57951=
4b.1565005867.git.gitgitgadget@gmail.com/
>
> I'm not sure I understand that part.  Do you mean there are gaps of
> knowledge about nedmalloc and/or PCRE2 and/or their interaction?  And
> someone is working on closing those gaps, and is going to submit more
> patches in the process?
>
> Your patch uses a custom global context only if USE_NED_ALLOCATOR is
> defined, while [1] does it unconditionally.  The latter is easier to
> debug and requires less preprocessor directives.  What's the upside
> of your approach?

was hoping will perform better but it seems that testing can be done
only in windows

> > +#ifdef USE_NED_ALLOCATOR
> > +static void *pcre2_malloc(PCRE2_SIZE size, MAYBE_UNUSED void *memory_d=
ata)
> > +{
> > +     return malloc(size);
>
> Should this be xmalloc() to get consistent out-of-memory handling?

good point, note though that since it is inside a USE_NED_ALLOCATOR
ifdef it is really
nedalloc in disguise
>
> > +}
> > +
> > +static void pcre2_free(void *pointer, MAYBE_UNUSED void *memory_data)
> > +{
> > +     return free(pointer);
> > +}
> > +#endif
> > +#endif
> > +
> >  static const char *color_grep_slots[] =3D {
> >       [GREP_COLOR_CONTEXT]        =3D "context",
> >       [GREP_COLOR_FILENAME]       =3D "filename",
> > @@ -153,6 +169,7 @@ int grep_config(const char *var, const char *value,=
 void *cb)
> >   *
> >   * If using PCRE make sure that the library is configured
> >   * to use the right allocator (ex: NED)
> > + * if any object is created it should be cleaned up in grep_destroy()
> >   */
> >  void grep_init(struct grep_opt *opt, struct repository *repo, const ch=
ar *prefix)
> >  {
> > @@ -188,6 +205,13 @@ void grep_init(struct grep_opt *opt, struct reposi=
tory *repo, const char *prefix
> >               color_set(opt->colors[i], def->colors[i]);
> >  }
> >
> > +void grep_destroy(void)
> > +{
> > +#ifdef USE_LIBPCRE2
> > +     pcre2_general_context_free(pcre2_global_context);
> > +#endif
> > +}
> > +
> >  static void grep_set_pattern_type_option(enum grep_pattern_type patter=
n_type, struct grep_opt *opt)
> >  {
> >       /*
> > @@ -319,6 +343,11 @@ void append_header_grep_pattern(struct grep_opt *o=
pt,
> >  void append_grep_pattern(struct grep_opt *opt, const char *pat,
> >                        const char *origin, int no, enum grep_pat_token =
t)
> >  {
> > +#if defined(USE_LIBPCRE2) && defined(USE_NED_ALLOCATOR)
> > +     if (!pcre2_global_context && opt->ignore_case && has_non_ascii(pa=
t))
> > +             pcre2_global_context =3D pcre2_general_context_create(
> > +                                     pcre2_malloc, pcre2_free, NULL);
> > +#endif
> >       append_grep_pat(opt, pat, strlen(pat), origin, no, t);
> >  }
> >
> > @@ -507,9 +536,14 @@ static void compile_pcre2_pattern(struct grep_pat =
*p, const struct grep_opt *opt
> >
> >       p->pcre2_compile_context =3D NULL;
> >
> > +     /* pcre2_global_context is initialized in append_grep_pattern */
> >       if (opt->ignore_case) {
> >               if (has_non_ascii(p->pattern)) {
> > -                     character_tables =3D pcre2_maketables(NULL);
> > +#ifdef USE_NED_ALLOCATOR
> > +                     if (!pcre2_global_context)
> > +                             BUG("pcre2_global_context uninitialized")=
;
>
> [1] initializes on demand.  Why not do that?  To avoid race conditions

this was just for help migrating the code, could go away even now, but
though it was nice to keep for safety (as someone mentioned recently)

> that would lead to occasional double-allocation of the global context?

and a nicer API that allows for cleaning up any global objects (with
the chartables being an easy one to tackle next) and might
help in the future to make the worker threads less messy (ex: compile vs ma=
tch)

> > +#endif
> > +                     character_tables =3D pcre2_maketables(pcre2_globa=
l_context);
> >                       p->pcre2_compile_context =3D pcre2_compile_contex=
t_create(NULL);
>
> Don't you want to pass pcre2_global_context here as well?  And [1] even
> uses it in some more places.
>
> Oh, that's the "expected more" when "better understood" part from the
> commit message, right?

correct, was trying to be conservative and minimal (since this code
will conflict as well
with other in the fly changes), but considering that the last Azure
build from pu still failed
and I have no windows box to debug, might need to do it anyway.

> Basically I'd expect the custom global context to be used for all PCRE2
> allocations; I can't think of a reason for mixing allocators (e.g.
> system malloc for PCRE2 regexes and nedmalloc for everything else).

ok

Carlo
