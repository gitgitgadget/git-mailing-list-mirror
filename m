Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E65CC433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 18:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D40BE610FC
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 18:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbhDOSgO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 14:36:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63292 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbhDOSgN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 14:36:13 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DEF65C6BC9;
        Thu, 15 Apr 2021 14:35:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=We/0Trj8c5Vx
        1g0b2YeKY2bWxlQ=; b=LbLvSYm7MNvMN3V3ChtrfnGQKWuCCXlC22nmWz2OaC96
        ofMhFFC+7cJ7YqVOxnP6J9eKjkktdJ883ukriqA88JvIZivdR1H1KsUgMETsGnYi
        g1xakr2yqr2B9JMcJA0TamIVqhPYWMYcmaOw6Nddd/vVc8KlCEvWVxB03iZY4gk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=kUGuMo
        EsNWR8YrLpGiBd5pAM2Pwp5oE9fPdjqKsaFXRN8gtx1X/6tCzzEHivK3J4AkdGWU
        YpWX4UMvk5bzWXZ/VhGab9+v6Gj+Ocnb94H/x/NkldfN1vSNA/3glnwuS7U1TDI5
        jofhpynykCPI0q3/EU/U4byCO2LMVlW3DdVVU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D6162C6BC8;
        Thu, 15 Apr 2021 14:35:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 57C4EC6BC7;
        Thu, 15 Apr 2021 14:35:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 15/16] Revert and amend "test-lib-functions: assert
 correct parameter count"
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
        <patch-15.16-0cd511206c4-20210412T110456Z-avarab@gmail.com>
        <xmqqa6q3cn0s.fsf@gitster.g> <87blafvl49.fsf@evledraar.gmail.com>
Date:   Thu, 15 Apr 2021 11:35:48 -0700
In-Reply-To: <87blafvl49.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 15 Apr 2021 13:32:38 +0200")
Message-ID: <xmqqh7k7qttn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 665EAF00-9E19-11EB-AF5F-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Apr 12 2021, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>
>>>  test_path_is_file () {
>>> -	test "$#" -ne 1 && BUG "1 param"
>>> -	if ! test -f "$1"
>>> +	if ! test -f "$@"
>>>  	then
>>> -		echo "File $1 doesn't exist"
>>> +		echo "File $@ doesn't exist"
>>>  		return 1
>>
>> What does it even mean to call
>>
>> 	test_path_is_file Documentation/ Makefile
>>
>> with this patch applied?
>>
>> If there were three files "COPYING Makefile", "COPYING", and
>> "Makefile", what would happen when you did
>>
>> 	test_path_is_file COPYING Makefile
>>
>> (without dq around them)?
>>
>> I think this particular medicine is far worse than the symptom it
>> tries to cure.
>
> We'll error with:
>
>     test: foo: unexpected operator

Ah, so use of "$@" was intentional.  That's clever (I thought it was
a common typo people make when they mean "$*").

Of course, it would not work if the caller did a nonsense like so:

	test_path_is_file foo -o ok

but as long as we trust that the callers would not make stupid
mistakes, this is OK.  Is that the reasoning behind this removal of
the BUG?

> I thought guarding just for the one-off development error of not using
> the function correctly wasn't worth it, but I thought it made sense not
> to litter all of this with:
> =09
> 	diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> 	index 28b8826e565..0bd7367a07e 100644
> 	--- a/t/test-lib-functions.sh
> 	+++ b/t/test-lib-functions.sh
> 	@@ -690,6 +690,7 @@ test_expect_success () {
> 	 test_path_is_file () {
> 	 	if ! test -f "$@"
> 	 	then
> 	+		test $# -eq 1 || BUG "Do not call test_path_is_file() with more tha=
n one argument!"

But this breaks our assumption that the caller would not be making
stupid mistakes, so I am not sure if it is worth it.  If we were to
have a sanity check, shouldn't we do the check upfront, like the
original?

Thanks.
