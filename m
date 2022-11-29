Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB5DC4332F
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 19:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236703AbiK2TSZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 14:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236689AbiK2TSV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 14:18:21 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5453520198
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 11:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669749485; bh=1H2qr/PWXBlit5j6fw2DEhk0SaYW/dqVoY9wK6VUBPQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=EXA9hbYODbTsD6GxgQEHVLslDCUtNoi3AvfT3Z1YHwldURS63zkfCaHRSPKiWYD0t
         ANbhrhgtEVJLJa5ESDQc24krbvBKoDyJXueO9FT5oxtuXv0Qc29V/RrbYjW0Hqy90t
         2+LoeWAbVkV4O2Jl932zc5GzEbs5GCucVxP1UttfSoBmUVCxGwIt8D4YlfBkmkxP50
         5srkH1uUa3cS2G/YIMwhK8995WOIF3BK/JJYWUw5yQBQM9csjZ8lnKDIxYlv7CyEPn
         1yPBFvjeG2lKxBC5yhQSNBekS7CGnxFwFvit7bVS0NI6NjSZDf4McnOLPslLVL8DAh
         3cfyAKL3xas9w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mx0N5-1oorf42GJH-00yQT2; Tue, 29
 Nov 2022 20:18:05 +0100
Message-ID: <6eaa4178-ad38-c02d-a4c6-7c666cc87bba@web.de>
Date:   Tue, 29 Nov 2022 20:18:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH v2 3/3] Revert "pack-objects: lazily set up "struct
 rev_info", don't leak"
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff King <peff@peff.net>
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
 <d19c6cb4-611f-afea-8a14-5e58d7509113@web.de>
 <f5779e19-813c-cda9-2f84-9fe58f745e89@web.de> <xmqqv8mz5ras.fsf@gitster.g>
 <d10de9b5-e5ff-18d6-d950-1d090d87b113@web.de>
 <221128.864jujmhgp.gmgdl@evledraar.gmail.com>
 <c5aeb93c-763d-3eae-0150-15f6ca675319@web.de>
 <221128.865yezkule.gmgdl@evledraar.gmail.com>
 <59431916-9f55-d0f4-da54-e7369803eb4c@web.de>
 <2488058d-dc59-e8c1-0611-fbcaeb083d73@web.de>
 <221128.86o7sqkjcj.gmgdl@evledraar.gmail.com>
 <0b86ae8b-5523-3857-cdba-12275f727cde@web.de>
 <221129.86fse2ji6c.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <221129.86fse2ji6c.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4AyVFZruQbu8iR/RoktwrRKSXe5dRA3sWy2hNMBeUIJi+Bszh4H
 maxudlT8UkKvsQMgiamwJVZLp25++AgTFzX2n8sGoeujhkFFgcXX4D5QMdR1t692QQhQVM3
 GAa6WLn7dEUOH/BZLSswRG/fYzyedLCn4idH+kN6Ih9w00XBQYVpGKM3QTojtbmO3Glgv/O
 MUyC7VpUa0E/Tnyasp8tw==
UI-OutboundReport: notjunk:1;M01:P0:vHvUTKt79UQ=;roN6zWLK8dIsw4QQfFrK+tzfTei
 3NTLqKOPMAzDGlCOc69ri5cCxcOStsUS6wyNug8hNPpjvpqwv/Bst0HKwESSuNqDG2oTtMCkl
 LlqBJOKsUnrpYFcEwg0aaDSC3Twb2rGZquLX0TQsOKw9lsM/rC8GSzukTZc4eVrdr2gz74lBb
 F7n54MZ6B2WPPgbgPrqd09HBabsEc8Kis9f4xTEdALEJzT85fBRN832Ux9/y3iIX1j/dtR61r
 uqP8Uwr921/TwrTrUOFfAGvwQwrrXRtquKWmFsHedzDHbQ73U0PK+rRlv4lt0+pFYQQd+F45C
 6IN/mh2yXPDuvHru85uLsM0wDPggnAuBximdnnATTXqqsuQKlYPuOLbpgjT8oOrlcf0e1O7lR
 ZmbeJ2+feEJttVCzU2a2rvyZRTjCgXiG8ucFuUxraRu/EZdSwMZZeZncwS/A4tZdz01Z/q/HD
 UNQv96JaJXOoPce4G+qO+Sb30TI0iG4v4JNjUEQY4NF/P23E3ZU5tS1tAQ/7lEM6Kn+r08wHq
 sIM70sNir+RpsleF9zY9ukbyEDVH1nGphMJ14FtHKsG1yQNTqO9IrSx4LlAzFKXdxyfK6BaOQ
 eyUu1LKi91wUF58BdZAYNpvcQo+7zBXfSClxbeCYjNni/KSxgNH0CD8KrcvItzHCChaf3r2I0
 3i+qDw8jDXr0iKYZpb1wGaz+JJVSrvc1xz5iN4UJu/3ydCUcM5XPhkEVCzWkAGhDiQ27DVktF
 j2MgT4uy1YpFHE7bly1nznTCUGfWiYditwf1CBpFiwdGauSl5t0adz9WmR8NV459GV3ZRNrCL
 BvGKmVStn/DKKh6vQofi6Y9MLOO9DXb1CaMCKY7o/HW00g69ULV1fQjwfyLqducj8BUOLLQaN
 wEAUdbZiqzjMt6rKjav07POh6BpR4nLepzHf5MPX2FtTaq0UIq9bWGSYkfmFyGQMg6HsZnkub
 PXrfEQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.11.22 um 08:12 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Mon, Nov 28 2022, Ren=C3=A9 Scharfe wrote:
>
>> That may be true, and looks even useful -- I didn't know the check
>> value.  I only get a strange error message, though:
>>
>>    $ GIT_TEST_PASSING_SANITIZE_LEAK=3Dcheck ./t0001-init.sh
>>    Bail out! GIT_TEST_PASSING_SANITIZE_LEAK=3Dtrue has no effect except=
 when compiled with SANITIZE=3Dleak
>>
>> Same with make test and prove, of course.  And of course I compiled
>> with SANITIZE=3Dleak beforehand.
>
> The "=3Dtrue" part of the message is unfortunately incorrect (it pre-dat=
es
> "check" being a possible value), but I don't see how you could have
> compiled with "SANITIZE=3Dleak" and get that message.
>
> It's unreachable if 'test -n "$SANITIZE_LEAK"', and that'll be non-empty
> in GIT-BUILD-OPTIONS if compiled with it. Perhaps you gave SANITIZE=3Dle=
ak
> to t/Makefile, not the top-level Makefile?
>
> Try this at the top-level:
>
> 	GIT_TEST_PASSING_SANITIZE_LEAK=3Dcheck make SANITIZE=3D test T=3Dt0001-=
init.sh

It works today, no idea what I did yesterday.  Did reboot and make
clean in the meantime, shell history is inconclusive.  *shrug*

>> As I wrote: A call to an initialization function followed by a call to =
a
>> cleanup function and nothing else shouldn't leak.  There are examples o=
f
>> repo_init_revisions()+release_revisions() without setup_revisions() or
>> diff_setup_done() beyond pack-objects.  I mentioned prune, but there ar=
e
>> more, e.g. in sequencer.c.
>
> Yes, I agree it shouldn't leak. And we should definitely fix those
> leaks. I just don't see why a series fixing bugs in --filter needs to
> expand the scope to fix those.

The connection is that this is the very leak that 5cb28270a1
(pack-objects: lazily set up "struct rev_info", don't leak, 2022-03-28)
plugged locally.  Took me a while to see that.  Anyway, I'm also not
keen on scope creep.

>>> But in general: I don't really think this sort of thing is worth
>>> it. Here we're reaching into a member of "revs->diffopt" behind its ba=
ck
>>> rather than calling diff_free(). I think we should just focus on being
>>> able to do do that safely.
>>
>> Sure, but the FREE_AND_NULL call is simple and safe, while diff_free()
>> is complicated and calling it one time too many can hurt.
>
> It's "safe" because you've read the internals of it, and know that it
> isn't assuming a non-NULL there once it's past initialization?
>
> Or is it like the revisions init()+release() in this thread, where
> you're assuming it works one way based on the function names etc., only
> for the CI to fail?

Ouch.

> In either case, I'm saying that if someone's confident enough to reach
> into the internals of a structure and tweak it they should be confident
> enough to just patch diff_free() or the like.

diff_free() is more complicated; it does that FREE_AND_NULL plus several
things that are not idempotent.

>>> WIP patches I have in that direction, partially based on your previous
>>> "is_dead" suggestion:
>>>
>>> 	https://github.com/avar/git/commit/e02a15f6206
>>> 	https://github.com/avar/git/commit/c718f36566a
>>
>> Copy-typed the interesting parts of the first patch like a medieval mon=
k
>> because there doesn't seem to be a download option. :-|
>
> Jeff pointed out the ".patch" (there's also ".diff"), but also: Git has
> this well-known transport protocol it uses, which typically maps to the
> web URL on public hosting sites ... :)
>
> 	git remote add avar https://github.com/avar/git.git
> 	git fetch avar
> 	git show <OID>

Yes, I probably should have downloaded everything like that.  Just did
it for the heck of it and got 43.37 MiB at 598.00 KiB/s.  Typing wasn't
that much slower.

Ren=C3=A9
