Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB096C433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 13:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97706615A4
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 13:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbhKRNVD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 08:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhKRNVB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 08:21:01 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826AEC061570
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 05:18:01 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id g14so26866203edb.8
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 05:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=xE61HZmh3UaJ86oDqMp/mgpzS4Jr/2eZ8oqgO+vktt4=;
        b=MZe/cl0HidcArhKCgyS54GbtoQUe2B4HT/zCwaWKnTJ/mjgSbXYzSgMqypfWNB3XXD
         lUMmGg9YCzasPdQ++NCFmm9ISUXnlXeYOi6FJx1C2O4uKXPy1+RuX5haKtgjodHvgwZF
         kTQ6aDDYDE8TgkI6HZtADUTtyUHzq2iwb1/N+z/YRuximSCNirEnnwBEnM7ZJBf8IWl6
         KdGMQmmLUVZFxENd2DnR/rhx+rjwXhV0vsFKVDQUUJ3Nz5czVMD6moPwoRrMKLF79OFE
         U4B1kgRvFAriyeCHM/BiNnZOKMANeJeC8AvBm1oiVWzzqFNaoB+8EcWAVesj1DWxb9ye
         S36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=xE61HZmh3UaJ86oDqMp/mgpzS4Jr/2eZ8oqgO+vktt4=;
        b=ap1XQoCB8Ze5STEqNMeuSv4aPdDAbaipJIYIb2eermR8gGklPHFTgZku6metmvAEnt
         jAJUalhHnuLytgPnPnMO/PIsxlxDUpW2LyPSjcXuMzgSwjyjKFZDS/R6sDHin4n/bcSM
         NKC8yeDyzsVswpyEDoIgMOTURmJI5vhxYvah3qiP1nyrkMWM0MqHqko+Znk2mgbAKvhe
         DzFB8s6MCXxyjwogbOF0fNlb4NA08IqHskZdVRItpwjGAliApfypR3A11ABKRuYDSeQ/
         irAqYTgGBIIRme/y4+iqUaouBNHM7zCD+bothFSeEGZQx36fiwfOSdJ61XqDt3vKI7N0
         gYlA==
X-Gm-Message-State: AOAM533oMRwhyqdMJxSI7DtHK08ARgkkILgXlxMLccT4SfA/1e1bfPX6
        u8HLVkhcQl574rya0IrCtlE=
X-Google-Smtp-Source: ABdhPJxIOFfsgoHqUinC5dtBiW3WOBSLMgcwYyOm84WhTCf02R845L+d9X9QcboDjgFI/txLotG95Q==
X-Received: by 2002:aa7:c941:: with SMTP id h1mr9977386edt.319.1637241479671;
        Thu, 18 Nov 2021 05:17:59 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id sd28sm1445687ejc.37.2021.11.18.05.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 05:17:59 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mnhIc-000THG-Jv;
        Thu, 18 Nov 2021 14:17:58 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 18/23] Makefiles: add and use wildcard "mkdir -p"
 template
Date:   Thu, 18 Nov 2021 14:05:48 +0100
References: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
 <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
 <patch-v3-18.23-d61e2b44f68-20211116T114334Z-avarab@gmail.com>
 <20211117025148.awdha4udu5kmzwbe@glandium.org>
 <211117.86wnl76sal.gmgdl@evledraar.gmail.com>
 <20211117093947.ifkrvddmiiu3hg2v@glandium.org>
 <211117.86k0h76lcy.gmgdl@evledraar.gmail.com>
 <20211118000002.wykfbk3qtlt46ab7@glandium.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211118000002.wykfbk3qtlt46ab7@glandium.org>
Message-ID: <211118.868rxl61rt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 18 2021, Mike Hommey wrote:

> On Wed, Nov 17, 2021 at 12:52:11PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>=20
>> On Wed, Nov 17 2021, Mike Hommey wrote:
>>=20
>> > On Wed, Nov 17, 2021 at 10:26:27AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>> >>=20
>> >> On Wed, Nov 17 2021, Mike Hommey wrote:
>> >>=20
>> >> > On Tue, Nov 16, 2021 at 01:00:18PM +0100, =C3=86var Arnfj=C3=B6r=C3=
=B0 Bjarmason wrote:
>> >> >> Add a template to do the "mkdir -p" of $(@D) (the parent dir of $@)
>> >> >> for us, and use it for the "make lint-docs" targets I added in
>> >> >> 8650c6298c1 (doc lint: make "lint-docs" non-.PHONY, 2021-10-15).
>> >> >>=20
>> >> >> As seen in 4c64fb5aad9 (Documentation/Makefile: fix lint-docs mkdir
>> >> >> dependency, 2021-10-26) maintaining these manual lists of parent
>> >> >> directory dependencies is fragile, in addition to being obviously
>> >> >> verbose.
>> >> >>=20
>> >> >> I used this pattern at the time because I couldn't find another me=
thod
>> >> >> than "order-only" prerequisites to avoid doing a "mkdir -p $(@D)" =
for
>> >> >> every file being created, which as noted in [1] would be significa=
ntly
>> >> >> slower.
>> >> >>=20
>> >> >> But as it turns out we can use this neat trick of only doing a "mk=
dir
>> >> >> -p" if the $(wildcard) macro tells us the path doesn't exist. A re=
-run
>> >> >> of a performance test similar to thatnoted downthread of [1] in [2]
>> >> >> shows that this is faster, in addition to being less verbose and m=
ore
>> >> >> reliable (this uses my "git-hyperfine" thin wrapper for "hyperfine=
"[3]):
>> >> >>=20
>> >> >>     $ git hyperfine -L rev HEAD~0,HEAD~1 -b 'make -C Documentation=
 lint-docs' -p 'rm -rf Documentation/.build' 'make -C Documentation lint-do=
cs'
>> >> >>     Benchmark 1: make -C Documentation lint-docs' in 'HEAD~0
>> >> >>       Time (mean =C2=B1 =CF=83):      2.129 s =C2=B1  0.011 s    [=
User: 1.840 s, System: 0.321 s]
>> >> >>       Range (min =E2=80=A6 max):    2.121 s =E2=80=A6  2.158 s    =
10 runs
>> >> >>=20
>> >> >>     Benchmark 2: make -C Documentation lint-docs' in 'HEAD~1
>> >> >>       Time (mean =C2=B1 =CF=83):      2.659 s =C2=B1  0.002 s    [=
User: 2.306 s, System: 0.397 s]
>> >> >>       Range (min =E2=80=A6 max):    2.657 s =E2=80=A6  2.662 s    =
10 runs
>> >> >>=20
>> >> >>     Summary
>> >> >>       'make -C Documentation lint-docs' in 'HEAD~0' ran
>> >> >>         1.25 =C2=B1 0.01 times faster than 'make -C Documentation =
lint-docs' in 'HEAD~1'
>> >> >>=20
>> >> >> So let's use that pattern both for the "lint-docs" target, and a f=
ew
>> >> >> miscellaneous other targets.
>> >> >>=20
>> >> >> This method of creating parent directories is explicitly racy in t=
hat
>> >> >> we don't know if we're going to say always create a "foo" followed=
 by
>> >> >> a "foo/bar" under parallelism, or skip the "foo" because we created
>> >> >> "foo/bar" first. In this case it doesn't matter for anything except
>> >> >> that we aren't guaranteed to get the same number of rules firing w=
hen
>> >> >> running make in parallel.
>> >> >
>> >> > Something else that is racy is that $(wildcard) might be saying the
>> >> > directory doesn't exist while there's another make subprocess that =
has
>> >> > already started spawning `mkdir -p` for that directory.
>> >> > That doesn't make a huge difference, but you can probably still end=
 up
>> >> > with multiple `mkdir -p` runs for the same directory.
>> >> >
>> >> > I think something like the following could work while avoiding those
>> >> > races:
>> >> >
>> >> > define create_parent_dir_RULE
>> >> > $(1): | $(dir $(1)).
>> >> > ALL_DIRS +=3D $(dir $(1))
>> >> > endef
>> >> >
>> >> > define create_parent_dir_TARGET
>> >> > $(1)/.: $(dir $(1)).
>> >> > 	echo mkdir $$(@D)
>> >
>> > erf, s/echo //
>> >
>> >> > endef
>> >> >
>> >> > $(eval $(call create_parent_dir_RULE, first/path/file))
>> >> > $(eval $(call create_parent_dir_RULE, second/path/file))
>> >> > # ...
>> >> >
>> >> > $(foreach dir,$(sort $(ALL_DIRS)),$(eval $(call create_parent_dir_T=
ARGET,$(dir:%/=3D%))))
>> >>=20
>> >> I think the "race" just isn't a problem, and makes managing this much
>> >> simpler.
>> >>=20
>> >> I.e. we already rely on "mkdir -p" not failing on an existing directo=
ry,
>> >> so the case where we redundantly try to create a directory that just =
got
>> >> created by a concurrent process is OK, and as the quoted benchmark sh=
ows
>> >> is much faster than a similar (but not quite the same as) a
>> >> dependency-based implementaiton.
>> >>=20
>> >> I haven't implemented your solution, but it seems to be inherently mo=
re
>> >> complex.
>> >>=20
>> >> I.e. with the one I've got you just stick the "mkdir if needed"
>> >> one-liner in each rule, with yours you'll need to accumulate things in
>> >> ALL_DIRS, and have some foreach somewhere or dependency relationship =
to
>> >> create those beforehand if they're nested, no?
>> >
>> > For each rule, it would also be a oneliner to add above the rule. The =
rest
>> > would be a prelude and a an epilogue to stick somewhere in the Makefil=
e.
>>=20
>> How would that epilogue know to handle cases where we're running "clean"
>> or whatever thing doesn't want to create the full set of directories
>> we've accumulated in ALL_DIRS while parsing the Makefile?
>
> The epilogue only adds rules like:
>
> dir/subdir/.: dir/.
> 	mkdir $(@D)
>
> As long as those "clean" or whatever rules don't depend on those,
> nothing will happen.

Ah, I see.

I don't see why why this pattern would be preferrable to the $(wildcard)
idiom I'm introducing, which doesn't require any boilerplate at all.

We've got that in snippet form on the one hand, and then my working
patch. I haven't tried to implement what you suggested, but don't see
how it wouldn't be the same thing speed-wise as the explicitly
enumerated dependiencies I replaced for the lint-docs target.

So unless there's something broken etc. about that approach I think we
should go forward with it.

