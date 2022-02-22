Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E466C433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 14:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbiBVOdn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 09:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbiBVOdm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 09:33:42 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5685332047
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 06:33:17 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id s14so20022484edw.0
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 06:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=mbWlxQPQwpmHLEewDFVvNjaeAGnskLc5v+iWFylLOjI=;
        b=cZLd8xiBgjswJInONWfVDEnvWChrU+Q2A8ueSovcKNdETeUyQPBp/m8ibkRvqbYy/8
         09UB9X+Y3P7OKjMlsGa+Nb9GDPgq40+Ao51L4/WwRKBiQ5tgkyR3H9e3mMuzADVl3Zw1
         B+RObPL2QlN3Aif0PRXYU7pnuGCp3yL/+/AyA+tXV9jLPCIeZSNVyO5LjZfWnkpFAD3F
         OMrd3sOHBWgBDehRn92U4qKrDSqydJItPdXUipJVbE+DsFQsL/qmf5nd75AW1gfoudxe
         YOBhfLaLazTVjwijX4AbXLYLhh2nhJompUW1zTB2gPEi/g52ciEVeqB4G0Wgk74UVRsZ
         i5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=mbWlxQPQwpmHLEewDFVvNjaeAGnskLc5v+iWFylLOjI=;
        b=b4BRjO0tXNEh341bZmJHSzfnz9Msj6E7Guq6NCQ3PjJhm8c1eFgEtLX3kbeQFUtHUr
         RkLWFZ3xONuYb/Cd2mbCut9siVgSAW6iwzWyDQ+AgLM8CD7yDY/Hl0dOmGTIH0dUuEFZ
         mMZqSZ4z6xBNaFYggJaxFxQkrCZFOrkdM7JYTezYQDI3iV3slsco/klKM0ZR34wgM+00
         PHLhWiYwQf9U23QAvGtJ1m94GMvDlCnzEX2RITRmUAMudaEGeQSz3yyc4DapA1GzD/eR
         ze5VqvGlMqxoCRdkpII79SO+s1rxw30xsxlWRxzHTHqF17+XzW0WppInsVLnPsDH7K09
         O62w==
X-Gm-Message-State: AOAM532EIFfRvkiR/e5J/dZO7SGEmCRR4x0HzTVwEbT6PdaKXtSn8jv6
        8bFeIHCgIvrJeMLM8P+dVncrYWM2o4/YmDhX
X-Google-Smtp-Source: ABdhPJzqUHNvwo4k77yuZ0QHaW/Hjc/0+g/YzQvNVMmguqPsC4pZdW2OGkys39pF+n3AFjcZhQ+SZA==
X-Received: by 2002:a05:6402:27c7:b0:412:80f9:18af with SMTP id c7-20020a05640227c700b0041280f918afmr26650429ede.127.1645540395636;
        Tue, 22 Feb 2022 06:33:15 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d25sm6379866ejz.4.2022.02.22.06.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 06:33:14 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nMWE6-0068HH-CL;
        Tue, 22 Feb 2022 15:33:14 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Shubham Mishra <shivam828787@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 0/2] microproject: avoid using pipes in test
Date:   Tue, 22 Feb 2022 15:24:31 +0100
References: <20220222114313.14921-1-shivam828787@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220222114313.14921-1-shivam828787@gmail.com>
Message-ID: <220222.86pmnf6ket.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 22 2022, Shubham Mishra wrote:

> pipes doesn't care about error codes and ignore them thus we should not use them in tests.

Aside from what Derrick Stolee mentioned in his feedback, all of which I
agree with.

I think these changes are good, but it's not the case that we try to
avoid using pipes at all in our tests.

It's often a hassle, and just not worth it, e.g.:

    oid=$(echo foo | git hash-object --stdin -w) &&

Sure, we can make that:

    echo foo >in &&
    oid=$(git hash-object --stdin -w <in) &&

But in the general case it's not worth worrying about.

What we *do* try to avoid, and what's actually important is to never
invoke "git" or other programs we invoke on the LHS of a pipe, or to
otherwise do so in a way that hides potential errors.

That's not isolated to just pipes, but e.g. calling it within helper
functions that don't &&-chain, but pipes are probably the most common
offender.

The reason we do that is because in hacking git we may make it error,
segfault etc. If it's on the LHS of a pipe that failure becomes
indistinguishable from success.

And if the test is really checking e.g. "when I run git like this, it
produces no output" printing nothing with an exit of 0 will become the
same as a segafault for the purposes of test.

And that's bad.

But just invoking things on the LHS of a pipe? Sometimes it's a good
thing not do do that, because we'll be able to see a failure more
incrementally, and with intermediate files.

But it's generally not a problem, our test suite assumes that the OS is
basically sane. We're not going to call every invocation of "sed",
"grep" etc. with a wrapper like "test_must_fail grep" instead of "!
grep".

The same goes for our own helper utility functions such as "q_to_nul"
etc, as long as (and this is critical) that they're implemented by
shelling out to "sed", "grep", "perl" or whatever, and not to "git" or
"test-tool" etc. Then we need to start being as paranoid about them as
"git" on the LHS of pipes.

