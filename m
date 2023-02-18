Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADA9C05027
	for <git@archiver.kernel.org>; Sat, 18 Feb 2023 02:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjBRCAF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 21:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBRCAE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 21:00:04 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4641C6ABF0
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 18:00:03 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id t1so435509qkt.3
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 18:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0QnULE6r9VF4Vx0kx9J37jhsF490ZfiBZ4QTmEcJzLo=;
        b=VdU04aYoyUSbMpWXIL2ggPyrZCl+I3i4jV4KfCDCCz6JprieEaFVTsC0ZMXFpqteRc
         lzMH/YQfxUXhzFn2wxyVxrg42pQjCfcXuwBXDpwPX983/okHD1hkZ0yHKw/IgKD2Hf3T
         Tw5qJ2uq2aZnaZk9GUfGTvJsOWSAezXCQnOs2BSoozeJ/b0maO+4QxLKBc49SWkRSiuM
         wv7V45lKfnTaXYq1B0UO3CJhBL2mrUqwF+dlZ7UFLYkKRgJmvOvymTPwRY7n6ebnBcOD
         VnQIVNb3Io/qGhXS2uKIS3ckVV/NP0tmv50xmhRyF91OyqkHvqSpzZrYUEECV3z3vWzQ
         neBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0QnULE6r9VF4Vx0kx9J37jhsF490ZfiBZ4QTmEcJzLo=;
        b=4aVERoJM6cWwteqgfyLPTyhx75kNFXwXgKr52v/cnSa3BKiOjgn6W7JPrFnY4W3uOB
         0rzgPxVGrvhQNMlgVvL6dhozqoUAPpywDkfo3AFMv9sXMLC+sWnFKwRiicVhAZf7lcGj
         fpKS5MDDTO3JA4V2GVBJo0r9D1HSzJUTqKaRO4pf+s7SZH0s51jnhJJFzBCxxVoEOhaQ
         YKBEk4nRRR86KYbtFUflarEF//rkQRiT7Pu8Wgh+ByY14SPYdbunjeekr0MAwXKpFkAT
         /urEIZz85LsmJfmcb3dEWvm2HE86eoZDEk3zQBP1Z8NFJ1iUV9LDizZHfj8hGAfrMliA
         BDIA==
X-Gm-Message-State: AO0yUKX64ItIY2PDTYryJ0+7wIIXoWrjBW19z6h8MzABUNfyfKLaawsF
        asz/SxSm7WLAHIn8vjG+Fh020CX9fQlyKcPxq8rP5Lnty3Z7GQ==
X-Google-Smtp-Source: AK7set9pyWegPCJPPwnmo3p5rp1+DjK5tLxVVtj6o3zx2mSZiDOsIA1BC0ceiwhkrPr5Is/wJ+r4FJwiouM7O3ZKWiY=
X-Received: by 2002:a05:620a:151c:b0:73b:a5c3:7e8b with SMTP id
 i28-20020a05620a151c00b0073ba5c37e8bmr697765qkk.7.1676685602320; Fri, 17 Feb
 2023 18:00:02 -0800 (PST)
MIME-Version: 1.0
References: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com>
 <xmqq3573lx2d.fsf@gitster.g>
In-Reply-To: <xmqq3573lx2d.fsf@gitster.g>
From:   demerphq <demerphq@gmail.com>
Date:   Sat, 18 Feb 2023 02:59:51 +0100
Message-ID: <CANgJU+XoT42u91WP7-p4V41w7q-UVhutL2LUfNkp3_BRCOn-FQ@mail.gmail.com>
Subject: Re: Proposal/Discussion: Turning parts of Git into libraries
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrn@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Aleksandr Mikhailov <avmikhailov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 18 Feb 2023 at 00:24, Junio C Hamano <gitster@pobox.com> wrote:
>
> Emily Shaffer <nasamuffin@google.com> writes:
>
> > Basically, if this effort turns out not to be fruitful as a whole, I'd
> > like for us to still have left a positive impact on the codebase.
> > ...
> > So what's next? Naturally, I'm looking forward to a spirited
> > discussion about this topic - I'd like to know which concerns haven't
> > been addressed and figure out whether we can find a way around them,
> > and generally build awareness of this effort with the community.
>
> On of the gravest concerns is that the devil is in the details.
>
> For example, "die() is inconvenient to callers, let's propagate
> errors up the callchain" is an easy thing to say, but it would take
> much more than "let's propagate errors up" to libify something like
> check_connected() to do the same thing without spawning a separate
> process that is expected to exit with failure.


What does "propagate errors up the callchain" mean?  One
interpretation I can think of seems quite horrible, but another seems
quite doable and reasonable and likely not even very invasive of the
existing code:

You can use setjmp/longjmp to implement a form of "try", so that
errors dont have to be *explicitly* returned *in* the call chain. And
you could probably do so without changing very much of the existing
code at all, and maintain a high level of conceptual alignment with
the current code strategy.

To do this you need to set up a globally available linked list of
jmp_env data (see `man setjmp` for jmp_env), and a global error
object, and make the existing "die" functions populate the global
error object, and then pop the most recent jmp_env data and longjmp to
it.

At the top of any git invocation you would set up the topmost jmp_env
"frame". Any code that wants to "try" existing logic pushes a new
jmp_env (using a wrapper around setjmp), and prepares to be longjmp'ed
to. If the code does not die then it pops the jmp_env it just pushed
and returns as normal, if it is longjmp'ed to you can detect this and
do some other behavior to handle the exception (by reading the global
error object). If the code that died *really* wants to exit, then it
returns the appropriate code as part of the longjmp, and the try
handler longjmps again propagating up the chain. Eventually you either
have an error that "propagates to the top" which results in an exit
with an appropriate error message, or you have an error that is
trapped and the code does something else, and then eventually returns
normally.

FWIW, this is essentially a loose description of how Perl handles the
execution part of "eval" and supports exception handling internally.
Most of the perl internals do not know anything about exceptions, they
just call functions similar to gits die functions if they need to,
which then call into Perl_die_unwind(). which then calls the
JUMPENV_JUMP() macro which does the "pop and longjmp" dance.

Seems to me that it wouldn't be very difficult nor particularly
invasive to implement this in git. Much of the logic in the perl
project to do this is at the top of cop.h,  see the macros
JMPENV_PUSH(), JMPENV_POP(), JMPENV_JUMP(). Obviously this code
contains a bunch of perl specific logic, but the general gist of it
should be easily understood and easily converted to a more git like
context:

struct jmpenv: https://github.com/Perl/perl5/blob/blead/cop.h#L32
JMPENV_BOOTSTRAP: https://github.com/Perl/perl5/blob/blead/cop.h#L66
JMPENV_PUSH: https://github.com/Perl/perl5/blob/blead/cop.h#L113
JMPENV_POP: https://github.com/Perl/perl5/blob/blead/cop.h#L147
JMPENV_JUMP: https://github.com/Perl/perl5/blob/blead/cop.h#L159

Perl_die_unwind: https://github.com/Perl/perl5/blob/blead/pp_ctl.c#L1741
Where Perl_die_unwind() calls JMPENV_JUMP:
https://github.com/Perl/perl5/blob/blead/pp_ctl.c#L1865

You can also grep for functions of the form S_try_ in the perl code
base to find examples where the C code explicitly sets up an "eval
frame" to interoperate with the functionality above.

git grep -nP '^S_try_'
pp_ctl.c:3548:S_try_yyparse(pTHX_ int gramtype, OP *caller_op)
pp_ctl.c:3604:S_try_run_unitcheck(pTHX_ OP* caller_op)
pp_sys.c:3120:S_try_amagic_ftest(pTHX_ char chr) {

Seems to me that this gives enough prior art to convert git to use the
same strategy, and that doing so would not actually be that big a
change to the existing code.  Both environments are fairly similar if
you look at them from the right perspective. Both are C, and both have
a lot of global state, and both have lots of functions which you
really dont want to have to change to understand about exception
objects..

Here is an example of how a C function might be written to use this
kind of infrastructure to "try" functionality that might call die. In
this case there is no need for the code to inspect the global error
object, but the basic pattern is consistent. The "default" case below
handles the situation where the "tried" function is signalling an
"untrappable error" that needs to be rethrown to ultimately unwind the
entire try/catch chain and exit the program. It is derived and
simplified from S_try_yyparse mentioned above. This function handles
the "compile the code" part of an `eval EXPR`, and traps exceptions
from the parser so that they can be handled properly and distinctly
from errors trapped during execution of the compiled code. [ I am
assuming that given the historical relationship between git and perl
these concepts are not alien to everybody on this list. ]

/* S_try_yyparse():
 *
 * Run yyparse() in a setjmp wrapper. Returns:
 *   0: yyparse() successful
 *   1: yyparse() failed
 *   3: yyparse() died
 *
 * ...
 */
STATIC int
S_try_yyparse(pTHX_ int gramtype, ...)
{
    dJMPENV;

    JMPENV_PUSH(ret);
    switch (ret) {
    case 0:
        ret = yyparse(gramtype) ? 1 : 0;
        break;
    case 3:
        /* yyparse() died and we trapped the error. */
        ....
        break;
    default:
        JMPENV_POP;          /* remove our own setjmp data */
        JMPENV_JUMP(ret); /* RETHROW */
    }
    JMPENV_POP;
    return ret;
}

-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
