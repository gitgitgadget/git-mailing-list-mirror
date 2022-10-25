Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377ABC38A2D
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 20:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbiJYUCK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 16:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJYUCI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 16:02:08 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14527119BF0
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 13:02:07 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id sc25so15514224ejc.12
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 13:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ILoFiiWwWmpgLtI2DZbdDXpZzD9wNv9OQhEiBdgmZzg=;
        b=TiG1XyjL20aATqx3OriG7VZ7WfzfQrPSFPK4kGhakz0jNubiLnBrArsOu8vSjRzaGd
         LSnxil9E0w6nvnTXTZcH6EAZPjEsoQ7/Avpz7HjFDn/R0hgUoMm4VbrWR0SCHUVN5A0w
         8FsdDtjo0xMyZS7paShcaymxHgxnKDaNg4X+gpnq5myFkjAsehvd5pDklr1bpQaa2pmx
         W+WfBPlpQcnKbIOqACWSCdUeJnTfIOIOylhDBqfSpCalus76vvxAlALGwk8xiOYEoPmy
         lZuI3rfh6rVfHK4hP907LI0cGYa0MNrCQItPIQ/C9gp1mDJk0GjXvLfeTvhLVm6Ukj9z
         mavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILoFiiWwWmpgLtI2DZbdDXpZzD9wNv9OQhEiBdgmZzg=;
        b=5YOiENgeYoTGLVBb7W2aCbcm3avUzYkf4cjKKVA1KK8SzYbPX9SKaWvgU/3xUbeFCW
         S6bzEWgibluzYbdMyao9NR/MC0OOa8+lJv6maN4SeLfjTwiXhSyOYSyfr9jyj2b31ruU
         z39ZC8Xz1zK3p34tGx0sMo8ldv9kXSfrFKFx/Uw5g2SeVdkBcNbrUOpCFyCvV9Gaa8f9
         DfxkB1TG5daJ8Q7TYz58jLeup+Rm63yJRIMUyNyPGFHUS2MggE2cW8830aQyNJ5dtNSe
         JMc7NL8ckAT1YGWr8k7wHL5Zsr283M7XAdMm4sNdn61ksjdOZAzgFVNSuYC4YzZ7/7Y4
         Efaw==
X-Gm-Message-State: ACrzQf0rPLjpxHU64o5TfhMCvHHouIuViDDMIMXMjYuYYzn2iKrNlPX7
        mPOnWxt1lF5maFSIp7u8wAYanTWecbs=
X-Google-Smtp-Source: AMsMyM6KyOczd80LKkBc8oAPiP3dEGIlitXPpZcR8irC2f+WE9r3l/aAftp5KdqwQkPIILxLBDNU8w==
X-Received: by 2002:a17:907:75e6:b0:7a1:848:20cb with SMTP id jz6-20020a17090775e600b007a1084820cbmr16689724ejc.745.1666728124912;
        Tue, 25 Oct 2022 13:02:04 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id sh39-20020a1709076ea700b0073dc8d0eabesm1905595ejc.15.2022.10.25.13.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 13:02:03 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1onQ7e-008DMk-2m;
        Tue, 25 Oct 2022 22:02:02 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com,
        phillip.wood123@gmail.com
Subject: Re: [PATCH v3 2/6] run-command: add hide_output to
 run_processes_parallel_opts
Date:   Tue, 25 Oct 2022 21:32:13 +0200
References: <20221020232532.1128326-3-calvinwan@google.com>
 <221021.86lep9g9ja.gmgdl@evledraar.gmail.com>
 <CAFySSZCFrfhdKuOT=kxqPPBGBD0T2FtD4vJHfa9M3cMAPCSBtA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <CAFySSZCFrfhdKuOT=kxqPPBGBD0T2FtD4vJHfa9M3cMAPCSBtA@mail.gmail.com>
Message-ID: <221025.86fsfbd64l.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 24 2022, Calvin Wan wrote:

>> I may just be missing something, but doesn't "struct child_process"
>> already have e.g. "no_stderr", "no_stdout" etc. that we can use?
>> I.e. isn't this thing equivalent to running:
>>
>>         your-command >/dev/null 2>/dev/null
>>
>> Which is what the non-parallel API already supports.
>>
>> Now, IIRC if you just set that in the "get_next_task" callback it won't
>> work in the parallel API, or you'll block waiting for I/O that'll never
>> come or whatever.
>>
>> But that'll be because the parallel interface currently only suppors a
>> subset of the full "child_process" combination of options, and maybe it
>> doesn't grok this.
>>
>> But if that's the case we should just extend the API to support
>> "no_stdout", "no_stderr" etc., no?
>>
>> I.e. hypothetically the parallel one could support 100% of the "struct
>> child_process" combination of options, we just haven't bothered yet.
>>
>> But I don't see why the parallel API should grow options that we already
>> have in "struct child_process", instead we should set them there, and it
>> should gradually learn to deal with them.
>>
>> I think it's also fine to have some basic sanity checks there, e.g. I
>> could see how for something like this we don't want to support piping
>> only some children to /dev/null but not others, and that it should be
>> all or nothing (maybe it makes state management when we loop over them
>> easier).
>>
>> Or again, maybe I'm missing something...
>
> Shouldn't the options that are set in "child_process" be abstracted away
> from "parallel_processes"?

In general yes, and no :)

Our main interafce should probably be "just set
these in the 'struct child_process' we hand you", but the parallel API
might want to assert certain things about those settings, as some of
them may conflict with its assumptions.

> Setting "no_stdout", "no_stderr", etc. in a
> "child_process" shouldn't imply that we still pass the stdout and stderr to
>  "parallel_processes" and then we send the output to "/dev/null".

Sure, but if they're not producing any output because it's being piped
to /dev/null how worthwhile is it to optimize that?

We still can optimize it, but I still think the interface should just be
the equivalent of:

	parallel -k -j100% 'sleep 0.0$RANDOM && echo {} >/dev/null' ::: {1..100}

Whereas what you seem to be trying to implement is the equivalent of a:

	parallel -u -j100% 'sleep 0.0$RANDOM && echo {} ::: {1..100} >/dev/null

Except as an option to the parallel API, but the end result seems to be
equivalent.

> That being said, I can understand the aversion to adding an option like
> this that doesn't also add support for stdout and stderr. I can remove this
> patch and instead reset the buffer inside of pipe_output and task_finished
> in a later patch

I'm not necessarily opposed to it, just puzzled about it, maybe I don't
have the full picture.

In general I highly recomend looking at whatever GNU parallel is doing,
and seeing if new features in run-command.[ch] can map to that mental
model.

Our API is basically a small subset of its featureset, and I've found it
useful both to steal ideas from there, and to test
assumptions. E.g. "ungroup" is just a straight rip-off of the
"--ungroup" option, it's also had to think about combining various
options we don't have yet (but might want).

In that case the supervisor API/parallel(1) needs to do something
special, but for "I don't want output" it seems best to just do that at
the worker level, i.e. equivalent to piping to /dev/null.

Having a bias towards that approach also makes it easier to convert
things to running in parallel, i.e. you just (mostly) keep your current
"struct child_process", and don't need to find the equivalents in the
parallel API.








