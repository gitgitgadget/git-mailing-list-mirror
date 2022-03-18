Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0DEC433F5
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 23:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241501AbiCRX2N (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 19:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238224AbiCRX2M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 19:28:12 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E2C30A8A1
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 16:26:52 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x34so10736491ede.8
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 16:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Kk3pzPlrlH+7oXpwZ2Atemf4tyR05vkKO+coK3Blhis=;
        b=MdfUxEEwLu9nEoU9LsrObVVHXNfWOB1ZJ7ZQ+oTErQjZ6iTc+QAtckAy2RSOzk6ZlL
         zZ1Ff1NesZ5cyL4G3HiSlWwBQm+Oax8ZQ/0BjvRp3/oWFku1XiK3Xhl1NiXYJtaM57bN
         azfCHtzEeUST1ick8I9aPTD1fZurdh28RHouR6xkP/dJd4HdBqHlQpD56d+9LdOCBy0J
         pLvNvcQuGfzWT+xIcDPzjbcXY+aRNmtPMh+g4dihnXwD+Cik96Fgtzd5ipNYbALJkgVe
         AvCRM+eHXP10yfyuG2ConnXFqaacHuO7Ge4gWRGrOM7uuXxQlqxbrpHIH5XME0gqFyp4
         3NRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Kk3pzPlrlH+7oXpwZ2Atemf4tyR05vkKO+coK3Blhis=;
        b=5LyktI5f8cOOrazdYt3xaoDK+mmn+VOEafwV3foGD//R88IGEuEbT5y0WuI/u8tVq5
         rvSUB2Is+fSCc+cZBe7E6jUt7Pk54cvGeTf6+QSCX72ix+Dd1DbSqL6Ke3pi1EebOOud
         AmN7L04INDnnxNz7gG5nnwIjkw+G0qsbZdlwZYHb6OYrDdyzdYup1UOXeYo56OOneGXR
         PQBtxM146040UAUh1ARiAAA2Dl2GWbGGVUgPzhudkq4BF9NjyFJSfD3K5CV5h5mpcwfV
         mTe6X8XIPa/z1Gs/VFRjWH8/bAOSXsnvJD5nQPP+xrZyAH1JXGzv4pD+KXyrlxX8+sqL
         Mr+w==
X-Gm-Message-State: AOAM5317I6otbLWI4tMb71vyAIKgL1UJncd4vFeid/WFwocVBrYcckgJ
        3kkaNhGysKa2ruE2EEuJgtU=
X-Google-Smtp-Source: ABdhPJzhnblOSuvOw6xjJy+S4r95KOWLZpl8o9VYFT7TeFsrhuSrdTZbTt1PHVcjSlhs/XRM2fL4IA==
X-Received: by 2002:a50:d592:0:b0:415:e599:4166 with SMTP id v18-20020a50d592000000b00415e5994166mr11750597edi.195.1647646010658;
        Fri, 18 Mar 2022 16:26:50 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id g15-20020a170906520f00b006cd07ba40absm4179863ejm.160.2022.03.18.16.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 16:26:49 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nVLzd-003h8E-Aq;
        Sat, 19 Mar 2022 00:26:49 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/7] test-lib: add a "test_expect_todo", similar to
 "test_expect_failure"
Date:   Sat, 19 Mar 2022 00:07:12 +0100
References: <cover-0.7-00000000000-20220318T002951Z-avarab@gmail.com>
 <patch-1.7-4624abc2591-20220318T002951Z-avarab@gmail.com>
 <xmqqczij9jeg.fsf@gitster.g> <xmqq8rt77zp7.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <xmqq8rt77zp7.fsf@gitster.g>
Message-ID: <220319.86v8waetae.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 18 2022, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Marking the step that demonstrates the current shortcomings with
>> "MUST FAIL" is a bad taste, but let's pretend that we didn't notice
>> it ;-).  Other than that, it looks like an improvement.
>> ...
>>> +test_expect_failure () {
>>> +	_test_expect_todo test_expect_failure "$@"
>>> +}
>>> +
>>> +test_expect_todo () {
>>> +	_test_expect_todo test_expect_todo "$@"
>>> +}
>>
>> It is a bit surprising that _test_expect_todo does not share more of
>> its implementation with test_expect_success, but let's pretend we
>> didn't see it.
>
> With a bit more tweak, I think this can be made palatable:
>
>  * introduce something that is *NOT* test_must_fail but behaves like
>    so, but with a bit of magic (see below).
>
>  * do not introduce test_expect_todo, but use an improved version of
>    test_expect_success.
>
> Let's illustrate what I mean by starting from an example that we
> want to have _after_ fixing an known breakage.  Let's say we expect
> that our test preparation succeeds, 'git foo' fails when given a bad
> option, 'git foo' runs successfully, and the command is expected to
> emit certain output.  We may assert the ideal future world like so:
>
> 	test_expect_success 'make sure foo works the way we want' '
> 		preparatory step &&
> 		test_must_fail git foo --bad-option >error &&
> 		grep "expected error message" error &&
> 		! grep "unwanted error message" error &&
> 		git foo >output &&
> 		grep expected output &&
> 		! grep unwanted output
> 	'
>
> Let's also imagine that right now, option parsing in "git foo",
> works but the main execution of the command does not work.
>
> With test_expect_todo, you have to write something like this
> to document the current breakage:
>
> 	test_expect_todo 'document breakage' '
> 		preparatory step &&
> 		test_must_fail git foo --bad-option >error &&
> 		grep "expected error message" error &&
> 		! grep "unwanted error message" error &&
> 		test_must_fail git foo >output &&
> 		! grep expected output &&
> 		grep unwanted output
> 	'
>
> You can see that this makes one thing unclear.
>
> Among the two test_must_fail and two !, which one(s) document the
> breakage?  In other words, which one of these four negations do we
> wish to lift eventually?  The answer is the latter two (we said that
> handling of "--bad-option" is already working), but it is not obvious
> in the above test_expect_todo test sequence.
>
> I'd suggest we allow our test to be written this way:
>
> 	test_expect_success 'make sure foo works the way we want' '
> 		preparatory step &&
> 		test_must_fail git foo --bad-option >error &&
> 		grep "expected error message" error &&
> 		! grep "unwanted error message" error &&
> 	test_ki git foo >output &&
> 	test_ki grep expected output &&
> 	test_ki ! grep unwanted output
> 	'
>
> and teach test_expect_success that an invocation of test_ki ("known
> issue"---a better name that is NOT test_must_fail very much welcome)
> means we hope this test someday passes without test_ki but not
> today, i.e. what your test_expect_todo means, and we unfortunately
> have to expect that the lines annotated with test_ki would "fail".
>
> To readers, test_ki should appear as if an annotation to a single
> command that highlights what we want to eventually be able to fix,
> and when the issue around the line marked as test_ki is fixed, we
> can signal the fact by removing it from the beginning of these lines
> (that is why the last one is "test_ki !" and not "!  test_ki").
>
> To the test framework and the shell that is running the test,
> test_ki would be almost identical to test_must_fail, i.e. runs the
> rest of the command, catch segv and report, but otherwise the
> failure from that "rest of the command" execution is turned into
> "success" that lets &&-chain to continue.  In addition, it tells
> the test_expect_success running it that a success of the test piece
> should be shown as TODO (expected failure).
>
> Hmm?

Have you had the time to look past patch 1/7 of this series? 2/7
introduces a "test_todo" helper, the "test_expect_todo" is just the
basic top-level primitive.

I don't think we can categorically replace all of the
"test_expect_failure" cases, because in some of those it's too much of a
hassle to assert the exact current behavior, or we don't really care.

But I think for most cases instead of a:

	test_ki ! grep unwanted output

It makes more sense to do (as that helper does):

	test_todo grep --want yay --expect unwanted -- output

Which is quite a handful, which is why the series goes on to
e.g. introduce a todo_test_cmp, used e.g. like this (and we can easily
add more wrappers for common cases):

	cat >want <<-EOF &&
	$(git rev-parse HEAD)
	EOF
	cat >expect <<-\EOF &&
	error: can't rev-parse stuff
	EOF
	test_might_fail git some-cmd HEAD >actual &&
	todo_test_cmp want expect actual

I.e. if you just want to throw your hands in the air and say "I don't
care how this fails and just emit a 'not ok .. TODO' line" we already
have test_expect_failure for that use-case.

I think in most other cases documenting that something is broken or
should behave differently shouldn't be synonymous with not caring *how*
that unwanted behavior works right now.

Understanding of your past commentary on this topic is that you strongly
objected to not having the test suite output reflect that a given test
was "not ok ... TODO" in some way. I.e. even though I think
"test_expect_success" has the approximate *semantics* we want we
shouldn't use those.

But I think the combination of "test_expect_todo" and the "test_todo"
primitive should satisfy that, and will give us accurate assertions
about what we're actually doing now.

