Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675EFC2B9F7
	for <git@archiver.kernel.org>; Mon, 24 May 2021 23:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B87B6140B
	for <git@archiver.kernel.org>; Mon, 24 May 2021 23:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhEXXhc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 19:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhEXXhb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 19:37:31 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C130BC061574
        for <git@vger.kernel.org>; Mon, 24 May 2021 16:36:01 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id y7so16387050eda.2
        for <git@vger.kernel.org>; Mon, 24 May 2021 16:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=jXPYVYGhiJUpfUOX/QR2NYrzlyeV76UBk1nkWyrCXKg=;
        b=tli+jHRyhi8vG6LXKdqSCbVXU0F2ESXdKrWxJaNd5X3aL7w+rryh8WR9NKkoIuzKaZ
         jRxrnmt/1sQq7hiO//YV6kkg7RJLoBYCmRuDGuhdQTEi6RVdV6+3rmDkgoJpMu7m8ZV6
         hYuQZnWPK06d33IE2q8mzjIK4+LyuV8N8BjUod+BYrabzSOafHx70a1X3aoVMY8Y2Ef2
         BL932+psieK2RbNHccwXu6gMqWF1zMDo/2HwLjHeOc3BflX7Z62ekfFdo7hpU8lR0PMG
         /pHIN/opDyx4G8vF/h+ohdXgjJNaHxUxjjSCjPUzH9Svdgtb30tab3KIqKVk80Hxi45p
         puKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=jXPYVYGhiJUpfUOX/QR2NYrzlyeV76UBk1nkWyrCXKg=;
        b=CxvtbMeG8QfYt0ABqjFLx7ZEk8OSG46ltBbHX1IKJjyFDp7cEABUhdYY3RoTX7JZ0/
         +vLEUtxMvOObEm6iRuFvZjZ+hIJ3EGXDZgUiz0QZqyy4LzdSoKXXwd0980z3Zg4ImqKO
         y7+R1SrWXtNFmOFwurQNdImecE8FK3hsXI0EGRfvZD749fERKZppR8Tv0bjI9oGD3v1d
         XUV7WLDtorQSrk84VD/eo1JgejeLfIQx8sMJIILFwWqvVLY35egC0IVJAbAcICta+qL8
         JUmE+yZOY6vtJfBG8sRyGTBfwLp1S9r4M/aPGgYsz4Ulf5rq9ZkFRag10DBtyWqCmXEn
         kBww==
X-Gm-Message-State: AOAM533Zv0U0AoOc/K1Djl/ucmMZaFmobGuLWB/bDEJduU9uxG5Wsee2
        7//A4yK/gGp00YKyeLIt5Zk=
X-Google-Smtp-Source: ABdhPJx462XKFHbZarBIqQAUJQGSK0j2/s3+6F1fOAyszDbuT04jH25tJpn9TFyllqEyEdnNtiTSKA==
X-Received: by 2002:aa7:ce91:: with SMTP id y17mr27966217edv.83.1621899360324;
        Mon, 24 May 2021 16:36:00 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id j4sm7135608edq.13.2021.05.24.16.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 16:35:59 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2] tr2: log parent process name
Date:   Tue, 25 May 2021 01:33:27 +0200
References: <20210520210546.4129620-1-emilyshaffer@google.com>
 <1e3bb53e-895b-f571-1c03-a6ae6499746d@jeffhostetler.com>
 <YKgSc5OgVOt6HQqW@google.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YKgSc5OgVOt6HQqW@google.com>
Message-ID: <877djnogbk.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 21 2021, Emily Shaffer wrote:

> On Fri, May 21, 2021 at 03:15:16PM -0400, Jeff Hostetler wrote:
>> On 5/20/21 5:05 PM, Emily Shaffer wrote:
>> > - I took a look at Jeff H's advice on using a "data_json" event to log
>> >    this and decided it would be a little more flexible to add a new event
>> >    instead. If we want, it'd be feasible to then shoehorn the GfW parent
>> >    tree stuff into this new event too. Doing it this way is definitely
>> >    easier to parse for Google's trace analysis system (which for now
>> >    completely skips "data_json" as it's polymorphic), and also - I think
>> >    - means that we can add more fields later on if we need to (thread
>> >    info, different fields than just /proc/n/comm like exec path, argv,
>> >    whatever).
>> 
>> I could argue both sides of this, so I guess it is fine either way.
>> 
>> In GFW I log a array of argv[0] strings in a generic "data_json" event.
>> I could also log additional "data_json" events with more structured
>> data if needed.
>> 
>> On the other hand, you're proposing a "cmd_ancestry" event with a
>> single array of strings.  You would have to expand the call signature
>> of the trace2_cmd_ancestry() API to add additional data and inside
>> tr2_tgt_event.c add additional fields to the JSON being composed.
>> 
>> So both are about equal.
>> 
>> (I'll avoid the temptation to make a snarky comment about fixing
>> your post processing. :-) :-) :-) )
>
> ;P
>
> (I don't have much to add - this is an accurate summary of what I
> thought about, too. Thanks for writing it out.)
>
>> 
>> It really doesn't matter one way or the other.
>> 
>> > - Jonathan N also pointed out to me that /proc/n/comm exists, and logs
>> >    the "command name" - excluding argv, excluding path, etc. It seems
>> 
>> So you're trying to log argv[0] of the process and not the full
>> command line.  That's what I'm doing.
>
> It's close to argv[0], yeah. POSIX docs indicate it might be truncated
> in a way that argv[0] hasn't been, but it also doesn't include the
> leading path (as far as I've seen). For example, a long-running helper
> script I use with mutt, right now (gaffing on line length in email to
> help with argv clarity, sorry):
>
>   $ ps aux | grep mutt
>   emilysh+ 4119883 0.0 0.0 6892 3600 pts/6 S+ 12:44 0:00 /bin/bash
> /usr/local/google/home/emilyshaffer/dotfiles/open-vim-in-new-split.sh
> /var/tmp/mutt-podkayne-413244-1263002-7433772284891386689
>   # comm is truncated to 15ch, except apparently in the cases of some
>   # kernel worker processes I saw with much longer names?
>   $ cat /proc/4119883/comm
>   open-vim-in-new
>   # exe is a link to the executable, which means bash as this is a
>   # script
>   $ ls -lha /proc/4119883/exe
>   lrwxrwxrwx 1 emilyshaffer primarygroup 0 May 21 12:44
>   /proc/4119883/exe -> /usr/bin/bash
>   # cmdline has the whole argv, separated on NUL so it runs together in
>   # editor
>   $ cat /proc/4119883/cmdline
>   /bin/bash/usr/local/google/home/emilyshaffer/dotfiles/open-vim-in-new-split.sh/var/tmp/mutt-podkayne-413244-1263002-7433772284891386689
>
> Jonathan N pointed out that the process name (the thing in 'comm') can
> also be manually manipulated by the process itself, and 'man procfs'
> also talks about 'PR_SET_NAME' and 'PR_GET_NAME' operations in
> 'prctl()', so that tracks. (It doesn't look like we can use prctl() to
> find out the names of processes besides the current process, though, so
> the procfs stuff is still needed. Dang.)
>
>> 
>> >    like this is a little more safe about excluding personal information
>> >    from the traces which take the form of "myscript.sh
>> >    --password=hunter2", but would still be worrisome for something like
>> >    "mysupersecretproject.sh". I'm not sure whether that means we still
>> >    want to guard it with a config flag, though.
>> 
>> You might check whether you get the name of the script or just get
>> a lot of entries with just "/usr/bin/bash".
>
> See above :)
>
>> There's lots of PII in the data stream to worry about.
>> The name of the command is just one aspect, but I digress.
>
> Yes, that's what we've noticed too, so a process name isn't worrying us
> that much more.
>
>> 
>> > - I also added a lot to the commit message; hopefully it's not too
>> >    rambly, but I hoped to explain why just setting GIT_TRACE2_PARENT_SID
>> >    wasn't going to cut it.
>> > - As for testing, I followed the lead of GfW's parentage info - "this
>> >    isn't portable so writing tests for it will suck, just scrub it from
>> >    the tests". Maybe it makes sense to do some more
>> >    platform-specific-ness in the test suite instead? I wasn't sure.
>> 
>> yeah, that's probably best.  Unless you can tokenize it properly
>> so that you can predict the results in a HEREDOC in the test source.
>> 
>> For example, you might try to test tracing a command (where a top-level
>> "git foo" (SPACE form) spawns a "git-foo" (DASHED form) and check the
>> output for the child.
>
> Yeah, I had trouble with even deciding when to attempt such a check or
> not.
>> > +	if (reason == TRACE2_PROCESS_INFO_STARTUP)
>> > +	{
>> > +		/*
>> > +		 * NEEDSWORK: we could do the entire ptree in an array instead,
>> > +		 * see compat/win32/trace2_win32_process_info.c.
>> > +		 */
>> > +		char *names[2];
>> > +		names[0] = get_process_name(getppid());
>> > +		names[1] = NULL;
>> 
>> You're only logging 1 parent.  That's fine to get started.
>> 
>> I'm logging IIRC 10 parents on GFW.  That might seem overkill,
>> but there are lots of intermediate parents that hide what is
>> happening.  For example, a "git push" might spawn "git remote-https"
>> which spawns "git-remote-https" which spawn "git send-pack" which
>> spawns "git pack-objects".
>> 
>> And that doesn't include who called push.
>> 
>> And it's not uncommon to see 2 or 3 "bash" entries in the array
>> because of the bash scripts being run.
>
> Agree. But it's expensive - I didn't find a handy library call to find
> "parent ID of given process ID", so I think we'd have to manipulate
> procfs; and so far I only see parent ID in summary infos like
> /proc/n/status or /proc/n/stat, which contain lots of other info too and
> would need parsing.

It sounds a bit like you're fumbling your way towards (re?)discovering:

    pstree -s <pid>

You can look at its implementation (or strace it) to see what it does,
and yes, on Linux there's no handy C library for this, iterating over
procfs is the library.

Aside from the privacy, PII, usefulness of this data etc. discussions in
this & related threads I don't think that per-se should be an issue on a
modern Linux system. After all we'd just need to do it once on
startup. For any sub-process we spawn we'd carry it forward after the
initial /usr/bin/git invocation.
