Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6706C433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 16:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 975AD61205
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 16:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhKJQpf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 11:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhKJQpe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 11:45:34 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C92C061764
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 08:42:46 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id o8so12942040edc.3
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 08:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=4ynjAnq5i0bBXhcKQAeRqN+SC1VteiFhHvm7v6USo68=;
        b=MuQElfapwjAhBN1hl0nZjuvczQ0fMAXBBYK0/7I0Vnx/Tu8ny+KJWh2PVeCssTUmIm
         d58D1ESWGYzhyh+XPI9JGBFb7VL5j7HtSYzwjMBjqfaPwY+HL+VC47X9tp0ple7UHWJa
         EYNO0PvVhcJKMirA5YfUJHI8i3oFSPSNuv6Tzf/MxyBWWLlAMtLyfApby5pHYRYIFhuA
         bOVxHLwTZF3+oBywrnw9JarYinCxwfl7uCV5CnIioJGFaIAN/11n/chOcVyQAaCaMEQ1
         9cVlsUI7H+U5wgGiERpskFtsd/FhwLHbbPTEosfB1FdJRugkJHpq0H+bvi/zvjXmNNaL
         y26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=4ynjAnq5i0bBXhcKQAeRqN+SC1VteiFhHvm7v6USo68=;
        b=6DBP7bc4ouQxh85jWlH/VFi/CVy+eIXAt9QqK+kitMI72QSG8gYh7IVLMs33WpBzMm
         14CwYrbFiFbJzi2/CSPpCM/h8pRWOwip2FjeEfeBC2fD9VuCwYrb1DgwQXrZrCe6BBkY
         0tRvustDo27SO3NnUx60uQHuacelfiU5E90jzLIQPsjd5QXFS1Ezdrf5nHreq3MLb1tc
         9ks/JQW2Nd9Xq7hP9YRLfWfbnqyPKitGyqbIprmtKg6fuCBHLMYnd5sgNvEJTsP3DaMH
         BoDxHfONcfMlRrQgz0db1I9M4cpNeDNYICCgfTjOXvnm0bSQKDk+8ArqJ9sESfSsvLB7
         3LBA==
X-Gm-Message-State: AOAM5325uCbP+z0Dfm1wI4m9Nxcw54mONjXfWmOKhSZU4ynk3rw3NcXd
        MLkGxtoLuL5aOaZq8OpwWXsL5IC9fSJIyA==
X-Google-Smtp-Source: ABdhPJyyYgmAEjLU0ce07rp45r7uCIjVvrSDiN/ABpDeJt719vQQtQHYVfyG8UnfFB/RZs4ZHNWCkA==
X-Received: by 2002:a17:906:314e:: with SMTP id e14mr540648eje.165.1636562565103;
        Wed, 10 Nov 2021 08:42:45 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hq33sm137678ejc.119.2021.11.10.08.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 08:42:44 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mkqgN-0019Sa-QX;
        Wed, 10 Nov 2021 17:42:43 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] maintenance tests: fix systemd v2.34.0-rc* test
 regression
Date:   Wed, 10 Nov 2021 17:22:09 +0100
References: <patch-1.1-90172a8ddcc-20211102T142351Z-avarab@gmail.com>
 <patch-v2-1.1-44f0cafa16e-20211110T035103Z-avarab@gmail.com>
 <nycvar.QRO.7.76.6.2111101422030.21127@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <nycvar.QRO.7.76.6.2111101422030.21127@tvgsbejvaqbjf.bet>
Message-ID: <211110.86ilx0gdx8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 10 2021, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Wed, 10 Nov 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Fix tests added in b681b191f92 (maintenance: add support for systemd
>> timers on Linux, 2021-09-04) to run successfully on systems where
>> systemd-analyze is installed, but on which there's a discrepancy
>> between a FILE argument of "/lib/systemd/system/basic.target" and
>> "systemd/user/git-maintenance@.service" succeeding.
>
> Could you try to rephrase `there's a discrepancy between a FILE argument
> of "/lib/systemd/system/basic.target" and
> "systemd/user/git-maintenance@.service" succeeding` more clearly?

Sure. Briefly to test if X works our prereq should test if X can work,
not if Y can work. Will try to update it.

> Also, commit messages in git.git should not assume that every reader has a
> profound knowledge of `systemd`. The commit message needs to do a better
> job at explaining what is broken in the first place.

If I need to explain that in any detail I don't think this can go
forward.

I don't really understand systemd well enough and don't have time to do
so before the release.

This change seems to work well enough, and fixes the issue. What's
*really* going on with systemd here, is there a better way to do this? I
have no idea.

> The CI runs pass, after all, so it is unclear that there is anything
> broken that would need fixing to begin with.

Huh? It's unclear that we've got a portability-related breakage in
git.git because CI passes?

The CI environment is a fairly monolithic environment that tests some
very common setups. It's useful as a basic testing canary, but it's
pretty much useless for finding out if we've got any sort of portability
issues beyond a basic test/compile on linux/OSXWindows.

E.g. we routinely break builds and/or tests on the BSDs because of some
Linux/Windows/OSX-specific assumptions in our code. CI will catch some
of those, but not a large category of other issues.

So aside from this fix I don't think the GitHub CI can tell us much if
anything in this regard.

> [...]
>> We also need to pipe this output to FD's 5 & 6, to avoid mixing up the
>> trace output with our own output under "-x".
>
> We do not need to pipe to file descriptors 5 and 6. Other file descriptors
> would do, either. We need to redirect away from 1 and 2, is what this
> sentence should say.

Any other wouldn't do, because this is running in the context of
test-lib.sh, which squat on some of the others from 3..9.

Yeah, I should mention that, but you can't just pick any of 3..9 here.

> And the hint about `-x` suggests that even that is not true that we need
> to redirect 1, either, just 2. And we would only need to redirect 2 with
> shells that do not understand `BASH_XTRACEFD`. It would be best not to
> mention `-x` at all.

I'd like both stdout & stderr here, and
=20=20=20=20
    $ sh -c 'set -x; echo hi' >/dev/null=20
    + echo hi
    $ sh -c 'set -x; echo hi' 2>/dev/null
    hi

I don't think we have a way in the tests to easily hoist the "turn off
tracing" bit that test-lib.sh itself uses in similar cases, maybe I'm
wrong and there's some easier way to do this.

>> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
>> index 74aa6384755..5fe2ea03c1d 100755
>> --- a/t/t7900-maintenance.sh
>> +++ b/t/t7900-maintenance.sh
>> @@ -20,15 +20,16 @@ test_xmllint () {
>>  	fi
>>  }
>>
>> -test_lazy_prereq SYSTEMD_ANALYZE '
>> -	systemd-analyze verify /lib/systemd/system/basic.target
>> -'
>> -
>>  test_systemd_analyze_verify () {
>> -	if test_have_prereq SYSTEMD_ANALYZE
>> -	then
>> -		systemd-analyze verify "$@"
>> -	fi
>> +	# Ignoring any errors from systemd-analyze is intentional
>> +	systemd-analyze verify "$@" >systemd.out 2>systemd.err;
>
> The semicolon is superfluous.

We use it in other places as shorthand for "I mean to not have && here".

> It is a bit sad that we're now doing unnecessary work when
> `systemd-analyze` does not even exist.

It's a chicken & egg problem. How do you figure out if you're able to
run the command & get the output you expect without doing that?

Moving that to a test_have_prereq would just mean running it
twice. Unless there's some better approach here I've missed.

>> +
>> +	cat systemd.out >&5 &&
>> +	sed -n \
>> +		-e '/^Failed to load/d' \
>
> Lines starting with the prefix `Failed to load` are now deleted. Okay.
> Nothing in the commit explains why we can safely ignore those messages,
> though.

Quoting from it:
=20=20=20=20
    To do that ignore whatever exit code we get from "systemd-analyze
    verify", and filter its stderr output to extract the sorts of lines it
    emits on note syntax warnings and errors. We need to filter out
    "Failed to load", which would be emitted e.g. on the
    gcc135.fsffrance.org test box[1].

Isn't that covered by that mention of "Failed to load"? Can you suggest
a rewording you'd be happy with?

>> +		-e '/git-maintenance@i*\.service:/x' \
>
> Lines containing `git-maintenance@.service:` (or the same pattern with an
> arbitrary number of `i`s after the `@` character???) are exchanged with
> hold space.
>
> That does not look right.

It'll emit @.service or @i.service. I have no idea why, yeah the regex
is overly generous, but it doesn't hurt anything in this case (see
below)>

> Since this is a `sed -n` call, we would need an explicit `p` command to
> print anything. Therefore, the current code is a pretty expensive
> equivalent to calling `true >&6`: it succeeds, and it does not print
> anything.

Yes, like the buggy "if the prereq succeeds" code it replaced.

>> +		<systemd.err >&6 &&
>> +	rm systemd.out systemd.err
>>  }
>>
>>  test_expect_success 'help text' '
>> @@ -697,7 +698,11 @@ test_expect_success 'start and stop Linux/systemd m=
aintenance' '
>>  	# start registers the repo
>>  	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
>>
>> -	test_systemd_analyze_verify "systemd/user/git-maintenance@.service" &&
>> +	# If we have a systemd-analyze on the system we can verify the
>> +	# generated file.
>> +	test_systemd_analyze_verify "systemd/user/git-maintenance@.service" 5>=
out 6>err &&
>> +	test_must_be_empty out &&
>> +	test_must_be_empty err &&
>
> Since the function name has the suffix `_verify`, the verification part
> should be _inside_ that function, not outside.
>
> This patch is not clear enough to tell whether it actually fixes a
> regression worth fast-tracking into v2.34.0 or not.

Because I really don't know. Is it broken on literally one machine in
the world that I happened to have tested on, or more generally on the
sorts of OS version/whatever that has that systemd? No idea.

But the worst we'll do here is not run a test on some obscure setup.

Since the value of having the test is there if we just run it on some
setups that's fine. We should lean towards over-suppressing it to not
have "make test" in v2.34.0 fail on some platforms.

I.e. as the commit message and the commits it links to explain we're
really just asserting that when we change the systemd-specific code that
we're not introducing syntax errors or whatever. So as long as this test
runs for whoever is changing that (and they'd notice if it didn't) we're
OK.
