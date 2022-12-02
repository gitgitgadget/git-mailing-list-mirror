Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFA3C4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 08:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbiLBIzK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 03:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbiLBIzG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 03:55:06 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F138DFF3
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 00:55:05 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id d14so657234edj.11
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 00:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FsntgtARspmfqTzxx4x/sxk3iKa0sj/FcWhVqe20EhA=;
        b=eUkFvMeIMSM5JUYZ2euFxSdqVeumoFpShMxAoxyUoPcgYoPWLtRVm4mw9o8MrGIZTY
         XuUmFUuwQ3WghXTYDlsPhGI5EG7g2YwCveh4AcTLb9jFJzp6/87msdEPiX4YPKbqqKy+
         mtVz+ef9AvwqnDp/LnfxiBClsaajPpHypAYCpZr1ZhgOnmmn52Jm4iVY413WKDhy0Bfx
         2/+20hs1gufI+2i9eOx+Lffg28SomEHvxZ8guMbraFotYGjLTsYfOxAHeB1pVhjfXFGq
         6XnEP2QdbNxzGWYihsD5XkK2wAoWMqDhcT6iVUm/mXZG+7/yifJQELVRf0Kjej0pfTZB
         KOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FsntgtARspmfqTzxx4x/sxk3iKa0sj/FcWhVqe20EhA=;
        b=j3MMW/xZJDLbOELBiiXC7TqVKwhiTCoQBTR4PGkc4g49HTGMC/eIzZImsvgfWLQA8X
         KJKMt/xo1DkXNxhsh9SoeKH1LVBydJWftH2g1uH5/bBAoiaHBAspnmUXAeB2VvGMcJoZ
         jLUp+T234s+L1BC4GZ6vzPwaaO+xK4HqacWbNe4mAJkieiNctkrjXvaESZlLCzuu7M3g
         bs3hGVZuUmeqGuVtxbXuLIZUOsCSBd+HuYhNM1wCjXEwmPAxUk4DAMvd3YlavI0nEQJK
         92sPozJKdwTdC5pEcgZRUjDxf2iH8r8F3l5OHM7uEeelCmDbi3Rpg3U5PTtgWgewhsmZ
         QgsQ==
X-Gm-Message-State: ANoB5pm3/YqybYgpOL4ATut+iGuwvTVltx+X8Zv4zGGgfNG+o93ThCe1
        lC1K8cbEnVsRuMJxXN8gk6U=
X-Google-Smtp-Source: AA0mqf7KhdqJj/paTAqF5FBI/naLemXWk5Ru7prYKZNcCuOxB5sgE14NEpCaQkKKMkVrsszERpZgzg==
X-Received: by 2002:aa7:cc12:0:b0:462:79ec:55eb with SMTP id q18-20020aa7cc12000000b0046279ec55ebmr61861899edt.151.1669971304146;
        Fri, 02 Dec 2022 00:55:04 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id k2-20020a170906680200b0077077c62cadsm2743468ejr.31.2022.12.02.00.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 00:55:03 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p11p0-002YAo-05;
        Fri, 02 Dec 2022 09:55:02 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 1/8] log tests: don't use "exit 1" outside a sub-shell
Date:   Fri, 02 Dec 2022 03:45:55 +0100
References: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
 <patch-v2-1.8-7c9f8d2830f-20221202T000227Z-avarab@gmail.com>
 <CAPig+cQK8BRU0u0g+jAkyJaqSamYBynJ6s00_6H2beb6gXaRDA@mail.gmail.com>
 <xmqqwn7apodp.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <xmqqwn7apodp.fsf@gitster.g>
Message-ID: <221202.865yeugp7e.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 02 2022, Junio C Hamano wrote:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>>>                 git show -s --pretty=oneline "$r" >raw &&
>>> -               cat raw | lf_to_nul || exit 1
>>> +               cat raw | lf_to_nul || return 1
>>>         done >expect &&
>>
>> Using `return 1` here is "obviously correct" since this code is not
>> inside a subshell. Furthermore, the exit code of the for-loop itself
>> is not being lost down a pipe, so `return 1` is indeed an appropriate
>> way to signal failure. Good.
>
> "return 1" is obvious and safe correction.  I have to wonder if
> test_expect_success can be taught to be smarter to intercept "exit"
> so we do not have to bo so careful, but that would be a much more
> involved change to the lower-level of test framework.

I can't think of a way to do so that wouldn't involve running the test
in a sub-shell, which I think would bring us to the state management
problems noted in [1] for Phillip's "test_todo" series, except in this
case we'd have those issues trying to pass state back from the
"test_expect_success".

It's possible, but we'd need to change a lot of code that's expecting to
talk to itself via variables in the same shell to use IPC between
shells, wouldn't we?

1. https://lore.kernel.org/git/221006.86v8owr986.gmgdl@evledraar.gmail.com/
