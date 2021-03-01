Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D2DC433E0
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 13:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B13C64E38
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 13:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235900AbhCANzW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 08:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235807AbhCANzW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 08:55:22 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6EFC061756
        for <git@vger.kernel.org>; Mon,  1 Mar 2021 05:54:41 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id f6so5046351edd.12
        for <git@vger.kernel.org>; Mon, 01 Mar 2021 05:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Om7sMMZ8s0xzoNERtuaxywh3VglgSNhuin208shrDno=;
        b=tBny+n1K9Tu6q4vsmhoOC8n30zZtwE9J9yH2stDZ55uKAZlxX+CkbUgWh2pOFBv+Yp
         z8GfY5bxHLogwJIdZ8bFNzHVKYQO+3IpnKtEPnTzkn0b3miXDQlwfwbYMsR+W2ZJls5P
         QGrJxNdt1WjVhtP7X3tBYvlPcdOcSk0AAg/C9aEW74jL7G9NWeorQZlWcfk7SeKgsZQU
         alTR2wVJ7UgV4qXaP1Sznx7dJHeyU3rT1DyeLWsxngUTpYDvbhFHf9GSBDxOfUB7pHbG
         IbAQcoIXJTZni3U6ocER9+usrPxDbqgpEL+D+w/Yr0I75Wxw8KVnTKKbBA6M5TTg+Orn
         EaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Om7sMMZ8s0xzoNERtuaxywh3VglgSNhuin208shrDno=;
        b=H1e4eo2oqoiCn7LIbYMWsIEamr681sq3t7AoNc7gwU6EZaHoOygs/ZbqAWWUtg28Ke
         QvzxMeGL9nOOXPzscE2UlhwcOXVwbnGkzA2mTwN9dSa6NwnrliSMvx3DrB/MT3XCXbSu
         36g9LXiWxz5sQUHK/PJQ5jlQGPGQwQh6fVqA/zbF/eI77JPtyfzeo3E1GsGXGv/yhOlT
         hBcJ+Gv4HxFbeV+o5phkV22OqhYcNPormYi5tVVK29L1FF6lqDk8GMqaBRBD94tEIvCr
         a4kAkyiMA30Zc3OIwPDm5vPL8Dbewi5wxaXVExi4q19po9gwxf8z7rzoS4dKtf1ER2WM
         V2qQ==
X-Gm-Message-State: AOAM530JgG3vBJKGs2fyHb4uYa7BUrZ5MiWhxVrbb6U2XmXfx+H2mKVz
        NFH9Qr7eUrFcvcA7RezViGo=
X-Google-Smtp-Source: ABdhPJzeoF+1GPPMYuoqRlRfTJU5+hVI8ZGsSQKZbil4+Y3aQdnuIA7ik1fnku5qtR1vHKglH0IyrA==
X-Received: by 2002:aa7:c618:: with SMTP id h24mr6139064edq.358.1614606880070;
        Mon, 01 Mar 2021 05:54:40 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id s13sm13538127edr.86.2021.03.01.05.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 05:54:39 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH/RFC] test-lib: make --verbose work under prove
References: <20161021104107.vh3bjx6x6pd6izat@sigill.intra.peff.net>
 <20161021104759.hx6q7u66r3ll7l44@sigill.intra.peff.net>
 <87tupwj5y5.fsf@evledraar.gmail.com>
 <YDy5LDsnF1THmvUw@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YDy5LDsnF1THmvUw@coredump.intra.peff.net>
Date:   Mon, 01 Mar 2021 14:54:33 +0100
Message-ID: <87r1kzj7xi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 01 2021, Jeff King wrote:

> On Sun, Feb 28, 2021 at 09:25:06PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> As explained in 452320f1f5 (test-lib: add --verbose-log option,
>> 2016-10-21) combining the "--verbose" option with the TAP-parsing
>> "prove" utility would result in broken tests.
>>=20
>> This is because "prove" expects valid TAP on stdout, and if there's a
>> stray line starting with "ok", or other invalid TAP syntax it will
>> error on the test.
>>=20
>> In 452320f1f5 numerous potential methods are discussed for dealing
>> with this problem, but not the one implemented here, which I think is
>> a much simpler approach.
>
> I guess I don't really have an objection to this method existing, but I
> don't see the point of it now. The original problem has been solved, and
> I don't find this any simpler than --verbose-log (on the contrary, I
> find it much more complicated). So I don't know why I would want to use
> this instead.

I guess that's the problem with picking something from the middle of a
local WIP series I have, I forgot to state the end goal of the whole
thing.

The point is to be able to run "prove -v <test> :: --verbose" and see
the verbose output. See the commit message for when TAP was added for
examples: 5099b99d25 (test-lib: Adjust output to be valid TAP format,
2010-06-24)[1].

Because it's valid TAP with this patch you can easily parse the output:

    HARNESS_ACTIVE=3Dt ./t5547-push-quarantine.sh --verbose -x >t5547-push-=
quarantine.sh.tap
    perl -MTAP::Parser -MYAML::XS -wE '
        my $parser =3D TAP::Parser->new( { source =3D> "t5547-push-quaranti=
ne.sh.tap" } );
        my @lines;
        while ( my $result =3D $parser->next ) {
            push @lines =3D> $result;
        };
        say Dump \@lines
    ' >t5547-push-quarantine.sh.tap.parsed

Gives you a stream like:

    [...]
    - !!perl/hash:TAP::Parser::Result::Unknown
      raw: + chmod +x dest.git/hooks/pre-receive
      type: unknown
    - !!perl/hash:TAP::Parser::Result::Unknown
      raw: ''
      type: unknown
    - !!perl/hash:TAP::Parser::Result::Test
      description: '- create picky dest repo'
      directive: ''
      explanation: ''
      ok: ok
      raw: ok 1 - create picky dest repo
      test_num: 1
      type: test
    - !!perl/hash:TAP::Parser::Result::Unknown
      raw: ''
      type: unknown
    - !!perl/hash:TAP::Parser::Result::Unknown
      raw: 'expecting success of 5547.2 ''accepted objects work'': '
      type: unknown
    - !!perl/hash:TAP::Parser::Result::Unknown
      raw: "\ttest_commit ok &&"
      type: unknown
    - !!perl/hash:TAP::Parser::Result::Unknown
      raw: "\tgit push dest.git HEAD &&"
    [...]

The eventual goal was to make ci/print-test-failures.sh and the code
that cares about t/test-results/* capable of working with output like
that.

So e.g. you could optionally get summarized output about just the
specific tests that failed, not all the output for failing tests, as
ci/print-test-failures.sh is spewing out now.

I also wanted to have something similar to Documentation/doc-diff but
for smart test diffing. E.g. now we have an rc0 out, and the set of
tests broken on various test boxes I have access to is different than in
the last release.

But it's a pain to summarize that output currently (or at least I've
always written one-off tools for it).

By being able to parse the tap it's easier to massage that output and
e.g. spew it into a database, or into two text files friendly to "git
diff --no-index".

But yes, the implementation isn't any simpler, it's more complex than
just a "tee -a", but I think it's worth it for machine-readable verbose
test output.

1. As an aside this is a bit tricker/broken in the prove utility than
   when I wrote that code initially, sometimes it won't show you verbose
   output:
   https://github.com/Perl-Toolchain-Gang/Test-Harness/issues/105
