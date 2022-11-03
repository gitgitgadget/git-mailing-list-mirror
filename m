Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E277C4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 20:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiKCUrA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 16:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiKCUq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 16:46:57 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F311CFD2
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 13:46:56 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id i21so4842882edj.10
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 13:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=do4wG4HiI1lvL1/zFXchiUkNFpcYvpSU2es4HadKzBI=;
        b=j8YDGyuJBFtfWIJ8Wtv0MECsQ2lNwyoNsKpMn2545nOR7taCd8lB1DYV0TvpPnX4ZV
         LvC5kJMuJ2GdnimTB52U+i85svrKyZ61jk2lVpbb0ul2YWCw3GH5kb4+F1gDSraB/0IT
         Rp2oOEqERWDxit0Fjy3BntQxfsHzuitGeo1ewVXenabxytIS4n6xVfxbhtI8YQxJ3VYA
         /KuzrIZoNNoYjDnx5Nd/qbAETW+MJdayXdwmW3MRaQVMC0TrqCIswWbd7UiTKGB6iBNR
         /Gm32WtvmlWwRDnPbhqC3iVslgxO/0gMYW0Iwk3TV31crLNdAZ/XHq8THUHdzPDJgKN9
         dePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=do4wG4HiI1lvL1/zFXchiUkNFpcYvpSU2es4HadKzBI=;
        b=VJsqcBlqGhh0bySe3dmh8+waZFdG4mK9kHVDS7EmyDq4irtSZ/snD5CVl/gja2ywn/
         9tE7PA46Nn6WwnUEcJ0Dim8TZoKSPt94xAGvOgT7oBMqKiCpW2zOfVNyUyxC1CUqIbnQ
         4h81cJC3EElgkTVMbz9LHwvIGlGoU/JT+i8e/GkMW6MHrObBoczr1j4F6umq7PE+NEwJ
         gRneDP1w/lG/Mqe1NvUeM648cZD47DyFejggldBBAYIe3hK0CcTS9K5cpd7A3Dgb45s/
         UG0i5RpgstEXOccIwQgfMt6gBEPxfXtTixP4PyKyQ5PNJK/A3FRY/vwcUP+wYHlFVFrt
         w7KQ==
X-Gm-Message-State: ACrzQf1JNN1HyaQyMb5k1hGx3gptMABhmkoYCsIw+p9LCKk7VVQ6w3z8
        x1LMwIeyaPH06WytGBhkLXI=
X-Google-Smtp-Source: AMsMyM5LLJVP2p5DktIC4zSa1NN6pDO9ACCFXaLk2kW/06ed3OX74yjSamweaJh42u9+PLxh/t3Wyg==
X-Received: by 2002:a05:6402:12d1:b0:463:3f0c:be02 with SMTP id k17-20020a05640212d100b004633f0cbe02mr25700905edx.239.1667508415116;
        Thu, 03 Nov 2022 13:46:55 -0700 (PDT)
Received: from gmgdl (j84064.upc-j.chello.nl. [24.132.84.64])
        by smtp.gmail.com with ESMTPSA id n15-20020a170906088f00b0078d9b967962sm937128eje.65.2022.11.03.13.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 13:46:54 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oqh70-00CseP-0E;
        Thu, 03 Nov 2022 21:46:54 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [RFC/PoC 1/5] doc: provide DocBundles design document
Date:   Thu, 03 Nov 2022 21:36:10 +0100
References: <20221102224843.2104-1-philipoakley@iee.email>
 <20221102224843.2104-2-philipoakley@iee.email>
 <221103.86mt981i9h.gmgdl@evledraar.gmail.com>
 <ab275fa0-2977-f880-cc33-836f667287bc@iee.email>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <ab275fa0-2977-f880-cc33-836f667287bc@iee.email>
Message-ID: <221103.861qqj22bl.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 03 2022, Philip Oakley wrote:

> Hi =C3=86var,
> Thanks for the review,
>
> On 03/11/2022 09:19, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> My main point was that the examples need to be covered by the test
> suite, and that bundles were a simple way of capturing the tested setup.
> The GIT_BUNDLE_DIR was simply a way of collecting them in one place for
> ease of distribution with the documentation (as you mentioned that's a
> gap in the automation step)
>>  i.e. with a minor variation of that you can do this
>> in test-lib.sh:
>>
>> 	TEST_RESULTS_BDL_DIR=3D"$TEST_RESULTS_DIR/$TEST_NAME.test-bdl"
>>
>> Then have a helper like:
>>
>> 	do_my_test_bundle_stuff () {
>> 		local name=3D"$1" &&
>> 		shift &&
>> 		git bundle create "$TEST_RESULTS_BDL_DIR/$name.bdl" "$@"
>> 	}
> That would be a simplification

I forgot that there needs to be a "mkdir" of the "$TEST_RESULTS_BDL_DIR"
in there somewhere (see the *.leak dir setup), but other than that
that's pretty much all there's to it.

>> Then all you need to make these is:
>>
>> 	make test GIT_TEST_OPTS=3D--debug
>
> I didn't quite get the link in that step between the `--debug` and the
> bndl prep.

Sorry, I was misrecalling that we wiped away "test-results" except
without "--debug", which when I spend more than 2 seconds thinking about
it makes no sense, that's just for the trash directories. Nevermind.

>> And then:
>>
>> 	ls -l t/test-results/*.bdl/*
>>
>> Will give you all the bundles you want.
>>
>> We're then missing the "connect it with the docs" part, but that part
>> would be e.g.:
>>
>> - Have a validation target for it that depends on such a "make test" run
>> - Sanity check that we did create the ones the docs expect
>>
>> Anyway.
>>
>> I like the end-goals, but I can't help think that bundles are the wrong
>> direction to go in, as opposed to:
>>
>> 1. We could have "make install" ship test-lib{,-functions}.sh along
>>    with git itself
>> 2. Have e.g. t/doc-setup/*.sh with the snippets to set up these test
>>    demos, which we'd also ship.
>
> I'm not into the idea of shipping a load of extra `test` infrastructure
> with Git itself. We don't ship any in the Git for Windows install.

We don't ship in anywhere now, but presumably GfW has the required parts
to use it, since it has git-submodule.sh and other *.sh now?

Anyway....

> I'd viewed the bundles as an adjunct to the also independent manuals and
> documentation.

...yeah me too, I'm just wondering if we won't back ourselves into a
corner with some examples, where we'll want to hand the user more
complex state.

But maybe simpler is better, and it can just be a bundle plus "run these
commands manually". The bundle can also contain a script in-tree that
performs the finishing touches, if required (unless there's no 'sh' at
runtime in GfW?).

Anyway, *if* that's a good idea (and I've got no idea, just throwing it
out there) it doesn't need to be hindered by lack of 'sh', we could just
ship compiled C code that does the required run_command() sequences to
set up the desired state.

Then in the test suite we'd call that as a test helper, or a new
built-in helper,.

>>
>> And you'd then do e.g.:
>>
>> 	git test-case rebase/description-1
>>
>> Which would just be a thin wrapper around (pseudocode):
>>
>> 	dir=3D$(git test--helper get-tempdir) &&
>> 	(
>> 		cd "$dir" &&
>>                 # And whatever else we need to set up to say "use this l=
ocal installed git"
>> 		GIT_TEST_INSTALLED=3D[...] &&
>> 		. "$(git --test-dir)"/test-lib.sh
>> 		. "$(git --test-dir)"/doc-setup/rebase-description-1.sh"
>>
>> 		# This would run test_commit, and any other arbitrary setup code
>> 		setup_rebase_description_1()
>> 	) &&
>> 	echo "Go play with '$dir', and have fun"
>>
>> The big advantage of that is:
>>
>>  1. It ships with git, so it works offline, and we won't get into the
>>     inevitable confusion of the user reading v2.40 docs locally, but the
>>     online url tracking a v2.50 example or whatever.
>
> Isn't this always a problem (lack of synchronisation between multiple
> sources). If the user has local documentation, it should have matching
> bundles locally, No?

Yes, I just didn't know if that was your plan, so if that's how it works
then no problem.

It's just a depressingly common pattern these days that manual pages are
"just read about it at this link", which inevitably links to some
out-of-date documentation, even some of GCC's docs are doing that these
days.

It's good that that's not the plan here.

>>  2. We can represent whatever arbitrary repo state, e.g. drop the user
>>     into a merge conflict that's already happening.
> Isn't the manual's example already meant to describe that? And the user
> then (hopefully) follows along in their throw-away copy of the repo bundl=
e.

Yeah, maybe that's fine.

>>  3. We can also represent "repo-extra" state, e.g. imagine the
>>     "git-gc/git-repack" docs discussing loose objects, and wanting to
>>     get you into some arbitrary state with regards to your loose objects
>>     etc.
> That's a future option, but way past the initial concept for user
> on-boarding.
