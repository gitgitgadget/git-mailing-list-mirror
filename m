Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3FAC4743D
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 02:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 118066101A
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 02:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbhFICoL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 22:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235734AbhFICoK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 22:44:10 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B344CC061574
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 19:42:16 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id k7so35858942ejv.12
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 19:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=OGrkwtggjo20DDkXv5Z6gIbh904C4CxhstYrgo+a4GA=;
        b=Fr5bVWQYsdJBPkA5J0NcoUvlyP62+G+G9C0C1bum725ywRnDh/ScrAXJQG94cFOGPA
         NofX3VBhXdbh0PtYe24P+nscxeK+k94hf/Wh/6e2fWS0mFyShVOZBlD38It4BV3JtLYw
         BGbx9Zz9FvHeX4wPRCzQPoSHb05zrZJ6ENUs95deKb8z0qfJxi/lvl8C0xwoOg/DIt6B
         qNJeuBklfUbHAjtQFh1xg7ieCrY/mIFLS7nScgOGql/63tcCo/nAeC3Py9l5WHf5ypEV
         7ikpkY6BDs3n0daARl7r5hXIHJc5B8TTF+toKTFnw3f1/DNMDk4xqFY+PU6bD923r/Sv
         sAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=OGrkwtggjo20DDkXv5Z6gIbh904C4CxhstYrgo+a4GA=;
        b=Fh2HSXIjv7blFHI6Q5+UJjfqd5NJNtI+fZ8PfmdFe0a9NAyUQe6JqF8KB1Ort6IcGF
         C+e3tOMXLN1mQwRlqapLMr/scxjN4S+SjNGxolAHk+6+oCRjvOIhkbL2uCf7lRhu3MG5
         KJBODkNfBcAOn+dRz5Xpra0l0lYHytZ5z5z2hr2+fx8QyjMakkA5uCSG2Mv3imsm3M3O
         IYE9fZTQfI/0ruERLtYfLm5GQxc8WumfVOecovT1zAMP+sWy9XjgYVe+3M9FZX+HIJcm
         MpquN+z6U7c24SfaJpD9n95FwYqRI9Q/xOo0Mk3wVA+kGoCOCH8ztb9s4Vb0UvmMiFw9
         8hbw==
X-Gm-Message-State: AOAM530kaFDIcGbv5bJrrVwGX3bBoQ7cI8C39/HuaNk/A+rkXKGrqp3f
        CSv6bHwIgBKJYQ/bZX6xTkw=
X-Google-Smtp-Source: ABdhPJwc8AMhc3Nn+iPRQdvePIZ++FDF8PaNdzS2ZhrqYhfz67IPX5PWWIpp7xbpZ2i5Qi397HotCw==
X-Received: by 2002:a17:906:b855:: with SMTP id ga21mr26616231ejb.550.1623206535201;
        Tue, 08 Jun 2021 19:42:15 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id br21sm485795ejb.124.2021.06.08.19.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 19:42:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] builtins + test helpers: use return instead of
 exit() in cmd_*
Date:   Wed, 09 Jun 2021 03:54:22 +0200
References: <patch-1.1-61d7e6e079-20210607T111008Z-avarab@gmail.com>
 <patch-1.1-f225b78e01-20210608T104454Z-avarab@gmail.com>
 <xmqqwnr3nc7i.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <xmqqwnr3nc7i.fsf@gitster.g>
Message-ID: <87im2n3gje.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 09 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Change various cmd_* functions that claim no return an "int" to use
>
> s/no return/to return/
>
>> "return" instead of exit() to indicate an exit code. These were not
>> marked with NORETURN,
>
> Up to this point, it is well written.
>
>> and by directly exit()-ing we'll skip the
>> cleanup git.c would otherwise do (e.g. closing fd's, erroring if we
>> can't). See run_builtin() in git.c.
>
> But I think this is a hyperbole.  File descritors are closed when we
> exit without git.c's help, thank-you-very-much ;-), [...]

Closed yes, but not ", erroring if we can't". That's referring to the
behavior in git.c added in g0f157315a1 (Check for IO errors after
running a command, 2007-06-24) and 0227f9887b (git: Try a bit harder not
to lose errno in stdio, 2007-06-30).

That strictness isn't something you get by default from an exiting C
program, which is why we're explicitly checking and calling die_errno()
in run_builtin().

I wasn't aiming for hyperbole, just accurately describing the
implications of skipping the code we'd skip before this patch.

> [...]and if we do
> have clean-ups that are truly important, we would have arranged them
> to happen in the atexit handler, so it is not a crime for functions
> called from the subcommand dispatchers to exit themselves (as long
> as they exit sensibly, e.g. without doing nonsense like exit(-1)).

I'm not quite sure what "clean-ups that are truly important" is meant to
get at here. I was just describing the cleanups in git.c that we were
skipping, which aren't implemened as atexit handlers.

But no, those couldn't be done in atexit handlers as they call
die_errno() or BUG(), and both of them want to modify the exit code. The
atexit() handlers cannot modify the exit code (both per the C standard,
and POSIX).

That particular edge was last last discussed on-list in my
https://lore.kernel.org/git/20210202020001.31601-6-avarab@gmail.com/;
when the whole "should SIGPIPE from the pager be ignored" topic came up.

So it's really the opposite of what you're saying. If you have cleanups
that are truly important, i.e. so important that you'd like to notify
the user with a non-zero exit code if they fail, you *don't* want them
in an atexit handler. That won't work.

> It nevertheless is a good idea because it encourages good code
> hygiene, just like marking with NORETURN if the function must exit.
> Selling this change as if it were a correctness fix (i.e. we were
> exiting and missed these important clean-ups that the caller wanted
> to do after we return) is misleading.

Before this patch:

    $ git ls-tree HEAD | git mktree >/dev/full; echo $?
    0

After:

    $ git ls-tree HEAD | git mktree >/dev/full; echo $?
    fatal: unknown write failure on standard output
    128

So yes, it's a correctness fix, and you can't do that in an atexit
handler, at least not portably.

You might find that if you try it that it works perfectly fine. But
that's because e.g. glibc does non-standard shenanigans to make it work,
but it's not portable behavior. See
e.g. https://wiki.musl-libc.org/functional-differences-from-glibc.html#Re_e=
ntrancy_of_exit

That page suggests that glibc's behavior might be an accident, but it's
not. They explicitly support that non-standard behavior of an atexit
handler munging the exit code. See their implementation & comments:
https://github.com/bminor/glibc/blob/master/stdlib/exit.c
