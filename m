Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65872C433E0
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 08:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21116229CA
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 08:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgLXINP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Dec 2020 03:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgLXINP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Dec 2020 03:13:15 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617E1C061794
        for <git@vger.kernel.org>; Thu, 24 Dec 2020 00:12:34 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id cw27so1495412edb.5
        for <git@vger.kernel.org>; Thu, 24 Dec 2020 00:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w8rnt4yJfKSDNFBdQ0lDNAH881Q0SLbwLR64K0TpRq0=;
        b=ioG763/ySb6m0c0uWSFKxcjuyM6vxb4Hwtr/VpMgRFOi4R8odOPgII4AoKTHSD16bC
         SPEIPgmvxevYs/ZWRooXohrLJHDdbycLn75pZQ3LQA5GbawvWvOfAOjDgYPWy2Lhqllf
         OCs7Yemu+din90l0q16mflZgIws35IvLAL5u9guLkLUsHLracCiSQ6BV7c6smTXMx2G0
         cgDyjDpv03wZlKg+RxZ6Qs1TP0TyubmhBG+WiH2OxdkzEDXNtisMa0kshG+ZLstiiCee
         7dzQtA0H4ObZgcsWlYrmj1hcM7KdeFjDnVjg4pC0aTDU6o5j+JS3rlkYAJ5zkLtpeEJ3
         usDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w8rnt4yJfKSDNFBdQ0lDNAH881Q0SLbwLR64K0TpRq0=;
        b=LaVhK3PMtRL43NUXK79OCOYhC1AOpGDrT5O2qsUTUBkA0nf2uWuRiHPX98n3QM8s7i
         QVfRydDYB2JdNMzI9nQI3Q5tC3CMU66aY2CukcdofQcxmFwV4fuNtGTNafmiVvED7lZm
         19q/RCD350I/lWPPuCK3X85wsAJwRpv3amjZqYi8cCsidx4ibSk3wIEqHej5WyLrobWW
         daY0WIMEALSJj8YKiBDOWD/7cPGLNMZ3iZfHH6HuJ3KtuYCsgLrq6D5f2qeNWREKNCU5
         4ZYoo1gkrxX/phXyyj1bb1K9oNTlkQ3hXkUFzQDkgeFrGBu5WwPG6IcvPY2V0XR62uz4
         Fm9A==
X-Gm-Message-State: AOAM530TVuHwQBltKgQgpCfteT+jC4Z32JpS3iSQOhgDo+aD2xRUE/uA
        D47liXIYN156RNToo9V4vjlVDuw4YAGvkyIFZXM=
X-Google-Smtp-Source: ABdhPJz5NAhcyPB5i9FYLDDgSaUW2whfZHoryNIzdE+SSJaescLt8H6sC2z1Tr5lagARqSNtSlxumzn7JBC1Xyo4ymI=
X-Received: by 2002:a05:6402:3049:: with SMTP id bu9mr27727456edb.127.1608797552881;
 Thu, 24 Dec 2020 00:12:32 -0800 (PST)
MIME-Version: 1.0
References: <20201124164405.29327-1-rafaeloliveira.cs@gmail.com>
 <20201126204141.1438-1-rafaeloliveira.cs@gmail.com> <20201126204141.1438-2-rafaeloliveira.cs@gmail.com>
 <20201208201256.GK36751@google.com> <xmqqsg8g559i.fsf@gitster.c.googlers.com> <xmqqh7ow54eb.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqh7ow54eb.fsf@gitster.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 24 Dec 2020 09:12:21 +0100
Message-ID: <CAP8UFD2mrgympQ0tbhty+cgZ7ow_+bsxE8gm1Wsn_mo+a6sq2Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] maintenance: fix SEGFAULT when no repository
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 9, 2020 at 2:16 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Josh Steadmon <steadmon@google.com> writes:
> >
> >> Caught a typo here, sending this as a squash patch since it's already in
> >> next:
> >
> > The breakage and the fix looks obvious to me, but...
> >
> > How did CI allow 'next' to pass with such a typo, I wonder?
> > Moreover, my pre-push tests of all the integration branches
> > I didn't notice this to fail, but I cannot see how it could
> > have been succeeded.  Puzzled...
>
> That is because of this:
>
>     $ (sh t7900-maintenance.sh 2>&1; echo $?) | tail -5
>     ok 25 - register preserves existing strategy
>     t7900-maintenance.sh: line 444: test_execpt_success: command not found
>     # passed all 25 test(s)
>     1..25
>     0
>
> The story is the same with prove.
>
>     $ prove t7900-maintenance-sh
>     t7900-maintenance.sh .. 24/? t7900-maintenance.sh: line 444: test_execpt_success: command not found
>     t7900-maintenance.sh .. ok
>     All tests successful.
>     Files=1, Tests=25,  2 wallclock secs ( 0.02 usr  0.01 sys +  0.97 cusr  0.97 csys =  1.97 CPU)
>     Result: PASS
>
> Since this typo appeared immediately before test_done, we _could_
> improve test_done to pay attention to $? when it starts (and in a
> similar fashion, we _could_ also check $? at the beginning of the
> test_expect_* for the previous step), but I do not think that is a
> good approach that would scale well.  There are legitimate reasons
> we have to write things other than test_expect_* at the top level
> of the script (e.g. test helper function may have to be defined to
> be shared amongst the test pieces in the same script).
>
> I wonder if it is a good direction to go to run the tests with the
> "set -e" option on, and accept its peculiarities.

Another solution could be to define a command_not_found_handle
function as bourne shells should call that.

By the way it's not the first time we get such an issue, see:

https://lore.kernel.org/git/CAP8UFD15+p+xKwJ=B9WVsrc+2TvLHKmu78SBCLUFZVSYoTtbbg@mail.gmail.com/
