Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA80DC433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 12:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8CF06120D
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 12:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbhJVM10 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 08:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbhJVM1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 08:27:24 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9A1C061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 05:25:06 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id w14so2308971edv.11
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 05:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=9A7Vrv9F9hZyEC6dh61CoUgpYHLziEecIfBBi0AoJgg=;
        b=Zegx0IJDbt/VxjhjVn2eNbd/pdMLmszFX9lrRlTZUemZjOOLyXA6fzRKmwb1pJPhm6
         AQ2spDbL8UikBpSSDZbwc+WUBaRptf1CF1paRzltV3XX94Q3YzHIVLNM8o9aRcHDQXmW
         G1G222GNITJUkjUZuBDgR1X4igT3k2bXPb57bo1YGBelF7dYcyWRHU28qschR8ugbWwW
         TZJjwkx4FtDObnFTRg7oAKcG2ONCudF6/VNxVYvj2EuXiYdeOq3PeKEN8o84RCnFJd6R
         nMLpgZaGe/yvU6xCYiGBwhQ4OssaTQK7h7JYvEO7cXuXOwqLBLwUTI5R5BTizDNJxlBV
         BnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=9A7Vrv9F9hZyEC6dh61CoUgpYHLziEecIfBBi0AoJgg=;
        b=hV1EAEl0cYagwfw/0BtnR+9MeTtgA4f8F685DziDjIqygxc18d8JNokYUFa9kpwiTA
         mSjxDhUhAfrYFe072W4zMianX6DKCzLfIkrfNcCOWfBwYX99VjFGbrl9QTUdGoPAQAYx
         QmEQsk7qmivRAzfhS9yAexL+mSdixNkiTAzh/Ow5eNjD15tcxKFX9z9glWKL4F3aWnHJ
         qFBUylkchs1NO4pMx5eI+G2B9mKelN9itm/dJvQFL1RfOqOf/W+PnwQdG06PW+lNq+Fj
         NWPVQNGjIu9+3c2e3luKrlGMEsY2JT7jUGy9u0eirYDp4uC1T+Ifh5/HZo7WbdpCTUuu
         M/TQ==
X-Gm-Message-State: AOAM530qMgGoBgALFm1j8N4wbXsd7lkHmHeTxlaK9EO2tEY+AMgp225U
        ijpmljxfeVRsWJXz4cWV2W8=
X-Google-Smtp-Source: ABdhPJymeLkuU/j9mG9nR4zHgEkWF8J30iOCAV4JTw30c/X3dmZK1GNn6lUenGt+pt6dy0CwTmk8eQ==
X-Received: by 2002:a17:906:8283:: with SMTP id h3mr15494466ejx.460.1634905503957;
        Fri, 22 Oct 2021 05:25:03 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f3sm3797809ejl.77.2021.10.22.05.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 05:25:03 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mdtba-001C3U-I0;
        Fri, 22 Oct 2021 14:25:02 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kalyan Sriram <kalyan@coderkalyan.com>,
        git <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: Git submodule remove
Date:   Fri, 22 Oct 2021 14:12:11 +0200
References: <0101017ca3e30c39-f111f739-4db7-4c1e-aff2-3ee50f546591-000000@us-west-2.amazonses.com>
 <YXHdaQ98GJiFj0OK@camp.crustytoothpaste.net> <xmqqbl3ihu6l.fsf@gitster.g>
 <CAHd-oW5PfygyNsRWGg4_W2pxR_HbePvguKRf-bK9RtY3cuAX9g@mail.gmail.com>
 <xmqqee8egddw.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <xmqqee8egddw.fsf@gitster.g>
Message-ID: <211022.86lf2ll00x.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 21 2021, Junio C Hamano wrote:

> Matheus Tavares <matheus.bernardino@usp.br> writes:
>
>> On Thu, Oct 21, 2021 at 7:47 PM Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>>>
>>> > On 2021-10-21 at 17:25:38, Kalyan Sriram wrote:
>>> >> Hello,
>>> >>
>>> >> I was curious why git-submodule does not have an `rm` command. Currently
>>> >> I have to manually delete it from .gitmodules, .git/config,
>>> >> .git/modules/, etc. See [0].
>>> >>
>> [...]
>>> I'd imagine that the happy-case implementation should be fairly
>>> straight-forward.  You would:
>>>
>>>  - ensure that the submodule is "absorbed" already;
>>>
>>>  - run "git rm -f" the submodule to remove the gitlink from the index
>>>    and remove the directory from the working tree; and
>>>
>>>  - remove the .gitmodules entry for the submodule.
>>
>> I think "git rm <submodule>" already does these three steps, doesn't it?
>
> Wow, that is a unnerving layering violation, but I suspect it is too
> late to fix it. So perhaps "git submodule rm" would just become a
> synonym for "git rm"?
>
> Thanks.

Why would it be a good thing to change it even if we could? We added
that section with "git submodule add", it makes sense to have it removed
on "git init". The user could have added it manually, but the same goes
for manually added config that "git remote remove" would remove.

If anything I think it would make sense to extend this behavior. E.g. if
we "git rm" a <path> and notice that the <path> was the only thing that
matched a given entry in .gitignore we should remove that entry.

Or e.g. warn if we notice that the non-ext name of the removed file is
the only thing matching non-ext-versions of .gitignore, i.e. to catch
the common case of removing a "foo.c", but leaving a "foo.o" gitignore
entry behind.

See 95c16418f03 (rm: delete .gitmodules entry of submodules removed from
the work tree, 2013-08-06) for the commit that gave "git rm" these
smarts.

I used to think that "git rm" was a bad layering violation, i.e. what's
the point of it over:

    rm foo
    git add foo

And in the early days having it at all is IMO one of the things that
confused a lot of users about git's data model, i.e. they'd re-do their
moves or removals with the "git mv" or "git rm", thinking the SCM cared
about being informed of things like that.

But those commands are worthwhile, because they interact nicely with
other native git features, pathspecs, .gitmodules etc.

FWIW I think one thing that might make the "git submodule" interface
less confusing is to go in the opposite direction, not to add a "git
submodule rm" or whatever, but think about whether we need something
like "git submodule add" at all, i.e. shouldn't that ideally just be
some special-case of "git add" or "git clone"?

I.e. Either you "git clone" to the working tree and it Just Works (adds
.gitmodules and all), or "git add" on a directory with a .git dir in it
will (perhps after asking) shimmy up the relevant submodule scaffolding.
