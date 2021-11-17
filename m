Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590B9C433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2919A63241
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbhKQJfx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 04:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbhKQJfv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 04:35:51 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66368C061746
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 01:32:53 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id y13so7972555edd.13
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 01:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=cV9uwJEnxhfmBCnWe6TVJpxz2BVEHK44pUBC+oopjdU=;
        b=nMKBTE8F52Mf1EbLOWRNl+xX23Jnxkw3BR0Shn+RvJ2xflds+/tqaw+ko7/3JKwT99
         ImXUWjd8o2RKSaFxGV2+B6lY2MN3dtBf6c3Uj/qnuYk5eRx+oU9nicvXTuKyHRnHI7Ia
         zVrews2zUecD9NloFDPyQlZyuIIdS/dFS9qvRULoG7WQUvc0uSg2722l+vMgQLMuWBUF
         FyeTNly3WggD+9KHr/XW/qEEv2lUtiVW4A882/HM54iXSe36CKTm8KJDuw7qw2mB6Kgi
         qaB0yGd9pu1f/LvonZdFHl6UluZ/srQdD5yZgyJhlj9JN0T6ShQ1ujKQdLdUNRcUQWow
         yb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=cV9uwJEnxhfmBCnWe6TVJpxz2BVEHK44pUBC+oopjdU=;
        b=qO73TLKRvx/EWFpSD4I9FlqMUkE+btz26XfQhq7thapM4XkqNC+qMwWWaOgu5E8QXm
         jl5KGi4EwMOhvgksBHVW+3E88uPPSng0qaf9IqRTqSScgW0DQ3Jf0kgMo9qO6JTuMh7z
         aIRskxEJbM8eD2H8Zpm2ysv4ugJzyaSH3mwem2XcAec4JLkKYWIx25zSAGKBcGKm+P4U
         KsnWAx+wcDExe6knj3TjckyEQ3VewaCrt4fO1eppQTmNbpic1MsKtg7Pk9K81Ae8VpK/
         CC8HVUslSSzOnG7O4E52FjiREFOKFjsl1/oMIJXtS6Rz4iIK77wkRIdmLBo4UAKr0lF1
         YLuw==
X-Gm-Message-State: AOAM5315dRLRpNno57578uQTVSkL1Syi3YrDMR/LnlqoDPHiRw2s+hEK
        tCRgxOBU0AOyC06BlL3ml5g=
X-Google-Smtp-Source: ABdhPJyH2qTfzgUUbqxtDCCjZyaxFlZbjsKjLqemG6WmE19BeSQct3cXirCoBM/rYtoKHJ4Ci+921g==
X-Received: by 2002:a17:907:118d:: with SMTP id uz13mr20502008ejb.334.1637141571886;
        Wed, 17 Nov 2021 01:32:51 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gs17sm9808322ejc.28.2021.11.17.01.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 01:32:51 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mnHJC-0004rG-OZ;
        Wed, 17 Nov 2021 10:32:50 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 18/23] Makefiles: add and use wildcard "mkdir -p"
 template
Date:   Wed, 17 Nov 2021 10:26:27 +0100
References: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
 <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
 <patch-v3-18.23-d61e2b44f68-20211116T114334Z-avarab@gmail.com>
 <20211117025148.awdha4udu5kmzwbe@glandium.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211117025148.awdha4udu5kmzwbe@glandium.org>
Message-ID: <211117.86wnl76sal.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 17 2021, Mike Hommey wrote:

> On Tue, Nov 16, 2021 at 01:00:18PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> Add a template to do the "mkdir -p" of $(@D) (the parent dir of $@)
>> for us, and use it for the "make lint-docs" targets I added in
>> 8650c6298c1 (doc lint: make "lint-docs" non-.PHONY, 2021-10-15).
>>=20
>> As seen in 4c64fb5aad9 (Documentation/Makefile: fix lint-docs mkdir
>> dependency, 2021-10-26) maintaining these manual lists of parent
>> directory dependencies is fragile, in addition to being obviously
>> verbose.
>>=20
>> I used this pattern at the time because I couldn't find another method
>> than "order-only" prerequisites to avoid doing a "mkdir -p $(@D)" for
>> every file being created, which as noted in [1] would be significantly
>> slower.
>>=20
>> But as it turns out we can use this neat trick of only doing a "mkdir
>> -p" if the $(wildcard) macro tells us the path doesn't exist. A re-run
>> of a performance test similar to thatnoted downthread of [1] in [2]
>> shows that this is faster, in addition to being less verbose and more
>> reliable (this uses my "git-hyperfine" thin wrapper for "hyperfine"[3]):
>>=20
>>     $ git hyperfine -L rev HEAD~0,HEAD~1 -b 'make -C Documentation lint-=
docs' -p 'rm -rf Documentation/.build' 'make -C Documentation lint-docs'
>>     Benchmark 1: make -C Documentation lint-docs' in 'HEAD~0
>>       Time (mean =C2=B1 =CF=83):      2.129 s =C2=B1  0.011 s    [User: =
1.840 s, System: 0.321 s]
>>       Range (min =E2=80=A6 max):    2.121 s =E2=80=A6  2.158 s    10 runs
>>=20
>>     Benchmark 2: make -C Documentation lint-docs' in 'HEAD~1
>>       Time (mean =C2=B1 =CF=83):      2.659 s =C2=B1  0.002 s    [User: =
2.306 s, System: 0.397 s]
>>       Range (min =E2=80=A6 max):    2.657 s =E2=80=A6  2.662 s    10 runs
>>=20
>>     Summary
>>       'make -C Documentation lint-docs' in 'HEAD~0' ran
>>         1.25 =C2=B1 0.01 times faster than 'make -C Documentation lint-d=
ocs' in 'HEAD~1'
>>=20
>> So let's use that pattern both for the "lint-docs" target, and a few
>> miscellaneous other targets.
>>=20
>> This method of creating parent directories is explicitly racy in that
>> we don't know if we're going to say always create a "foo" followed by
>> a "foo/bar" under parallelism, or skip the "foo" because we created
>> "foo/bar" first. In this case it doesn't matter for anything except
>> that we aren't guaranteed to get the same number of rules firing when
>> running make in parallel.
>
> Something else that is racy is that $(wildcard) might be saying the
> directory doesn't exist while there's another make subprocess that has
> already started spawning `mkdir -p` for that directory.
> That doesn't make a huge difference, but you can probably still end up
> with multiple `mkdir -p` runs for the same directory.
>
> I think something like the following could work while avoiding those
> races:
>
> define create_parent_dir_RULE
> $(1): | $(dir $(1)).
> ALL_DIRS +=3D $(dir $(1))
> endef
>
> define create_parent_dir_TARGET
> $(1)/.: $(dir $(1)).
> 	echo mkdir $$(@D)
> endef
>
> $(eval $(call create_parent_dir_RULE, first/path/file))
> $(eval $(call create_parent_dir_RULE, second/path/file))
> # ...
>
> $(foreach dir,$(sort $(ALL_DIRS)),$(eval $(call create_parent_dir_TARGET,=
$(dir:%/=3D%))))

I think the "race" just isn't a problem, and makes managing this much
simpler.

I.e. we already rely on "mkdir -p" not failing on an existing directory,
so the case where we redundantly try to create a directory that just got
created by a concurrent process is OK, and as the quoted benchmark shows
is much faster than a similar (but not quite the same as) a
dependency-based implementaiton.

I haven't implemented your solution, but it seems to be inherently more
complex.

I.e. with the one I've got you just stick the "mkdir if needed"
one-liner in each rule, with yours you'll need to accumulate things in
ALL_DIRS, and have some foreach somewhere or dependency relationship to
create those beforehand if they're nested, no?
