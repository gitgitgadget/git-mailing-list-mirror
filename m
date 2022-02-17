Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5F0C433F5
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 04:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbiBQEE5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 23:04:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiBQEEz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 23:04:55 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A588C21FC7C
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 20:04:41 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id b9-20020a63e709000000b00362f44b02aeso2302622pgi.17
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 20:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=rBd3KenX8n/IoN8zdWaWXVU+ifXv5iw76FvoGMs7b9U=;
        b=BkgfULZcJdcjloGWAu98cMOsn/7UVrzxRoSHNE0PF8Nekg8bsnB7zDH8Vxh2YO4ty1
         xCKJQZGc3rgwBVg6d0agT+TWr8juOIlHKE7AyvwW7VnGPm4t5X3O3E8i/jjs0JfRm+xj
         I2ecEfVrgGrBLn+S7LAq3vkMmPw2rZI76ejwDQaA5fB2QN5JMzBupM6Eov1g3GbIwiJH
         xI2yS5VQWs0bmfv1Sbx8dyM0pGgc48eXWhU1ddOEQSeHQgQLgcbjA1DYijKejvXqWduK
         FvdckQah1FtBQm1uZ46fK7QIsklP3eCvUNONGPW2YfuSIDtnKgaMb2iwvL+zG6p8XYL5
         VjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=rBd3KenX8n/IoN8zdWaWXVU+ifXv5iw76FvoGMs7b9U=;
        b=TZGDl6te1hLOEv7e01mU1yxQKnL315r+f9TiQO7LGiT/HXqDlcZIAGxWONg4iqa0tj
         NVZryx8WF4rbaZlGQah5pI+jBxdxeQGPhptHbxS8RW+3MkqMJZi7jpfetqa2HhnmFT+q
         C7U3kF5DVEdZ+/j7/J1KZWNeZI5lO7KKGxhSWVnJhYVWL2IeD+TMJk/dm91F6+5A+Mjc
         WnuX3XhOTSO4WXeor9HbZ+EjECSKBj0n9kGWQ6tDKyTP+Lm+DG/PJE1zPqI41M0ZnHPT
         XYy/uLRKI1OFnKUJQmtvr1WrF21AQTnXetwzJpdivH0F8QNZIZTKptf7bTQ9nkZGdp9V
         CaBw==
X-Gm-Message-State: AOAM5333QOkfxHBc9V0KMmMY3WEfORGsHX+GlFUrzUOWcailF4x0IZKl
        kXaBM8NjnjFLv8sRDUP+9NzJ90CCXWFSGg==
X-Google-Smtp-Source: ABdhPJxU5IdFn2VrFhX9saXaYsS4qbrl2XdnzIU+O2eCByHrwNKvXsaaHYvyamYltc6hIKYPcwXcXxH0HD+VZQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:a50f:b0:1b8:e6ad:f63c with SMTP
 id a15-20020a17090aa50f00b001b8e6adf63cmr263392pjq.1.1645070680826; Wed, 16
 Feb 2022 20:04:40 -0800 (PST)
Date:   Thu, 17 Feb 2022 12:04:37 +0800
In-Reply-To: <220216.86y22bt8gp.gmgdl@evledraar.gmail.com>
Message-Id: <kl6l7d9u5eay.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220210044152.78352-1-chooglen@google.com> <20220215172318.73533-1-chooglen@google.com>
 <20220215172318.73533-3-chooglen@google.com> <220215.86r183x043.gmgdl@evledraar.gmail.com>
 <kl6ltucz5wys.fsf@chooglen-macbookpro.roam.corp.google.com> <220216.86y22bt8gp.gmgdl@evledraar.gmail.com>
Subject: Re: [PATCH v2 2/9] t5526: use grep to assert on fetches
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Feb 16 2022, Glen Choo wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> On Wed, Feb 16 2022, Glen Choo wrote:
>>>
>>>> In a previous commit, we replaced test_cmp invocations with
>>>> verify_fetch_result(). Finish the process of removing test_cmp by usin=
g
>>>> grep in verify_fetch_result() instead.
>>>>
>>>> This makes the tests less sensitive to changes because, instead of
>>>> checking the whole stderr, we only grep for the lines of the form
>>>>
>>>> * "<old-head>..<new-head>\s+branch\s+-> origin/branch"
>>>> * "Fetching submodule <submodule-path>" (if fetching a submodule)
>>>>
>>>> when we expect the repo to have fetched. If we expect the repo to not
>>>> have fetched, grep to make sure the lines are absent. Also, simplify t=
he
>>>> assertions by using grep patterns that match only the relevant pieces =
of
>>>> information, e.g. <old-head> is irrelevant because we only want to kno=
w
>>>> if the fetch was performed, so we don't need to know where the branch
>>>> was before the fetch.
>>>
>>> I tried ejecting 1/9 and 2/9 out of this series locally, and it passes
>>> all tests until the new tests you add in 7/9.
>>>
>>> As ugly as some of the pre-image is, I wonder if dropping these first
>>> two and biting the bullet and just continuing with the test_cmp is
>>> better.
>>>
>>> The test_cmp is going to catch issues that even the cleverest grep
>>> combinations won't, e.g. in the submodule-in-C series I discovered a bu=
g
>>> where all of our testing & the existing series hadn't spotted that we
>>> were dropping a \n at the end in one of the messages.
>>
>> I think there are two schools of thought on how to test informational
>> messages:
>>
>> - assert an exact match on the exact output that we generate
>> - assert that the output contains the pieces of information we care
>>   about
>>
>> These two approaches are virtually opposites on two axes - the former
>> will catch unintentional changes (like you've noted)[...]
>
> Yes, and to be fair I'm thoroughly in the "assert an exact match" camp,
> i.e. "let's just use test_cmp", and not everyone would agree with that.
>
> I mean, I don't think we should test_cmp every single instance of a
> command, but for things that are *the tests* concerning themselves with
> what the output should be, yes we should do that.

That's a good point I hadn't considered, which is that if we want any
hope of catching unintentional changes in our test suite, we'd want
_some_ test to check the output. For "git fetch --recurse-submodules",
it makes the most sense for that test to live in this file.

By eliminating all instances of test_cmp in this file in particular, we
lose assurances that we don't introduce accidental changes. It makes
sense to at least have some tests explicitly for output.

>
>> [...] and the latter saves on maintenance effort and tends to be less no=
isy in tests.
>
> I also don't think you're right about the other approach "sav[ing] on
> [future] maintenance effort" in this case.
>
> If I was needing to adjust some of this output I'd spend way longer on
> trying to carefully reason that some series of "grep" invocations were
> really doing the right thing, and probably end up doing the equivalent
> of a "test_cmp" for myself out of general paranoia, whereas adjusting
> the output.

That's fair. I've optimized the tests for readability by putting
complicated logic in the test helper. But any diligent test reader would
need to read the test helper to convince themselves of its correctness.
In this case, I agree that the helper is too complex.

>> Personally, I'm a bit torn between both approaches in general because I
>> want tests to be maintainable (testing the exact output is a bit of an
>> antipattern at Google), but I'm not very comfortable with the fact that
>> unintended changes can sneak through.
>
> Yes, anyway whatever one thinks in general what I meant to point out
> here with "biting the bullet" is that whatever one thinks in general
> about the right approch for new tests, this series in particular seems
> to be creating more work for itself than it needs by refactoring the
> test_cmp in existing tests just to add a few new ones.
>
> I.e. even if you'd like to not use test_cmp-alike for the new tests,
> wouldn't it be simpler to just leave the old ones in place and use your
> new helper for your new tests?

I'm not sure about this - avoiding changing old tests leads to
fragmentation in the test suite and even the same file. I find it very
challenging to read/modify files like this, because there is no longer a
consistent style for the file, and I have to figure out which is the
"good" way to write tests.

This suggestion makes sense if there's some qualitative difference
between the new tests and old ones besides just 'being new'. This isn't
true for this series, so I'd prefer to keep things consistent.

>> So I don't think there's a correct answer in general. Maybe an
>> acceptable rule of thumb is that test_cmp is good until it starts
>> getting in the way of reading and writing understandable tests.
>>
>> If we agree on that rule, then for this patch, I think replacing
>> test_cmp is the way to go, primarily because it lets us ignore the 'old
>> head' of the branch before the fetch, e.g. in the quoted example..
>
> [...]
>
>>>>  test_expect_success setup '
>>>> @@ -274,13 +277,10 @@ test_expect_success "Recursion doesn't happen wh=
en no new commits are fetched in
>>>>  '
>>>> =20
>>>>  test_expect_success "Recursion stops when no new submodule commits ar=
e fetched" '
>>>> -	head1=3D$(git rev-parse --short HEAD) &&
>>>>  	git add submodule &&
>>>>  	git commit -m "new submodule" &&
>>>> -	head2=3D$(git rev-parse --short HEAD) &&
>>>> -	echo "From $pwd/." > expect.err.super &&
>>>> -	echo "   $head1..$head2  super      -> origin/super" >>expect.err.su=
per &&
>>>
>>> ...as opposed to if we just rolled the generation of this into some
>>> utility printf function.
>>
>> we'd still have to deal with $head1 if we use test_cmp. That's fine for
>> this test, because it's pretty simple, but it gets pretty janky later
>> on:
>>
>>   @@ -345,20 +339,13 @@ test_expect_success "Recursion picks up all subm=
odules when necessary" '
>>         git fetch &&
>>         git checkout -q FETCH_HEAD
>>       ) &&
>>   -		head1=3D$(git rev-parse --short HEAD^) &&
>>       git add subdir/deepsubmodule &&
>>       git commit -m "new deepsubmodule" &&
>>   -		head2=3D$(git rev-parse --short HEAD) &&
>>   -		echo "Fetching submodule submodule" > ../expect.err.sub &&
>>   -		echo "From $pwd/submodule" >> ../expect.err.sub &&
>>   -		echo "   $head1..$head2  sub        -> origin/sub" >> ../expect.err=
.sub
>>   +		git rev-parse --short HEAD >../subhead
>>     ) &&
>>   -	head1=3D$(git rev-parse --short HEAD) &&
>>     git add submodule &&
>>     git commit -m "new submodule" &&
>>   -	head2=3D$(git rev-parse --short HEAD) &&
>>   -	echo "From $pwd/." > expect.err.super &&
>>   -	echo "   $head1..$head2  super      -> origin/super" >> expect.err.s=
uper &&
>>   +	git rev-parse --short HEAD >superhead &&
>>     (
>>       cd downstream &&
>>       git fetch >../actual.out 2>../actual.err
>>
>> In this example, we have two $head1 variables in different subshells,
>> one of which is HEAD, but the other is HEAD^. The reason why we want
>> HEAD^ isn't obvious (IIRC it's because the submodule upstream is 2
>> commits ahead because we add the deepsubmodule in a separate commit), in
>> my opinion, and I got tripped up quite a few times trying to read and
>> understand the test. That's a lot of effort to spend on irrelevant
>> information - the test actually cares about what it fetched, not where
>> the ref used to be.
>>
>> So for that reason, I'd prefer to remove test_cmp for this test.
>
> I agree that it's pretty irrelevant, but I also think we'd be throwing
> the baby out with the bath water by entirely doing away with test_cmp
> here, there's an easier way to do this.
[...]
> Instead let's just test once somewhere that when we run submodule
> fetching that submodules are indeed updated appropriately. Surely other
> submodule tests will break if the "update" code is made to NOOP, or
> update to the wrong HEAD>
>
> Then for all these test_cmp tests we can just sed-away the
> $head1..$head2 with something like (untested):
>
>     sed -n -e 's/[^.]*\.\.[^.]*/OLD..NEW/g'
>
> I.e. let's just skip this entire ceremony with asserting the old/new
> HEAD unless it's really needed (and then we can probably do it once
> outside a test_cmp).
>
> If you grep through the test suite for "sed" adjacent to "test_cmp"
> you'll find a lot of such examples of munging the output before
> test_cmp-ing it.

Makes sense, I hadn't considered this (though I have seen the pattern in
the test suite, oops). The most compelling argument in favor of this is
that this could remove a lot of the complexity of verify_fetch_result(),
which is impeding test readability.

> I.e. none of these tests surely need to test that we updated from
> $head1..$head2 again and again with the corresponding verbosity in test
> setup and shelling out to "git rev-parse --short HEAD" or whatever.

I find the converse (we are testing the formatting over and over again)
less convincing. In these tests, we really are checking for $head2 in
the stderr to verify that the correct thing was fetched. I'm not
convinced that we should be relying on _other_ submodule tests to tell
us that submodule fetch is broken. Which brings me back to the original
motivation of this patch..

>
> That's perfectly fine here, since the actual point of the test_cmp is to
> check the formatting/order etc. of the output itself, not to continually
> re-assert that submodule updating still works, and that we get the right
> OIDs.

which is that these tests actually are continually re-asserting the
submodule updating works correctly in the different circumstances, and
since we use the stderr to check this, test_cmp adds unwarranted noise.

But you are correct in that the point of test_cmp is to check
formatting/order etc. There is value in using test_cmp for this purpose,
and getting rid of it entirely creates a hole in our test coverage.
(This wouldn't mean that we'd need to use test_cmp _everywhere_ though,
only that we need to use test_cmp _somewhere_.)

As it stands:

+   test_cmp can improve the readability of the test helpers and
    debuggability of tests vs grep
+/- test_cmp can catch formatting changes that are hard to catch
    otherwise, though at the cost of being sensitive to _any_ formatting
    changes
-   test_cmp needs some munging to eliminate unnecessary information

so on the whole, I think it's worth trying to use test_cmp in the test
helper. We may not _need_ it everywhere, but if it would be nice to use
it in as many places as possible.
