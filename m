Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5668C433E1
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 18:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A51261A26
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 18:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237297AbhCXSIe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 14:08:34 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:41697 "EHLO bsmtp5.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237397AbhCXSIH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 14:08:07 -0400
X-Greylist: delayed 2880 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Mar 2021 14:08:06 EDT
Received: from bsmtp1.bon.at (unknown [192.168.181.103])
        by bsmtp5.bon.at (Postfix) with ESMTPS id 4F5FNj2zhlz5tpW
        for <git@vger.kernel.org>; Wed, 24 Mar 2021 18:20:05 +0100 (CET)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4F5FNW215jz5tl9;
        Wed, 24 Mar 2021 18:19:55 +0100 (CET)
Subject: Re: [PATCH v4 00/10] userdiff: refactor + test improvements
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>
References: <20210224195129.4004-1-avarab@gmail.com>
 <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <7c560336-c087-5159-06c2-5b22e949902e@kdbg.org>
Date:   Wed, 24 Mar 2021 18:19:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <cover-00.11-00000000000-20210324T014604Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.03.21 um 02:48 schrieb Ævar Arnfjörð Bjarmason:
> This is a restart of the 35-patch v3 of this topic at
> https://lore.kernel.org/git/20210224195129.4004-1-avarab@gmail.com/
> 
> I still plan on submitting the rest of it, but wanted to start with
> the early parts of that series that hasn't been controversial or has
> outstanding feedback I haven't addressed.
> 
> The range-diff to v3 is just for those patches I'm re-rolling here.

I'm mostly relying on the interdiff below. I think I had no comments on
these patches in the earlier round, so:

Acked-by: Johannes Sixt <j6t@kdbg.org>

> 
> Ævar Arnfjörð Bjarmason (10):
>   userdiff: refactor away the parse_bool() function
>   userdiff style: re-order drivers in alphabetical order
>   userdiff style: declare patterns with consistent style
>   userdiff style: normalize pascal regex declaration
>   userdiff: add and use for_each_userdiff_driver()
>   userdiff tests: explicitly test "default" pattern
>   userdiff tests: list builtin drivers via test-tool
>   userdiff: remove support for "broken" tests
>   blame tests: don't rely on t/t4018/ directory
>   blame tests: simplify userdiff driver test
> 
>  Makefile                 |   1 +
>  t/annotate-tests.sh      |  34 ++++----
>  t/helper/test-tool.c     |   1 +
>  t/helper/test-tool.h     |   1 +
>  t/helper/test-userdiff.c |  31 +++++++
>  t/t4018-diff-funcname.sh |  39 ++-------
>  t/t4018/README           |   3 -
>  userdiff.c               | 178 ++++++++++++++++++++++++---------------
>  userdiff.h               |  15 ++++
>  9 files changed, 186 insertions(+), 117 deletions(-)
>  create mode 100644 t/helper/test-userdiff.c
> 
> Range-diff:
>  1:  0be132b05e2 =  1:  fb7346cd296 userdiff: refactor away the parse_bool() function
>  2:  d1e00a739ac =  2:  149387155bc userdiff style: re-order drivers in alphabetical order
>  3:  b99bd158d45 =  3:  faf1a824f05 userdiff style: declare patterns with consistent style
>  4:  9ce6d47021c =  4:  1e9ddcd1a9a userdiff style: normalize pascal regex declaration
>  5:  369fbdcee83 =  5:  64ea5e8443f userdiff: add and use for_each_userdiff_driver()
>  6:  70d62a97211 =  6:  862f6ab5d66 userdiff tests: explicitly test "default" pattern
>  7:  792421a2f8b =  7:  22a07591b76 userdiff tests: list builtin drivers via test-tool
>  8:  9081e2a152e !  8:  7755db95014 userdiff: remove support for "broken" tests
>     @@ Commit message
>      
>          There have been no "broken" tests since 75c3b6b2e8 (userdiff: improve
>          Fortran xfuncname regex, 2020-08-12). Let's remove the test support
>     -    for them, this is in preparation for a more general refactoring of the
>     -    tests.
>     +    for them.
>      
>          Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>      
>  9:  d3652f95d5e !  9:  4e0b4b42e16 blame tests: don't rely on t/t4018/ directory
>     @@ Commit message
>          with userdiff driver, 2020-11-01) so that the blame tests don't rely
>          on stealing the contents of "t/t4018/fortran-external-function".
>      
>     -    I'm about to change that file in a subsequent commit. Just moving the
>     -    relevant test file here inline is the easiest solution, and I think
>     -    also the most readable.
>     +    I have another patch series that'll possibly (or not) refactor that
>     +    file, but having this test inter-dependency makes things simple in any
>     +    case by making this test more readable.
>      
>          Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>      
> 10:  35d12779ea1 ! 10:  ce98c61bf40 blame tests: simplify userdiff driver test
>     @@ Commit message
>          test_commit, 2021-01-12).
>      
>          We also did not need the full fortran-external-function content. Let's
>     -    cut it down to just the important parts, and further modify it to
>     -    demonstrate that the fortran-specific userdiff function is in effect
>     -    by adding "DO NOT MATCH ..." and "AS THE ..." lines surrounding the
>     -    "RIGHT" one. This is to check that we're using the userdiff "fortran"
>     -    driver, as opposed to the default driver.
>     +    cut it down to just the important parts.
>      
>     -    The test also left behind a .gitattributes files, let's clean it up
>     -    with "test_when_finished".
>     +    I'm modifying it to demonstrate that the fortran-specific userdiff
>     +    function is in effect by adding "DO NOT MATCH ..." and "AS THE ..."
>     +    lines surrounding the "RIGHT" one.
>     +
>     +    This is to check that we're using the userdiff "fortran" driver, as
>     +    opposed to the default driver which would match on those lines as part
>     +    of the general heuristic of matching a line that doesn't begin with
>     +    whitespace.
>     +
>     +    The test had also been leaving behind a .gitattributes file for later
>     +    tests to possibly trip over, let's clean it up with
>     +    "test_when_finished".
>      
>          Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>      
> 
