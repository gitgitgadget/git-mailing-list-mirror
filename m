Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68956C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 16:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244026AbiCGQOY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 11:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237281AbiCGQOX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 11:14:23 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF6B24089
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 08:13:27 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id m21so15150709edc.0
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 08:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=olkui+rjt2NpRONMhQoxd7x13HBXRrQeV/sSyrlnWzU=;
        b=XikyzSdQD5Gre17dRU5k5/oAZ25VLjjrWWGXEuLKNoHHZ4Oi94mfijPRFqj0IbeFmt
         X6HdnFu+wBX3leffRwdcnyZ11CxaufoIlaR0TpHP6G7XrmgFI+xjUk7+0POqxsc9IDxi
         Pdt3KoQuzXW2wQ30HN4Ik14+d5wwOY9BTwprq+s03KAPRf0SAlt58AZUvhEndNWV6KEc
         c1AJRX9Rt7L2ig1oUGnUXVZJbSa6fMdHVo4D+nYoC+VJRmW8GldGZg8ElLiUvjSBMVnk
         UMO18GndgSBGudxBaQJvjtf1L/rNTX1EvdzK1gmH4D8MGwGffg8imR4jjG44Yj1ZSmAz
         VtjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=olkui+rjt2NpRONMhQoxd7x13HBXRrQeV/sSyrlnWzU=;
        b=GI154+ZADNwzfufWg/Y1e/lQXBYBHPRIn0sHm/rQQhHrGmlO89mH2yUFdN2MbxcbnP
         i+4/YYimXiOwB7qHWJptdisPdJtuzyUZHdGsk5hJDDrlsCD3JrIE1b4BP0NSBesideVp
         Ak+ZTh9HqgWxqLrIWHSntdOfwwDp55NJpxYapsCNHP3OLXGYaqrjJzZ8X/lyi+agMn8B
         aoyQ56iMrAmom0s/tXt41IVaOXgTvq7610o1HfrU8Y7EC+Dc5fSBh318HQdjbBWPtfp0
         X0ssDtA/SD6cdHoqAS+ZlYGVMhKvtAOriZAXiVFmsvqiLoClnAOks3/cTg7kqPH1WE/E
         RJNw==
X-Gm-Message-State: AOAM533c9pw1qbY5idYbVnnY/6r8xKbsNtJ6N3NuqgKhDcT4aznwSuXn
        F3v/EqK9eQAWGm2xqNnVsYg=
X-Google-Smtp-Source: ABdhPJxwIJPE1QxA/sy372TY5R8RcRZiKIi/5XXAObbUm5QLgygBpSih8NzcQB5gvM4AiOWJ1bacSQ==
X-Received: by 2002:a05:6402:2810:b0:415:ff8b:cd2a with SMTP id h16-20020a056402281000b00415ff8bcd2amr11644979ede.333.1646669606247;
        Mon, 07 Mar 2022 08:13:26 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id k23-20020a1709062a5700b006ccd8fdc300sm4826554eje.180.2022.03.07.08.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 08:13:25 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nRFzA-001b5I-Vg;
        Mon, 07 Mar 2022 17:13:24 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 0/9] ci: make Git's GitHub workflow output much more
 helpful
Date:   Mon, 07 Mar 2022 17:05:54 +0100
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
 <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
 <220302.86mti87cj2.gmgdl@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2203071655070.11118@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <nycvar.QRO.7.76.6.2203071655070.11118@tvgsbejvaqbjf.bet>
Message-ID: <220307.86tuc9yc4b.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 07 2022, Johannes Schindelin wrote:

> On Wed, 2 Mar 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>>
>> On Tue, Mar 01 2022, Johannes Schindelin via GitGitGadget wrote:
>>
>> > Changes since v1:
>> >
>> >  * In the patch that removed MAKE_TARGETS, a stale comment about that
>> >    variable is also removed.
>> >  * The comment about set -x has been adjusted because it no longer app=
lies
>> >    as-is.
>> >  * The commit message of "ci: make it easier to find failed tests' log=
s in
>> >    the GitHub workflow" has been adjusted to motivate the improvement
>> >    better.
>>
>> Just briefly: Much of the feedback I had on v1 is still unanswered,
>
> Yes, because I got the sense that your feedback ignores the goal of making
> it easier to diagnose test failures.

I think that's a rather strange conclusion given that I've submitted a
parallel series that makes some of those failures easier to diagnose
than the same changes in this series. I.e. the failures in build
v.s. test phases, not the individual test format output (but those are
orthagonal).

I think it's a fair summary of our differences that we're just placing
different values on UX responsiveness. I'm pretty sure there's some
amount of UX slowdown you'd consider unacceptable, no matter how much
the output was improved.

Clearly we just use it differently.

>> or in the case of the performance issues I think just saying that this
>> output is aimed at non-long-time-contributors doesn't really justify the
>> large observed slowdowns.
>
> What good is a quickly-loading web site when it is less than useful?

For all the flaws in the current output there are cases now where you
can click on a failure, see a summary of the 1-2 tests that failed, and
even find your way through the right place in the rather verbose raw log
output in 1/4 or 1/2 the time it takes the initial page on the new UX to
loda.

> I'd much rather have a slow-loading web site that gets me to where I need
> to be than a fast-loading one that leaves me as puzzled as before.

I think it's clear that we're going to disagree on this point, but I'd
still think that:

 * In a re-roll, you should amend these patches to clearly note that's a
   UX trade-off you're making, perhaps with rough before/after timings
   similar to the ones I've posted.

   I.e. now those patches say nothing about the UX change resulting in
   UX that's *much* slower than before. Clearly noting that trade-off
   for reviewers is not the same as saying the trade-off can't be made.

 * I don't see why the changes here can't be made configurable (and
   perhaps you'd argue they should be on by default) via the ci-config
   phase.
