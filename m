Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025EEC5CFC2
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 17:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8DAC61370
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 17:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhGORkj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 13:40:39 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:55680 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231143AbhGORkj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 13:40:39 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id C590D4188B;
        Thu, 15 Jul 2021 19:37:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1626370664; x=1628185065; bh=UJeETh7EbXaYysb2Vws
        b+jdSLsT17XBzKervIrWN4do=; b=X7Nsw9PyncU519tMYOzhQ6Chs9N1aPAczNn
        S/qHgU8y18OoeQVpkKPMuyYedqBU0NHp4X03eH4Gn3gh/+zvbJFtIrdFICyLuZ5y
        8KjWJInMbxsjjBVcI7hMq63/PBiyPZP4vtb1rqaPQkXkZ8wklq96gSuEJ6YxZ0J5
        GMZdLAN8KztG2BJuCSvsTGYlBuw2URnoIcdOGeHYGNb0RMXKYwpK4pa9ErNTJt+N
        h1NRgm5dphwBegXKsZ0CFqf/TLzgundIzWUrkqRAdV1YchtKHs1CDPp1568xFDkE
        OyYu8nmSZzPFgH2rPhfxbM7SrQYPOXST6gKR4UBJjcUIEJE8tqx6ZflSh20K2Vdw
        QaERPVsseq4/ZvWesum7/zuBH1GCOLVO6AVdByoaObrcfOXyhLArIyV8ZYGYQR51
        KjdExJem9TCXJiJMp0xCDBFbVuVJJwoBpQj5AxvVwkyjWvwvfwQd3k+rz9eom+c7
        xmUq6eViQjBfXu/WKJObTR2O3O7E4CO9xm0jOZsbGbck7F9kXBscV0fC5ZmMxKH5
        saIP1dz1wIEaBEw4fHYm6DBj9EbVQvPIhyCGJP2J7r8Xu6Y0diq017ZmNwKQHEB7
        x3uHP2mfV8dwY6LGPTn4e47LkHU89DSa+Zn4QKd/Fw2W3DLR14ix234cyyrAdlZa
        dQ/akekc=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6wZgwin_zGkC; Thu, 15 Jul 2021 19:37:44 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id DD3E6403E6;
        Thu, 15 Jul 2021 19:37:42 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id C004B1B2A;
        Thu, 15 Jul 2021 19:37:37 +0200 (CEST)
Subject: Re: [PATCH v2 0/4] add a test mode for SANITIZE=leak, run it in CI
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover-0.4-0000000000-20210714T001007Z-avarab@gmail.com>
 <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <35b37777-a79b-6dce-eb45-f7cd9d569ddb@ahunt.org>
Date:   Thu, 15 Jul 2021 19:37:35 +0200
MIME-Version: 1.0
In-Reply-To: <cover-0.4-0000000000-20210714T172251Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/07/2021 19:23, Ævar Arnfjörð Bjarmason wrote:
> As a follow-up to my recent thread asking if we had some test mode or
> CI to test for memory leak regression (we don't), add such a test
> mode, and run it in CI.
> 
> Currently the two new CI targets take ~2-3 minutes to run in GitHub
> CI, whereas the normal test targets take 20-30 minutes. The tests run
> slower, but we have a small whitelist of test scripts that are OK.
> 
> v2:
> 
>   * Fixes issues spotted by Đoàn Trần Công Danh and Eric Sunshine,
>     thanks both!
> 
>   * I got rid of the change to t0500, I saw it being flaky in GitHub
>     CI, and looks like there'll be other concurrent edits to that file,
>     so leaving it be.
> 
> v1: http://lore.kernel.org/git/cover-0.4-0000000000-20210714T001007Z-avarab@gmail.com

> 
> Ævar Arnfjörð Bjarmason (4):
>    tests: add a test mode for SANITIZE=leak, run it in CI
>    SANITIZE tests: fix memory leaks in t13*config*, add to whitelist
>    SANITIZE tests: fix memory leaks in t5701*, add to whitelist
>    SANITIZE tests: fix leak in mailmap.c
> 

The leak fixes look good to me, modulo the UNLEAK as already commented 
on in patch 2/4 - thank you!

I don't feel qualified to review the test and CI related scripting, 
hopefully someone else will be able to look at those changes :).

ATB,

Andrzej

[...snip...]
