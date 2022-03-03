Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E9BC433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 10:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbiCCKXH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 05:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbiCCKXH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 05:23:07 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25208657BA
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 02:22:22 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id gb39so9609806ejc.1
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 02:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=EGuCk4if/bwMe9EYOQ2ktFnx15DYStm5RHl4409VAuw=;
        b=QamQt3Sc7ktsRc5rgxBUclyueKev7qBiVEvQSpAcYsMF0CT4C6YF1vNI4t1Hs9/zQ4
         7yAJA75u11jR0nRupXr+r1RNpCgeJHmpO4CjbhvnHifc+d+PV0ZMdSgtwlSrp7kyH+O4
         V3Bkep87Nr74hPGzPPKRvKwNBgbfKdoc2TGLVB3dWdopir/mCxlL5pj8y1mAXPnMXL/c
         lTIhI2lFzwhmppymgIeF3uezeOmZrpIs86eUQpNPXv5AiGmrBvMipVnD7eIP0U+HLlFs
         yNLfAhHRCoZ77fuUdbZF4KX3tPH3PfJxLCgTl+xLf1Y7llM4gqhq7oy7FDRr5dBEF+f5
         rWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=EGuCk4if/bwMe9EYOQ2ktFnx15DYStm5RHl4409VAuw=;
        b=ZEZoYZZV3hxTG8bxuNT9ODOXnqJvPDAevZUqVBXtW0/zzHqBH40wd0TcZqr0TDn8XW
         V947LL31J6TArCn5fAqgIS41Gz2gs242JkX+CUgdUw9oRcYpCAfv49urkO5GFWRKHAz0
         QxMfjpYkiDgcwNFyaPcjFUgWLbQuHPs/KuWTSc0JBFj4pWtZ7+o8h84IbaZhkY9WvHBh
         yy/9cWSWBh99LCZALTqMFgZP9uXWtHlftvxK05uOeGpFpWhqo/ER76JhQF9ZiSfl5Xb4
         WzWUeELoxO5yNLKjv6tvd7LP6cLlwgwod1GwVeO3vrn3NsPoz/a4AOMWxEhT3G6eLeJk
         IHgA==
X-Gm-Message-State: AOAM530hVYIBToCHxOm8QA1dliSTtuX3zysev8OpzspbxIEr2xdWcv19
        jEpKZe23YfWQAPTErDYTgTM=
X-Google-Smtp-Source: ABdhPJxMbWjTxtQmtTNioIfSvil6tOQqUxfe78Ze+Vh29isW+ltQi/BROe5hfgQ3tcxUak+DexpWVw==
X-Received: by 2002:a17:906:66cb:b0:6cf:e4f7:9504 with SMTP id k11-20020a17090666cb00b006cfe4f79504mr26825749ejp.142.1646302940455;
        Thu, 03 Mar 2022 02:22:20 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id u23-20020a17090626d700b006cfcd39645fsm554660ejc.88.2022.03.03.02.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 02:22:20 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nPibD-000PjI-FG;
        Thu, 03 Mar 2022 11:22:19 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 00/15] tests: don't ignore "git" exit codes
Date:   Thu, 03 Mar 2022 11:13:02 +0100
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
 <76a1ff22-3eb0-08fb-5aa9-e612ee5b522f@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <76a1ff22-3eb0-08fb-5aa9-e612ee5b522f@github.com>
Message-ID: <220303.86fsnz5o9w.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 02 2022, Derrick Stolee wrote:

> On 3/2/2022 12:27 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> This series fixes issues where we ignored the exit code of "git" due
>> to it being on the LHS of a pipe, or because we interpolated its
>> output with $() in a "test" construct, or had missing &&- chains in
>> helper functions etc.
>>=20
>> This series is not made by string-replacing things in our test suite,
>> if it was it would be much larger. These are all tests I've seen real
>> hide real failures under SANITIZE=3Dleak, either on current "master", or
>> in combination with various local leak fixes I've got unsubmitted.
>
> My first reaction was to check that Subham was on the CC line (yes)
> because they have been working in this space, too. Your focus on
> examples that break SANITIZE=3Dleak is appreciated so there is room
> for that project.

Yeah, I'm certainly not meaning to steal this whole "hide exit code"
microproject, and there's *a lot* more to chew on there :) (and I have
no intention of doing the rest).

But hopefully this series also serves as a nice tour-de-force through
the test suite showing a wide variety of exit-code-hiding cases for any
future work in the area.

I.e. the "git on theon LHS of a pipe" is an overly narrow definition of
it.

But then again I think these should also all be covered in passing by
t/README's "don'ts" list.

>> In cases where I was starting to fix a pattern in a file I'd fix the
>> rest of the file if it was easy, but otherwise these are all cases
>> where I ran SANITIZE=3Dleak, had a test pass, but having ASAN_OPTIONS
>> log to a file revealed that we had memory leaks within that test.
>
> Neat trick.
>
> The patches in this series clearly do the right transformations to
> expose these errors at the appropriate time. The only time I got
> hung up was patch 11 where test_expect_failure was swapped for
> test_expect_success (while also dropping a test_must_fail inside
> the test). The double-negative confused me at first, but in the end
> the patch works as-is.
>
>> As an aside we still have various potential issues with hidden
>> segfaults etc. in the test suite after this that are tricked to solve,
>> because:
>>=20
>>  * Our tests will (mostly) catch segfaults and abort(), but if we
>>    invoke a command that invokes another command it needs to ferry the
>>    exit code up to us.
>>=20
>>  * run-command.c notably does not do that, so for e.g. "git push"
>>    tests where we expect a failure and an underlying "git" command
>>    fails we won't ferry up the segfault or abort exit code.
>
> Perhaps run-command.c could auto-exit for certain well-known error
> codes that could only happen on certain kinds of failures (segfault,
> for example). A simple die() might be something that is expected to
> be handled by the top-level command in some cases.

Yes. I have a local WIP patch to make it do that.

Basically just set a a global "uh oh, one of our ran commands segfaulted
or abort()-ed, here's that exit status".

Then when we do the real exit() (which we always intercept due to the
trace2 logging needing to do so) an non-zero exit() of e.g. status 128
will be changed to the appropriate exit status of that segfault or
abort().

We'll thus ferry such exit codes upwards, clobbering whatever the
"desired" exit code of e.g. "git pull" would have been (but that's a
feature in this case).

One thing I got hung up on is that it's relatively straightforward for
the wait_or_whine() case in run-command.c, but I didn't look into how to
do that with the pthread_join() we do for finish_async(), which
e.g. happens if the multiplex'd dialog exits in this way.

>>  * We have gitweb.perl and some other perl code ignoring return values
>>    from close(), i.e. ignoring exit codes from "git rev-parse" et al.
>>=20
>>  * We have in-tree shellscripts like "git-merge-one-file.sh" invoking
>>    git commands, and if they fail returning "1", not ferrying up the
>>    segfault or abort() exit code.
>
> These are more involved and harder to evaluate. Add them to the pile
> of projects for new contributors?

FWIW those are relatively easy, for the first:

    use v5.10.1;
    use autodie qw(close);

And for the second just go through the relatively small amount of such
remaining shell code and convert:

	if ! git ...
	then
		exit 1

To:

	git ...
	code=3D$?
        if test $code -ne 0
	then
		exit $code

Or whatever.
=20=20=20=20

=20=20=20=20
