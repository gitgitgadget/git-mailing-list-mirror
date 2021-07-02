Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCC0C11F68
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 13:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C11D6142C
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 13:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbhGBNpz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 09:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbhGBNpy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 09:45:54 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621FCC0613DE
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 06:43:22 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id i24so13312147edx.4
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 06:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=+3ZVllXyOrnrxQZWz4fJX53SxpFlqcNDBmCGnXqHnog=;
        b=Tq2C8XQVNt2RD+OP0SZiB21wxtR+y/XEWuGZw2jpjebbaU9XAGoIJKjyB9Fx4MHwGH
         oHMq4kUTQQQ6kXDGgni5OTLvrNUWe0h/En37SLirbng3m7jQRkFI8sNlRtnhrYUKMzRh
         82pCdzJ1h55i7c3fRe0PRv5QJNpDFra2RDO51vgsQJEJE1BMAMpNBxg6tL4Jv0nT+RNj
         kbklWxCVs967KTExSbOZ/F1tH1xMbScoSqdunmM4KXEBLdHySce9zB2Px+T+4gcQJ/so
         sOOSeXVbtKA1alzMPv0qiUBjk0Nlli2oTKSjm+3UEtAvOScQfjEXtEvaYIQYekVUQ6dg
         krpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=+3ZVllXyOrnrxQZWz4fJX53SxpFlqcNDBmCGnXqHnog=;
        b=GgcC4uPORkmr4KOn7mQrx9lX3+0MW5czCbA/UnYWV5RnQiEHh2aBozYbx9pCL3gd31
         GEMx95sI0nhmlrojvqrIPOcJdxSJCECu5Gjs9YmagSWH//5DuN+PQVadwQNhyTejJSxc
         PSBfVGbhdNy+qf4Hi6GgZ/R9k1vzDTPNZKWWW9NIvENjV4GduqLhHsNZtdS08jr8XaDg
         YRJpZI8OztySFLjdGPNvZGxiyx8MJDPTxmsS69oorkuM2aYOGAtKdrRBclwTFhSZ4AL5
         WKIp/wUwISf79AZheY8eWRANU+EefAvSNN+I2GNxp9YiKx3uKQrxrJmNbTFSdFkqh3Pn
         0BEg==
X-Gm-Message-State: AOAM533R2fSmZW7pbwoVbiV4JHjjvb/5cLoCh6kUxPC/sXJgyGCc1+c3
        oixDfxWnwVQMkI0LHAcca4k=
X-Google-Smtp-Source: ABdhPJz+NEh9zFpi7OLJKje3RGhVt4VVwjug8eKiPuK291jgYOxnOYnbr8l1h6zc3RM5/hlD+TTk1g==
X-Received: by 2002:a50:c907:: with SMTP id o7mr6800571edh.120.1625233400955;
        Fri, 02 Jul 2021 06:43:20 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id s10sm28295ejc.39.2021.07.02.06.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 06:43:20 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'martin' <test2@mfriebe.de>,
        'Felipe Contreras' <felipe.contreras@gmail.com>,
        'Andreas Schwab' <schwab@linux-m68k.org>, git@vger.kernel.org,
        'Junio C Hamano' <gitster@pobox.com>
Subject: Re: [PATCH 5/5] config: add default aliases
Date:   Fri, 02 Jul 2021 15:41:44 +0200
References: <20210702100506.1422429-1-felipe.contreras@gmail.com>
 <20210702100506.1422429-6-felipe.contreras@gmail.com>
 <871r8hauvi.fsf@igel.home> <60dee7d4e27bf_2964b20817@natae.notmuch>
 <65b1d215-c3ab-e0e3-f4ac-a30131541f9b@mfriebe.de>
 <60def07e686c7_7442083a@natae.notmuch>
 <3e82a574-fdcc-08b8-8fb5-1ff15f8ae564@mfriebe.de>
 <03a401d76f45$e1c6fce0$a554f6a0$@nexbridge.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <03a401d76f45$e1c6fce0$a554f6a0$@nexbridge.com>
Message-ID: <874kdcal1k.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 02 2021, Randall S. Becker wrote:

> On July 2, 2021 7:15 AM, martin wrote:
>>On 02/07/2021 12:54, Felipe Contreras wrote:
>>> martin wrote:
>>>> IMHO it would be good to (partly) follow other vcs, and have commit =
>>>> ci
>>> I'm fine with leaving co out of the default aliases if it's deemed
>>> "too controversial".
>>>
>>> But ci doesn't make sense. ci comes from "check in" which has no
>>> similitude in git.
>>svn uses it for "commit".
>>It can be seen as CommIt.
>>
>>But of course other letters can be picked. I don't see an advantage in it though.
>>Like CoMmit cm ? or CommiT ct ? None of them seems any better to me.
>>
>>> I don't think it's a good idea to leave "git checkout" without an
>>> alias (it's perhaps the second or third most used command), but at
>>> least some aliases are better than no aliases.
>>Well, that goes back to a bigger question. And from the brief time I have been on this mail list, it appears to me there is a divide into 2
>>groups.
>>
>>If checkout is really meant to give way to switch/restore then it needs no further advertising. And then the current usage statistics are a
>>relict from the before switch/restore time.
>>
>>If on the other hand checkout is not just to be kept for backward compatibility, but should always remain an equal alternative to
>>switch/restore (i.e. it should still be taught to new user in 20 years) then it wants to have a default alias.
>
> In my opinion, default aliases are not a good path. If a command is
> intended to be part of the git command set, then it should be a
> builtin not an alias. Users have their own alias setups and implied
> conflicts are just going to be confusing and end up in help, examples,
> presentations, and so forth.

So aside from the "are these aliases good idea?" discussion, would you
prefer if they're implemented that we theat them the exact same way we
do "git fsck-objects" and "git fsck"? I.e. list them twice in git.c,
just pointing to the same cmd_fsck?
