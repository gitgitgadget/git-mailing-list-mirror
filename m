Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD532C433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 18:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6C2764F5B
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 18:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbhCLSeA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 13:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbhCLSdo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 13:33:44 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0934AC061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 10:33:44 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id p7so43858834eju.6
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 10:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=u55wSPWLuJbEJMh+1jGBPbv682jhBRWdGR8eqwlFaDQ=;
        b=gMw4qahcZnJeIfG9obeam4gh1vJfOMIjT0ivoELjQdnPt0ZAVcEaYR9uNbOB2HRfJG
         eEU7HWPJ/sXJ93PUHbezXPuO1jgwO2aCDnlvFGRxFY9VSEE3FYmJBagk2Ouq1Isg0Rio
         RmPRDK4kRkiw1/hxzETuobnrj/ni8MDViwlrxDxWIHVyFvkGYcz1lr/ezDwecECdWr+3
         ZRfyzW/R/MGwRMf6/ihFNtY+JPsJoTPuXh1s86PEA2Ty+GpJ8i4U/IB1PgRtvFaqCPfG
         xH8W4/kSxGy4uiadOqk/am1BYlgeiwSeCwMAR0ZXvZjWGRqtCHcSEpXwmkaywg9o1Opa
         PRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=u55wSPWLuJbEJMh+1jGBPbv682jhBRWdGR8eqwlFaDQ=;
        b=tCX6AjUgOepJsglH61yAG30vqTBAoRqNS/n4iK3Meew2zWjckmA1p03Konhd71okNm
         p3X/31hFR3o79P0f3ht8+vMyPp+NkqpecdvCFRX+3BdrYi/VcC2qZbRApPgI0F2LjROk
         TR1N/xO8hQbFTDmQHalp7MpdRTbEH/opKnainCRKj2O4qAzT9Mbyy8daOJICdxrttWm1
         KzYhXtQKVXM8FvdPYnbGZhb/CbeVTQcAHianzzPN52h36Y5Xj3H3FarMGbT2D8Udmzj9
         Kg2t3m4U3f7jscD9Qw6u3zl6uP8IWZeRMHAONqbhq9AG/FI3nC480Zexp+knDgTBjxPV
         osxA==
X-Gm-Message-State: AOAM531I1PDrol6M22Jau710mHItQ29YEjA2ATku3QXqKs9OVMNC26bn
        se/5wetqS6v/2uTjfD94CKl8euJF/ro=
X-Google-Smtp-Source: ABdhPJz3EDT2H9Z7jK0hJJzCgQdkW2KGlqZ1BFEfuW3RpIyMNN6NBEN39Q+TxiVxlrXkqd4O88amyA==
X-Received: by 2002:a17:906:c099:: with SMTP id f25mr10319592ejz.141.1615574022517;
        Fri, 12 Mar 2021 10:33:42 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id hd8sm2984675ejc.92.2021.03.12.10.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 10:33:41 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Kevin Willford <Kevin.Willford@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff King <peff@peff.net>
Subject: Re: What to do with fsmonitor-watchman hook and config-based hooks?
References: <CAJoAoZk0fSyPSJZ51wNv4XujPA_-hPfh8eMRQPbyeTXFvKJ9+Q@mail.gmail.com>
 <33a12a7a-d19c-63b8-f21e-db7e517b0f53@gmail.com>
 <YEpxVELGCxtnNxQK@google.com>
 <e019cc71-ac39-44a4-0a23-b3b7decec754@jeffhostetler.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <e019cc71-ac39-44a4-0a23-b3b7decec754@jeffhostetler.com>
Date:   Fri, 12 Mar 2021 19:33:41 +0100
Message-ID: <87h7lgfchm.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 12 2021, Jeff Hostetler wrote:

> On 3/11/21 2:36 PM, Emily Shaffer wrote:
>> On Thu, Mar 11, 2021 at 02:23:03PM -0500, Derrick Stolee wrote:
>>>
>>> On 3/11/2021 1:42 PM, Emily Shaffer wrote:
>>>> Hi folks, I grabbed a bunch of CC from 'git blame fsmonitor.c' so
>>>> sorry if you don't care about fsmonitor-watchman anymore... :) Note
>>>> that this whole conversation has to do with the series proposed at
>>>> https://lore.kernel.org/git/20210311021037.3001235-1-emilyshaffer@google.com.
>>>>
>>>> When I was looking through the remaining hooks in
>>>> Documentation/githooks.txt I noticed that the fsmonitor-watchman hook
>>>> is implemented somewhat differently than most other hooks. As I
>>>> understand it, to use that hook someone needs to:
>>>>
>>>> 1. Configure core.fsmonitor with a path to some fsmonitor-watchman
>>>> hook. The documentation in 'Documentation/githooks.txt' claims that it
>>>> needs to point to '.git/hooks/fsmonitor-watchman' or
>>>> '.git/hooks/fsmonitor-watchmanv2', but I don't see that constraint
>>>> enforced when the config is read (config.c:git_config_get_fsmonitor()
>>>> and fsmonitor.c:query_fsmonitor()), so it seems that core.fsmonitor
>>>> can point to wherever it wants. (Plus
>>>> 'templates/blt/hooks/fsmonitor-watchman.sample' suggests setting
>>>> 'core.fsmonitor' = '.git/hooks/query-watchman'...)
>>>> 2. Configure core.fsmonitorhookversion to 1 or 2, to indicate the arg
>>>> structure for the executable specified in core.fsmonitor.
>>>
>>> This is correct.
>>>
>>>> Because the executable doesn't necessarily live in .git/hooks/,
>>>> fsmonitor.c:query_fsmonitor() completely skips the "API" for running
>>>> hooks (run-command.h:run_hook_le()) and just uses
>>>> run-command.h:capture_command() directly.
>>>>
>>>> Interestingly, this is really similar to the way config-based hooks
>>>> (https://lore.kernel.org/git/20210311021037.3001235-1-emilyshaffer@google.com)
>>>> work - but different enough that I think it may be awkward to
>>>> transition fsmonitor-watchman to work like everything else. So, some
>>>> questions, plus a proposal:
>>>
>>> You'll want to get Jeff Hostetler's perspective first, but I'm of
>>> the opinion that we'll want to stop recommending the Watchman hook
>>> when the Git-native FS Monitor feature lands, with some time to
>>> let things release and simmer before we remove the core.fsmonitor
>>> config option. We would also need a Linux implementation, but that
>>> is planned.
>>>
>>> If we think that the plan of "eventually, FS Monitor won't use hooks"
>>> is reasonable, then how much do you want to spend time unifying it
>>> with your config-based hooks? Can they live together temporarily?
>> Oh, that's useful context. If fsmonitor-watchman hook is going away,
>> I
>> don't think it's necessary to convert it at all, unless someone starts
>> asking for multihooks or something. There's no practical conflict between
>> config-based hooks and the current implementation - it's just a
>> surprising inconsistency. I'll be curious to hear Jeff's opinion, of
>> course, but given what you're describing, I'm not convinced it's worth
>> spending any time on - and when we're ready to stop checking
>> core.fsmonitor then the inconsistency will just go away.
>> The documentation in githooks.txt could use an update, though. :)
>>   - Emily
>> 
>
> I don't think it makes sense to have multiple fsmonitors for a given
> working directory.  They are fairly expensive to operate (listening
> to the kernel for events and building an in-memory database of changed
> files) and I'm not sure how two running concurrently (and listening to
> the same kernel event stream) would come up with different answers.
>
> The thing about the fsmonitor-watchman or query-watchman hook is that
> it is a bash/perl script that talks to a long-running service daemon.
> The hook script itself is just a proxy to decode the JSON response from
> Watchman and emit it on stdout in a way that the foreground Git command
> expects.  Git cannot directly talk to Watchman because it doesn't
> currently have the plumbing to talk to it on anything other than a fd
> pair that it sets up to give to the hook child.
>
> So your example of a watcher for NTFS and a separate watcher for ext4
> means you could maybe have two services running, but the foreground
> Git command would only need to spawn a single hook and maybe it would
> decide which service to talk to based upon the filesystem type of the
> working directory.  Or you set the repo-local config for each repo to
> point to a hook script that knew which service to talk to.  Either way
> you only need to invoke one hook.
>
> Setting it globally is an option, but fsmonitor is beneficial for large
> repos and working directories.  There is an overhead to having it
> running and talking to it.  (Spawning a hook written in PERL, having
> the hook talk to Watchman via some form of IPC, the hook parsing the
> mess of JSON returned, pumping that data back over stdout to Git, and
> having Git apply the results to the ce_flags.)  All of that has to
> happen *before* Git actually starts to do anything useful.  For small
> repos, all of that overhead costs more than the cost of letting the
> foreground `git status` just lstat() everything.  Of course all of this
> depends on the speed of your filesystem and the size of your working
> directory (and whether you have a sparse-checkout and etc), but there
> are lots of repos that just don't need fsmonitor.
>
> So yes, I would leave the existing fsmonitor code as is and not try
> to combine it with your current efforts (even if I wasn't working on
> a replacement for the fsmonitor-watchman setup).
>
> As Stolee mentioned I'm currently working on a builtin fsmonitor
> feature.  It will have a native coded-in-Git-C-code daemon to watch
> the filesystem.  Clients, such as `git status`, will directly talk
> to it via my "Simple IPC" patch series and completely bypass all of
> the hook stuff.
>
> Long term both fsmonitor solutions can co-exist.  Or we can eventually
> deprecate the hook version.  Given that, I don't see a need to change
> the existing fsmonitor hook code.

I'm all for built-in watchman, but this claim about Perl etc. being the
slow part and the hook parsing etc. just doesn't add up with performance
testing I've done on it.

See numbers at:
https://lore.kernel.org/git/CACBZZX6D8oC34qat7kdrDOWC5eYm-DRkMWG9eOPPvKKsQtgPyw@mail.gmail.com/#t

I don't have this re-paged into my memory, but I remember the invoking
of watchman etc. being trivially cheap, the cost was taking the
information from the hook, updating git's view of the world (index
etc.), and spewing out info for the user.

It was something like "git status" taking 500ms, invoking the watchman
binary (talking to the daemon) would take 2-5ms, the whole Perl
etc. parsing another mfew ms, and the rest of "git status" 10x that time
at least...

