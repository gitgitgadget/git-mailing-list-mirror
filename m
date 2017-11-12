Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDF5B201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 23:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751003AbdKLXYO (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 18:24:14 -0500
Received: from mail-ot0-f171.google.com ([74.125.82.171]:48510 "EHLO
        mail-ot0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbdKLXYN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 18:24:13 -0500
Received: by mail-ot0-f171.google.com with SMTP id b49so8925750otj.5
        for <git@vger.kernel.org>; Sun, 12 Nov 2017 15:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YZbUGfmWnlaiNGwd7NfCJhuv7X2EHVNWG98Euy+wxS8=;
        b=fPyw2sIC0o+pFcStMoFAU9FAkGU1AodAH0cFfGhiSVbbCTl1Fyd/g/a3h3CHw0EyB0
         CNJhhVVIOGxvRqodP2Zy86qVVqJkSeKVpJQL/v6QfDmcN2yPFMKl9YoUB65xmI3rfz1f
         w4mQCxkFKFJR4xpmbGfF5xKS0BLyF90YzqWf8gRKL8gKuXUqhorG9R3Lqslw/wxj/r5V
         9kde+7rC89uiBOkQzPfiXyHlLqMNs+z3jv/Y+J4aKESWrrb4YVRNknMbBnBjA8u4/OSm
         IIwpOjK5pymxYryF5FfNGOee07SKCnaAlrKG3RUH3RF8sahK8Dcs9cfTHME0iBxs5ZZK
         YdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YZbUGfmWnlaiNGwd7NfCJhuv7X2EHVNWG98Euy+wxS8=;
        b=cfPhzlpUgAfwzIgYHVrloE3qNLA7F+7McfZyW3KKoThr/xsKLdf8QuDSxm0nfTFjfe
         TQ6JHmrj5tbRA4aK3gd7Y9717lhhKiE7Q6x5BOoXIYkVtkzIoQAvLuDtVxV0KtKLoyvl
         UZMp9BLv/6tp7kcJoYlShmpDyvU5LAkiqNJsCW9BwG7zCf0CX4Gcmx6MFpZA+IN5ql7O
         GpEZd0wbaGq+nHF/0u3UCnr3+Vkl/x0ONBnff5CrFljv7XLURFsLJxpX6S4EAU02uyRs
         Ag3YCdQ1sYxybqNmkw1KTM3a1jJFpE2kKtjpH5WyeoFqXu3cYatNtSTCva+Aol9VFOry
         /LNA==
X-Gm-Message-State: AJaThX4Hiva20RTbo8EpUhFGpsmL2oqfBkPYawAXHZP9ZtSppqZBQCvi
        hflbKnR3sbx0xVwTESTmjeITFPylMb98s1DN2qvhwA==
X-Google-Smtp-Source: AGs4zMbmMRW7KJH6/fLvMxX2y/z1tVnpI4mcPFvM+n+q1MzZVMfiM3bpn41rQiWp9R+1kU4cS8s+u6ZDgCeZr3SoFq0=
X-Received: by 10.157.41.97 with SMTP id d88mr4395048otb.60.1510529052129;
 Sun, 12 Nov 2017 15:24:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.1.137 with HTTP; Sun, 12 Nov 2017 15:24:11 -0800 (PST)
In-Reply-To: <20171112141737.nmnsygm4wrhtkqwb@sigill.intra.peff.net>
References: <20171111192858.27255-1-gennady.kupava@gmail.com> <20171112141737.nmnsygm4wrhtkqwb@sigill.intra.peff.net>
From:   Gennady Kupava <gennady.kupava@gmail.com>
Date:   Sun, 12 Nov 2017 23:24:11 +0000
Message-ID: <CAPu-DQr0eRYiafF64=Mwm56xJgNPH0HVm+B4vKnzK0iAE4_xUg@mail.gmail.com>
Subject: Re: [PATCH] Reduce performance penalty for turned off traces
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Gennady Kupava <gkupava@bloomberg.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff, thanks for such detailed review and additional testing.

Below are just some discussion related review comments,
Please expect patch itself on some evening during coming week.

On 12 November 2017 at 14:17, Jeff King <peff@peff.net> wrote:
>
> On Sat, Nov 11, 2017 at 07:28:58PM +0000, gennady.kupava@gmail.com wrote:
>
> > From: Gennady Kupava <gkupava@bloomberg.net>
> >
> > Signed-off-by: Gennady Kupava <gkupava@bloomberg.net>
>
> Thanks, and welcome to the list.
>
>
> > ---
> > One of the tasks siggested in scope of 'Git sprint weekend'.
> > Couple of chioces made here:
>
> These kinds of choices/caveats (along with the motivation for the patch)
> should go into the commit message so people running "git log" later can
> see them.

Will split into two patches.

>
> >  1. Use constant instead of NULL to indicate default trace level, this just
> > makes everything simpler.
>
> I think this makes sense, as we were translating NULL into this default
> struct behind the scenes already. As we discussed off-list, this does
> mean that you can no longer do:
>
>   trace_printf_key(NULL, "foo");
>
> to send to the default key, and instead must do:
>
>   trace_printf("foo");
>
> The second one has always been the preferred way of spelling it, but the
> first one happened to work. So the only fallout would be if somebody is
> using the non-preferred method, they'd now segfault. There aren't any
> such calls in the current code base, though, and I find it rather
> unlikely that there would be new instances in topics other people are
> working on.
>
> I think it may be worth splitting that out into a separate preparatory
> patch to make it more clear what's going on (especially if our
> assumption turns out wrong and somebody does end up tracing a problem
> back to it).


Logic which lead me to removing NULL:
_If_ we want to do some kind of trivial check before calling functions
from other
translation units (which is always real function call), we have to
have some kind
of status immediately available in .h file.
I saw two options here:
 - move whole 'normalization' procedure to .h
 - remove 'normalization' procedure

Reasons removal option was chosen:
 - I found no code which actually uses NULL as a parameter option.
 - Given the nature of the key parameter ( struct key* )
I was just really unable to find any reasonable use
case there caller really want to pass NULL, so it seemed to me that
best solution
is to remove it. I still can imagine something like dynamic trace
category coming from
some kind of configuration file. In such special case there caller
might need it,
he might just do check in calling code once or just simply add it.
 - Squash big more performance as we do not need to do this
normalization on every call.

I will elaborate on 'moving whole implementation later'

>
> >  2. Move just enough from implementation to header, to be able to do check
> > before calling actual functions.
>
> Makes sense.
>
> >  3. Most controversail: do not support optimization for older
> >     compilers not supporting variadic templates in macroses. Problem
> >     is that theoretically someone may write some complicated trace
> >     while would work in 'modern' compiler and be too slow in more
> >     'classic' compilers, however expectation is that risk of that is
> >     quite low and 'classic' compilers will go away eventually.
>
> I think this is probably acceptable. I know we've discussed elsewhere
> recently how common such compilers actually are, and whether we could
> give up on them altogether.
>
> If we wanted to, we could support that case by using inline functions in
> the header (though it does make me wonder if compilers that old also do
> not actually end up inlining).
>
> I did manually disable HAVE_VARIADIC_MACROS and confirmed that the
> result builds and passes the test suite (though I suspect that GIT_TRACE
> is not well exercised by the suite).
>

Good.

>
> > diff --git a/trace.c b/trace.c
> > index 7508aea02..180ee3b00 100644
> > --- a/trace.c
> > +++ b/trace.c
> > @@ -25,26 +25,14 @@
> >  #include "cache.h"
> >  #include "quote.h"
> >
> > -/*
> > - * "Normalize" a key argument by converting NULL to our trace_default,
> > - * and otherwise passing through the value. All caller-facing functions
> > - * should normalize their inputs in this way, though most get it
> > - * for free by calling get_trace_fd() (directly or indirectly).
> > - */
> > -static void normalize_trace_key(struct trace_key **key)
> > -{
> > -     static struct trace_key trace_default = { "GIT_TRACE" };
> > -     if (!*key)
> > -             *key = &trace_default;
> > -}
> > +struct trace_key trace_default_key = { TRACE_KEY_PREFIX, 0, 0, 0 };
>
> Makes sense. We no longer auto-normalize, but just expect the
> appropriate functions to pass a pointer to the default key themselves.

This is again (more details below) choice of how much implementation details we
want to move into header file.

>
>
> > +struct trace_key trace_perf_key = TRACE_KEY_INIT(PERFORMANCE);
>
> This change was unexpected, but I think you just moved this up to keep
> all the pre-declared structs together. Makes sense.
>

Reason is that _if_ we want to cover trace_performance* macroses with
our performance patch, we need to expose this implementation detail in
header file now.
And I expect we do want, even if this interface is not used now.

> >  /* Get a trace file descriptor from "key" env variable. */
> >  static int get_trace_fd(struct trace_key *key)
> >  {
> >       const char *trace;
> >
> > -     normalize_trace_key(&key);
> > -
> >       /* don't open twice */
> >       if (key->initialized)
> >               return key->fd;
>
> And this and similar changes to drop normalize_trace_key() all make
> sense with the earlier hunk. Good.
>
> > @@ -341,7 +324,7 @@ void trace_repo_setup(const char *prefix)
> >
> >  int trace_want(struct trace_key *key)
> >  {
> > -     return !!get_trace_fd(key);
> > +       return !!get_trace_fd(key);
> >  }
>
> This line accidentally swapped out the tab for spaces.

Will fix that.

>
> > diff --git a/trace.h b/trace.h
> > index 179b249c5..64326573a 100644
> > --- a/trace.h
> > +++ b/trace.h
> > @@ -4,6 +4,8 @@
> >  #include "git-compat-util.h"
> >  #include "strbuf.h"
> >
> > +#define TRACE_KEY_PREFIX "GIT_TRACE"
> > [..]
> > -#define TRACE_KEY_INIT(name) { "GIT_TRACE_" #name, 0, 0, 0 }
> > +#define TRACE_KEY_INIT(name) { TRACE_KEY_PREFIX "_" #name, 0, 0, 0 }
>
> I see you pulled this out so you could use TRACE_KEY_PREFIX elsewhere
> for the default key. Yes, the default key and the prefix do happen to be
> related in that way, but I actually think it was a bit less obfuscated
> the original way, even it repeated the string "GIT_TRACE" twice.

Yeah, I thought for some time here as I don't like both approaches,
slight duplication vs
slight complication. Typically I choose slight complication, but now,
giving this another
thought it seems like slight duplication is really better in this case.

>
> > +#define trace_pass(key) ((key)->fd || !(key)->initialized)
>
> Factoring this out makes sense, since we have to repeat it in each
> macro.
>
> Speaking of macros, one side effect of this whole patch is that the
> "key" parmaeter is going to be evaluated multiple times. I think that's
> an acceptable tradeoff, as we'd basically always expect to pass the
> address of a static struct here.

Yes, I though about this.

>
> If that's a problem I think we _could_ do it with a combination of
> macros and inline functions.

Agree. Actually there is solution to this specific problem
which somehow didn't came to my mind yesterday. There is actually no
reason for trace_pass to be a macro, it is better to make it an inline function.

> The macro has to go in the outer layer in
> order to set __LINE__ properly. But something like:
>
>   static inline
>   void trace_printf_key_helper(const char *context, int line,
>                                struct trace_key *key,
>                                const char *fmt, ...)
>   {
>         if (trace_pass(key)) {
>                 va_list ap;
>                 va_start(ap, fmt);
>                 trace_vprintf_key_fl(context, line, key, fmt, ap);
>                 va_end(ap);
>         }
>   }
>
>   #define trace_printf_key(key, ...) \
>         trace_printf_key_helper(TRACE_CONTEXT, __LINE__, key, __VA_ARGS__);
>
> would work, I think.

It would but...

So I think main question in this whole idea to optimize traces a bit is how much
we really want and need to move to header. All reasons here are quite marginal,
but whole task is quite marginal, so we have to operate in terms of
marginal reasons.

So, i took into what gcc actually generated in optimized assembly for this code
(of course not in details, but just to find how much calls made). My expectation
was that gcc as one of best compilers optimize all that static
functions into one, so we'll have
something like one big function call to the functions which somewhere
on top will do
the check which is similar to trace_pass.

In reality, gcc didn't do that and I saw 3 function calls. I am pretty
sure that compiler
of the distant bright future will do that, and only problem would be
to eliminate that
single function call. Hopefully with -flto it will also eliminate this
single functions call,
at it will be able to see through translation units. Given that I
actually like current
implementation as it hides all details in .c file.

Noting on the side at this point that first theoretical conclusion
here is that even if we'll move whole
trace.c into trace.h we'll still have same 2-3 function calls.

So, now given the description above, what's the best way to improve performance,
if we want?
We need to somehow do check in header, so gcc could inline that into
calling function.
Now, how much of implementation details we want to move to header?
I think it is good if we hide inside .c whatever we can.
So my solution was to keep all logic in implementation, move only
necessary things to header,
so:
 - reader of header file would see as few implementation details as possible
 - compiler would not try to inline something which actually doesn't matter
   (it only matters to inline something which checks if traces are
off). As this trace.h is included
   (indirectly) pretty much everywhere (287 object files out of 315),
not trying to re-compile and inline
   things that many times will save some CPU cycles during build
reducing build time and probably
   even saving some non-binary trees =)

Now, implementation you suggesting moves extra things into .h,
so it is imperfect in terms above, while things I suggested moves only
necessary bit
of checking the necessity to do anything, which is only (interesting) part
should be executed while traces are off, and the only part we really
want to be inlined.

That's the reasons, hopefully it makes sense, if not, I just don't see
much difference
and could implement it in different way.

>
> > +#define trace_printf(...)                                                \
> > +     do {                                                                \
> > +             if (trace_pass(&trace_default_key))                         \
> > +                     trace_printf_key_fl(TRACE_CONTEXT, __LINE__,        \
> > +                                         &trace_default_key,__VA_ARGS__);\
> > +     } while(0)
> > +
> > +#define trace_printf_key(key, ...)                                       \
> > +     do {                                                                \
> > +             if (trace_pass(key))                                        \
> > +                     trace_printf_key_fl(TRACE_CONTEXT, __LINE__, key,   \
> > +                                         __VA_ARGS__);                   \
> > +     } while(0)
>
> Now that these definitions are getting a bit more complex, I wonder if
> we can implement them in terms of each other. I.e., could the first one
> be:
>
>   #define trace_printf(...) trace_printf_key(&trace_default_key, __VA_ARGS__)
>
> I'm not sure if there are any gotchas with recursive variadic macros. If
> it's just this one macro that's not too big a deal, and it looks like
> most of the rest of them end up having to call different functions and
> can't nest like this. So it may not be worth troubling about.

I was not sure about variadic macro calling variadic macro as well, so
decided to not do that.
Now I read that two lines in C99 standard related to __VA_ARGS__, it
seems like nothing
preventing that, so will do.

>
> > +#define trace_argv_printf(argv, ...)                                     \
> > [...]
>
> The rest of this looks good.
>
> I tried timing a simple loop like:
>
> diff --git a/git.c b/git.c
> index 9e96dd4090..f3dbc15a99 100644
> --- a/git.c
> +++ b/git.c
> @@ -626,6 +626,11 @@ int cmd_main(int argc, const char **argv)
>  {
>         const char *cmd;
>         int done_help = 0;
> +       int i;
> +
> +       for (i = 0; i < 1000000; i++)
> +               trace_printf("item %d", i);
> +       return 0;
>
>         cmd = argv[0];
>         if (!cmd)
>
> Without your patch, the times for GIT_TRACE=1 and GIT_TRACE=0 are about
> 500ms and 9ms respectively.

Well, still something measurable =) May be on some exotic hardware it
could be more...

> After your patch, the GIT_TRACE=1 time remains the same but GIT_TRACE=0
> drops to 1ms.
>
> So it is measurable, and we might expect that tracing a really big loop
> (say over all of the objects in the repository) would benefit. OTOH, a
> real loop would actually be doing other stuff, so the speedup would be
> less dramatic. Still, it seems like an easy win.

I actually quite familiar with performance analysis and know how to
use perf and similar tools a bit -
so if there is something more measurable in TODO, I could try. But I
guess this is
interesting to many devs so such tasks probably already all done and bottlenecks
are identified in git =)

With best regards,
Gennady

On 12 November 2017 at 14:17, Jeff King <peff@peff.net> wrote:
> On Sat, Nov 11, 2017 at 07:28:58PM +0000, gennady.kupava@gmail.com wrote:
>
>> From: Gennady Kupava <gkupava@bloomberg.net>
>>
>> Signed-off-by: Gennady Kupava <gkupava@bloomberg.net>
>
> Thanks, and welcome to the list.
>
>> ---
>> One of the tasks siggested in scope of 'Git sprint weekend'.
>> Couple of chioces made here:
>
> These kinds of choices/caveats (along with the motivation for the patch)
> should go into the commit message so people running "git log" later can
> see them.
>
>>  1. Use constant instead of NULL to indicate default trace level, this just
>> makes everything simpler.
>
> I think this makes sense, as we were translating NULL into this default
> struct behind the scenes already. As we discussed off-list, this does
> mean that you can no longer do:
>
>   trace_printf_key(NULL, "foo");
>
> to send to the default key, and instead must do:
>
>   trace_printf("foo");
>
> The second one has always been the preferred way of spelling it, but the
> first one happened to work. So the only fallout would be if somebody is
> using the non-preferred method, they'd now segfault. There aren't any
> such calls in the current code base, though, and I find it rather
> unlikely that there would be new instances in topics other people are
> working on.
>
> I think it may be worth splitting that out into a separate preparatory
> patch to make it more clear what's going on (especially if our
> assumption turns out wrong and somebody does end up tracing a problem
> back to it).
>
>>  2. Move just enough from implementation to header, to be able to do check
>> before calling actual functions.
>
> Makes sense.
>
>>  3. Most controversail: do not support optimization for older
>>     compilers not supporting variadic templates in macroses. Problem
>>     is that theoretically someone may write some complicated trace
>>     while would work in 'modern' compiler and be too slow in more
>>     'classic' compilers, however expectation is that risk of that is
>>     quite low and 'classic' compilers will go away eventually.
>
> I think this is probably acceptable. I know we've discussed elsewhere
> recently how common such compilers actually are, and whether we could
> give up on them altogether.
>
> If we wanted to, we could support that case by using inline functions in
> the header (though it does make me wonder if compilers that old also do
> not actually end up inlining).
>
> I did manually disable HAVE_VARIADIC_MACROS and confirmed that the
> result builds and passes the test suite (though I suspect that GIT_TRACE
> is not well exercised by the suite).
>
>> diff --git a/trace.c b/trace.c
>> index 7508aea02..180ee3b00 100644
>> --- a/trace.c
>> +++ b/trace.c
>> @@ -25,26 +25,14 @@
>>  #include "cache.h"
>>  #include "quote.h"
>>
>> -/*
>> - * "Normalize" a key argument by converting NULL to our trace_default,
>> - * and otherwise passing through the value. All caller-facing functions
>> - * should normalize their inputs in this way, though most get it
>> - * for free by calling get_trace_fd() (directly or indirectly).
>> - */
>> -static void normalize_trace_key(struct trace_key **key)
>> -{
>> -     static struct trace_key trace_default = { "GIT_TRACE" };
>> -     if (!*key)
>> -             *key = &trace_default;
>> -}
>> +struct trace_key trace_default_key = { TRACE_KEY_PREFIX, 0, 0, 0 };
>
> Makes sense. We no longer auto-normalize, but just expect the
> appropriate functions to pass a pointer to the default key themselves.
>
>> +struct trace_key trace_perf_key = TRACE_KEY_INIT(PERFORMANCE);
>
> This change was unexpected, but I think you just moved this up to keep
> all the pre-declared structs together. Makes sense.
>
>>  /* Get a trace file descriptor from "key" env variable. */
>>  static int get_trace_fd(struct trace_key *key)
>>  {
>>       const char *trace;
>>
>> -     normalize_trace_key(&key);
>> -
>>       /* don't open twice */
>>       if (key->initialized)
>>               return key->fd;
>
> And this and similar changes to drop normalize_trace_key() all make
> sense with the earlier hunk. Good.
>
>> @@ -341,7 +324,7 @@ void trace_repo_setup(const char *prefix)
>>
>>  int trace_want(struct trace_key *key)
>>  {
>> -     return !!get_trace_fd(key);
>> +       return !!get_trace_fd(key);
>>  }
>
> This line accidentally swapped out the tab for spaces.
>
>> diff --git a/trace.h b/trace.h
>> index 179b249c5..64326573a 100644
>> --- a/trace.h
>> +++ b/trace.h
>> @@ -4,6 +4,8 @@
>>  #include "git-compat-util.h"
>>  #include "strbuf.h"
>>
>> +#define TRACE_KEY_PREFIX "GIT_TRACE"
>> [..]
>> -#define TRACE_KEY_INIT(name) { "GIT_TRACE_" #name, 0, 0, 0 }
>> +#define TRACE_KEY_INIT(name) { TRACE_KEY_PREFIX "_" #name, 0, 0, 0 }
>
> I see you pulled this out so you could use TRACE_KEY_PREFIX elsewhere
> for the default key. Yes, the default key and the prefix do happen to be
> related in that way, but I actually think it was a bit less obfuscated
> the original way, even it repeated the string "GIT_TRACE" twice.
>
>> +#define trace_pass(key) ((key)->fd || !(key)->initialized)
>
> Factoring this out makes sense, since we have to repeat it in each
> macro.
>
> Speaking of macros, one side effect of this whole patch is that the
> "key" parmaeter is going to be evaluated multiple times. I think that's
> an acceptable tradeoff, as we'd basically always expect to pass the
> address of a static struct here.
>
> If that's a problem I think we _could_ do it with a combination of
> macros and inline functions. The macro has to go in the outer layer in
> order to set __LINE__ properly. But something like:
>
>   static inline
>   void trace_printf_key_helper(const char *context, int line,
>                                struct trace_key *key,
>                                const char *fmt, ...)
>   {
>         if (trace_pass(key)) {
>                 va_list ap;
>                 va_start(ap, fmt);
>                 trace_vprintf_key_fl(context, line, key, fmt, ap);
>                 va_end(ap);
>         }
>   }
>
>   #define trace_printf_key(key, ...) \
>         trace_printf_key_helper(TRACE_CONTEXT, __LINE__, key, __VA_ARGS__);
>
> would work, I think.
>
>> +#define trace_printf(...)                                                \
>> +     do {                                                                \
>> +             if (trace_pass(&trace_default_key))                         \
>> +                     trace_printf_key_fl(TRACE_CONTEXT, __LINE__,        \
>> +                                         &trace_default_key,__VA_ARGS__);\
>> +     } while(0)
>> +
>> +#define trace_printf_key(key, ...)                                       \
>> +     do {                                                                \
>> +             if (trace_pass(key))                                        \
>> +                     trace_printf_key_fl(TRACE_CONTEXT, __LINE__, key,   \
>> +                                         __VA_ARGS__);                   \
>> +     } while(0)
>
> Now that these definitions are getting a bit more complex, I wonder if
> we can implement them in terms of each other. I.e., could the first one
> be:
>
>   #define trace_printf(...) trace_printf_key(&trace_default_key, __VA_ARGS__)
>
> I'm not sure if there are any gotchas with recursive variadic macros. If
> it's just this one macro that's not too big a deal, and it looks like
> most of the rest of them end up having to call different functions and
> can't nest like this. So it may not be worth troubling about.
>
>> +#define trace_argv_printf(argv, ...)                                     \
>> [...]
>
> The rest of this looks good.
>
> I tried timing a simple loop like:
>
> diff --git a/git.c b/git.c
> index 9e96dd4090..f3dbc15a99 100644
> --- a/git.c
> +++ b/git.c
> @@ -626,6 +626,11 @@ int cmd_main(int argc, const char **argv)
>  {
>         const char *cmd;
>         int done_help = 0;
> +       int i;
> +
> +       for (i = 0; i < 1000000; i++)
> +               trace_printf("item %d", i);
> +       return 0;
>
>         cmd = argv[0];
>         if (!cmd)
>
> Without your patch, the times for GIT_TRACE=1 and GIT_TRACE=0 are about
> 500ms and 9ms respectively.
>
> After your patch, the GIT_TRACE=1 time remains the same but GIT_TRACE=0
> drops to 1ms.
>
> So it is measurable, and we might expect that tracing a really big loop
> (say over all of the objects in the repository) would benefit. OTOH, a
> real loop would actually be doing other stuff, so the speedup would be
> less dramatic. Still, it seems like an easy win.
>
> -Peff
