Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FCDC2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 18:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A8F62072C
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 18:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BaFmtBZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732308AbgKDSMC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 13:12:02 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60764 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730052AbgKDSMC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 13:12:02 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 27FBC85C0C;
        Wed,  4 Nov 2020 13:12:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VsGw3D71ASkgyuQgSnazmUmnhZc=; b=BaFmtB
        ZEbudXzVB1umnDbXTYDOnMEqblExX04qDiMNclxNrhwAI7o5SGuKaWX7SXx4kYNp
        jnkWp3CBh1hw4x3Z4T10YOuywILkaY6N850IS4qWiTtxmFO3ghkdiuBambdL22KR
        nROq3A4AWMMmFfLkm4zxxhL/oseVTcobHAc98=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GQoYiw3LG0+niRRY9NSt3mA/2hoQs1wM
        s/CCiGLI4NOoKJ9y73XzmWPEUmbORC0qU9Cf3lxdNtXO/G8lDxNFuaUIfmPhWDVp
        41kN6/l4L3BWyXzEjHLunlnrOX2qFSSWeNGPcd7Xvl9+ycZqorE1ViDI8hfKRt80
        E9yjeaAQw7Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E84585C0B;
        Wed,  4 Nov 2020 13:12:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8904885C0A;
        Wed,  4 Nov 2020 13:11:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] Makefile: enable -Wsparse-error for DEVELOPER build
References: <eaf5ac83-af3f-5028-3a9e-1669c9cde116@ramsayjones.plus.com>
        <xmqqsg9uxchb.fsf@gitster.c.googlers.com>
        <6676a08d-0c25-14ba-4ea6-677bc7ab0e20@ramsayjones.plus.com>
        <xmqqh7q7vbah.fsf@gitster.c.googlers.com>
        <43aadae9-a4c1-f1e4-6902-c05af36fcf19@ramsayjones.plus.com>
        <nycvar.QRO.7.76.6.2011041431370.18437@tvgsbejvaqbjf.bet>
        <67b3569c-453f-4e6a-502e-136f8f3d8df7@ramsayjones.plus.com>
Date:   Wed, 04 Nov 2020 10:11:58 -0800
In-Reply-To: <67b3569c-453f-4e6a-502e-136f8f3d8df7@ramsayjones.plus.com>
        (Ramsay Jones's message of "Wed, 4 Nov 2020 16:57:47 +0000")
Message-ID: <xmqqk0v1m1ox.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3B396F24-1EC9-11EB-B332-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> On 04/11/2020 13:43, Johannes Schindelin wrote:
>> Hi Ramsay,
>> 
>> On Tue, 3 Nov 2020, Ramsay Jones wrote:
>> 
>>> On 02/11/2020 18:55, Junio C Hamano wrote:
>>>
>>>> CI builds already have enough stuff around invocation of "make test"
>>>> etc., and it would be trivial to pass SPARSE_FLAGS from the command
>>>> line when adding "make sparse" invocation to one of the scripts in ci/
>>>> directory, so from that point of view, this patch is not needed for
>>>> them, either.
>>>
>>> My concern was more about how the CI system obtains/installs/builds a
>>> sufficiently new version of sparse. Otherwise, 'make sparse' won't do
>>> very much. ;-)  As I said, I don't know what's involved in getting that
>>> to work.
>> 
>> As mentioned in https://github.com/gitgitgadget/git/issues/345, there is a
>> Pipeline that builds sparse packages for Ubuntu, ready for use in our CI
>> build: https://dev.azure.com/git/git/_build?definitionId=10&_a=summary.
>> Currently, it is scheduled to run every weekday at 5:00am (I assume that's
>> UTC).
>
> Oh-my! Has there been a CI 'make sparse' build since september last year? :-D
> I missed that! (I couldn't view the azure build summary given above - it just
> keeps asking for a user/password :( ).

Hmph, is that what Dscho said?

I thought he was just saying packaged versions of latest sparse
usable on Ubuntu are regularly available so those who wants to add
"make sparse" to our jobs have a place to fetch it from.
