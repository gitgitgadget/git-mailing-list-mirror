Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC82C433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 15:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243486AbiCXPkx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 11:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243459AbiCXPkv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 11:40:51 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C596CE0FF
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 08:39:18 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id g20so6071379edw.6
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 08:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=lSLNDKqUeNstRMFaq2MQQ91X8Nd3uSgwQeRcX7XZvz0=;
        b=ePrwKfJl81pG4X3pJ0W30a6cM+G/wnOGS3phG0YGwPIYZY7xDEfcpeOXlvfDqrk93y
         7gPUosYD92zKwzdRO0WT0EjeZHzHvcxle2W3r1+a7NkFQjx4sSIZhKh+h1CqWSuT+CU0
         GuDQzryDZG6O78TlT96XQxL15m/MCWoEywNnp2OWr0n2i4wFdAkD8D4JbF9QIfUBY2UR
         LRGtM764wUWYKWT2AoJCQrbN2/qFgGONoF9ovzFBY6tafns69c13+FeXDgOxUjhk0KFs
         bxWsqUoZbgIk05LAYBfJHdZpCjkGGHdD4bM43PzQ4+4WkJEUScpvN+Ta9I+QxJth7Nn1
         Cpvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=lSLNDKqUeNstRMFaq2MQQ91X8Nd3uSgwQeRcX7XZvz0=;
        b=3VjfCtSuC+++BrZvqnqkDUU0Kqpaipx2vDZxfzjFeo+DOXpYrin0wzh3OCCfbVqVsv
         YMTbbmsAutq8WmNRdat+rES3cdkKzOKv0xPWVoHibqQxvOScq6n1e1MrSP+z3S9f9nQ7
         1/mD5ZCG/qw+1WMlVu205R6ERmvx04gC6+WTUXPoQy63+I228E2/bk4fXKP5zS59+vtU
         DzxIN+ep+2KWT/eI9gk4W6ATqgpSQWpAJAJRVa5YsJQ58yCGwf+SrtvMVZCrOXxC1yLQ
         b+yNch5Tudp1zdU1dYqPdLP25Avs9JH7s/Ce8+/yLUrtFkzpcckdItZBO9yCLULeKUcg
         +Pbw==
X-Gm-Message-State: AOAM531sdz17Ox7+0XnsUkTK4uUVVwiwd9HyCPD6J87mg7ldgzmDoSFD
        8UOwJ/+J0VNcqnDq5ZGRItk=
X-Google-Smtp-Source: ABdhPJxqIZreG1VWOk52zM14vJBqUOxMvua+NTJAirR3pAFaqtk4teShlZC9opnuoaS7DgWBrTLH2Q==
X-Received: by 2002:a05:6402:1650:b0:418:fbfc:971b with SMTP id s16-20020a056402165000b00418fbfc971bmr7253720edx.351.1648136356940;
        Thu, 24 Mar 2022 08:39:16 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f6-20020a0564021e8600b00412ae7fda95sm1586225edf.44.2022.03.24.08.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 08:39:16 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nXPYR-001g6u-S9;
        Thu, 24 Mar 2022 16:39:15 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: A "why TAP?" manifesto (was: [PATCH] test-lib: have --immediate
 emit valid TAP on failure)
Date:   Thu, 24 Mar 2022 14:48:42 +0100
References: <patch-1.1-47b236139e6-20220323T204410Z-avarab@gmail.com>
 <nycvar.QRO.7.76.6.2203241434360.388@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <nycvar.QRO.7.76.6.2203241434360.388@tvgsbejvaqbjf.bet>
Message-ID: <220324.8635j7nyvw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 24 2022, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Wed, 23 Mar 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Change the "--immediate" option so that it emits valid TAP on
>> failure. Before this it would omit the required plan at the end,
>> e.g. under SANITIZE=3Dleak we'd show a "No plan found in TAP output"
>> error from "prove":
>>
>>     $ prove t0006-date.sh ::  --immediate
>>     t0006-date.sh .. Dubious, test returned 1 (wstat 256, 0x100)
>>     Failed 1/22 subtests
>>
>>     Test Summary Report
>>     -------------------
>>     t0006-date.sh (Wstat: 256 Tests: 22 Failed: 1)
>>       Failed test:  22
>>       Non-zero exit status: 1
>>       Parse errors: No plan found in TAP output
>>     Files=3D1, Tests=3D22,  0 wallclock secs ( 0.02 usr  0.01 sys +  0.1=
8 cusr  0.06 csys =3D  0.27 CPU)
>>     Result: FAIL
>>
>> Now we'll emit output that doesn't result in TAP parsing failures:
>>
>>     $ prove t0006-date.sh ::  --immediate
>>     t0006-date.sh .. Dubious, test returned 1 (wstat 256, 0x100)
>>     Failed 1/22 subtests
>>
>>     Test Summary Report
>>     -------------------
>>     t0006-date.sh (Wstat: 256 Tests: 22 Failed: 1)
>>       Failed test:  22
>>       Non-zero exit status: 1
>>     Files=3D1, Tests=3D22,  0 wallclock secs ( 0.02 usr  0.00 sys +  0.1=
9 cusr  0.05 csys =3D  0.26 CPU)
>>     Result: FAIL
>
> The commit message is strong on the what, very strong in giving verbose
> output that might or might not clarify the intention, and a little weak in
> the why and the greater context.

I thought "so that it emits valid TAP" was sufficiently
self-explaining. I.e. we emit this machine-readable format, but in this
edge case our output is invalid TAP, now it's valid.

Re the verbose output: The last time I submitted patch for tweaking the
TAP output I got the feedback (from Junio in
https://lore.kernel.org/git/xmqq7dad10oy.fsf@gitster.g/) that a more
explicit example was wanted. So I included it this time around.

> In the broader story arc, I wonder why we're even bothering with TAP
> anymore because it seems that the world has moved on to more powerful file
> formats to represent test output, such as JUnit XML, that can be parsed,
> rendered and analyzed by powerful special-purpose applications.

[I guess that warrants a $subject change]

A few things, grouped by heading:

=3D=3D It "can be parsed"

First, the "[TAP ]can['t] be parsed" part of that is wrong.

As your own CI patch series[1] shows we currently parse the entire TAP
output of our test suite on every CI run. Otherwise prove(1) couldn't
have come up with this (quoting from your [1]):
=09
	Test Summary Report
	-------------------
	t1092-sparse-checkout-compatibility.sh           (Wstat: 256 Tests: 53 Fai=
led: 1)
	  Failed test:  49
	  Non-zero exit status: 1
	t3701-add-interactive.sh                         (Wstat: 0 Tests: 71 Faile=
d: 0)
	  TODO passed:   45, 47

That's the result of a compliant TAP parser parsing all of our test
output, which has worked for all our tests (sans edge cases like the one
being fixed here) for a long time.

Let's not go into how you don't like that summary output, that's not the
point.

That's a UX layer presenting something from the fully parsed output, the
point is that it *is* not only parsable, but it's currently *being
parsed* by our toolchain on every CI run.

=3D=3D Human readable

Unless you're expecting us to eyeball something like this verbose XML on
ad-hoc runs like:
=09
	$ ./t0013-sha1dc.sh --write-junit-xml --tee
	ok 1 - test-sha1 detects shattered pdf
	# passed all 1 test(s)
	1..1

Which for JUnit is:
=09
	$ cat out/TEST-t0013-sha1dc.xml=20
	<testsuites>
	  <testsuite name=3D"t0013-sha1dc" timestamp=3D"2022-03-24T14:20:27" time=
=3D"0.065762">
	    <testcase name=3D"t0013.1 test-sha1 detects shattered pdf&#x0a;" class=
name=3D"t0013" time=3D"0.029818">
	    </testcase>
	  </testsuite>
	</testsuites>

You're going to end up with 2 output formats, a human readable one and
some secondary also-machine-readable output.

TAP isn't perfect, but it's uniquely suitable as a format for the sort
of testing we do, because it's explicitly machine-readable format that's
designed to also be human readable.

Which isn't a goal with JUnit. Perhaps some XML enthusiasts would argue
that point. Sure, you *can* read it, but it's not exactly pleasing nor
aiming to reduce verbosity.

The JUnit we currently emit is >2x the verbosity of TAP by lines, and
~3x as much by byte count (all of which a human needs to occasionally
skim):
=09
	$ rm -rf out; ./t0001-init.sh --write-junit-xml --tee |wc ; wc <out/*xml
	 63   488  2553
	 130  615  7592

=3D=3D It's trivial to produce

Most output formats are way more picky about what constitutes a valid
payload than TAP is, which is why for the TAP v.s. JUnit output the
number of syscalls we need shows this drastic difference:
=09
	$ strace --summary-only -f ./t0001-init.sh --tee 2>&1 | tail -n 1
	100.00    3.703689          21    171581     13587 total
	$ strace --summary-only -f ./t0001-init.sh --tee --write-junit-xml 2>&1 | =
tail -n 1
	100.00    6.424080          22    285903     21097 total

I.e. the implementation of it just needs an "echo" or whatever, whereas
the XML one is shelling out for pretty much every line it prints to
escape things.

I'm you might argue about the hatefulness about shellscripting there and
how we should rewrite everything in C.

I don't disagree with that point in the abstract, but realistically
we'll be needing to deal with the shellscript-based test suite for the
foreseeable future.

=3D=3D It's more flexible

The JUnit we write out is just the summary output, but when you run a
test with e.g. "--verbose -x" the result is valid TAP. I.e. TAP parser
will take this:

	$ ./t0013-sha1dc.sh -vx 2>&1|wc
	38     165    1104

And grab the lines matching "ok" "not ok" etc., and *ignore everything
else*.

This means that we're able to use it for things that you just couldn't
use JUnit for, e.g. the POC I have here where we pair up our "--verbose
-x" output with the failure summary, i.e. show what specific test things
belongs t [2]:

=3D=3D It doesn't matter if nobody else uses it

Or: "we don't need a 2nd machine-parsable format".

I think your "the world has moved on to more powerful file formats to
represent test output" is a valid concern.

I.e. we don't want to have a test suite output that we can't pretty
render on whatever the latest fancy test CI renderer is is a completely
valid concern, whether that's Azure or GitHub CI.

But the implicit assumption there seems to be that TAP isn't rather
trivially machine-parsable, and that we aren't already running a parser
for it. It is, and we are.

Because of that we can just have a post-transformation step of changing
TAP into whatever other format you'd like.

So you can have JUnit, GitHub CI Markdown or whatever, it should just be
produced from the TAP output.

I think that your addition of JUnit & GitHub CI Markdown (in [1]) is
much better done like that. It avoids the complexity of N output formats
in test-lib.sh. A transformer for your desired format probably exists
already (or could trivially be adjusted for a new format):

    https://metacpan.org/search?q=3DTAP%3A%3AFormatter

=3D=3D Everyone uses it

Well, <citation needed>, but while per the above I don't think wide use
of TAP even matters I think being concerned about lack of tooling
support for it is strange.

I'm fairly sure it's the single most widely supported test output format
of any kind. Because of how trivial it is to parse and implement I'm
pretty sure it's the most widely-supported machine-readable test output
format of any kind.

*Maybe* something like JUnit has (near) parity if we're counting format
transformers-to-transformers, but I'm fairly sure not if it wouldn't be
allowed to "cheat" by making use of TAP as an intermediate format.

=3D=3D Cases where TAP isn't good enough currently

Someone familiar with our test tooling might thing "wait, TAP with
--verbose is valid TAP?" because since 614fe015212 (test-lib: bail out
when "-v" used under "prove", 2016-10-22) we have been refusing to
produce it in that case:

    $ prove t0013-sha1dc.sh :: --verbose
    Bailout called.  Further testing stopped:  verbose mode forbidden under=
 TAP harness; try --verbose-log
    FAILED--Further testing stopped: verbose mode forbidden under TAP harne=
ss; try --verbose-log

Fixing that is needed for the approach in [2] to work 100% of the time,
I have working patches to that (which as it happens, are currently
blocking on conflicts with your [1]).

I.e. the problem is that if we're expecting a line starting with "ok" or
whatever the firehose --verbose output from the test itself might emit
such a line, and confuse the parser.

The solution was rather trivial in the case of TAP, just have
test-lib.sh emit a configurable prefix string before any TAP syntax it
emits, then have a "tee" tool we ship as a test helper munge that after
the fact:

    https://github.com/avar/git/commit/2358ff8c3a7
    https://github.com/avar/git/commit/2ae430bfce7

=3D=3D Handling the long-tail of machine-readability

Continuing the above: I don't think a solution to that sort of thing is
really viable with anything that doesn't behave like TAP.

We have tests doing things like starting a background daemon that will
racily emit output its output *in the middle of another* test.

As in not theoretically, it's a case I actually had to debug & test to
get the above commits working. The JUnit emitter punts on it entirely by
not including the "--verbose -x" output at all.

The rather easy solution for TAP explicitly relies on its "non-syntax"
of considering every line it doesn't explicitly classify as syntax as
something it'll pass through as "output".

Those lines thenh need no further escaping. They can pretty much be
latin-1, UTF-8, your favorite bits from /dev/urandom etc.. It doesn't
matter.

Whereas for e.g. any XML, JSON etc. format where things are syntax by
default you'd need to intercept all that output to strip "<" and the
like from it.

Even if you did that you probably wouldn't have anywhere sensible to
stick that output, you probably already emitted the beginning/end
markers for "here's the verbose output for test N" already, which would
require complexity a TAP emitter wouldn't need.

> Apart from taking reviewer time away from such more powerful avenues to
> make sense of our failing tests, the diff does not really hurt, so I have
> no objections against integrating this patch.

I hope the above will summarize why those suggested avenues aren't "more
powerful", quite the opposite.

I think if you did the legwork of trying to make those formats represent
our "--verbose -x" output in a machine-readable way and tried to
roundtrip that parsed output (which I have done for TAP) that you'd find
it somewhere between "much, much harder" and "impossible" to do the same
for those other formats in the context of our test suite.

So yes, I agree that there's a lack of focus here, and we should put
more wood behind fewer arrows in terms of making our test output
machine-parsable.

The [2] I mentioned above shows the sorts of wins we can get from that,
i.e. emitting *only* the lines of test output relevant to the specific
failures we had.

That's really useful, and something you inherently can't do with the
sort of approach you're going for in your [1] series.

At least not without buffering the whole thing & parsing it, at which
point you're back to square #1 in terms of fixing the sorts of issues
noted in "Handling the long-tail of machine-readability" above.

1. https://lore.kernel.org/git/pull.1117.git.1643050574.gitgitgadget@gmail.=
com/
2. https://lore.kernel.org/git/220302.86mti87cj2.gmgdl@evledraar.gmail.com/

