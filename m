Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643DDC636D7
	for <git@archiver.kernel.org>; Sat, 18 Feb 2023 10:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjBRKg5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Feb 2023 05:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjBRKg4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2023 05:36:56 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D033C04
        for <git@vger.kernel.org>; Sat, 18 Feb 2023 02:36:54 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id w18so95441wrv.11
        for <git@vger.kernel.org>; Sat, 18 Feb 2023 02:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O2E1+JfpLB7nJZFTrbcowunylnep0khv+4LbgB85iZw=;
        b=g59u105S0p9n+6LkwPvaxN+YA4OitqpCJ1YBoI54lo+DMYKG8dVfztz3zXrtg5curs
         tW/uI1mja8/CPrn2rqkcOh0vr2pWMbXg8LNpwsvq0D3zm0AZD6qbLFP5jUndTEfOn3xb
         xS9Gv7amBKaCS/BdlbDnMOf5a6Ct0gJjh0eymdrlT4tM9fWm4AmZ1vYQsP1K8N4+Jirf
         +gBR1sAiJbm2KX+HCvi1TOs6X3nR2y33RqcEWAjndDyInCYOCeUAkAqAEc14J8I391zW
         0VNDuq4jX3E5fNAjsIKdiUpL/qIKbe4GDT4B1v/bAFr97t7ic0l1U1i1IzudlKLk+nQO
         wb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2E1+JfpLB7nJZFTrbcowunylnep0khv+4LbgB85iZw=;
        b=uS5Q8R7v6inDEAOTtCLP1/ixGg22Cx21JQHCC1vvV1hZ6+Vwq6o6bvpyTS+CGec8o9
         y/50sh3W3bc4YeBIT3LpFys+iQkmmnNsZIq0+yKlx1SKfEBC8Jeb/5iaCrWvWDI0/3wU
         Rpu3FC5zuWTwawuK0CAOMKmKVJRargvw0zzB12u5QIwlr2HGBhpU6OC6ggMXnYohXzX7
         xFsfW5mPswBMkjSnTKRjeDm9PXbp04E9RizTyCdQ59l+/LEZSlsTMBblkly9TjJTMqv7
         W5APE+MtsA3tgAPNLRpnOaCVt/yCLnPQ5ic9ub1xoZRXxPBNPT+FOdUuvzHmuGuzi19U
         Yx8A==
X-Gm-Message-State: AO0yUKVeJ1oM1MdZwIHTb3JTjcI/iYznlHaeG7fEIFI0V8iD78fw3R1m
        QGwIph6owMO+a8Y8lOOwfjA=
X-Google-Smtp-Source: AK7set/dRgd1PjPSQ3W+uWhylvMLpL10P865QhNSrNo69bjlzAemKx4QpQbX0/Yq4iseyJPcs8144A==
X-Received: by 2002:a05:6000:1191:b0:2bd:d34e:5355 with SMTP id g17-20020a056000119100b002bdd34e5355mr312569wrx.20.1676716612906;
        Sat, 18 Feb 2023 02:36:52 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id a4-20020a056000100400b002c557f82e27sm6511947wrx.99.2023.02.18.02.36.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Feb 2023 02:36:52 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <4222af90-bd6b-d970-2829-1ddfaeb770bf@dunelm.org.uk>
Date:   Sat, 18 Feb 2023 10:36:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Proposal/Discussion: Turning parts of Git into libraries
Content-Language: en-US
To:     demerphq <demerphq@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrn@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Aleksandr Mikhailov <avmikhailov@google.com>
References: <CAJoAoZ=Cig_kLocxKGax31sU7Xe4==BGzC__Bg2_pr7krNq6MA@mail.gmail.com>
 <xmqq3573lx2d.fsf@gitster.g>
 <CANgJU+XoT42u91WP7-p4V41w7q-UVhutL2LUfNkp3_BRCOn-FQ@mail.gmail.com>
In-Reply-To: <CANgJU+XoT42u91WP7-p4V41w7q-UVhutL2LUfNkp3_BRCOn-FQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/02/2023 01:59, demerphq wrote:
> On Sat, 18 Feb 2023 at 00:24, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Emily Shaffer <nasamuffin@google.com> writes:
>>
>>> Basically, if this effort turns out not to be fruitful as a whole, I'd
>>> like for us to still have left a positive impact on the codebase.
>>> ...
>>> So what's next? Naturally, I'm looking forward to a spirited
>>> discussion about this topic - I'd like to know which concerns haven't
>>> been addressed and figure out whether we can find a way around them,
>>> and generally build awareness of this effort with the community.
>>
>> On of the gravest concerns is that the devil is in the details.
>>
>> For example, "die() is inconvenient to callers, let's propagate
>> errors up the callchain" is an easy thing to say, but it would take
>> much more than "let's propagate errors up" to libify something like
>> check_connected() to do the same thing without spawning a separate
>> process that is expected to exit with failure.
> 
> 
> What does "propagate errors up the callchain" mean?  One
> interpretation I can think of seems quite horrible, but another seems
> quite doable and reasonable and likely not even very invasive of the
> existing code:
> 
> You can use setjmp/longjmp to implement a form of "try", so that
> errors dont have to be *explicitly* returned *in* the call chain. And
> you could probably do so without changing very much of the existing
> code at all, and maintain a high level of conceptual alignment with
> the current code strategy.

Using setjmp/longjmp is an interesting suggestion, I think lua does 
something similar to what you describe for perl. However I think both of 
those use a allocator with garbage collection. I worry that using 
longjmp in git would be more invasive (or result in more memory leaks) 
as we'd need to to guard each allocation with some code to clean it up 
and then propagate the error. That means we're back to manually 
propagating errors up the call chain in many cases.

Best Wishes

Phillip

> To do this you need to set up a globally available linked list of
> jmp_env data (see `man setjmp` for jmp_env), and a global error
> object, and make the existing "die" functions populate the global
> error object, and then pop the most recent jmp_env data and longjmp to
> it.
> 
> At the top of any git invocation you would set up the topmost jmp_env
> "frame". Any code that wants to "try" existing logic pushes a new
> jmp_env (using a wrapper around setjmp), and prepares to be longjmp'ed
> to. If the code does not die then it pops the jmp_env it just pushed
> and returns as normal, if it is longjmp'ed to you can detect this and
> do some other behavior to handle the exception (by reading the global
> error object). If the code that died *really* wants to exit, then it
> returns the appropriate code as part of the longjmp, and the try
> handler longjmps again propagating up the chain. Eventually you either
> have an error that "propagates to the top" which results in an exit
> with an appropriate error message, or you have an error that is
> trapped and the code does something else, and then eventually returns
> normally.
> 
> FWIW, this is essentially a loose description of how Perl handles the
> execution part of "eval" and supports exception handling internally.
> Most of the perl internals do not know anything about exceptions, they
> just call functions similar to gits die functions if they need to,
> which then call into Perl_die_unwind(). which then calls the
> JUMPENV_JUMP() macro which does the "pop and longjmp" dance.
> 
> Seems to me that it wouldn't be very difficult nor particularly
> invasive to implement this in git. Much of the logic in the perl
> project to do this is at the top of cop.h,  see the macros
> JMPENV_PUSH(), JMPENV_POP(), JMPENV_JUMP(). Obviously this code
> contains a bunch of perl specific logic, but the general gist of it
> should be easily understood and easily converted to a more git like
> context:
> 
> struct jmpenv: https://github.com/Perl/perl5/blob/blead/cop.h#L32
> JMPENV_BOOTSTRAP: https://github.com/Perl/perl5/blob/blead/cop.h#L66
> JMPENV_PUSH: https://github.com/Perl/perl5/blob/blead/cop.h#L113
> JMPENV_POP: https://github.com/Perl/perl5/blob/blead/cop.h#L147
> JMPENV_JUMP: https://github.com/Perl/perl5/blob/blead/cop.h#L159
> 
> Perl_die_unwind: https://github.com/Perl/perl5/blob/blead/pp_ctl.c#L1741
> Where Perl_die_unwind() calls JMPENV_JUMP:
> https://github.com/Perl/perl5/blob/blead/pp_ctl.c#L1865
> 
> You can also grep for functions of the form S_try_ in the perl code
> base to find examples where the C code explicitly sets up an "eval
> frame" to interoperate with the functionality above.
> 
> git grep -nP '^S_try_'
> pp_ctl.c:3548:S_try_yyparse(pTHX_ int gramtype, OP *caller_op)
> pp_ctl.c:3604:S_try_run_unitcheck(pTHX_ OP* caller_op)
> pp_sys.c:3120:S_try_amagic_ftest(pTHX_ char chr) {
> 
> Seems to me that this gives enough prior art to convert git to use the
> same strategy, and that doing so would not actually be that big a
> change to the existing code.  Both environments are fairly similar if
> you look at them from the right perspective. Both are C, and both have
> a lot of global state, and both have lots of functions which you
> really dont want to have to change to understand about exception
> objects..
> 
> Here is an example of how a C function might be written to use this
> kind of infrastructure to "try" functionality that might call die. In
> this case there is no need for the code to inspect the global error
> object, but the basic pattern is consistent. The "default" case below
> handles the situation where the "tried" function is signalling an
> "untrappable error" that needs to be rethrown to ultimately unwind the
> entire try/catch chain and exit the program. It is derived and
> simplified from S_try_yyparse mentioned above. This function handles
> the "compile the code" part of an `eval EXPR`, and traps exceptions
> from the parser so that they can be handled properly and distinctly
> from errors trapped during execution of the compiled code. [ I am
> assuming that given the historical relationship between git and perl
> these concepts are not alien to everybody on this list. ]
> 
> /* S_try_yyparse():
>   *
>   * Run yyparse() in a setjmp wrapper. Returns:
>   *   0: yyparse() successful
>   *   1: yyparse() failed
>   *   3: yyparse() died
>   *
>   * ...
>   */
> STATIC int
> S_try_yyparse(pTHX_ int gramtype, ...)
> {
>      dJMPENV;
> 
>      JMPENV_PUSH(ret);
>      switch (ret) {
>      case 0:
>          ret = yyparse(gramtype) ? 1 : 0;
>          break;
>      case 3:
>          /* yyparse() died and we trapped the error. */
>          ....
>          break;
>      default:
>          JMPENV_POP;          /* remove our own setjmp data */
>          JMPENV_JUMP(ret); /* RETHROW */
>      }
>      JMPENV_POP;
>      return ret;
> }
> 
