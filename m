Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DD0C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 15:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238010AbiGSPjg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 11:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiGSPjT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 11:39:19 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B337599FF
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 08:39:18 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bp15so27949011ejb.6
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 08:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ja51A2UrmCIznkZJcC0FlAuqVEeObUQwtYJtFnekQ3Y=;
        b=SMoukJ6mxyk4RwOlFDApcCBj6iR8D6Iy6/g0LPKtzwNEj6Wx7BUhRSBv1ESZFXHHt8
         tvuJAmAg0MoastvesXfGWBuAaBXVr6D3cFwySTsutc707Hd8eyOEoU+ficz0OIIonsQb
         1+FKWIdoVSLeALrxVLVvn0AwM148QZHEp/5f28FtSyV+5pYMqfQBXE3IG3GmEDggQEa4
         OGxPlA1EOyXg34wxAgWnxAXEGaTozR+Vt7PNykLITH1gnlBGrM6U1altQfmxgq9JmmaD
         l47CWP5LsuNeiKpu82rob1PsBHy0vrTx91HDHeI9iFcGuhpnHjhqDnAqmld9kFzQJ72W
         8dKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ja51A2UrmCIznkZJcC0FlAuqVEeObUQwtYJtFnekQ3Y=;
        b=Sl+TGhzY3r/1S4Vj2bq/tzheuuLWjt2UbKnInka2t+9eYDZ5xS6A3xFY0l+iHqJUWo
         t5YUFO02K1UullbshDsTXmQ9Yt5ZWE5mCh1KhsGLCwNcgyv4DipDEnmW9fZN+0PPdv7s
         8BAwBuezXoBopAY41PPuxDoVAaZ4yhfqGqU0+GAXTcRoJBFJp6Rgq/ri9F1fyMWHPjDg
         aiNAjLxxqH5KzfydW8dYDoxu+OzGL5elSjK69LQYLNDacuCkY1s+Ha2IxI1jo2rj/dTJ
         BWfWGZHVMISVbPogeumNeLEdm41t+wesxnp6pwGAHEAerOOF/or1H6LXWcV9H8QDMryS
         eu0Q==
X-Gm-Message-State: AJIora9mt90P1GakEp5fra7IuTSGx3QPy5KMLXhXMzSnSGtoE3Zn8EiU
        iNgEaijZ47IX/+jB/BAfmrk=
X-Google-Smtp-Source: AGRyM1v+GX219f0ktnqOmC2xa9Fth4X3KpZ5k/aa4Fl/1i+cd/oyGCI6sGq3M41nTo0m6ctttY7t7Q==
X-Received: by 2002:a17:906:7007:b0:6ff:8028:42e with SMTP id n7-20020a170906700700b006ff8028042emr31162910ejj.278.1658245156656;
        Tue, 19 Jul 2022 08:39:16 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id q3-20020aa7cc03000000b0043ba7df7a42sm227878edt.26.2022.07.19.08.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 08:39:15 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oDpJa-003kRf-Tl;
        Tue, 19 Jul 2022 17:39:14 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/3] t/*: avoid "whitelist"
Date:   Tue, 19 Jul 2022 17:26:45 +0200
References: <pull.1274.git.1657718450.gitgitgadget@gmail.com>
 <pull.1274.v2.git.1657852722.gitgitgadget@gmail.com>
 <3c3c8c20bcb4e570d25a676ad1f29877762adb82.1657852722.git.gitgitgadget@gmail.com>
 <220715.86o7xqzkt3.gmgdl@evledraar.gmail.com>
 <75cc0f43-d9a5-45d3-5e36-dd20acfebf50@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <75cc0f43-d9a5-45d3-5e36-dd20acfebf50@github.com>
Message-ID: <220719.86lespun6l.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jul 19 2022, Derrick Stolee wrote:

> On 7/15/2022 7:02 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>  GIT_TEST_PASSING_SANITIZE_LEAK=3D<boolean> when compiled with
>>> -SANITIZE=3Dleak will run only those tests that have whitelisted
>>> -themselves as passing with no memory leaks. Tests can be whitelisted
>>> -by setting "TEST_PASSES_SANITIZE_LEAK=3Dtrue" before sourcing
>>> -"test-lib.sh" itself at the top of the test script. This test mode is
>>> -used by the "linux-leaks" CI target.
>>> +SANITIZE=3Dleak will run only those tests that have marked themselves =
as
>>> +passing with no memory leaks by setting "TEST_PASSES_SANITIZE_LEAK=3Dt=
rue"
>>> +before sourcing "test-lib.sh" itself at the top of the test script. Th=
is
>>> +test mode is used by the "linux-leaks" CI target.
>>=20
>> It's hard to improve your own verbage, but I think in this case my
>> original version can be improved still:
>>=20
>> 	GIT_TEST_PASSING_SANITIZE_LEAK=3D<bool> when compiled with
>> 	SANITIZE=3Dleak will, when true, only run those tests that declare
>> 	themselves leak-free by setting "TEST_PASSES_SANITIZE_LEAK=3Dtrue"
>> 	before sourcing "test-lib.sh". This test mode is used by the
>> 	"linux-leaks" CI target.
>
> Another iteration:
>
>   GIT_TEST_PASSING_SANITIZE_LEAK=3D<bool> focuses the test suite on findi=
ng
>   memory leaks.

In some ways it does the opposite of "focusing on finding memory leaks",
we're explicitly finding fewer memory leaks, what we're doing is
asserting that the tests we've whitelisted still pass.

>   SANITIZE=3Dleak, only run those tests that declare themselves leak-free=
 by
>   setting "TEST_PASSES_SANITIZE_LEAK=3Dtrue" before sourcing "test-lib.sh=
".
>   This test mode is used by the "linux-leaks" CI target.

Perhaps:

	GIT_TEST_PASSING_SANITIZE_LEAK=3Dtrue skips those tests that
	haven't declared themselves as leak-free by setting
	"TEST_PASSES_SANITIZE_LEAK=3Dtrue" before sourcing
	"test-lib.sh". This test mode is used by the "linux-leaks" CI
	target.

Anyway, do you mind if this part is dropped from this series?

I have a set of patches I was meaning to submit to add a tri-state
[false,true,check] support for this, which this conflicts with.

"check" being a mode where we check that the tests in "false" aren't yet
passing. So for that I'll need to re-word this whole thing anyway. I'll
rephrase this while I'm at it to something I think you'll be OK with.

>>> -test_description=3D'test protocol whitelisting with submodules'
>>> +test_description=3D'test protocol restrictions with submodules'
>>=20
>> Minor: I think this shows the awkwardness of using a word derived from
>> "allow". Before we could use "whitelist" and "whitelisting"
>> consistentlry, but now you have "allowed", "allowlist", "restrictions"
>> etc.
>>=20
>> I guess you could say "test protocol allowances..." or something? Meh.
>
> Perhaps "filtering" is the best way to describe the higher-level
> feature that these lists help to implement.

*Shrug*. I think "filtering" more naturally refers to the process,
i.e. in Makefile syntax:

	$(filter-out $(A),$(LIST))
	$(filter $(B),$(LIST))

I'd call $(B) a whitelist (or whatever), $(A) a blacklist (or whatever),
but "filtering" the process of producing them.
