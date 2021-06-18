Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC62CC48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 14:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 900D36127C
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 14:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbhFROFX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 10:05:23 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:40880 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230387AbhFROFW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 10:05:22 -0400
Received: from host-78-147-180-220.as13285.net ([78.147.180.220] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1luF5U-000C6z-D2; Fri, 18 Jun 2021 15:03:12 +0100
Subject: Re: [PATCH 0/3] Make CMake work out of the box
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Matthew Rogers via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Danh Doan <congdanhqx@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
References: <pull.970.git.1622828605.gitgitgadget@gmail.com>
 <6a9150ca-5c1a-1874-5f8b-35187f197d47@gmail.com>
 <nycvar.QRO.7.76.6.2106101140590.57@tvgsbejvaqbjf.bet>
 <b52d7c45-06dd-a9eb-bc86-e04d2ee16c5e@iee.email>
 <nycvar.QRO.7.76.6.2106181540340.57@tvgsbejvaqbjf.bet>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <bdb8bd83-c3d9-b8bd-2bd5-8b7ee0cd346a@iee.email>
Date:   Fri, 18 Jun 2021 15:03:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2106181540340.57@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 18/06/2021 14:42, Johannes Schindelin wrote:
>>> We already exercise the plain Makefile plenty, and the CMake-based build
>>> using Windows (in the `vs-build` job in `.github/workflows/main.yml`).
>> There is one 'gotcha' in the yml (probably historical) in that it
>> doesn't actually test the approach/changes that Matt addresses regarding
>> my [1].
>>
>> That is, I'm looking at the 'out of the box' view, while the yml test
>> _preloads_ the vcpkg artefacts.
> We need to "pre-load" them because building them would add another
> whopping 20 minutes to each CI run. And I am not talking total time, but
> wall-clock time.
>
> And we're not in the business of testing vcpkg's build.
>
> So I am really not in favor of even thinking about changing this
> "pre-loading" strategy.
>
>
I can see the common sense in that, however I was trying to highlight
that the approach in patch series could go stale, as did the previous
method. Making the entry ramp to investigating the code for the wide
variety windows users should have _some_ testing..

I don't have any good ideas about how to get out of that 20 minute
Catch-22 issue at the moment. Maybe it needs an independent, on-demand
(i.e. infrequent;-) test.

Maybe there is a way of adding a `--CI-test` option that at least
exercises the logic without needing the vcpkg to be built again (IIRC,
and I may well be wrong, we build once, remember the artefacts, and then
re-used them, but .. dunno).

Philip
