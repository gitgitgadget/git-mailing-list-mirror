Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01007C433C1
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 21:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B289861934
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 21:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhCUVeR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 17:34:17 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55773 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhCUVdv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 17:33:51 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 96C0211BFDD;
        Sun, 21 Mar 2021 17:33:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Ry/kMMkRutUd
        yPQ21PF/ytdZrlw=; b=MJLK/Fj0KHHvM23tVp6iNEfKNx4lR5NLYjrB5NdVlSyS
        dF6Ugj1DeC7tNIGxIuo8CK4DbvHgieE4r12d5aWlTx+Li4wxgvOI/jlxtIHWY8ku
        21gWNi3P2DJpjWl+4wtRaPCJiDnimRnSFe+ylShozWgiGxNLt6bLXCwFdZScKkY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=vrKans
        uIfHXJXTQxJVKehpgHfibTplwrqs+Z+mTeKmtRCubrOe/2Zt8/LCn5rWmJEsQF8K
        feQssAX+zdo743QBn1aBrjTi7qeMci+FlGYKtL1BcQI/Rn2+l/5rDaDov1q2v0KH
        5XrEp+VMmxDf2uxd+Hl/YAJlnDo33pFg2t/1k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8FCB211BFDC;
        Sun, 21 Mar 2021 17:33:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D307711BFDB;
        Sun, 21 Mar 2021 17:33:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] diff --no-index tests: add test for --exit-code
References: <87wnu0r8tq.fsf@evledraar.gmail.com>
        <cover.1616330120.git.avarab@gmail.com>
        <a6e4ed6c3f1d37170d7e99a2fab9c90662cceb19.1616330120.git.avarab@gmail.com>
        <29da572f-8d94-000e-ffc0-fded4b56d3c3@ramsayjones.plus.com>
Date:   Sun, 21 Mar 2021 14:33:45 -0700
In-Reply-To: <29da572f-8d94-000e-ffc0-fded4b56d3c3@ramsayjones.plus.com>
        (Ramsay Jones's message of "Sun, 21 Mar 2021 18:33:58 +0000")
Message-ID: <xmqqa6qw9op2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1EECE7E4-8A8D-11EB-A7AD-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> On 21/03/2021 12:39, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Add a test for --exit-code working with --no-index. There's no reason
>> to suppose it wouldn't, but we weren't testing for it anywhere in our
>> tests. Let's fix that blind spot.
>>=20
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
>> ---
>>  t/t4053-diff-no-index.sh | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/t/t4053-diff-no-index.sh b/t/t4053-diff-no-index.sh
>> index 0168946b639..9b7a8ebfd3f 100755
>> --- a/t/t4053-diff-no-index.sh
>> +++ b/t/t4053-diff-no-index.sh
>> @@ -16,7 +16,12 @@ test_expect_success 'setup' '
>>  	echo 1 >non/git/b
>>  '
>> =20
>> -test_expect_success 'git diff --no-index directories' '
>> +test_expect_success 'git diff --no-index --exit-code' '
>> +	git diff --no-index --exit-code a/1 non/git/a &&
>> +	test_expect_code 1 git diff --no-index --exit-code a/1 a/2
>> +'
>> +
>> +Test_expect_success 'git diff --no-index directories' '
>
> I assume that s/test/Test/ was not intended. ;-)

;-) =20

Love to see reviewers are more careful than submitters' shells that
are too lenient to allow such a test to pass before such a patch
gets submitted.

