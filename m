Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9DFE1F404
	for <e@80x24.org>; Sat,  1 Sep 2018 20:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeIBAmg (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Sep 2018 20:42:36 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:32877 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeIBAmg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Sep 2018 20:42:36 -0400
Received: by mail-ed1-f68.google.com with SMTP id d8-v6so3327603edv.0
        for <git@vger.kernel.org>; Sat, 01 Sep 2018 13:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=dDGPnpx7gzslk8t1lxPYc14duexKsQRxOt78nBNllNU=;
        b=czcuXrudAuTuJTEOJaoOaESPJ+z3wRXrrKuDKo59EmAPAx305uSg6OAa6ibYueHIze
         FLGssoSMcgB4L59qmcR3sUZFMPN9EL5PrRozjT/qlqhPJ4H0KhZVCZizE4aB1/D1YMBq
         +u7ctgSIPSL5GGSdb24O0OeUsYVa9AnUKIdLOIVt8S5kCY93CkiU0KZMRknf3diUuplR
         ic8tZTuyiMTax6LLHwCmMB1q/jK5WzDH3ltSGgwTV39Vpv1f0Xvom5VFUUZdkGFOBi1i
         7u6g+MdKv26dly+xiwZcxNB0eHve4PHouGh7cy+nIyWYqefd4z2yhHvG8ZdGDGr73hUG
         O71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=dDGPnpx7gzslk8t1lxPYc14duexKsQRxOt78nBNllNU=;
        b=jDextTYKuztlp59XE7LSwFggb5BYT5ryl/rW8/NtJJFbEI6+LYUathCmhHqrrlCN3u
         nRmXCWQDbBJopE/51gbZn3CTT0GTyd+ub6qupLHBDvcPfvNZewvUotXfU0Es4kdwdrVl
         d+ILENsI+anvX6bQ5SkEjCv2qED2mPjWuqQJf/jUVTXTBTNPf33ARKJq1ipGgemdRD+D
         92hJxtFlwySfrHIxLJXtFeTda4WYdu95MJ5a9TX+fQtldkqnPaX15JkpYqRt6HhZrYJU
         GpGnOBAYMD9GmAjCA/KjRpEuNrmbxszVBC2JTS/5A0TRTOHg62y56Z3SJme1EnKryzTQ
         2BFw==
X-Gm-Message-State: APzg51Dp/xfnt66cDsMs3E6ctBKKI0WpU1PjEhEGwENdHqtJq7CKCL3p
        SRtIH2cHpdYW0peS5/hdY/c=
X-Google-Smtp-Source: ANB0Vdbe2qMK8Xmklqeta0Jdt98nezZUTOqa68FYWImSqPel2Fo6fUuPDmUAwRovUry2bMDSfEEyLA==
X-Received: by 2002:a50:a267:: with SMTP id 94-v6mr24394488edl.189.1535833767008;
        Sat, 01 Sep 2018 13:29:27 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id r11-v6sm5342094edh.32.2018.09.01.13.29.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Sep 2018 13:29:26 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: [PATCH 2/4] t5310: test delta reuse with bitmaps
References: <20180901074145.GA24023@sigill.intra.peff.net> <20180901074813.GB25461@sigill.intra.peff.net> <20180901080316.GA25852@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180901080316.GA25852@sigill.intra.peff.net>
Date:   Sat, 01 Sep 2018 22:29:25 +0200
Message-ID: <87va7parmi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Sep 01 2018, Jeff King wrote:

> On Sat, Sep 01, 2018 at 03:48:13AM -0400, Jeff King wrote:
>
>> Commit 6a1e32d532 (pack-objects: reuse on-disk deltas for
>> thin "have" objects, 2018-08-21) taught pack-objects a new
>> optimization trick. Since this wasn't meant to change
>> user-visible behavior, but only produce smaller packs more
>> quickly, testing focused on t/perf/p5311.
>>
>> However, since people don't run perf tests very often, we
>> should make sure that the feature is exercised in the
>> regular test suite. This patch does so.
>
> This, by the way, is the crux of how such an obvious and severe bug made
> it to 'next'.
>
> The original series was tested quite extensively via t/perf and in
> production at GitHub. When I re-rolled v2, the only change was the
> addition of the assertion, so I didn't bother re-doing the perf tests,
> since they're slow and there wouldn't be a measurable impact.
>
> I did run the normal test suite (as I'm sure Junio did, too) as a
> double-check for correctness, but as we noticed, the code wasn't
> actually exercised there.
>
> Nor had I yet backported the revised series to the version we run at
> GitHub, so it hadn't been run there, either.
>
> And all of that coupled with the fact that it only triggers with
> bitmaps, so day-to-day use of the buggy Git (like Junio trying to push
> out the result ;) ) wouldn't show it.
>
> Anyway. Not that exciting, and kind of obviously dumb in retrospect. But
> I think it was worth analyzing to see what went wrong. If there's an
> immediate lesson, it is probably: add tests even for changes that aren't
> really user-visible to make sure the code is exercised.

Test-wise, isn't the problem rather that that we didn't have something
like what's described in t/README as "Running tests with special setups"
for bitmaps? I.e. stuff like GIT_TEST_SPLIT_INDEX=<bool>, or running it
with GIT_FSMONITOR_TEST=$PWD/t7519/fsmonitor-all to stress the fsmonitor
code.

That comment b.t.w. is not meant as a "you should have done that!"
blame, but just musings on how we could make things better.

Git has things like bitmaps, midx, commit graph, and probably a few
other things I'm forgetting which all have their own tests, but really
fall more in the category of something like the split index in that they
can potentially impact every test in some unexpected way.

So we could add some option to the test suite to e.g. run a custom
command before every "git push" or "git fetch", and then just do a gc
with a repack/commit graph write/midx write etc. in that codepath, along
with (in the case of stuff like midx) setting any neede config knobs to
turn it on.

Of course the utility of that sort of thing is limited unless we have
some dedicated smoke testers or CI capacity to run the various
combinations of those options. But FWIW when I build our own in-house
git I build the package with:

    # Set "false" to test the build procedure itself
    if true
    then
        export BKNG_GIT_HARNESS_OPTIONS="%{?_smp_mflags} --state=failed,slow,save --timer"
        echo Testing without any custom options:
        (cd t && /usr/bin/prove $BKNG_GIT_HARNESS_OPTIONS t[0-9]*.sh)

        echo Testing while roundtripping everything through the fsmonitor codepath:
        (cd t && GIT_FSMONITOR_TEST=$PWD/t7519/fsmonitor-all GIT_SKIP_TESTS="t3404.7 t7411.3 t7411.4" /usr/bin/prove $BKNG_GIT_HARNESS_OPTIONS t[0-9]*.sh)

        echo Testing split index
        (cd t && GIT_TEST_SPLIT_INDEX=true GIT_SKIP_TESTS="t3903 t4015.77" /usr/bin/prove $BKNG_GIT_HARNESS_OPTIONS t[0-9]*.sh)

        echo Testing uncommon pack modes. See ci/run-tests.sh in git
        (cd t && GIT_TEST_FULL_IN_PACK_ARRAY=true GIT_TEST_OE_SIZE=10 /usr/bin/prove $BKNG_GIT_HARNESS_OPTIONS t[0-9]*.sh)
    fi

Those skipped tests are various intermittent bugs related to those
codpaths which I haven't had time to track down / report yet.

So if there was a "test bitmaps everywhere" mode that would have been
caught during the build, unless I've misunderstood how this particular
bug manifests, but then again, it happened on just a plain git.git after
repack, so wasn't any bitmap + push pretty much all that was needed?, I
haven't read your patches in any detail.

B.t.w. for Ben or anyone else who knows about the fsmonitor part of
this: I've long been running the whole test suite with
`GIT_FSMONITOR_TEST=$PWD/t7519/fsmonitor-all prove ...` (also along with
GIT_TEST_SPLIT_INDEX=) after all the main tests pass as additional
stress testing.

It's not documented under the "special setups" section. So I was going
to add it, but I see that in 5c8cdcfd80 ("fsmonitor: add test cases for
fsmonitor extension", 2017-09-22) it's documented that you should also
set GIT_FORCE_PRELOAD_TEST=true, is that needed for GIT_FSMONITOR_TEST?
Or is it yet another mode, and if so to be combined with fsmonitor in
particular, or stand-alone?

> There may be a larger lesson about tracking code coverage, but I don't
> know that most general code coverage tools would have helped (any
> overall percentage number would be too large to move). A tool that
> looked at the diff and said "of the N lines you added/touched, this
> percent is exercised in the test suite" might have been useful.

This would be very useful.
