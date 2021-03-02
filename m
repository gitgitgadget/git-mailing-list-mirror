Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D65FC4332B
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13CC564EC3
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbhCCGXu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 01:23:50 -0500
Received: from mout.web.de ([212.227.15.4]:52717 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1447357AbhCBQDJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Mar 2021 11:03:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1614700826;
        bh=ct9EjO0cuKvq0wft9527gL38YPvRr6BeJpGrsckTGic=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=oyo+c5r5ihwnX9GhBzOYM42OtoapqTPxMcOUb6wIhCNzFQ1+2V/65rIHhPaJJ2qWT
         2RlMaCQipbi1eV8aHcUyqp/Z5qAZJLNcrRN6yz7zZgNAOTK0JCUk2J3Xz+OS+e63EF
         5g86va/hlcU/bJOY/6Wa3niVn+cQK/VzY6O3hXAc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.24.70]) by smtp.web.de
 (mrweb001 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0LwI2w-1lqvzA0bl8-017zWC; Tue, 02 Mar 2021 17:00:26 +0100
Subject: Re: [PATCH 1/2] pretty: add %(describe)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eli Schwartz <eschwartz@archlinux.org>, git@vger.kernel.org
References: <7418f1d8-78c2-61a7-4f03-62360b986a41@archlinux.org>
 <5561d11b-08c3-bcf7-5d37-a7d6c6bfb715@web.de>
 <87k0r7a4sr.fsf@evledraar.gmail.com>
 <b70e1b3a-dd5f-1fbc-22d5-e2bca4c00e79@web.de>
 <xmqq7dmqsr72.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe=2e?= <l.s.r@web.de>
Message-ID: <ef3832bb-ed81-e8bc-0a9f-39ae6e26ff9e@web.de>
Date:   Tue, 2 Mar 2021 17:00:25 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <xmqq7dmqsr72.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7TUWlCnh0kIZQsfSih+UI2/54HdIO/wtpf7S+hXNnpNuA7d0DXg
 iTmydLg0gpFQqYykTNzsYLNI21kBh4czEXtxGDoBjSZqgQ8sd4WoEzEC8OM9K4QwBaAnEg7
 o7TaEZlkyHq/bXaMD/PDSGiOr9zLO4oTaMopU4naMr/p7t9/JArX3Zg2CgN7oLBeDwonm/k
 +LdDkOoneD1hW/ssoqZqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2TvOdRFpTok=:eUOuLTzDfq4JeNb/p1xfRU
 3dB89H1Am7sArvUKTJuJTl4JE0ALgZAulLqtqimeytLnDA+05enIG81R1xq5cdrFEFaaaXs1p
 h1tz3nJKZvQzSo8WUUcSkwWWcYvDqPrxuUhp8DlsB4b5ibxOBQzXII6nAfFRGH3cLz++hl+E9
 5TUCx+zkZMg324uw2eGLONX/LGP2F9P4tVr/PqNzADMBtXGIy/IJv8VfZp6beaxdijMedr9C5
 2OET2UUukMczTcIrwV5El344ITjkvLsaghnI/uCuYbCw9dxgHtEXBo6fxHFq/YuFSpSvL5ugc
 vNqWNKAgrmwGNNZy8/8Bpuo9X408rDdRieE95X6T6pXnqJPjHD0j0y/6QYgTCIEXXJfxXRWKW
 tlLd0N4L0Mmh/qUPjCzo9L3S5nnmeyjJvfw4d5WOSNBvI9LXarSJEJhMjEw0tzV3PXni2b1It
 xCA0iy1hburrTPumgbHPxKNrLhLskVDg/aoCN2vK3NsLv8TtNuyiHq+/QrkA6sCTjegaFIrIY
 lTBtCFvPniaOUWKro5JkGHo/M0Sx1p1U9VmkZevDH6Ljf08RWaRmVa1chlXhM23sZ3wx1MdMn
 t+DZO7o5bL0rCTFExx6a93+Si9bpSGV+C1hJfrRKgNOLIhyoTDK8T+5fRQleFbXITuGuP5z25
 WdNErsltkBd1XKJqb5FzSeCaT76R2yXbsc2GMGLi0SRrTu0A8oxu6rwoESlHwt7WQGlzaZ9FQ
 uPPs1P4uBqS+QToRu4HxfNripZ54Tij4xdbaki9/gwOSArPPCdD1hf6th9uYAxgcrWoiqQM42
 as47DgSTCUlhU3mM7koNVi0IT7eXpj6vIh6eqtpBRhfsGU5BUjOHW8EUlgcs4Uy/8xa5MkDPr
 os4lS1GO2g02bh0vDxTA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.03.21 um 18:45 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe. <l.s.r@web.de> writes:
>
>> Subject: [PATCH] t4205: assert %(describe) test coverage
>>
>> Document that the test is covering both describable and
>> undescribable commits.
>>
>> Suggested-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  t/t4205-log-pretty-formats.sh | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats=
.sh
>> index b47a0bd9eb..cabdf7d57a 100755
>> --- a/t/t4205-log-pretty-formats.sh
>> +++ b/t/t4205-log-pretty-formats.sh
>> @@ -965,8 +965,17 @@ test_expect_success 'log --pretty=3Dreference is c=
olored appropriately' '
>>  test_expect_success '%(describe) vs git describe' '
>>  	git log --format=3D"%H" | while read hash
>>  	do
>> -		echo "$hash $(git describe $hash)"
>> +		if desc=3D$(git describe $hash)
>> +		then
>> +			: >expect-contains-good
>> +		else
>> +			: >expect-contains-bad
>> +		fi &&
>> +		echo "$hash $desc"
>>  	done >expect &&
>> +	test_path_exists expect-contains-good &&
>> +	test_path_exists expect-contains-bad &&
>
> Hmph, I am not sure why we want temporary files for this (and I
> doubt this "documenting" adds that much value to the tests to begin
> with), but OK.  Will queue.

Variables would suffice, but make debugging harder.  test_path_exists
will at least print a suggestive file name.  Perhaps we should add a
test_assert?

The added checks guard against neutering the test accidentally e.g.
by tagging the currently undescribable commit in the setup phase.
That would be hard to detect without it.

>
>>  	git log --format=3D"%H %(describe)" >actual 2>err &&
>>  	test_cmp expect actual &&
>>  	test_must_be_empty err
>> --
>> 2.30.1
