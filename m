Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22CDC4332F
	for <git@archiver.kernel.org>; Sat, 17 Dec 2022 16:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiLQQHa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 11:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiLQQH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 11:07:28 -0500
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FC82ADE
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 08:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1671293233; bh=FIavMF6GYxAc7HgaaOIjsgZjwYek6TZM1GboGbxp3bE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=UFcD1qHrBnRy6DE1fhPmHehlhwOot6TfKtT0bjfbSowHDEVzFQiZbNOlVoGL/RBmT
         u9/3SeQtj5qGx7OfwO0xsh+cHuVQWII29CKCGhf4hhQIFDnEGxoP8Sys7oBExu/BX7
         8yoaq/fy/TaNpKxLFyoyNegqygbk5dlJUaAVCa+sLKLR/mXvLwx4pr92voGl8G3rwO
         lk8vE0kJouOzx5TZDR6RUlTRB52Y1CXWQqCOY3sbwzMu1ZlpizXw0/D0mixGL/nurU
         gqw3QP3s0T970xQwScA4tu7ibu5QoLwM8/eAndGo6QBbGCyvsYgb0w71ljzCU8ImMq
         Mb6XcC6EMT8zg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.151.35]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MnpGi-1oZxyl0kbC-00pUox; Sat, 17
 Dec 2022 17:07:13 +0100
Message-ID: <91c5120d-bbd4-8aa5-a205-d1f5387a7f19@web.de>
Date:   Sat, 17 Dec 2022 17:07:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH] am: don't pass strvec to apply_parse_options()
Content-Language: en-US
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <baf93e4a-7f05-857c-e551-09675496c03c@web.de>
 <221213.86mt7r4ru2.gmgdl@evledraar.gmail.com>
 <2d0d77a4-f6ac-1fa7-bddb-9083579d8dd7@web.de>
 <Y53DAoJ4eK01rEji@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <Y53DAoJ4eK01rEji@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rbiMKGj3ucgsoe3ieufqowJnz2Q4jJWcHOlZzHu0FKPSYdkNgSp
 mh7AH3t2meatbK1QVtVx5/pSoexbZMAVVZovCkoq9cmJhA+qX2pOdB/Kiq25KQJNvxuhQfO
 M9/Heyt1+XQITrmCUAUvZaaqB2BzkEr3aiE+cSR0TU3RPTmpdNbMNjBIk9FfWfsMcNr8iQ7
 Up0qE3TJXzxb6BA3LkxGw==
UI-OutboundReport: notjunk:1;M01:P0:wS57fUxoWGo=;u8ZZywqcp4JPnkaK9Ou9S4VO4yI
 q6NNwGRqVvJEUSwsR/PxjSqSYJEG8CNpIJw6b+hqgZC9WqfwUxsxg8gVLbah19hc+NGygGhnY
 JZcSDAaXWQDv9QkNCWldb0nF05/pWTrGbNmvGi2G2gv5u+Bojr1Ku2bd3GLoKPi18o+u/XTBV
 fVTWCUceRZm+GcwKnBQ74JWY9CVofoPtsYr6kJ5f/V5A3I9OAnFy4CQ6GO2MMq77y4wygsMr+
 Ek4Yj1uHz3D/UoOKjkBtlZ/HWUFNyMUtK2PgwLeZswGqbjzUwnpkZwogwJiTLMoDuNrB2yyky
 T/cKgqnLlIptpUeH0qrKCRa7NxSEYwfrLL1xMornFgh8tIV1Waz76QM/8lnSnLZ29h6lpSxh6
 BlK+QZVTAG+noh3cddErUN4FENEy3yl27DuFjIxWUDhGppNXcUqZhhvljzpXc6HgqcwTYwY8U
 BQm18rKvx8M72oipoAAz9dLWX3hOP/TylFhnFmoRlCGME0l5INeR2DRLD48dKirqWJM2w2pQf
 cqEbzRL0VQdzrObKbE7pZy3heIcVp1VrXLdcYseXwgc5LuhbxdMHC2B4zGk7iImzjQqRr+eE4
 wYhWUzclafT3dND+V63N2N/TKeKj4ZtcYvGqIohNMNrlPfpCWIFjR92Ch8r+/MBZNnimTrs8M
 R1IAg+LR2Wwl/2c/u8/wKJKb4y9gYSCHWYI2MdpQi7wRVHMZPE4uHgMXAudPDTIZDrwaRIeID
 JNpkYBH+46sRbWg5E6zuPF2hgenMNJAkb11vOBkOiF+nn4uApwjcr1zNr4yo2c1NRa4G8MpqG
 X/lg5Lr2kbkJyn1gdMEPhg5U+6zJ+YBGGIk6tB2J+l/6rMblS+7EjRfU2ekgSZjS/e04CGmwZ
 EJtIgwBKa2aX9IdEmdfSQ8mYvBtFdX0vNlV2RNXArsmtqnveMDKQCYDIHHqqYTksDZiWGEo3F
 SlZOUw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.12.22 um 14:24 schrieb Jeff King:
> On Tue, Dec 13, 2022 at 07:31:13PM +0100, Ren=C3=A9 Scharfe wrote:
>
>>> I think less of a hack is to teach the eventual parse_options() that
>>> when it munges it it should free() it. I did that for the revisions AP=
I
>>> in f92dbdbc6a8 (revisions API: don't leak memory on argv elements that
>>> need free()-ing, 2022-08-02).
>>>
>>> What do you think?
>>
>> Generating string lists and then parsing them is weird.  When calls hav=
e
>> to cross a process boundary then we have no choice, but in-process we
>> shouldn't have to lower our request to an intermediate text format.  gi=
t
>> am does it anyway because it writes its options to a file and reads the=
m
>> back when it resumes with --continue, IIUC.
>
> The argument has been made[1] in the past that the public API for the
> revision machinery is not poking bits in the rev_info struct yourself,
> but passing the appropriate options to setup_revisions().

My point was that we are stuck with the way it's done in git am
specifically because of its on-disk parameter store.  It forces us to
be able to handle a parameter list that we allocate ourselves instead
of being given one by the OS like argc/argv in main().  And this
justifies a bespoke solution instead of changing parse_options().

In the meantime =C3=86var showed enough examples to convince me that a mor=
e
general solution is indeed needed, but I still think we should keep
parse_options() unchanged and add something like strvec_clone_nodup()
instead.

Regarding using textual interfaces internally in general: It's the
easiest method, as we have to provide it for users anyway.  It's not
simple, though -- generating strings and managing their ownership adds
overhead like this patch, which we wouldn't have in an struct
interface.

> And I can see the point; if option "--foo" requires twiddling both
> revs.foo and revs.bar, then we have no way to enforce that callers have
> remembered to do both. But if the only code which handles this is the
> parser for "--foo", then we're OK.

Depends on the specifics.  Perhaps .bar is redundant and could be
inferred from .foo.  Or they could be replaced by an enum.

> In a non-C language, we'd probably mark "foo" and "bar" as private and
> provide a method to enable the option. We could provide a function, but
> we'd have no compiler help to ensure that it was used over fiddling the
> bits. Possibly calling them "foo_private" would be sufficient to make
> people think twice about tweaking them, though.

Or normalize the struct to avoid dependencies between fields.

> [1] Apologies for the passive voice; I didn't want to muddle the
>     paragraph by discussing who and when. But I know this is an argument
>     Junio has made; I don't know if he still stands by it these days
>     (there is quite a lot of field-twiddling of rev_info by now). I'm
>     not sure to what degree I agree with it myself, but I thought it was
>     worth mentioning here.
>
>> If we have to change parse_options() at all then I'd prefer it to not
>> free() anything (to keep it usable with main()'s parameters), but to
>> reorder in a non-destructive way.  That would mean keeping the NULL
>> sentinel where it is, and making sure all callers use only the returned
>> argc to determine which arguments parse_options() didn't recognize.
>
> My findings with -Wunused-parameter show that there are quite a lot of
> places that take argv/argc but assume the NULL-termination of the argv.

Right.

> If we are just re-ordering argv, though, it feels like this could still
> work with a strvec. Right now a strvec with "nr" items will free items 0
> through nr-1, assuming that v[nr] is its NULL invariant. But it could
> free v[nr], too, in case the NULL was swapped into an earlier position.
>
> It's a little weird already, because that swap has violated the
> invariant, so trying to strvec_push() onto it would cause confusing
> results. But if the general use case is to pass the strvec to
> parse_options(), get reordered, and then clear() it, it should work. If
> you wanted to get really fancy, push() et al could double-check the
> invariant and BUG().

Yes, parse_options() and strvec are not fitting perfectly.  Changing the
former to reorder the elements and keeping them all would require
checking that all callers use the return value.  Feels like a lot of work.

A variant that takes a strvec and removes and frees parsed items from it
would be clean, but would require refactoring indirect callers like
apply_parse_options() users.  Busywork.

Making a shallow copy to give to parse_options() in callers that currently
pass a strvec directly or indirectly seems like the simplest solution to
me for now.

Ren=C3=A9
