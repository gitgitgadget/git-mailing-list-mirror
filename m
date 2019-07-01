Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA3EC1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 16:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbfGAQjy (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 12:39:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54984 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbfGAQjx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 12:39:53 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DB68416746E;
        Mon,  1 Jul 2019 12:39:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=QVl52fvXVdiR
        mjpYpbAKwDJvy3s=; b=XiV/gXiujjUUnWKEeJQvLcI8LtW3VIEq5p6FywhCl/WB
        At8/y2B+byKAeBlNL1zTP3eRIq3qMnWq5ocM7zwJ1O3Za603KXev7DFvRtVUKpOA
        QDVmLqVZkkLASC1WEgsPBhn8D306am7p/aDdIv4yzfgku1iIzvXBspS4lTR2ny0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=PCQP5O
        GRGa3sfC8tUU1mIPqGzUnFKlLCORG0b0NH2zgbYdDQtvVVizDejN8HSUlC3dSOvG
        9sDq0ofBAVhQJdo77pt1ps4rBIBdVkcrO1rnWluZ8zQZOBkUrO7piYI6aZB1rq/c
        HmJxhof2ApIKBn/jahAK0X7XEE7NsX89DCkBI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D2DD816746D;
        Mon,  1 Jul 2019 12:39:50 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 32F9116746C;
        Mon,  1 Jul 2019 12:39:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: ab/no-kwset, was Re: What's cooking in git.git (Jun 2019, #07; Fri, 28)
References: <xmqqzhm173sp.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1907011515150.44@tvgsbejvaqbjf.bet>
Date:   Mon, 01 Jul 2019 09:39:48 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1907011515150.44@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Mon, 1 Jul 2019 15:16:26 +0200 (CEST)")
Message-ID: <xmqqimsl7lpn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D83BF33E-9C1E-11E9-AB19-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio & =C3=86var,
>
> On Fri, 28 Jun 2019, Junio C Hamano wrote:
>
>> * ab/no-kwset (2019-06-28) 9 commits
>>  - grep: use PCRE v2 for optimized fixed-string search
>>  - grep: remove the kwset optimization
>>  - grep: drop support for \0 in --fixed-strings <pattern>
>>  - grep: make the behavior for NUL-byte in patterns sane
>>  - grep tests: move binary pattern tests into their own file
>>  - grep tests: move "grep binary" alongside the rest
>>  - grep: inline the return value of a function call used only once
>>  - grep: don't use PCRE2?_UTF8 with "log --encoding=3D<non-utf8>"
>>  - log tests: test regex backends in "--encode=3D<enc>" tests
>>
>>  Retire use of kwset library, which is an optimization for looking
>>  for fixed strings, with use of pcre2 JIT.
>>
>>  Will merge to 'next'.
>
> There is still a test failure that I am not sure how =C3=86var wants to
> address:
>
> https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D11535&v=
iew=3Dms.vss-test-web.build-test-results-tab

Thanks for a quick response to stop me.

As this is a mere swapping-an-optimization-with-yet-another-one, I
do not think we are in a hurry to have it graduate.

