Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6AFC433B4
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 10:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A82C4613C3
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 10:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349012AbhDNKJZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 06:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbhDNKJP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Apr 2021 06:09:15 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBBFC061574
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 03:08:25 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id h10so22945422edt.13
        for <git@vger.kernel.org>; Wed, 14 Apr 2021 03:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=rAc99cF+GCL1brUSl8pLK5h/chxR3RfY3Ql5Mxf7HTU=;
        b=bXVsWLMCyAtyjq+xcDMDImCwPlq9phKCLiXh6ljuAlDQDQq472ZgJcFGljbqehZ0Sj
         czlRwbM79l0A+C1GpLf3cxS4/vadiniLg8qgQ1vJCTm7bLKcx+zbsPcu+wfyFccC8XDy
         3wYEzYLG/NzQxpt8gxUFhdmAFRcjUy0Cd+LNd/K9nhw1Ok+INATR04TVdzPWvDsEkPXz
         qjURqgZUOINyqgr+YdQjY0Z612nNjE9SGVchu/SCKXtWyZ13kF3uoeguoq8xTo0FPO20
         aeng9yfXAXvnOhGCVcyBaAmpU+5AMn28fa5akMMc3nwWtZxUSUmyuK1mHIPFQrm4RkIA
         tw6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=rAc99cF+GCL1brUSl8pLK5h/chxR3RfY3Ql5Mxf7HTU=;
        b=swnWg9skG9Srr8yjwy51BmOTPNEm6bLwg/e2BgxQbEN1zgBziUX6ZkACy3LNPkZRUJ
         qxkOCZfPh7gNQZOIRc0vYwXTz7ZSWG8K8/On7HPkZLpT2TbwLEvsVkEVx4yIYIqKEyWQ
         4/sr2/BEgVMVjM0g2if1xYJskvvB/AXk7e7RTAx7ooJ2F/ziODK1Ye3y+8VhGPhVZ/vG
         yBHwqTTraoClWr9J6u+J6e0wyo+/jsqM201eE2UIpJodSkiISvqnfZllPCGyvzhGhwia
         94vj56PCjLYyWfmoHviW7A2JLa5MiMFL/tz++81MVDsGC3OGvxqQmcL2XeJMRFFeBVVy
         yotQ==
X-Gm-Message-State: AOAM531sdTv18cXzW9EO3bCPvUgPNinvY0HKaaCYcS83NrhJPtBlViM2
        p4D9/lk0ml5wqU/AZXtqAFo=
X-Google-Smtp-Source: ABdhPJwPJVmjlvjrPofp0sPSbDXj5FMOiU1nlVqmz/xDKN7Zg69E62Sud1zG2God8tJe2JLcLPMIPA==
X-Received: by 2002:aa7:c74c:: with SMTP id c12mr39618455eds.346.1618394904421;
        Wed, 14 Apr 2021 03:08:24 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id y16sm11304084edc.62.2021.04.14.03.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 03:08:24 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] diff tests: rewrite flakyness-causing test "aid"
References: <patch-1.1-f0542cd902c-20210413T121930Z-avarab@gmail.com>
        <cover-0.2-00000000000-20210413T122645Z-avarab@gmail.com>
        <patch-2.2-c2cb52b6605-20210413T122645Z-avarab@gmail.com>
        <CAHd-oW4G+7z3UM3qjhPp=2oqOPE4a49fweew0n+gheGtQEy5VA@mail.gmail.com>
        <87fszu2elw.fsf@evledraar.gmail.com>
        <CAHd-oW6D7Tmp2TmrmGvXDt-NnT_wxhfr_bn_P_7=ot=m_2eyyA@mail.gmail.com>
        <874kg92xn0.fsf@evledraar.gmail.com> <xmqqim4pz83e.fsf@gitster.g>
        <871rbd2u47.fsf@evledraar.gmail.com> <xmqqblahz4hx.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqblahz4hx.fsf@gitster.g>
Date:   Wed, 14 Apr 2021 12:08:23 +0200
Message-ID: <87y2dl18mg.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 14 2021, Junio C Hamano wrote:

["tl;dr" below]:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>>> Thus if we do:
>>>>
>>>>     git something >expected &&
>>>>     test_cmp expected actual &&
>>>>     rm expected actual
>>>
>>> Isn't it a poor example to use to argue for your particular change,
>>> where $actual in the original is designed to be unique among tests,
>>> in order to ensure that $actual files left after test pieces fail
>>> would not interfere with the tests that come later?  IOW, there is
>>> not a reason to remove $actual until the end of the test sequence,
>>> is there?
>>
>> Not really, because you needed to read the rest of the test file to come
>> to that conclusion.
>>
>> The point of using a helper that guarantees cleanup such as
>> test_when_finished or test_config over manual "git config" or "git rm"
>> isn't that we can prove that we need it because a later test needs the
>> cleanup, but that anyone can add new tests or functionality without
>> having to worry about cleaning up the existing trash directory.
>>
>> So yes, it's not needed here, but that's only because we know the rest
>> of the tests don't have e.g. a test that does a:
>
> In this particular case, $actual files are designed to be left
> behind for failed test pieces, so that the tester can come back and
> inspect them.  I probably should have said it a bit more strongly
> than "there is not a reason to remove".  You SHOULD NOT remove and
> that is why we had "check and then remove only upon success" there,
> instead of test_when_finished.  We want them left for and only for
> failing test pieces.

Yes, it's clear that it's designed to do that. I'm not disagreeing on
the intent of your commit in 2006 to set it up this way.

What I am saying is that it's incompatible to have:

 1. Failing tests
 2. Not removing scratch files that would otherwise be removed

And:

 3. Knowing that the rest of the tests pass in the case of #1 without
    reading them all.

Hence the suggestion that we should use test_when_finished without
exception for such patterns.

Because consistently using the helper would allow us to smartly get #1
and #2 without #3, i.e. some "copy them for later analysis" as suggested
upthread in:
http://lore.kernel.org/git/874kg92xn0.fsf@evledraar.gmail.com

> Please do not advocate for and encourage newbies who would be
> reading the discussion from sidelines to use test_when_finished out
> of dogmatic principle without thinking.

Is Matheus the newbie here? I think he's contributed enough to form his
own opinion.

I think it's clear to anyone else reading from the sidelines that we're
having some informed disagreement about a finer point of patterns in the
test suite.

I doubt either one of us is likely to have much of an impact on newbies
reading from the sidelines.

In any case, I don't see how you're able to read this thread and come to
the conclusion that I'm proposing the use of test_when_finished out of
"[some] dogmatic principle".

I'm not. I'm proposing to use it because I think it makes sense, and I
think the reasons you've noted for avoiding it in this case have more
downsides than upsites, as noted in the #1-3 examples above.

> Even though there are valid cases where test_when_finished is the
> perfect fit, in this particular case, use of it is a clear regression.

Well, I disagree with you.

I think even if the patch I was proposing was a mere conversion to
test_when_finished as would be typical for most newly written tests,
i.e. a diff like this:
=09
	diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
	index 6cca8b84a6b..d0031aa0f7b 100755
	--- a/t/t4013-diff-various.sh
	+++ b/t/t4013-diff-various.sh
	@@ -204,6 +204,7 @@ do
	 	actual=3D"$pfx-diff.$test"
=09=20
	 	test_expect_$status "git $cmd # magic is ${magic:-(not used)}" '
	+		test_when_finished "rm \"$actual\"" &&
	 		{
	 			echo "$ git $cmd"
	 			case "$magic" in
	@@ -216,22 +217,11 @@ do
	 			    -e "s/^\\(.*mixed; boundary=3D\"-*\\)$V\\(-*\\)\"\$/\\1g-i-t--v-e-=
r-s-i-o-n\2\"/"
	 			echo "\$"
	 		} >"$actual" &&
	-		if test -f "$expect"
	-		then
	-			process_diffs "$actual" >actual &&
	-			process_diffs "$expect" >expect &&
	-			case $cmd in
	-			*format-patch* | *-stat*)
	-				test_cmp expect actual;;
	-			*)
	-				test_cmp expect actual;;
	-			esac &&
	-			rm -f "$actual" actual expect
	-		else
	-			# this is to help developing new tests.
	-			cp "$actual" "$expect"
	-			false
	-		fi
	+		test_when_finished "rm actual" &&
	+		process_diffs "$actual" >actual &&
	+		test_when_finished "rm expect" &&
	+		process_diffs "$expect" >expect &&
	+		test_cmp expect actual
	 	'
	 done <<\EOF
	 diff-tree initial

It's a clear improvement, because, on current master, emulating the case
when you add a new test-case:

    $ rm t4013/diff.log_-GF_-p_--pickaxe-all_master

Now run it once:

    $ ./t4013-diff-various.sh
    [...]
    # failed 1 among 199 test(s)

And then to debug it:

    $ ./t4013-diff-various.sh -vixd
    [...]
    # passed all 199 test(s)

So because we copied the file around the only get the failure the first
time around.

You might rightly say that we could have narrowly just fixed that
particular bug and kept the old "copy and return false", so something
like:
=09
	diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
	index 6cca8b84a6b..6f0f3c7f53c 100755
	--- a/t/t4013-diff-various.sh
	+++ b/t/t4013-diff-various.sh
	@@ -229,7 +229,7 @@ do
	 			rm -f "$actual" actual expect
	 		else
	 			# this is to help developing new tests.
	-			cp "$actual" "$expect"
	+			cp "$actual" "$expect.MAYBE-USE-THIS"
	 			false
	 		fi
	 	'

But as noted above that gets us into needing to worry about cascading
failure. I.e. any new test added later in the file needs to think about
"what if the t4013 directory is in this state?".

We also document what we'll do and how we'll do it in t/README in this
case:
=09
	--immediate::
		This causes the test to immediately exit upon the first
		failed test. Cleanup commands requested with
		test_when_finished are not executed if the test failed,
		in order to keep the state for inspection by the tester
		to diagnose the bug.

So it's much more obvious and consistent to have a failure that ends on
the test_cmp and being able to see the test_when_finished for the
intermediate files in the trace output.

The hypothetical newbie might have debugged such a pattern already, but
not having it end in a special-case used only for this test:

    [...]
    + test -f /home/avar/g/git/t/t4013/diff.log_-GF_-p_--pickaxe-all_master
    + cp 0096-diff.log_-GF_-p_--pickaxe-all_master /home/avar/g/git/t/t4013=
/diff.log_-GF_-p_--pickaxe-all_master.MAYBE-USE-THIS
    + false

In any case, neither one of those is the patch I'm suggesting upthread.

I am suggesting not just to use test_when_finished, but that we should
use BUG here. Since not having the file itself is a bug in git's test
suite, not a mere failure of the test case. The test will never pass if
the file doesn't exist.

So even if I agreed with you that the more narrow migration to
test_when_finished would be a regression, I don't see how you think
*this* patch could be a regression.

You seem to just be focusing on the test_when_finished part of it, but
that's not all it's doing. Since we also use BUG the output is now:

    $ ./t4013-diff-various.sh=20
    [...]
    error: bug in the test script: Have no "t4013/diff.log_-GF_-p_--pickaxe=
-all_master", new test? [...]

I.e. whether we used "rm" or "cp" or "test_when_finished 'rm [...]'"
earlier has become irrelevant to achieve the states aims in 3c2f75b590c
(t4013: add tests for diff/log family output options., 2006-06-26).

It doesn't matter how we're removing/copying etc. the file anymore,
that's no longer how we're helping the user debug the test.

tl;dr:

In any case, I think it's best to just drop this series. I wrote the
above more as a synopsis of what I belive we should be doing in general,
I do have some patches queued up to address the general debug-ability of
our test output (e.g. for CI).

For that end-goal having e.g. test_when_finished (mostly) consistently
used would help a lot, but not using it in any one test would be
fine. This is just one such case, and something I thought wouldn't be a
controversial patch.

I think at this point me trying to gleaming entrails of what you want &
you responding back is going to take both of us much more time than
replacing this series with a patch you'd be happy with, and this wasn't
something I cared about more than a one-off.
