Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83419C00140
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 18:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbiGZSKd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 14:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiGZSKc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 14:10:32 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFE218E1F
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 11:10:30 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z22so18655053edd.6
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 11:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=UpKHxsmrZehxshZkwiFRsQRboAPi5BsAJkHDbOMlsdc=;
        b=gMe70kQBBBctWEzHU2oCNY5Wghw/+6V8IWhSGRNJDzxZLEaBzAY2gONpe+gwS8L6LS
         49iWlwnMETcP/sBh6OhLD6SycoiGHQIYDjPYDVasNeIaRkkaIR2NhGC0LpAevbU+Tt3i
         ptwj5RT5OP0I5g17eSkijANX5ApfuKmQ1kuI5LSUlPvWUa7GzzMRO3UF/wEznRDrzZMM
         XzmjglgLHGw4JFJgJMRVwVe8MDk4Ww3wiGgBs2EhCBB7e9M3S2YlBLlskMcZ9sZ0uHoF
         I6tcLasRT77Z/h8A1ZkKXZja4SmwyT9l3HsCycutoxuoo0hCBB58jjXCyVhOwOqQTQhr
         7d+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=UpKHxsmrZehxshZkwiFRsQRboAPi5BsAJkHDbOMlsdc=;
        b=VetdrtCV8PO8nwNe5V7+WIOa4yJZQx0gjUm6Xm48gws9Qmua397EnNA32yw35wmR9y
         ojw1hLaxy77p1sycBDgZ/rnSl14TyL7JYIcIDvhLBamJ/oXxLRsnDeTTK/bidnizKpru
         DVSeespEnP/k22Udz9HlTzUv/OVrF/w9qdNGVvvsnJ7p1NMHh57iobS78GayrUobE3NY
         ovhyfwwTurzxE1vlqaIRt6hiPyEoqgeJyzZT/4y8Ox/c/2gWmT7/39xqqyNp+a75AmaX
         4Xc9mws9VxmGbcqU0kJJNSe08Jz/iqoypnUeF0A1XEQZhW6iRrfm4K7vFIuBLPAX2EHr
         dhBQ==
X-Gm-Message-State: AJIora89OWYhJddhZzLYs0GvQcNUAV8dU3fdh75SjQsYwB674+vz6Ji8
        iHX8u3ZgE4ANULP/PcwcGFA=
X-Google-Smtp-Source: AGRyM1sckOHQuzXKudKdnRWuKffHuA+UzhI+cEP+IMNDtlank68ToSnq6hW9wU0eiX1J53B8M9Soxw==
X-Received: by 2002:a05:6402:3707:b0:437:61f9:57a9 with SMTP id ek7-20020a056402370700b0043761f957a9mr19142326edb.1.1658859028563;
        Tue, 26 Jul 2022 11:10:28 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id j4-20020a056402238400b0043bdd401cafsm6102641eda.47.2022.07.26.11.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 11:10:28 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oGP0k-006DLY-RE;
        Tue, 26 Jul 2022 20:10:26 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 00/20] parse-options: handle subcommands
Date:   Tue, 26 Jul 2022 20:02:32 +0200
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
 <xmqq5yjl5b4y.fsf@gitster.g> <1p04q351-9938-r0r7-snr6-9s8237s27459@tzk.qr>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <1p04q351-9938-r0r7-snr6-9s8237s27459@tzk.qr>
Message-ID: <220726.86h733n3sd.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 26 2022, Johannes Schindelin wrote:

> Hi Junio,
>
> On Mon, 25 Jul 2022, Junio C Hamano wrote:
>
>> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>>
>> >   - builtin/bisect.c: after the conversion/rename from 'bisect--helper=
',
>> >     cmd_bisect() doesn't use parse-options anymore.  Take what's on 's=
een'
>> >     to resolve the conflict.
>> >     Note that the conflicting topic should have marked cmd_bisect() wi=
th
>> >     the NO_PARSEOPT flag in 'git.c's command list.
>>
>> I was wondering about this one.  Does the new "subcommand" support
>> help implementing the dispatching to subcommands better?  If so it
>> may not be a bad idea to redo the cmd_bisect() on top of this series
>> once it proves to be solid.
>
> The built-in `bisect` code carries around some local state, in a somewhat
> futile attempt to keep things in a state that would be more amenable to
> libifying.
>
> The `subcommand` series does not accommodate for such a local state, the
> signature `typedef int parse_opt_subcommand_fn(int argc, const char
> **argv, const char *prefix);` requires all pre-subcommand options to be
> parsed into global (or file-local, but not function-local) variables.
>
> This implies that moving `cmd_bisect()` on top of the `subcommand` topic
> would require the `bisect` code to become less libifyable, which is an
> undesirable direction.

What are you referring to here specifically?

The commands in the builtin/bisect.c take a "struct bisect_terms", but
as far as I can tell we could simply move setting that up into the
sub-command callbacks.

So cmd_bisect() only needs to parse_options() enough to figure out that
the first argument is e.g. "start", then call bisect_start(), which will
do its own parse_options() & setup of the rest.

But I could see how we'd in general have a need to carry state from the
cmd_name() to the cmd_name_subcmd(). Such a thing doesn't seem like a
big change to SZEDER's patches here, we'd support functions that take a
void *, similar to how we support two types of "callback" in the "struct
option" itself.

Or, you could have perfectly lib-ified code where your
cmd_name_subcmd(int argc, char **argv, char *prefix) would be a one-line
wrapper for another function taking an extra argument.

You'd use a global only to ferry state between the cmd_name() and that
cmd_name_subcmd(), which would be some boilerplate, but it wouldn't be
prohibitive.

When used as a library the API would probably want to take a struct, and
not an argc/argv/prefix. I don't see how having just that part of the
command callback handling needing one global would close the door on
anything else...
