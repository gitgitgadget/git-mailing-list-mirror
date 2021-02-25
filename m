Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5303C433E0
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 19:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8488760202
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 19:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbhBYTwj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 14:52:39 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51489 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbhBYTu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 14:50:58 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 722C611BD18;
        Thu, 25 Feb 2021 14:50:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0bE2xbkR/RybqnIP+CKuC4DuykY=; b=cTv2bM
        BeZ5cbAXnld5LMkGwF1C8qO9OF9ZYn/ic+Bc/W6FAPRdPqy+pEspfW1S5zAUtnja
        /pRvpn972WtZPg0UWbrLTq0S7wlzOI8KP4njXZY3WP1Txz/y8j17ejvZFnK0T8u6
        +ebm5O3pf0knF9wOMmDZfmO2iMPxqQdYWOmWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DyqIoPp74bLZCLoZ9I9/kzuABdjob9gq
        amp/Yz3dpnhtJNCt5JeMHXxA1K5MGb+L43heyIV4cLUFS1Fe25RlXB8Iflcaq7mn
        NWQbjjNlGZd3wFjkPT2BPFzOTEwM0L4zWh/EWnXKchrrfKgArKoEgRoDCtluqw7v
        Q412W34Y92I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6A73511BD17;
        Thu, 25 Feb 2021 14:50:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6693F11BD16;
        Thu, 25 Feb 2021 14:50:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, James Ramsay <james@jramsay.com.au>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v7 00/17] propose config-based hooks (part I)
References: <20201205014607.1464119-1-emilyshaffer@google.com>
        <20201222000220.1491091-1-emilyshaffer@google.com>
        <YCwhA6VIs16uMnJG@google.com>
        <xmqqy2fnocjc.fsf@gitster.c.googlers.com>
        <YC2IzVxLgvC7N8qd@google.com> <xmqqlfbmi99f.fsf@gitster.g>
Date:   Thu, 25 Feb 2021 11:50:11 -0800
In-Reply-To: <xmqqlfbmi99f.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        17 Feb 2021 15:07:08 -0800")
Message-ID: <xmqq4ki0udu4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ACEA15F6-77A2-11EB-9A95-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Josh Steadmon <steadmon@google.com> writes:
>
>>> The topic branch has a lot more commits than these 17; I am
>>> wondering if the reviewed-by applies only to the bottom 17, or as
>>> the whole?  I recall that the upper half was expecting at least some
>>> documentation updates.
>>> 
>>> Thanks.
>>
>> Just to these 17, sorry for being unclear.
>
> Thanks for reading them through.
>
> I am tempted to say we should merge these "mechanism" part down to
> 'next', hoping that the "rewrite existing ones using the new
> mechansim" part can follow soon.

I said this on Feb 17th, but since then I think I saw you answer
"I'll do that" in responses to JTan's reviews in the past few days
(e.g. <YC7o2rUQOEdiMdqh@google.com>).  Would I regret if I merge the
topic down to 'next' today?

Thanks.
