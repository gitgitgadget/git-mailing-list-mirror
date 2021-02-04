Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D7CC433DB
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 00:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BABF964F68
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 00:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbhBDAOy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 19:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbhBDAOx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 19:14:53 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB13C0613ED
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 16:14:13 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id r12so2054136ejb.9
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 16:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=WDK5j5kwvMhXma8e0WdLWqP6JBpQ0f1dRZhVTPQgW4M=;
        b=ZGviQh/WxYiXNPPcn2SoZYhDm8ulwcqkgX6wf12gmi9hiNr8yFBk3JRQkkl1wiww8O
         oijWcvY/YfXVWuLxavNx6odMU0SpvGsG8/6wHR+4ZalyKm8NSixPs/dRRJf8K5DrOwoB
         r9RjNE0cUjzD+uBC09VUtEF2MooMkV2f0V7akj6KE5GO+ysu/ZJjdu8pAkidS/ivoiZi
         LH6tgI1QO5uYqDjqv3V3FKRHTrEW2mfPutUXS63XhcqcivPwZ+WKTB+s/p/z0uWgvLcp
         ScoeSVLTtejjOmI7klDX2LyIlCKeF5NQcLiNV63xHs8EzzQJeXzzKhASLJOW4kJDjdRY
         GCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=WDK5j5kwvMhXma8e0WdLWqP6JBpQ0f1dRZhVTPQgW4M=;
        b=LSmRxvw2wJwESaju0HvBDGYAYRt3d8wTtVQfzszy8IDI9RykHx/39IN4sS203qkrIy
         yfJhMVZjyJfZ1gXuvXinEBnQYG1Grwr37PSK5Y/p2syGXk3XM8xvtN0rUaoreSOClSpu
         e6um9C1PbSJWhx9vESRnTc5VKdy3txORI71ZEYhSMOyf9nPRPfvvBvh9pr2NzBrafDVE
         BpN5x2ti8E6in25ZejBZq4l4cJoFQOStYNJPp1sSKoG4bXuJce5wi8grkhXq0I4Jz3C1
         X958pFEwq/LnDEIPxr4RQew9zrZ9OKRZaL+clZxsgpx6aE328nrcDy6KpyDE7F3f6Jlz
         4XAw==
X-Gm-Message-State: AOAM533MTKI9pfJnYdvz6O5nBgFQ6GsH56M0H0uaOAsvlssnaf/tBKQb
        BSCKLHAkw7b/+TkIwTw4VC+pec9cd7PQRg==
X-Google-Smtp-Source: ABdhPJymGu0MOmvq9v6Cf25UsDLHKunmCoLmpcE4QIaqu3FM+MSQsnb1sjKfvRicIopDz1I9VzLvtw==
X-Received: by 2002:a17:906:780b:: with SMTP id u11mr5613264ejm.492.1612397652034;
        Wed, 03 Feb 2021 16:14:12 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id i15sm1638719ejj.28.2021.02.03.16.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 16:14:11 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Vincent Lefevre <vincent@vinc17.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: git fails with a broken pipe when one quits the pager
References: <YAG/vzctP4JwSp5x@zira.vinc17.org>
 <8735yhq3lc.fsf@evledraar.gmail.com>
 <20210131033652.GK623063@zira.vinc17.org>
 <87o8h4omqa.fsf@evledraar.gmail.com>
 <20210201103429.GT623063@zira.vinc17.org>
 <87im7cng42.fsf@evledraar.gmail.com>
 <20210201144857.GB24560@zira.vinc17.org>
 <87a6snokrr.fsf@evledraar.gmail.com>
 <20210203152634.GA22673@joooj.vinc17.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210203152634.GA22673@joooj.vinc17.net>
Date:   Thu, 04 Feb 2021 01:14:10 +0100
Message-ID: <87v9b8d6zx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 03 2021, Vincent Lefevre wrote:

> On 2021-02-01 16:44:24 +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrot=
e:
>> And then whether it makes sense to ignore SIGPIPE for all users, or
>> e.g. if it's some opt-in setting in some situations that users might
>> want to turn on because they're aware of how their pager behaves and
>> want to work around some zsh mode.
>
> AFAIK, SIGPIPE exists for the following reason. Most programs that
> generate output are not written to specifically handle pipes. So,
> if SIGPIPE did not exist, there would be 2 kinds of behavior:
>   1. The program doesn't check for errors, and still outputs data,
>      wasting time and resources as output will be ignored.
>   2. The program sees that the write() failed and terminates with
>      an error message. However, in most cases, such a failure is
>      not an error: the consumer has terminated either because it
>      no longer needs any input (e.g. with the "head" utility or a
>      pager), or because it has terminated abnormally, in which case
>      the real error is on the side of the consumer. So, the error
>      message from the LHS of the pipe would be annoying.
>
> SIGPIPE solves this issue: the program is simply killed with SIGPIPE.
> In a shell, one gets a non-zero exit code (128 + 13) due to the
> signal, but as being on the left-hand side of the pipe, such a
> non-zero exit code is normally not reported, so that this will not
> annoy the user.
>
> Note 1: Non-zero exit codes from right-hand side are not reported
> either by most shells, but zsh can report them, and this is very
> useful for developers, as programs may fail with a non-zero exit
> code but without an error message. (Reports may also be done by
> looking at the standard $? in some hook.)
>
> Note 2: Failures on the left-hand side are less interesting in practice
> and generally ignored, at least for commands run in interactive shells.
> For scripts, there are various (non-simple) ways to handle them.
>
> Now, I think that in the case (like Git) a program creates a pipe,
> it should use its knowledge to handle SIGPIPE / EPIPE. Either this
> is regarded as an error because the full output is *always expected*
> to be read, in which case there should be an error message in addition
> to the usual non-zero exist status (not necessarily 141), or this is
> regarded as OK (if there is a real failure, this is on the side of
> the consumer). In the case of Git, the consumer is documented to be
> a pager, which obviously may not read the full output (e.g. for the
> GCC repository, "git log" returns more than 3 million lines, back to
> the year 1988, while one is generally interested in the latest changes
> only). If the user wants to pipe to something else, he can always use
> an explicit pipe.

SIGPIPE exists because *nix systems are composable, so you can make
something useful by stringing together unrelated programs via files and
pipes, and with exit codes and signal mostly everyone's happy.

I follow what you're saying right until the point of arguing that
because either your shell or POSIX shells in general have decided to
either be sloppy or overzelous in how they show you some
information. That we should use their behavior as a guide in
pro-actively suppressing our own exit code.

And that's not because I think (to the tune of Monty Python...) that
every exit code is sacret. It's because when we invoke a pager handing
it data is *the* thing we're doing. If we can fully hand it over, great,
if not, let's tell the user with the appropriate exit code.

Yeah it's annoying with zsh's PRINT_EXIT_VALUE, but the same is true of
POSIX "set -e". Not every shell option is meant for general use. The
shell is very forgiving of things like pipe failures by default for a
reason.

But "connected to a terminal" (isatty(1)) and "invoked by Vincent's zsh
instance" aren't the same thing. And I think it makes sense to be
conservative in preserving exit codes.

In the early days of git complaining about "Broken pipe" in the exact
same scenario was the default behavior of bash's overzelous reporting,
as you can read about starting here:
https://lore.kernel.org/git/?q=3D%22Broken+pipe%22+bash&o=3D-1

AFAICT that changed by default in bash 3.1, released in 2005-12-08. It
was a FAQ in the early days, now nobody cares.

Have you reported this as a bug to zsh? I think it's likely that the
motivation for wanting this squashed in git is going to be as transitory
as bash's once-default verbosity was.

I also tested "hg log", it behaves the same way, although interestingly
they cast SIGPIPE to 255 in their exit code.

