Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0D9C433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 02:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbhKWCax (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 21:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbhKWCax (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 21:30:53 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE334C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 18:27:45 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id l25so68510995eda.11
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 18:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=HR9wQ76lZRDMGBqRMqlbUmMh/II8UU2wN+1qH3zSoQA=;
        b=Z/AWrM3ryqH+SlW3bIYKysH3M9VOBY0YjSncX5a54WDCa/+NCCXsReLrlpl3JhiKf8
         BZw6dcbx+EN8xHR75SAgUcs5+RP8GMkCyttP+sZmeERcG8dEUR4Aw867DSM4SDK0mwsW
         J67zcDrUpl6C8Uc+TBHv0Ipzvv/b1927q4LGQ0f+L5yFjFOybbbdO8jwmfumfItl2r3h
         hPpWz/dK8PMjxNz9Dpi1t4Z+Wc3ai37iPKRQrdXKtv/FVvbBAkweW+DFy59ml9f22O2Z
         tvzS6tBmhgYgGtS5s9e7ZnUiTXvOe8JNE0IdIXqM8p9eEz1jRl62mNJhepHdMoZ+YXYC
         wiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=HR9wQ76lZRDMGBqRMqlbUmMh/II8UU2wN+1qH3zSoQA=;
        b=RaLXZfpOsVem0SXt1alEnxpWnPox1oRZV3iZvQY2w1E5Nxn9854zGuNz0IEUQG7wSp
         uj6GfWsNgxMEHMxSf7UOcZANCRc4XkXOAIJUQydYG3ylGlOrvjDAWz5Z0yp2OldQwjxQ
         cLCWnC+MRXjqV7shHKBdRvNhuO3inqh5swZ3vwXL/gruMKCrkAaH900fQ1gwWyI2kPDC
         UpjqLaHpngAHFaNKGWeQDgz+z6yV9hAUv+MCSBrDX1KO7yrOUTf8cseL8vlMTw5yMG6y
         ehJxrRM37oV6DT4hvCY3UZu9+7P9fy3ZpIWSLVx7aHno57W6IV2+kkMo7ufkOaOY24w+
         OcQQ==
X-Gm-Message-State: AOAM533MutqbJ6G3ucs+JYkl67N2PQgeihkAE59fwoufC8ZuaV9Atpdq
        1X+8DrX/Mwzsd+5N0YUO9GJGRH9x8eXoPw==
X-Google-Smtp-Source: ABdhPJzxLAtofuU1qWWo2Bp8w+4lODAbbD9+TBbkN0ODrOzvIYLBWPWafEbLTjau/OTnSe5e4cdS6Q==
X-Received: by 2002:a05:6402:50ca:: with SMTP id h10mr3302064edb.70.1637634464416;
        Mon, 22 Nov 2021 18:27:44 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gs17sm4460413ejc.28.2021.11.22.18.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 18:27:44 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mpLX5-001HZ0-IP;
        Tue, 23 Nov 2021 03:27:43 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Glen Choo <chooglen@google.com>
Subject: Re: [PATCH 1/8] t2501: add various tests for removing the current
 working directory
Date:   Tue, 23 Nov 2021 03:19:47 +0100
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
 <0b71996a3b462d4147fb792b20057544b9ef1710.1637455620.git.gitgitgadget@gmail.com>
 <211121.867dd11jbl.gmgdl@evledraar.gmail.com>
 <CABPp-BEp3OL7F2J_LzqtC-x-8pBUPO8ZR1fTx_6XbqZeOH1kRw@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <CABPp-BEp3OL7F2J_LzqtC-x-8pBUPO8ZR1fTx_6XbqZeOH1kRw@mail.gmail.com>
Message-ID: <211123.86czmrwqqo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 22 2021, Elijah Newren wrote:

> On Sun, Nov 21, 2021 at 9:59 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>> On Sun, Nov 21 2021, Elijah Newren via GitGitGadget wrote:
>>
>> > From: Elijah Newren <newren@gmail.com>
>>
>> > +test_expect_failure 'checkout fails if cwd needs to be removed' '
>> > +     git checkout foo/bar/baz &&
>> > +     test_when_finished "git clean -fdx" &&
>> > +
>> > +     mkdir dirORfile &&
>> > +     (
>> > +             cd dirORfile &&
>> > +
>> > +             test_must_fail git checkout fd_conflict 2>../error &&
>> > +             grep "Refusing to remove the current working directory" =
../error
>> > +     ) &&
>> > +
>> > +     test_path_is_dir dirORfile
>>
>>
>> I'd find this & the rest of this series much easier to understand if we
>> started out by positively asserting the current behavior here, and
>> didn't test_cmp/grep for erro r messages that don't exist anymore.
>
> Yeah, this is my fault for my bad commit message.  I stated I was
> adding tests checking for the problems of interest, making it sound
> like I was testing existing behavior, but I should have stated I was
> adding tests with the behavior we'd prefer to have (i.e. basically a
> test-driven-development) setup.
>
> Also, there really wouldn't need to be so many tests for describing
> the existing behavior.  It's basically just `git
> $OPERATION_THAT_REMOVES_CWD_AS_SIDE_EFFECT` followed by nearly any
> other git command will cause the second and later commands to fail
> with:
>
> ```
> shell-init: error retrieving current directory: getcwd: cannot access
> parent directories: No such file or directory
> fatal: Unable to read current working directory: No such file or directory
> ```
>
> However, we do need a lot of tests for corrected behavior, because
> there are so many different codepaths we can follow which will lead to
> deletion of the current working directory.

Currently if I do e.g.:

    git checkout master
    git clean -dxf
    cd perl
    git checkout v0.99
    cd ../
    git clean -dxfn

Nothing breaks and I don't end up with an empty perl/ to remove. With
these patches we'd either die on the "checkout" (I think) keep the
"perl" and have an empty perl/ to report in the "git clean -dxfn" at the
end (I'm not sure which, I forgot and haven't re-read this series just
now).

I think changing it anyway might be justifiable, but changing the
behavior of things like that tickles my spidey sense a bit. I.e. I can
see people having written scripts like that which would break (it's
often easier to cd around after globbing than staying at the top-level,
then jump back).

So I wonder (especially with Glen's comment in
<20211123003958.3978-1-chooglen@google.com>) if this is being done at
the right API level. E.g. maybe it would be better for some commands to
ease into this with an advise() or warning() and not a die() or error(),
or have the die() be in the likes of "git switch" but not "reset
--hard".

Or maybe not, just food for thought...
