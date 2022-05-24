Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E285C433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 20:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbiEXUaX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 16:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbiEXUaW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 16:30:22 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF74962BDB
        for <git@vger.kernel.org>; Tue, 24 May 2022 13:30:21 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id m20so37626842ejj.10
        for <git@vger.kernel.org>; Tue, 24 May 2022 13:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=qmjML5Foe9pSR9f4gkCpyBLvTEt5FQtsSiwcCH1zqho=;
        b=BS4lrUvbsOIPbw82/S+H9K8D8HiiRQU6XL680uDxfrSfzZs5aMqSJSDR0aayymEkZJ
         /cUVY7qau3UFEEpULfiXJeZ1ddmsWzoO5qY74J31GLEOMu8PMCL3kbUVLUc9vuFIH4wP
         lNW72dqh5YPCp7yaQFtXMxUY7eKmxZUSJxaugpZMsvNVczlHCiOI6ADc4CiM/J9gJoeS
         6Y40iGSyHHPsEUImc0rsJ8PxQYKwO4DBELe/fhsKcfUZl50AtjqT5kTjIMiBiytTu6oI
         A3oMC8iUGnmuUPk6ZGUZqYhbcgSgvyBsMz0GkU1Et0uoEMIXSImlOfB5GmvB4QiHZopz
         tvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=qmjML5Foe9pSR9f4gkCpyBLvTEt5FQtsSiwcCH1zqho=;
        b=VHISml+hLqutQ94bzqDa2fG0NiiaRBGC3hHdIOMDX8u6i+7U/j0nFrCOvBKWGNgFIg
         fm5cM6y72g/ROEUvtBivgUWDj9sahGbEv20FXY3hlOT9AQV4MqAlbFYT9x0VkRi+J2NM
         xBmkoZFYfJonWocouU/t+MF/yKz1Fcmj2CzNAMXdvE99qiWe60d6QS7tV5/kTCNZDEsm
         HAJfMBEKIwd2isdAAhogM3DDEeZ0Np9l0tzvf7kOIZKmV+MIq9rTP8Pwl5GQZ0MRBTRi
         SRbOBxz06GfduvpexgvhffvmztAHRfOezXb9if0LjbejWUVHoWcak23rgj4rRKOVc/yc
         ZiUg==
X-Gm-Message-State: AOAM531BaWtyjJRajfchky0MhBIhVxE+Gx/r2oPr9pXhQBSxNl1SKabG
        E0lByZBhLJX/qayTV0Xs11Tcqbt3xkQ=
X-Google-Smtp-Source: ABdhPJzOA1FIqcB9dmFp5OsjXDNa8LAl5q56ua2lJ0aKaJiPhlx66oONMgzLciS+UZLohACxs17i3Q==
X-Received: by 2002:a17:907:96ab:b0:6ff:127:65a9 with SMTP id hd43-20020a17090796ab00b006ff012765a9mr5413498ejc.603.1653424220083;
        Tue, 24 May 2022 13:30:20 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id jz10-20020a17090775ea00b006f3ef214e0asm7419160ejc.112.2022.05.24.13.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 13:30:19 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1ntbAY-003Yxl-Vj;
        Tue, 24 May 2022 22:30:18 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
Subject: Re: [PATCH] diff: fix a segfault in >2 tree -I<regex> and
 --output=<file>
Date:   Tue, 24 May 2022 22:17:24 +0200
References: <a6a14213-bc82-d6fb-43dd-5a423c40a4f8@web.de>
        <patch-1.1-f7fd645468c-20220523T182954Z-avarab@gmail.com>
        <xmqqleusqaff.fsf@gitster.g>
        <220524.86leurw3my.gmgdl@evledraar.gmail.com>
        <xmqqmtf6hgae.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqmtf6hgae.fsf@gitster.g>
Message-ID: <220524.86v8tuvfl1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 24 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I.e. the "right" thing to do in this case would require a much more
>> involved fix. We've somehow ended up not supporting --output=3D<file>, -I
>> and probably many other options in the combined-diff mode, which both in
>> testing and in this part of the implementation seems to have become an
>> afterthought.
>
> OK, a hopefully final question.
>
> How much less involved is it to add a new code (without doing
> anything in this patch)

...yeah, I think for this one it makes sense to narrowly focus on the
segfault...

> to detect and die on the combination of
> combined-diff with these two options, so that we can document the
> fact that we do not support them?  It would give us much better way
> forward than leaving the command silently ignore and give result
> that is not in line with what was asked, wouldn't it?  That way, the
> much more involved "fix" will turn into a change to add a missing
> feature.

I think not much, it's rather trivial for the case where we invoke "git
diff", I.e. just adding something to the "builtin_diff_combined()"
branch in builtin/diff.c to detect these two cases specifically.

I haven't looked in any depth into how we might reach code in
combine-diff.c through other means, and if any of it can set these two
indirectly somewhere else (i.e. other things that take diff options).

I also wonder if I'm just wrong in my assessment that it's a Bad Thing
that we take some of these without ever doing anything with them in some
modes, e.g.:

	git log --oneline -I foo

This will never do anything with that "-I foo" by definition, but would
as soon as you add -p, should we error without -p (or other diff-showing
options).

The same goes for range-diff, format-patch, --remerge-diff and any
number of other things where we take the full set of options, but only
do something with a limited subset of them.

It is helpful in some cases if we were more anal about it, e.g. when I
was wondering why -I didn't do anything with the combined diff, but also
handy for scripting and one-liners if you can tweak the command-line
back & forth without it being so strict.

So I don't know. Maybe I'm just trying to talk myself out of pulling on
that (bound to be long) thread, but I'm coming more around to this just
being a non-issue beyond the narrow and needed fix for diff_free() in
particular.

I.e. the more general approach of chasing down options that don't do
anything for a given "diff mode". We might still want to error on some
particular ones, such as -I with the combined diff (but not with
--oneline, or whatever).
