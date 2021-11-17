Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95BEC433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 12:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9241C61BC1
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 12:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237092AbhKQMFj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 07:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhKQMFi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 07:05:38 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4677AC061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 04:02:40 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id b15so10000380edd.7
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 04:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=vITmmmQV0u1C/kY0ttJHvqCoRaB3jGfZLqtazTl1XR4=;
        b=GYu1OO4BrnEnlc8/eHlTX+gjH8a/YNEpZ/65R/OvRiR+zmyO3A4FSIjm/hIpsnhn1A
         psZwPa+FqoETkPqXIuZ83UnY+ss/fnNyVL46FKIEel6pfGaLmJ1z/9UdgS+oImQnEF4m
         s/2OwiEF51SKoDyYvoBQ+0ahP8oY2nD75uNHMv4aYNtdO7kc16eUlIUB3apVM3+kRKQm
         kpzc/TaOUrswZez0qT6jD/Rrz7GzUBwqHwaTyHcVaeOUSMpXXLgrhs1fjU3DhP8iyozq
         8b5QUHBNBnszuKJMErAWE++yVkw9aN6FsenUbhgVE1woyWTu0Q9uYNFr3/UGFhxoDR4d
         mL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=vITmmmQV0u1C/kY0ttJHvqCoRaB3jGfZLqtazTl1XR4=;
        b=0jdD9W8yOWwe250n/OGv45Byt7pME38VsEQJWcVy0pjdPbuJeSQ4bxH/fgNEUmzbYD
         grm+liYtrIw6A3afxKiNZLAJ4RRDE882WxrNrWgMe6gdODiGyiC4NIDtWaZ+Yh9r+kP2
         VplgE0lq+yjymT1XuHzDkOHA5y2/VIsBCP407jbdaf9Oohe3qu43+94ZEdCs/iLFTnqb
         l1UT0g/KBOa8+4s/b1YTSdYiktNRmlcqjz8/NM3uNGzOQAho+ShNbpRVGobKgEETi7G7
         uZcCyS3r0M50V2F5YOtcwJeC7BRD+sKu5LUXr8jj+sWkUHJWFy4/u6hzBWc3ETk/nOIe
         q3AQ==
X-Gm-Message-State: AOAM530puRM8vwSUMxOLgmqufv5cYDdBu6DA+m0C8NZV51BWxMzTnOUW
        /QmG0IFXF6n298MtuzpuBbdtss+BaV5Fcg==
X-Google-Smtp-Source: ABdhPJxcPhBeoqeZkQMEmX2ZnC0fxUbUz/uY2nSiUyo2TgZuHdtLeO1sS9Kq7pO5h0CopmNB4gJptQ==
X-Received: by 2002:a17:907:72d2:: with SMTP id du18mr20736180ejc.570.1637150558573;
        Wed, 17 Nov 2021 04:02:38 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hp3sm10075700ejc.61.2021.11.17.04.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 04:02:37 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mnJe9-0008Gl-3g;
        Wed, 17 Nov 2021 13:02:37 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 18/23] Makefiles: add and use wildcard "mkdir -p"
 template
Date:   Wed, 17 Nov 2021 12:52:11 +0100
References: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
 <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
 <patch-v3-18.23-d61e2b44f68-20211116T114334Z-avarab@gmail.com>
 <20211117025148.awdha4udu5kmzwbe@glandium.org>
 <211117.86wnl76sal.gmgdl@evledraar.gmail.com>
 <20211117093947.ifkrvddmiiu3hg2v@glandium.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211117093947.ifkrvddmiiu3hg2v@glandium.org>
Message-ID: <211117.86k0h76lcy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 17 2021, Mike Hommey wrote:

> On Wed, Nov 17, 2021 at 10:26:27AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>> On Wed, Nov 17 2021, Mike Hommey wrote:
>>=20
>> > On Tue, Nov 16, 2021 at 01:00:18PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>> >> Add a template to do the "mkdir -p" of $(@D) (the parent dir of $@)
>> >> for us, and use it for the "make lint-docs" targets I added in
>> >> 8650c6298c1 (doc lint: make "lint-docs" non-.PHONY, 2021-10-15).
>> >>=20
>> >> As seen in 4c64fb5aad9 (Documentation/Makefile: fix lint-docs mkdir
>> >> dependency, 2021-10-26) maintaining these manual lists of parent
>> >> directory dependencies is fragile, in addition to being obviously
>> >> verbose.
>> >>=20
>> >> I used this pattern at the time because I couldn't find another method
>> >> than "order-only" prerequisites to avoid doing a "mkdir -p $(@D)" for
>> >> every file being created, which as noted in [1] would be significantly
>> >> slower.
>> >>=20
>> >> But as it turns out we can use this neat trick of only doing a "mkdir
>> >> -p" if the $(wildcard) macro tells us the path doesn't exist. A re-run
>> >> of a performance test similar to thatnoted downthread of [1] in [2]
>> >> shows that this is faster, in addition to being less verbose and more
>> >> reliable (this uses my "git-hyperfine" thin wrapper for "hyperfine"[3=
]):
>> >>=20
>> >>     $ git hyperfine -L rev HEAD~0,HEAD~1 -b 'make -C Documentation li=
nt-docs' -p 'rm -rf Documentation/.build' 'make -C Documentation lint-docs'
>> >>     Benchmark 1: make -C Documentation lint-docs' in 'HEAD~0
>> >>       Time (mean =C2=B1 =CF=83):      2.129 s =C2=B1  0.011 s    [Use=
r: 1.840 s, System: 0.321 s]
>> >>       Range (min =E2=80=A6 max):    2.121 s =E2=80=A6  2.158 s    10 =
runs
>> >>=20
>> >>     Benchmark 2: make -C Documentation lint-docs' in 'HEAD~1
>> >>       Time (mean =C2=B1 =CF=83):      2.659 s =C2=B1  0.002 s    [Use=
r: 2.306 s, System: 0.397 s]
>> >>       Range (min =E2=80=A6 max):    2.657 s =E2=80=A6  2.662 s    10 =
runs
>> >>=20
>> >>     Summary
>> >>       'make -C Documentation lint-docs' in 'HEAD~0' ran
>> >>         1.25 =C2=B1 0.01 times faster than 'make -C Documentation lin=
t-docs' in 'HEAD~1'
>> >>=20
>> >> So let's use that pattern both for the "lint-docs" target, and a few
>> >> miscellaneous other targets.
>> >>=20
>> >> This method of creating parent directories is explicitly racy in that
>> >> we don't know if we're going to say always create a "foo" followed by
>> >> a "foo/bar" under parallelism, or skip the "foo" because we created
>> >> "foo/bar" first. In this case it doesn't matter for anything except
>> >> that we aren't guaranteed to get the same number of rules firing when
>> >> running make in parallel.
>> >
>> > Something else that is racy is that $(wildcard) might be saying the
>> > directory doesn't exist while there's another make subprocess that has
>> > already started spawning `mkdir -p` for that directory.
>> > That doesn't make a huge difference, but you can probably still end up
>> > with multiple `mkdir -p` runs for the same directory.
>> >
>> > I think something like the following could work while avoiding those
>> > races:
>> >
>> > define create_parent_dir_RULE
>> > $(1): | $(dir $(1)).
>> > ALL_DIRS +=3D $(dir $(1))
>> > endef
>> >
>> > define create_parent_dir_TARGET
>> > $(1)/.: $(dir $(1)).
>> > 	echo mkdir $$(@D)
>
> erf, s/echo //
>
>> > endef
>> >
>> > $(eval $(call create_parent_dir_RULE, first/path/file))
>> > $(eval $(call create_parent_dir_RULE, second/path/file))
>> > # ...
>> >
>> > $(foreach dir,$(sort $(ALL_DIRS)),$(eval $(call create_parent_dir_TARG=
ET,$(dir:%/=3D%))))
>>=20
>> I think the "race" just isn't a problem, and makes managing this much
>> simpler.
>>=20
>> I.e. we already rely on "mkdir -p" not failing on an existing directory,
>> so the case where we redundantly try to create a directory that just got
>> created by a concurrent process is OK, and as the quoted benchmark shows
>> is much faster than a similar (but not quite the same as) a
>> dependency-based implementaiton.
>>=20
>> I haven't implemented your solution, but it seems to be inherently more
>> complex.
>>=20
>> I.e. with the one I've got you just stick the "mkdir if needed"
>> one-liner in each rule, with yours you'll need to accumulate things in
>> ALL_DIRS, and have some foreach somewhere or dependency relationship to
>> create those beforehand if they're nested, no?
>
> For each rule, it would also be a oneliner to add above the rule. The rest
> would be a prelude and a an epilogue to stick somewhere in the Makefile.

How would that epilogue know to handle cases where we're running "clean"
or whatever thing doesn't want to create the full set of directories
we've accumulated in ALL_DIRS while parsing the Makefile?

Won't that require extensive use of the same sort of MAKECMDGOALS
trickery I added for one target in 8cc804d0abf (doc build: speed up
"make lint-docs", 2021-10-15)?

I can imagine how we /could/ get that to work, but so far I just dont's
see the point. The wildcard trick I'm proposing here seems to be the
best of both worlds, it's both faster than anything else I've come up
with or seen, and requires zero management outside the rule itself.

Also, only the lint-docs rule I'm modifying here went to any trouble to
avoid redundant "mkdir" calls at all, the rest are all doing a "mkdir
parent-dir" every single time. So as far as any edge cases with these
rules tripping over one another are concerned I think we're already
handling that.

Well, I suppose *theoretically* not, because I'm assuming that we only
ever run the equivalent of "make all" or "make clean && make all" and
not "make -jN clean all".

But while it's possible to get a Makefile working that can clean and
build things in parallel in practice nobody does that, and ours
doesn't. If you try that it'll fail right away on some bad dependency
(which we both just generated and rm -rf'd).
