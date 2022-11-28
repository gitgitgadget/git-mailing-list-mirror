Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1116C4332F
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 15:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbiK1P4X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 10:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiK1P4V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 10:56:21 -0500
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CAB22B34
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 07:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669650965; bh=25DyP8N8o7/5xCe7f0OHQTMJ2N9C+hWSK6BKBpsk7dc=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=mjJrpIQgmYxuyyBW9HJ3uMaCqn7dvqHw6JgsQZAPKyACXDoucq80BMA6JQ3XVz9OW
         DnbNQQATbaZLUHU8iJe3viHA0TfxadR8SIAc+uQmObqtj3sRfzZIN7SBfGH6ApoBiw
         BMbJVTA0ycB+bdyqc396wPib+K4LFvS8e/RItVEIdzYcgADXFYfRZfeh26cRy2W7it
         kyLn2FS6Fv7Fu7MXqavARsqg9HhaT90FoyyB5MGYKeZDWl92rVonVsJ5H5qkaBislg
         MRBTERXlv+IFL9bTchl1ScczZiBQOMfk/QBId9UawB2Qng6RHuzbVpXIrodcQaN1tP
         xcQIk0ol3EJeg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.35] ([91.47.154.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRW2R-1pKmGn3XOP-00NaSU; Mon, 28
 Nov 2022 16:56:04 +0100
Message-ID: <59431916-9f55-d0f4-da54-e7369803eb4c@web.de>
Date:   Mon, 28 Nov 2022 16:56:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 3/3] Revert "pack-objects: lazily set up "struct
 rev_info", don't leak"
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
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <221128.865yezkule.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3pHLWzEt6eANQwYwXjGR+6lN3Hzdyi8K6LHTCS1aICULHo72I+Y
 kSjIpoXziS6knkKyXnx6zJrgKlKRQzQ494Mg7DT4mWDKxftuVj/HCYLDU8BrusEp0+Xyk9v
 yLRpSTv04MVoAH2mXZO2J2AA0gukAA6JWysk1L6i2hKNLMwHEuU/CTFbpX5BkcFr5xche7g
 t9wd0XKdZlVlKsPfy22ew==
UI-OutboundReport: notjunk:1;M01:P0:+ndlNcQAmFY=;RsDS8El8X9vj0VuZi/V48997lp7
 9Ve6lbD9RzwRA8MscsyFM1zsHk/wuO2sekggE3/g/wSnEcbEd5gjkpSY9QF8Z9dUQWLBO2vPP
 DyItuABYYW8E+eYS4Frek7m9b40xpL2MIyxT9dKqR8tHb+Hp+M2LcZJXcs4pVJWYturKmysVo
 G3we6hobe4xnIXNXFpBYsp5ZymzJsZTXHV+EXTVzMaL90RrSuDlT56PPRQf0Z7qxuPXXiUphb
 K2h5UHB+eE3rGnZzakw4Tu/kwRDl1akwaBfNx7GGFLqEcOT6eJda5x05IdX5cpnVBwN99KM2B
 W9AkXDMKiYFmYiDT3sbP8g7McWV1X6JNpB15h+DBev961QOM77LLNSDie6LM59014snEhqFv1
 oB305OYf15EbAddQtOoPL8eC/MdxgGnLQZgIbqrWqtGuWzJ7zQP2ruhenDnv71+hdIgx92Nr1
 ih8CWbBg0lCWfkpW0hNhgS7UY1h572ngzk/GzNKRLSGwJgFoJVwB7JX9z4IFVe6zDIyC2Em0g
 WMs8yUH0gK201+5OTE6Q1310oc4ZwyyfUsLDV15md46DBP1oC/3rUXVxeOQkLGPCKNXGHltB0
 UZrw7K/Sg+pmYDf+nfacYLAS+ZlSlVJyS1zH54j2s0mW4QXYgfSTL8lEfAWZh8uNFZgtvWnmZ
 j9oEtcYV1/Z7MWgEwEEFKAvgOmmt0L1br3+1h5Tp+jWqDP8eJjPFzL3e/pWYGEaaPx9JQbjgI
 gfAkSY76VEaSnofomC9am4x2U2HkSnGyXH/phTvsuiOCd+XbWV6UxK2X/OlPw61FRMYkt09At
 JQ8/kaZi5rxHiTWYU9vEy0qZFQuA3WiGTjdGHObTc4Nq8sgh/cdj2HWcToUswxB2If6du5Zpc
 dxdg4ZakM2Bm6payH4h1QQPHrEiWnMXkx67RAMumLFILXS5hpLNK0nMruSuBTafW9+ijLo8mJ
 OYpYS0fFMV2smDQ0sS9jK5f+Onk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.11.2022 um 15:34 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Mon, Nov 28 2022, Ren=C3=A9 Scharfe wrote:
>
>> Am 28.11.2022 um 12:31 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>>
>>> On Mon, Nov 28 2022, Ren=C3=A9 Scharfe wrote:
>>>
>>>> Am 28.11.2022 um 11:03 schrieb Junio C Hamano:
>>>>> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>>>>>
>>>>>> This reverts commit 5cb28270a1ff94a0a23e67b479bbbec3bc993518.
>>>>>>
>>>>>> 5cb28270a1 (pack-objects: lazily set up "struct rev_info", don't le=
ak,
>>>>>> 2022-03-28) avoided leaking rev_info allocations in many cases by
>>>>>> calling repo_init_revisions() only when the .filter member was actu=
ally
>>>>>> needed, but then still leaking it.  That was fixed later by 2108fe4=
a19
>>>>>> (revisions API users: add straightforward release_revisions(),
>>>>>> 2022-04-13), making the reverted commit unnecessary.
>>>>>
>>>>> Hmph, with this merged, 'seen' breaks linux-leaks job in a strange
>>>>> way.
>>>>>
>>>>> https://github.com/git/git/actions/runs/3563546608/jobs/5986458300#s=
tep:5:3917
>>>>>
>>>>> Does anybody want to help looking into it?
>>>
>>> [I see we crossed E-Mails]:
>>> https://lore.kernel.org/git/221128.868rjvmi3l.gmgdl@evledraar.gmail.co=
m/
>>>
>>>> The patch exposes that release_revisions() leaks the diffopt allocati=
ons
>>>> as we're yet to address the TODO added by 54c8a7c379 (revisions API: =
add
>>>> a TODO for diff_free(&revs->diffopt), 2022-04-14).
>>>
>>> That's correct, and we have that leak in various places in our codebas=
e,
>>> but per the above side-thread I think this is primarily exposing that
>>> we're setting up the "struct rev_info" with your change when we don't
>>> need to. Why can't we just skip it?
>>
>> I have no idea how to stop get_object_list() from using struct rev_info=
.
>> We could let it take a struct list_objects_filter_options pointer
>> instead and have it build a struct rev_info internally, but that would
>> just move the problem, not solve it.
>
> I mean skip it when it's not needed, it's needed when we call
> get_object_list().
>
> But what "problem" is being caused by get_object_list()? That there's
> some other case(s) where it'll leak still? I haven't checked, I think we
> should leave that for some other time if there's such leaks, and just
> not introduce any new leaks in this topic.

The problem is "How to use struct rev_info without leaks?".  No matter
where you move it, the leak will be present until the TODO in
release_revisions() is done.

>
>>> Yeah, if we do set it up we'll run into an outstanding leak, and that
>>> should also be fixed (I have some local patches...), but the other cas=
es
>>> I know of where we'll leak that data is where we're actually using the
>>> "struct rev_info".
>>>
>>> I haven't tried tearing your change apart to poke at it myself, and
>>> maybe there's some really good reason for why you can't separate getti=
ng
>>> rid of the J.5.7 dependency and removing the lazy-init.
>>>
>>>> The patch below plugs it locally.
>>>>
>>>> --- >8 ---
>>>> Subject: [PATCH 4/3] fixup! revision: free diffopt in release_revisio=
ns()
>>>>
>>>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>>>> ---
>>>>  builtin/pack-objects.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>>>> index 3e74fbb0cd..a47a3f0fba 100644
>>>> --- a/builtin/pack-objects.c
>>>> +++ b/builtin/pack-objects.c
>>>> @@ -4462,6 +4462,7 @@ int cmd_pack_objects(int argc, const char **arg=
v, const char *prefix)
>>>>  	} else {
>>>>  		get_object_list(&revs, rp.nr, rp.v);
>>>>  	}
>>>> +	diff_free(&revs.diffopt);
>>>>  	release_revisions(&revs);
>>>>  	cleanup_preferred_base();
>>>>  	if (include_tag && nr_result)
>>>
>>> So, the main motivation for the change was paranoia that a compiler or
>>> platform might show up without J.5.7 support and that would bite us, b=
ut
>>> we're now adding a double-free-in-waiting?
>>>
>>> I think we're both a bit paranoid, but clearly have different
>>> paranoia-priorities :)
>>>
>>> If we do end up with some hack like this instead of fixing the
>>> underlying problem I'd much prefer that such a hack just be an UNLEAK(=
)
>>> here.
>>>
>>> I.e. we have a destructor for "revs.*" already, let's not bypass it an=
d
>>> start freeing things from under it, which will result in a double-free
>>> if we forget this callsite once the TODO in 54c8a7c379 is addressed.
>>
>> Well, that TODO fix should remove this new diff_free() call, but I
>> agree that this is fragile.
>>
>> Removing the "TEST_PASSES_SANITIZE_LEAK=3Dtrue" line from affected test=
s
>> is probably better.
>
> Or just not introduce new leaks, per my suggested fix-up at
> https://lore.kernel.org/git/221128.86zgcbl0pe.gmgdl@evledraar.gmail.com/
> (which it looks like you haven't seen when this E-Mail is composed...).

Not adding leaks is a good idea.  AFAICS none of my patches so far add
any.  Patch 3 of v2 exposes an existing one that was only triggered by
the --filter option before.  Which is also not ideal, of course, but
giving it more visibility hopefully will motivate a proper fix.

>>> As you'd see if you made release_revisions() simply call
>>> diff_free(&revs.diffopt) doing so would reveal some really gnarly edge
>>> cases.
>>
>> That was my first attempt; it breaks lots of tests due to double frees.
>
> Right, to be clear I'm saying that none of this is needed right now,
> i.e. I don't get why we'd want the scope-creep past the hunk I noted in
> https://lore.kernel.org/git/221128.868rjvmi3l.gmgdl@evledraar.gmail.com/
> for the --filter bug fix (plus the tests you're adding).

Well, you asked to squash the minimal fix into the laziness removal in
https://lore.kernel.org/git/221112.86bkpcmm6i.gmgdl@evledraar.gmail.com/

Reverting 5cb28270a1 (pack-objects: lazily set up "struct rev_info",
don't leak, 2022-03-28) wholesale is the simplest way to reach the goals
of regression fix, simplification and standard compliance.  Except that
the leak check tests have come to depend on the leak being hidden in the
=2D-filter corner.  So going back to v1 sure seems attractive.

>
>>> I haven't dug into this one, but offhand I'm not confident in saying
>>> that this isn't exposing us to some aspect of that gnarlyness (maybe
>>> not, it's been a while since I looked).
>>
>> I saw it as the way towards a release_revisions() that calls diff_free(=
)
>> itself: Add such calls to each of them, fix the "gnarlyness"
>> individually, finally move them all into release_revisions().  The only
>> problem is that there are 60+ callsites.
>
> I think this is a really bad approach in general.
>
> Yes, it may happen to work to free() some data from under an API, but
> it's just as likely that we'll miss that this one caller is screwing
> with its internal state, and e.g. when some new revision.c code is used
> it'll go boom.
>
> If we wanted to phase in such a free() of "foo" I think the right way
> would be to add some "revs.free_foo =3D 1" flag, giving the API a chance
> to treat that sanely, not to start poking at members of the struct, and
> assuming that its release() won't be free()-ing them.

And that's why you added no_free to struct diff_options.  We could use
it here by setting it in repo_init_revisions() and unsetting in
cmd_pack_objects() and elsewhere, until it is set everywhere.

> But as noted above & in the linked I think we can defer all of that. The
> only reason we're discussing this is because you're changing the
> lazy-init to be not-lazy, and introducing new leaks as a result.>
> I've shown a couple of approaches in this thread of fixing the issue(s)
> at hand without introducing such leaks, so ...

As noted above: These leaks are not new, they are just moved into
test coverage.

Ren=C3=A9
