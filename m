Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF16DC433F5
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 09:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351309AbiDTJEE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 05:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377057AbiDTJD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 05:03:57 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F242E10E8
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 02:00:53 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e21so1280167wrc.8
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 02:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AxsZjTOpuytm73QV8Ja0j+TpdgSTIghLS9Z6tTH7bJI=;
        b=cwZCmX+qVXOqWPYmugGlWwBvWvMhL1DTDpIPq67KE09pyn44vCvM6olW7nhnEsPCBv
         jHaNFrmVPwlmRHGYMh+LxixsTWBb9U6G5SefjcnavaE44Ijp4qmh6NNVE2fQ7df7lQ4b
         cg51SOyqbsG+9jhkrHtFs4QReWjDL+Yrg3Dv7h6+yyAYnEtTCv4lhP16jfVXxG8bIKw+
         7s+srPgwuo3yt+Ja7d9wcshgH1r9ssWX9cM6NuwUA0MMBOtFVqc9GZiBmjS2htUn3hg5
         32sOdzmGGak3Jqrq5+wNJazRjORdYoWVropYr3sig29D18T9zgN6V9wluJ61H/9c2+y3
         Qn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AxsZjTOpuytm73QV8Ja0j+TpdgSTIghLS9Z6tTH7bJI=;
        b=p5+TBaIGYC8AUZv/wTRSIZe8C5KHNulofUCx6rM0oH4ESAsRXTq3hV8oXkyz67lvpB
         yvSN449w1ORvs4Gv7Pixdg9/QX5eMB7V2KsIwoK6tMLZlhEIbgbwhD+wzi6KGLoq/j3y
         wVWVbAWALr96RvI+AUEFkTY9RWHMHukxerYnUhNkk0Cd4CIk94Af2OKrIUdp6uEK5aKr
         sD/WiBOHerSy9BIw3EK67NvYgGaWiyJS4HMDqQ1mCydqJGXV/o6v2yfZVQ2G/oNp0hHC
         xmwRvcgzIw+k7iXs0Ry7RxM8TsTGfI7/PXwnUILf8+5EW7qqrUOoo35X2jSf93mmCuPk
         8Baw==
X-Gm-Message-State: AOAM531o54fn05N74aTPs82UPuY06KAYfH2j/2SWB6jzY906FTYuCdjX
        FCMs76ClKi9s5o2KQUBgreffgmLdvws=
X-Google-Smtp-Source: ABdhPJyI4QCLa5nySnLwicfoHzyxDUdfgsT5LUOO9RE/PEB5E8he+570gUqKaTEydtP2Y2YWLiN7Ag==
X-Received: by 2002:a05:6000:150:b0:207:bb51:df0f with SMTP id r16-20020a056000015000b00207bb51df0fmr14689822wrx.92.1650445251094;
        Wed, 20 Apr 2022 02:00:51 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id m6-20020a05600c4f4600b003918d69b334sm16225321wmq.42.2022.04.20.02.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 02:00:50 -0700 (PDT)
Message-ID: <6aabbcd6-f6c2-fe97-eb73-593bcf2e9e75@gmail.com>
Date:   Wed, 20 Apr 2022 10:00:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git 2.36.0 regression: pre-commit hooks no longer have
 stdout/stderr as tty
Content-Language: en-GB-large
To:     Emily Shaffer <emilyshaffer@google.com>,
        Anthony Sottile <asottile@umich.edu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <CA+dzEBn108QoMA28f0nC8K21XT+Afua0V2Qv8XkR8rAeqUCCZw@mail.gmail.com>
 <Yl9Hn0C0TwalASC0@google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <Yl9Hn0C0TwalASC0@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily

On 20/04/2022 00:37, Emily Shaffer wrote:
> On Tue, Apr 19, 2022 at 02:59:36PM -0400, Anthony Sottile wrote:
>> [...]
> Interesting. I'm surprised to see the tty-ness of hooks changing with
> this patch, as the way the hook is called is pretty much the same:
> 
> run_hook_ve() ("the old way") sets no_stdin, stdout_to_stderr, args,
> envvars, and some trace variables, and then runs 'run_command()';
> run_command() invokes start_command().
> 
> run_hooks_opt ("the new way") ultimately kicks off the hook with a
> callback that sets up a child_process with no_stdin, stdout_to_stderr,
> args, envvars, and some trace variables (hook.c:pick_next_hook); the
> task queue manager also sets .err to -1 on that child_process; then it
> calls start_command() directly (run-command.c:pp_start_one()).
> 
> I'm not sure I see why the tty-ness would change between the two. If I'm
> being honest, I'm actually slightly surprised that `isatty` returned
> true for your hook before - since the hook process is a child of Git and
> its output is, presumably, being consumed by Git first rather than by an
> interactive user shell.
> 
> I suppose that with stdout_to_stderr being set, the tty-ness of the main
> process's stderr would then apply to the child process's stdout (we do
> that by calling `dup(2)`). But that's being set in both "the old way"
> and "the new way", so I'm pretty surprised to see a change here.
 >
> It *is* true that run-command.c:pp_start_one() sets child_process:err=-1
> for the child and run-command.c:run_hook_ve() didn't do that; that -1
> means that start_command() will create a new fd for the child's stderr.
> Since run_hook_ve() didn't care about the child's stderr before, I
> wonder if that is why? Could it be that now that we're processing the
> child's stderr, the child no longer thinks stderr is in tty, because the
> parent is consuming its output?

Exactly, stderr is redirected to a pipe so that we can buffer the output 
from each process and then write it to the real stdout when the process 
has finished to avoid the output from different processes getting mixed 
together. Ideally in this case we'd see that stdout is a tty and create 
a pty rather than a pipe when buffering the output from the process.

Best Wishes

Phillip
