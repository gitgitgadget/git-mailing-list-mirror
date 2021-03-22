Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D555DC433E3
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 17:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACA5E619A8
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 17:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbhCVRHS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 13:07:18 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51790 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbhCVRHM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 13:07:12 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 26924117106;
        Mon, 22 Mar 2021 13:07:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=R6QltVtuX/leIdQUAKUMPyodD
        I8=; b=AoIA8xEPfhxJiYkflldejhlkjYu6fDMx6PFC6zIT5x+qpDko9pcTH45I8
        15n/ql87uMHp7OO5DjlV353EdkxdfREI63PjgFhqhIllaR65rR5chhQDzjThtgNC
        VHeYaKuATv/+RUXvQzvOr5lC9udvKcoV6dxWdXhnby8KN966iI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=VokGau0C0s3vH2SNRov
        ZEVPPdUH4ZeAGRPKqNQILMOtpIzftuRA6SNIxEYKG5mro2fBUY6V/7Ts5fLnDW5k
        mSAeKvGFDZruglP3mfHq6yvn26FxgPvJU/ZMm4XUDeXoA0vOnMdW0uDnUWEbMeIN
        O95y0drC75niLubKH7TNxlJY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1DB21117105;
        Mon, 22 Mar 2021 13:07:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 646DA117077;
        Mon, 22 Mar 2021 13:07:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7Ru?= =?utf-8?B?Zw==?= Danh 
        <congdanhqx@gmail.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 2/2] [GSOC] interpret-trailer: easy parse trailer value
References: <pull.911.git.1616251299.gitgitgadget@gmail.com>
        <pull.911.v2.git.1616317134.gitgitgadget@gmail.com>
        <8b8b236a4ffb81a8c6be3f320b878cea1d0f9d7a.1616317135.git.gitgitgadget@gmail.com>
        <CAP8UFD1Oo-eWmoV-1mh1M=pA8+yRUYHy1wg8NvN3bthmCHBfvQ@mail.gmail.com>
        <xmqqwnu0bga9.fsf@gitster.g>
        <CAOLTT8TU+XwLmDQRROHW6iumFgMKok9mi+_OBmN4FbvgWkNb7Q@mail.gmail.com>
Date:   Mon, 22 Mar 2021 10:07:06 -0700
Message-ID: <xmqqv99j6rt1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 08EC26FE-8B31-11EB-8F0D-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8822=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=8812:52=E5=86=99=E9=81=93=EF=BC=9A
>>
>> Christian Couder <christian.couder@gmail.com> writes:
>> ...
>> > So even without this patch, after your first patch that implements
>> > `git commit --trailer ...`, it should be easy to setup something les=
s
>> > verbose and less error-prone.
>>
>> It is nice that it makes the complexity of 2/2 unnecessary ;-)
>
> A little frustrated, both `--own-identity` and `@nickname` seem to be
>  rejected. I will roll back to the first patch.

If existing functionality can be used to achieve the same end result
without any extra effort by end-users, that's a happy endgame, isn't
it?  There isn't a reason to be frustrated---the users benefit with
the new --trailer option without adding (hence having to learn) new
extra features like --own-ident or @name, which is a big plus.


