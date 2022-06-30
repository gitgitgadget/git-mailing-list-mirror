Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30310C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 17:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbiF3R2Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 13:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbiF3R2P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 13:28:15 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD75CE0F
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 10:28:13 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id u13-20020a17090a4bcd00b001eefd8fa171so54485pjl.2
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 10:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=1jM4d2HwRaD/+r6BOHkD/EAsFXrQWB9zHao/v5IweiA=;
        b=qB0jc2LDPubC4wK9MzMi9RQ91b9Lk90HVJmjUqIfJeqaRltXDgrJ3xQJIuENPiLOAd
         jkOiKCgAdxE8g3xNg9UQmpgQj/Jm5UjJL4b/2AIuwcuSTzadvj5OEmKJRMuqI62VCxR3
         J/bpT/HgAXU6L/mjRNyDosHy9R/TOJ1fUhVtieXyJbttY7h9X7+v5S0gIJzG/tNcO/wD
         obezjEHLQaX1r19Mi6tPUrcOAUNnzU6PZlsLbeF6QSQ4xrayaBv0aiJED1RRo2j9PIit
         +UIkBG9t0KPUVSeaw40vlzBrli/NfaAW9PTuL/ZWMGuEQY50MCfXrtL8Pg3ufgIs73qd
         Jdig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=1jM4d2HwRaD/+r6BOHkD/EAsFXrQWB9zHao/v5IweiA=;
        b=2OLL7r3xeLWeJetAUtigtSFzxcY57zbx3DF/fADwFZXycBfuhU8scXZq1D+5HWPEfR
         ir8bOR+QU4JO/Ab0whCDzg7jRrdxizcjMJQ2eugVuBXdpAbQ/Ki6JuoW1ZKkPrLPVcWf
         UszplQlb9PCkRRmNcxs7PSfss3RwkTFRh8OqsYfDBSep+youK9LYtCRuc5bQwROMdWpT
         xYMuxM+vxJmDpR+U9Y3RtP0D1xw0H2+cM0aEx08623B99SD1v5hNvXFMwuk/RTAyvzqw
         4lm/IqCrdGV11CBQWFtOxGhxse7Vok9I08rmi9TUAlqsfZRNMV2XcMd4BFEn4YgTzj5x
         AY/g==
X-Gm-Message-State: AJIora+xkV5Crw5cT137ncQlMVCoFYtrpFIXC0oK7CpJAaH9eMORZdpn
        oSnHbrTkvHhIPVSB9Ri/CZWKtua1vY3FBA==
X-Google-Smtp-Source: AGRyM1uzjn3P/SK0WULTAqtDQBHVR5e7hj25CZkklTv8X+9Noc85RxL/VXt1Csxvd6J/1QRilhM1QgiwKWcrWg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:3307:b0:527:cbdc:d7dc with SMTP
 id cq7-20020a056a00330700b00527cbdcd7dcmr14501342pfb.85.1656610092698; Thu,
 30 Jun 2022 10:28:12 -0700 (PDT)
Date:   Thu, 30 Jun 2022 10:28:11 -0700
In-Reply-To: <220630.864k02e14e.gmgdl@evledraar.gmail.com>
Message-Id: <kl6l5ykit61g.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1261.v4.git.git.1654635432.gitgitgadget@gmail.com>
 <pull.1261.v5.git.git.1656354994.gitgitgadget@gmail.com> <14411512783fd4e2cdcc8513690377b29262f6b8.1656354994.git.gitgitgadget@gmail.com>
 <220630.864k02e14e.gmgdl@evledraar.gmail.com>
Subject: Re: [PATCH v5 5/5] setup.c: create `discovery.bare`
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Jun 27 2022, Glen Choo via GitGitGadget wrote:
>
>> From: Glen Choo <chooglen@google.com>
>
>> diff --git a/t/t0035-discovery-bare.sh b/t/t0035-discovery-bare.sh
>> new file mode 100755
>> index 00000000000..0b345d361e6
>> --- /dev/null
>> +++ b/t/t0035-discovery-bare.sh
>> @@ -0,0 +1,68 @@
>> +#!/bin/sh
>> +
>> +test_description=3D'verify discovery.bare checks'
>> +
>
> You're missing a:
>
> 	TEST_PASSES_SANITIZE_LEAK=3Dtrue
>
> Above this line:
>
>> +. ./test-lib.sh
>
> Which tells us that this new test doesn't leak (yay!)

Ah, thanks! Hooray.

>> +expect_accepted () {
>> +	git "$@" rev-parse --git-dir
>> +}
>
> I think we can do away with this helper, we use the argument support
> once, and for the rest we can inline the trivial command...

That is true, having fewer test helpers can be a good idea. Though in
this case, the helper wins out slightly (IMO at least) because of the=20
readability/refactoring benefit.

>> +
>> +expect_rejected () {
>> +	test_must_fail git "$@" rev-parse --git-dir 2>err &&
>> +	grep "discovery.bare" err
>
> grep -F ?
>
> This helper is less trivial, but more obvious would be a "run command
> and assirt xyz about the output" helper, see
> e.g. test_stdout_line_count.

This takes precedent from t0033, which does the same "run command and
grep the result". And just as I typed this out, I remembered that
t0033's corresponding test helper was made more specific in f62563988f
(t0033-safe-directory: check the error message without matching the
trash dir, 2022-04-27), because just grep-ing for the config variable
masked some errors.

It turns out the same thing is happening in the last test - I forgot
that "-c" doesn't unset the variable (it sets the value to ''), and the
test_must_fail passes because we fail to parse "discovery.bare", _not_
because we forbade the repo.

So besides -F, I think the only change here would be to grep on the
specific "cannot use bare repository" message (instead of grepping for
"discovery.bare").

>> +test_expect_success 'discovery.bare unset' '
>> +	(
>> +		cd outer-repo/bare-repo &&
>> +		expect_accepted
>> +	)
>
> Also: Odd to use a sub-shell when the helper takes -C...
>
>> +'
>> +
>> +test_expect_success 'discovery.bare=3Dalways' '
>> +	git config --global discovery.bare always &&
>> +	(
>> +		cd outer-repo/bare-repo &&
>> +		expect_accepted
>> +	)
>> +'
>> +
>> +test_expect_success 'discovery.bare=3Dnever' '
>> +	git config --global discovery.bare never &&
>> +	(
>> +		cd outer-repo/bare-repo &&
>> +		expect_rejected
>> +	)
>
> ...ditto...

Ok, I'll drop the sub-shell.

>
>> +'
>> +
>> +test_expect_success 'discovery.bare in the repository' '
>> +	(
>> +		cd outer-repo/bare-repo &&
>> +		# Temporarily set discovery.bare=3Dalways, otherwise git
>> +		# config fails with "fatal: not in a git directory"
>> +		# (like safe.directory)
>> +		git config --global discovery.bare always &&
>> +		git config discovery.bare always &&
>> +		git config --global discovery.bare never &&
>> +		expect_rejected
>> +	)
>
> Drop the sub-shell and use test_config?

Oh, I was so focused on t0033 that I hadn't realized that we had
test_config_global. Thanks :)

>> +'
>> +
>> +test_expect_success 'discovery.bare on the command line' '
>> +	git config --global discovery.bare never &&
>> +	(
>> +		cd outer-repo/bare-repo &&
>> +		expect_accepted -c discovery.bare=3Dalways &&
>> +		expect_rejected -c discovery.bare=3D
>> +	)
>> +'
>> +
>> +test_done
