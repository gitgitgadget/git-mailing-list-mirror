Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D89C433DF
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 20:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C1EB2077D
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 20:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="VazFuS79"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbgF3Uhq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgF3Uhp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 16:37:45 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7110BC061755
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 13:37:44 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id b25so20591946ljp.6
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 13:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lvBGqbbkq0hd5eyF1oMG+4nAc5nByTqZLNcp7ybGX0U=;
        b=VazFuS799WNORDfSvhxLsEgfX9SwFxBZBY7PU5FTwfgmg/+qXOCggwqAIaLWl94E/8
         B5UJ924rkyZT0aS8XiqwyCJpPI0SmBlL4ivYt57EbAmdeGwBfI9dXyfx/OoG48fFzrux
         PnAtqARY55imTwjb/9r/HCU3nKvZLbVfnhxvty8g6+XMy7MtszKOxtvGyePjwbKKrivN
         D5latQU+68vxjXfNx4uuhMyVR22XvQiA8YFVus3rKLWZEdAexCJBozq9sltBCJBK9SFR
         cPkkbX+AI3i8Ra/WHJ5PlPy7x2dIhpDE11t1HiXYEh282+cltqi/Hj8AFN10IdM19CiZ
         lx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lvBGqbbkq0hd5eyF1oMG+4nAc5nByTqZLNcp7ybGX0U=;
        b=trocmcR4wQPaG1DAXlsfVr43g2zi9sfXOglbiQ1318sAVuSpdR8XigO80W1NtdzK2M
         UsH9hmxNtQwRZXROzOHnZE2bmxR+bklwwwIP9ADwLBEWTL8EDB8FEFi6kVsD5Ek48UJ9
         anl/sn+X4L2A6cy93L7zFkHET6+7N93rAeS7N89EeA2Blm/dB8nKvnpBt/91pGBQUc9H
         N+4DX5W1rajijBArXUY/R/w1DlFFHiAUnRGYxgzm4IVDHmWacNImHxU3Xh/GV6BsMBOj
         wMIZlcl9m0oDOWTtAVzxC92rEPtMRmUaiMI0QqFr669INGKG1KhzCluHgrWEdXPe7R69
         sJLw==
X-Gm-Message-State: AOAM530TosXHYT0zJpqs+LpM4FPe4JZ4CgKyQCChl58IXScS1JDu+88c
        FwvJNzKVfecqfd3psISTAI/Sm4Q6B/fmhRZtx5RmUg==
X-Google-Smtp-Source: ABdhPJyqRG8+04TebLpLB6RqyeGmsb/Vq3Duel+l+6qhhtu/NGyFV+kw8OpBABYC/JZrVkeRDq7KfIXOfwA/Kl+urr4=
X-Received: by 2002:a2e:9bda:: with SMTP id w26mr6903311ljj.107.1593549462661;
 Tue, 30 Jun 2020 13:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593208411.git.matheus.bernardino@usp.br>
 <b47445fa1cef6d4523dd0ca336f7ee22bce89466.1593208411.git.matheus.bernardino@usp.br>
 <nycvar.QRO.7.76.6.2006291646420.56@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2006291646420.56@tvgsbejvaqbjf.bet>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 30 Jun 2020 17:37:30 -0300
Message-ID: <CAHd-oW6U9krWYd++5ipGA6e4Xy6ZoBxE+QVFpshrjUKjN+RH0g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hex: make hash_to_hex_algop() and friends thread-safe
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 30, 2020 at 12:01 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Matheus,
>
> I am fine with the Windows changes (although I have to admit that I did
> not find time to test things yet).
>
> There is one problem in that I do not necessarily know that the memory is
> released correctly when threads end; You will notice that the
> `pthread_key_create()` shim in `compat/win32/pthread.h` does not use the
> `destructor` parameter at all. The documentation at
>
>       https://docs.microsoft.com/en-us/windows/win32/procthread/using-thread-local-storage
>
> is also not terribly clear _how_ the memory is released that was assigned
> via `TlsSetValue()`.

Yes, I wasn't sure about that either... It would be great if someone
familiar with TLS memory on Windows could help us with this.

> A couple more things:
>
> On Fri, 26 Jun 2020, Matheus Tavares wrote:
> >
[...]
> > +struct hexbuf_array {
> > +     int idx;
>
> Is there a specific reason why you renamed `bufno` to `idx`? If not, I'd
> rather keep the old name.

OK, I'll change it back in v3.

> > +     char bufs[4][GIT_MAX_HEXSZ + 1];
> > +};
> > +
> > +#ifdef HAVE_THREADS
> > +static pthread_key_t hexbuf_array_key;
> > +static pthread_once_t hexbuf_array_once = PTHREAD_ONCE_INIT;
> > +
> > +static void init_hexbuf_array_key(void)
> > +{
> > +     if (pthread_key_create(&hexbuf_array_key, free))
> > +             die(_("failed to initialize threads' key for hash to hex conversion"));
> > +}
> > +
> > +#else
> > +static struct hexbuf_array default_hexbuf_array;
> > +#endif
> > +
> >  char *hash_to_hex_algop(const unsigned char *hash, const struct git_hash_algo *algop)
> >  {
> > -     static int bufno;
> > -     static char hexbuffer[4][GIT_MAX_HEXSZ + 1];
> > -     bufno = (bufno + 1) % ARRAY_SIZE(hexbuffer);
> > -     return hash_to_hex_algop_r(hexbuffer[bufno], hash, algop);
> > +     struct hexbuf_array *ha;
> > +
> > +#ifdef HAVE_THREADS
> > +     void *value;
> > +
> > +     if (pthread_once(&hexbuf_array_once, init_hexbuf_array_key))
> > +             die(_("failed to initialize threads' key for hash to hex conversion"));
> > +
> > +     value = pthread_getspecific(hexbuf_array_key);
> > +     if (value) {
> > +             ha = (struct hexbuf_array *) value;
> > +     } else {
> > +             ha = xmalloc(sizeof(*ha));
> > +             if (pthread_setspecific(hexbuf_array_key, (void *)ha))
> > +                     die(_("failed to set thread buffer for hash to hex conversion"));
> > +     }
> > +#else
> > +     ha = &default_hexbuf_array;
> > +#endif
>
> This introduces two ugly `#ifdef HAVE_THREADS` constructs which are
> problematic because they are the most likely places to introduce compile
> errors.
>
> I wonder whether you considered introducing a function (and probably a
> macro) that transparently gives you a thread-specific instance of a given
> data type? The caller would look something like
>
>         struct hexbuf_array *hex_array;
>
>         GET_THREADSPECIFIC(hex_array);
>
> where the macro would look somewhat like this:
>
>         #define GET_THREADSPECIFIC(var) \
>                 if (get_thread_specific(&var, sizeof(var)) < 0)
>                         die(_("Failed to get thread-specific %s"), #var);
>
> and the function would allocate and assign the variable.

Hmm, we would need two macros, wouldn't we? GET_THREADSPECIFIC(var)
and a DECLARE_THREADSPECIFIC(var, destructor), to declare the
pthread_once_t and pthread_key_t variables, as well as define a
initialization function for the key (i.e. the callback to
pthread_once()). Or we could provide these declarations ourselves, but
then we would need the "ifdef HAVE_THREADS" guard to avoid calling
pthread_key_create() when there is no multithreading.

I think that would work, yes. Alternatively, I think we could adjust
the dummy pthread_key_* functions in thread-utils.h to emulate the
real ones when HAVE_THREADS == false. Then we could eliminate the
`#ifdef HAVE_THREADS` guards and use the same code for both cases here
(and everywhere else pthread_key is used). I haven't thought about it
carefully enough yet, but I think this *might* be as simple as adding
the following defines in the "#ifdef NO_PTHREADS" section of
thread-utils.h:

#define pthread_key_t void *
/*
 * The destructor is not used in this case as the main thread will only
 * exit when the program terminates.
 */
#define pthread_key_create(key_ptr, unused) return_0((*key_ptr) = NULL)
#define pthread_setspecific(key, value) return_0((key) = (value))
#define pthread_getspecific(key) (key)
#define pthread_key_delete(key) return_0(NULL)

static inline int return_0(void *unused)
{
        return 0;
}

That's the general idea, but we might as well define a `struct
dummy_pthread_key_t` instead of defining the key directly as `void *`
(and have functions instead of macros). This way we could store, e.g.,
an "initialized" flag that could be used to return an error code on
double-initializations.

What do you think?
