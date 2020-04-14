Return-Path: <SRS0=cd4n=56=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD23C2BA19
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 15:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FED620768
	for <git@archiver.kernel.org>; Tue, 14 Apr 2020 15:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8t3atGg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437743AbgDNPPi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2437165AbgDNPPO (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 14 Apr 2020 11:15:14 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC6BC061A0C
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 08:15:14 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f13so14737691wrm.13
        for <git@vger.kernel.org>; Tue, 14 Apr 2020 08:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1EO2XqMjJyONUbG1ylqONYtIRlwKzt/LD6lSvFWJb6w=;
        b=W8t3atGgf1qgKSxhADLmcKuPrJrE4WElW8MLtQi5f4IHdfl++84TNdcA+k3pc1i5EH
         BLA7/3QOCJ65OHW29eaa5APUIKnD5pb8tukXtlBIt0Qbw8oyvcY6HP7XypWDBEoPY+6Z
         uVzAJBhi3MCrYC4wuZjt2oQK1U4XYQtVto3dLOSHVhYQkcEIiwi4dz87KL0JAXFOpnLS
         EhZ13U/UCGrjbozh2b7u0Wl19sBb62lXTJYnHAR2Gw5fk3v6sDY2Zj2x5yVDaEDhZuZi
         1nelKr7oPiCbMspRntfUQRlKwY8Ew4BUUDnTSzO0+Z5qhivLSIZZuPiwMh0se64cCO9Y
         WIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=1EO2XqMjJyONUbG1ylqONYtIRlwKzt/LD6lSvFWJb6w=;
        b=BNQFYhh2tRaO7Boj/X+pgdriWS6OOJAp9ZXaumysg75GlCH2E/Z1+W9SywPl8Cy7UB
         JRFWG8nM/PZbjIMVefnqTAwyq2cblttu5s80wT6S7OIFYvunh5leidnoInrbvtd/L8HJ
         AjlnEtARs6S1vPb4ouOWL66mLE8oBcBVRTnUkVXt1qbyE/d2zGcN1sqbLeO6BpmDOPC9
         bD8yPXcS0kkq2BU0yS2NlxCxqjO0Dfm2hdm7Ka6xb+vj238vKZ1Hekc+16e3Rm4eBYlJ
         3Is8kF2W0cFj273tD5JfYIULAsk1T4gqftrfU806bKKkEsZUbVXIwDfUZyD5I2ZVRTHz
         o+LA==
X-Gm-Message-State: AGi0PuY11WYA/UQgz5tSVyOxRk+u18zOq17drU83onfObFbQa6CVOi9T
        HI5n/vAnM9R9XPSGd63Wna9YBfy9
X-Google-Smtp-Source: APiQypLLodx9zRn7OYo37LjgjbjUBuhgt7Q8vpHfRUKqlaZmi2ny6iTF/C65J3BLvuMci944scvqdw==
X-Received: by 2002:a5d:4dcb:: with SMTP id f11mr13157894wru.174.1586877312927;
        Tue, 14 Apr 2020 08:15:12 -0700 (PDT)
Received: from [192.168.1.240] (155.20.198.146.dyn.plus.net. [146.198.20.155])
        by smtp.gmail.com with ESMTPSA id h2sm882627wro.9.2020.04.14.08.15.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 08:15:12 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v2 0/2] configuration-based hook management
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>, Jeff King <peff@peff.net>
References: <20191210023335.49987-1-emilyshaffer@google.com>
 <20200414005457.3505-1-emilyshaffer@google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <efad3927-1d8f-5545-48e9-9a58c2308273@gmail.com>
Date:   Tue, 14 Apr 2020 16:15:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200414005457.3505-1-emilyshaffer@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily

Thanks for working on this, having a way to manage multiple commands per 
hook without using an external framework would be really useful

On 14/04/2020 01:54, Emily Shaffer wrote:
> Not much to look at compared to the original RFC I sent some months ago.
> This implements Peff's suggestion of using the "hookcmd" section as a
> layer of indirection.

I'm not really clear what the advantage of this indirection is. It seems 
unlikely to me that different hooks will share exactly the same command 
line or other options. In the 'git secrets' example earlier in this 
thread each hook needs to use a different command line. In general a 
command cannot tell which hook it is being invoked as without a flag of 
some kind. (In some cases it can use the number of arguments if that is 
different for each hook that it handles but that is not true in general)

Without the redirection one could have
   hook.pre-commit.linter.command = my-command
   hook.pre-commit.check-whitespace.command = 'git diff --check --cached'

and other keys can be added for ordering etc. e.g.
   hook.pre-commit.linter.before = check-whitespace

With the indirection one needs to set
   hook.pre-commit.command = linter
   hook.pre-commit.check-whitespace = 'git diff --check --cached'
   hookcmd.linter.command = my-command
   hookcmd.linter.pre-commit-before = check-whitespace

which involves setting an extra key and checking it each time the hook 
is invoked without any benefit that I can see. I suspect which one seems 
more logical depends on how one thinks of setting hooks - I tend to 
think "I want to set a pre-commit hook" not "I want to set a git-secrets 
hook". If you've got an example where this indirection is helpful or 
necessary that would be really useful to see.

Best Wishes

Phillip


> The scope is a little smaller than the original
> RFC as it doesn't have a way to remove hooks from downstream (yet), and
> ordering numbers are dropped (for now).
> 
> One thing that's missing, as evidenced by the TODO, is a way to handle
> arbitrary options given within a "hookcmd" unit. I think this can be
> achieved with a callback, since it seems plausible that "pre-receive"
> might want a different set of options than "post-commit" or so on. To
> me, it sounds achievable with a callback; I imagine a follow-on teaching
> git-hook how to remove a hook with something like "hookcmd.foo.skip =
> true" will give an OK indication of how that might look.
> 
> Overall though, I think this is simpler than the first version of the
> RFC because I was reminded by wiser folks than I to "keep it simple,
> stupid." ;)
> 
> I think it's feasible that with these couple patches applied, someone
> who wanted to jump in early could replace their
> .git/hook/whatever-hookname with some boilerplate like
> 
>    xargs -n 1 'sh -c' <<<"$(git hook --list whatever-hookname)"
> 
> and give it a shot. Untested snippet. :)
> CI run: https://github.com/gitgitgadget/git/pull/611/checks
> 
>   - Emily
> 
> Emily Shaffer (2):
>    hook: scaffolding for git-hook subcommand
>    hook: add --list mode
> 
>   .gitignore                    |  1 +
>   Documentation/git-hook.txt    | 53 ++++++++++++++++++++
>   Makefile                      |  2 +
>   builtin.h                     |  1 +
>   builtin/hook.c                | 77 +++++++++++++++++++++++++++++
>   git.c                         |  1 +
>   hook.c                        | 92 +++++++++++++++++++++++++++++++++++
>   hook.h                        | 13 +++++
>   t/t1360-config-based-hooks.sh | 58 ++++++++++++++++++++++
>   9 files changed, 298 insertions(+)
>   create mode 100644 Documentation/git-hook.txt
>   create mode 100644 builtin/hook.c
>   create mode 100644 hook.c
>   create mode 100644 hook.h
>   create mode 100755 t/t1360-config-based-hooks.sh
> 
