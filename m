Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D78C433FE
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 21:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbiK1V5T (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 16:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiK1V5S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 16:57:18 -0500
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DE92C65D
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 13:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669672623; bh=zppJMhXSiVRf541gMAcpxKnlx1LLR40YagBPgR7mauU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=D+3ggA1BzEagc018i+xMASsclDb3U3XirJ+6IXwO1it/i6uxooHXy4nU3AnEmc5we
         bPrLTYUP5ggAju11pzNnPof+27/sW8u8P9FoDrYxZnA6YHEBYkrG0sXLURp2Btt1qC
         hbSY4tXUbsGDDZzl/uaWt0O7hNSc4dNTaLnUxos+r9dSsZpbD1rY4TTGLnL+q/EamD
         MdfGdlGCcgpcJPhAwLhzF8oUPWLgA+MUDeh1MpX291GbsCXQbx9SUmGRS3zB1933qz
         7PHdRTZlVah9EPLn3c1juCf9gB3/BevnyeVjFRD4QwFvOhoWc13vWudsYWiHCSBO5R
         m0zKV/CnWWt3A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.35] ([91.47.154.159]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqZMQ-1odtd83ZTs-00mhMw; Mon, 28
 Nov 2022 22:57:02 +0100
Message-ID: <0b86ae8b-5523-3857-cdba-12275f727cde@web.de>
Date:   Mon, 28 Nov 2022 22:57:02 +0100
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
 <59431916-9f55-d0f4-da54-e7369803eb4c@web.de>
 <2488058d-dc59-e8c1-0611-fbcaeb083d73@web.de>
 <221128.86o7sqkjcj.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <221128.86o7sqkjcj.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WNplu4EKG9XCtMVTUpWjPRCDFgYHgenAZ/f5Q1B4MB+9fE5TP4f
 UqVRwdA5a9kofovQlNw8w0Zn0ScrElNvjWhiLfdcQ6ekxyvB8mdt2riuUbgUo7gEo0PuvtS
 dbIJM9moUJTt0koml7Y6USP1xweFpNa36EhJwBraeqvUtKB7RqPGk/gYapScNdAS0m5E4fw
 4QxA7FfjDLXrDqyU9kMkQ==
UI-OutboundReport: notjunk:1;M01:P0:J2KPtBVNDxw=;5ZISocTrlKU8Ke5h447nRetc6V9
 D1jUDcuYs8bLWiLpKIBDSKDShubnsSW9ClbW8fISTkgV404PrmxWjK9ZlII0E9RNEUtBgZ3Q2
 2TN4EXcV1EHlK1nJEOQ61wBLxMM4VLc6JDBw7M2Wt/DUDoF/20RzA9LtLt8XbzmzvwINiwraE
 aYS8d6PPgkjDoZNTWqdJgFFR37ENBiqkdu4GRmnorUhzhuWHpSVm5Zt7Hl59oaqg4JSvASi1d
 szh7k4k5jec3gAfeXlHKSKa1Cyr4QmQ0XIkCtIJ95tVHr4iSMcnLY93WLnSrhcbNq114YajvY
 aBFTjN2Zc4Jd8B6VXtBV8jd8GEuHzNdjFJ3DLGYlStsCCKH+EitQaGKFxtRTBeOkS7H321una
 uQABPfciFQJNnJndCUSiRgpQkr6oseMqJz44GiUR7IKtMxVVTuFcr8tEHbYb5lcu9uxrUraBU
 lSWaqJ7O7Lc8xmK3RtOVFtkjEpUlVgDrodKt+cw7kJoSBFrPqwakvdBPNNr4hzC/TS/yknnOc
 OvGkWpcP6tlTsinKkSV1YOPljIjOdNrxsFLtadV42kHHxwN00pIt64wTTXQpnq8UvGn1k9Imw
 o7daXQmnl6CQc+nY8EvKVWIjaYkKX9e5KsO2/K1lS9QvuhNfI8TmwKgTjpWzX2N7BbcUI4UdB
 ULDD+DoIPy3lTYPynXw21wOgbI+G+G0OSyfIwLrAlA7hx3OgrUrCa1XFicU4s3PzgwBnief0P
 AQCN+o/nD1327t0qpasSteEWJbt3/Aa7Ft22tBoaF3sizXIlcjINBrylAwvZhAQKVAHbXvkTc
 0BQVTstdz5B765wZnVzStkyqyLM3FzxZDrwFiZYd2mrhaFtogVg02fQMPkEXnNNQYvUfvnwcF
 gY2drgK1uFD7CyIKpr6jGQwBBr6o9fdFkzL9MnaoXhHgO/w4EcDUv8btAt31iwXie2Xl/vU1i
 ZmWqg6TcrzVU4tSVZleCQLvzrls=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.11.2022 um 19:32 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Mon, Nov 28 2022, Ren=C3=A9 Scharfe wrote:
>
>> Am 28.11.2022 um 16:56 schrieb Ren=C3=A9 Scharfe:>
>>> The problem is "How to use struct rev_info without leaks?".  No matter
>>> where you move it, the leak will be present until the TODO in
>>> release_revisions() is done.
>>
>> Wrong.  The following sequence leaks:
>>
>> 	struct rev_info revs;
>> 	repo_init_revisions(the_repository, &revs, NULL);
>> 	release_revisions(&revs);
>>
>> ... and this here doesn't:
>>
>> 	struct rev_info revs;
>> 	repo_init_revisions(the_repository, &revs, NULL);
>> 	setup_revisions(0, NULL, &revs, NULL);  // leak plugger
>> 	release_revisions(&revs);
>>
>> That's because setup_revisions() calls diff_setup_done(), which frees
>> revs->diffopt.parseopts, and release_revisions() doesn't.
>>
>> And since builtin/pack-objects.c::get_object_list() calls
>> setup_revisions(), it really frees that memory, as you claimed from the
>> start.  Sorry, I was somehow assuming that a setup function wouldn't
>> clean up.  D'oh!
>>
>> The first sequence is used in some other places. e.g. builtin/prune.c.
>> But there LeakSanitizer doesn't complain for some reason; Valgrind
>> reports the parseopts allocation as "possibly lost".
>
> Yes, some of the interactions are tricky. It's really useful to run the
> tests with GIT_TEST_PASSING_SANITIZE_LEAK=3D[true|check] (see t/README) =
to
> check these sorts of assumptions for sanity.

That may be true, and looks even useful -- I didn't know the check
value.  I only get a strange error message, though:

   $ GIT_TEST_PASSING_SANITIZE_LEAK=3Dcheck ./t0001-init.sh
   Bail out! GIT_TEST_PASSING_SANITIZE_LEAK=3Dtrue has no effect except wh=
en compiled with SANITIZE=3Dleak

Same with make test and prove, of course.  And of course I compiled
with SANITIZE=3Dleak beforehand.

But I don't see a connection between my comment and yours.  I was
not running any tests, just the above sequences of function calls,
e.g. in git prune.

>
>> I still think the assumption that "init_x(x); release_x(x);" doesn't
>> leak is reasonable.  Let's make it true.  How about this?  It's safe
>> in the sense that we don't risk double frees and it's close to the
>> TODO comment so we probably won't forget removing it once diff_free()
>> becomes used.
>>
>> ---
>>  revision.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/revision.c b/revision.c
>> index 439e34a7c5..6a51ef9418 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -3055,6 +3055,7 @@ void release_revisions(struct rev_info *revs)
>>  	release_revisions_mailmap(revs->mailmap);
>>  	free_grep_patterns(&revs->grep_filter);
>>  	/* TODO (need to handle "no_free"): diff_free(&revs->diffopt) */
>> +	FREE_AND_NULL(revs->diffopt.parseopts);
>>  	diff_free(&revs->pruning);
>>  	reflog_walk_info_release(revs->reflog_info);
>>  	release_revisions_topo_walk_info(revs->topo_walk_info);
>
> At this point I'm unclear on what & why this is needed? I.e. once we
> narrowly fix the >1 "--filter" options what still fails?

As I wrote: A call to an initialization function followed by a call to a
cleanup function and nothing else shouldn't leak.  There are examples of
repo_init_revisions()+release_revisions() without setup_revisions() or
diff_setup_done() beyond pack-objects.  I mentioned prune, but there are
more, e.g. in sequencer.c.

> But in general: I don't really think this sort of thing is worth
> it. Here we're reaching into a member of "revs->diffopt" behind its back
> rather than calling diff_free(). I think we should just focus on being
> able to do do that safely.

Sure, but the FREE_AND_NULL call is simple and safe, while diff_free()
is complicated and calling it one time too many can hurt.

> WIP patches I have in that direction, partially based on your previous
> "is_dead" suggestion:
>
> 	https://github.com/avar/git/commit/e02a15f6206
> 	https://github.com/avar/git/commit/c718f36566a

Copy-typed the interesting parts of the first patch like a medieval monk
because there doesn't seem to be a download option. :-|

> I haven't poked at that in a while, I think the only outstanding issue
> with it is that fclose() interaction.

You mean the t3702-add-edit.sh failure on Windows mentioned in the
commit message of e02a15f6206?  That's caused by the file being kept
open and thus locked during the call of the editor.  Moving the
release_revisions() call in builtin/add.c::edit_patch() before the
launch_editor() call fixes that by closing the file.

> I think for this particular thing there aren't going to be any bad
> side-effects in practice, but I also think convincing oneself of that
> basically means putting the same amount of work in as just fixing some
> of these properly.

Not to me, but perhaps that TODO is easier solved that I expected.
In any case, with the mentioned edit_patch() change described above
e02a15f6206 passes the test suite on Windows for me.

Ren=C3=A9
