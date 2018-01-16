Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B8CA1F406
	for <e@80x24.org>; Tue, 16 Jan 2018 11:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750892AbeAPLOU (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 06:14:20 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:34449 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbeAPLOT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 06:14:19 -0500
Received: by mail-wm0-f43.google.com with SMTP id 81so16659308wmb.1
        for <git@vger.kernel.org>; Tue, 16 Jan 2018 03:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=NbBdWfpqu/hBshcvfPQZTSoG2Qq/lFJNfMPboWolaao=;
        b=QCbvBBPJ7E18FNBn/NgDPVzoXWVQ+bBwdhFLsc43I2gDmTNiA4LM+74umzLkEwYlwI
         tyRebX9RI77GgbvshezP1+ARSoLsSnj7ZPwzuYFQ4b0iKisCG38jm4Jrx6YehP3lZEL1
         haszxQpV+bCcjiVfnzGJAK3Chp1QNaD/HG0pZONqg4Ow6Z2eLl6WnleUsbNIsp/vzKYy
         OxdpbwR2NF3B3GDJ9mRAbKz1SJFu5ehyXWiM+A8oaJWAJj/fUIYzIi1F6/v6Xy14/1vC
         GxRAaSfxgt2uJMtsmBrIJm9RT+zeyD8pxhe8HXfeh3WXjqF5tD/nJ1hRrQeMcJmJxmZc
         IXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=NbBdWfpqu/hBshcvfPQZTSoG2Qq/lFJNfMPboWolaao=;
        b=seofLr/s2ecNuC1rkmqoEfbEhzJOyFmX8DXl4Si8H7Z4bTry17C7y6rq1xZQrKrSgH
         oDqat1DeCmYitu+4CUMMAOHRbocwtEULgW3YaDSgiMERclVyC1qxkw6YJjN3AlEpP9UV
         nkBlb93iRXK6lm+gKtZEXG0QSQH6WlYh+lCnAnwFA6WcKdy8Gz3d62uLT1MZWyu/aA32
         biJQs3SX6W9sk0coo7KnEr7ZtqhkmOC/MZtYrVNdltyAVVEyvNXhkspMlvyBctFXhOBr
         dXqyNQI1lg4y6Dat/5V6gl4DUMxArckzexdNi0ZyzJLxV0XTFiK1yRsWjvjqZW2B6NgJ
         hwKA==
X-Gm-Message-State: AKwxyte6gTi2xKb1RISj8tRin+vOexvzQ40iumX6wBOARaH+d4bAk8Zr
        pCCzHHBqvsVFj4iYlGg0A6N1GQew
X-Google-Smtp-Source: ACJfBoub0hZi4swDS8qcYEVqfBArW00ZCF2GDgCGkJk0lC8te1l+uU53FU0xFkbGpjL8m4Z2hxJIAQ==
X-Received: by 10.80.175.102 with SMTP id g93mr33602539edd.156.1516101258543;
        Tue, 16 Jan 2018 03:14:18 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id e25sm1474396edj.27.2018.01.16.03.14.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Jan 2018 03:14:17 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Michael Giuffrida <michaelpg@chromium.org>
Cc:     git@vger.kernel.org, Michael Schubert <mschub@elegosoft.com>
Subject: Re: [BUG] git remote prune removes local tags, depending on fetch config
References: <CACi5S_39wNrbfjLfn0xhCY+uewtFN2YmnAcRc86z6pjUTjWPHQ@mail.gmail.com> <87tvvmiqn7.fsf@evledraar.gmail.com> <CACi5S_33F7VVRYiBOQsxgg_ZPOg9ZvhLZ26bStYWiq7n96aeug@mail.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <CACi5S_33F7VVRYiBOQsxgg_ZPOg9ZvhLZ26bStYWiq7n96aeug@mail.gmail.com>
Date:   Tue, 16 Jan 2018 12:14:16 +0100
Message-ID: <87po6ahx87.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 16 2018, Michael Giuffrida jotted:

> Just to confirm, you're talking about the behavior of removing *all*
> tags that aren't found on the remote? (Not just tags that used to be
> on some remote, but have since been removed from that remote.) So,
> with your proposed workflow, you would never create your own tags
> locally, without pushing them to the remote before running `git fetch`
> -- otherwise they would simply be deleted.
>
> It doesn't seem like a useful feature -- you wouldn't expect `git
> fetch --prune` to remove your local branches that you were developing
> on, right?

Yes, I realize this isn't everyone's cup of tea, but it's very useful in
our in-house use-case for git.

We have repos that have tags pushed to them on every deployment, thus
the cumulative set of tags is in the hundreds of thousands.

There's a pruning script that prunes both branches and tags from the
server (and archives them to an archive repo that has every ref ever).

Then we need to push these deletions back to client checkouts. For
branches that's easy, just set fetch.prune=true. For tags I need to
chase down checkouts and do:

    git -C {} config --replace-all remote.origin.fetch "refs/tags/*:refs/tags/*" "^refs/tags/*:refs/tags/*$"

It would be easier to just set fetch.{prune,pruneTags}=true in
/etc/gitconfig, this is on e.g. shared development staging boxes where
you might have a manually cloned checkout in your ~.

Of course it'll wipe away any manually created tag you have, *ideally*
we'd have something like the refs/remotes/ namespace for tags, but that
ship has sailed.

But meanwhile tag pruning is an OK compromise, 99% of our users will
never even think to create a tag (and if they created one manually they
couldn't push it), the advanced users that would know what sort of repo
they're editing and can out-out of the behavior by editing their local
config.

> On Mon, Jan 15, 2018 at 4:38 PM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>>
>> On Mon, Jan 15 2018, Michael Giuffrida jotted:
>>
>>> `git remote prune <name>` should "delete all stale remote-tracking
>>> branches under <name>". I was surprised to discover, after some
>>> troubleshooting, that it also deletes *all* local tags that don't
>>> exist on the remote, if the following refspec is included in the
>>> remote's fetch config:
>>>
>>>     +refs/tags/*:refs/tags/*
>>>
>>> So, if `remote.origin.fetch` is configured to fetch all tags from the
>>> remote, any tags I create locally will be deleted when running `git
>>> remote prune origin`. This is not intuitive [1], nor is is it
>>> explained in the docs [2]. Is this behavior obvious to someone with a
>>> better understanding of Git internals?
>>>
>>> I did find a better way to automatically fetch tags (using tagopt
>>> instead of adding the fetch refspec). However, the refspec doesn't
>>> seem "wrong" in itself; in particular, `git fetch --tags` used to be
>>> considered equivalent to specifying the refspec
>>> "refs/tags/*:refs/tags/*" -- implying that this is a sensible refspec
>>> [3]. So I wouldn't expect it to "break" the behavior of another
>>> command.
>>>
>>> [1] https://stackoverflow.com/q/34687657/1327867
>>> [2] https://git-scm.com/docs/git-remote.html#git-remote-empruneem
>>> [3] https://github.com/git/git/commit/c5a84e92a2fe9e8748e32341c344d7a6c0f52a50
>>
>> These docs are really confusing, but it is working as intended, and
>> really should be re-documented.
>>
>> The `git remote prune` subcommand just ends up piggy-backing on
>> git-fetch, whose behavior is explained here:
>> https://git-scm.com/docs/git-fetch.html#git-fetch---prune
>>
>> It's worked this way since at least v1.8.5.6, maybe at some distant
>> point in the past it only did this for branches when invoked via
>> git-remote as the documentation says.
>>
>> RELATED:
>>
>> I've actually had the reverse problem with this. I want some way to turn
>> this behavior on without explicitly hacking the refspec, so I can do it
>> globally in /etc/gitconfig or in ~/.gitconfig without screwing with the
>> config of each checkout on certain machines.
>>
>> You can set fetch.prune=true, but that only prunes the branches, you
>> need to inject remote.origin.fetch into each checkout, unless I've
>> missed some way of doing this.
>>
>> I wanted to add fetch.pruneTags that would make it as if you had
>> refs/tags/*:refs/tags/* in the fetch spec, but I haven't hacked that up
>> yet, if anyone can see any inherent issue with that plan I'd like to
>> know about it.
