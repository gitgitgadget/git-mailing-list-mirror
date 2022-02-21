Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F091BC433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 17:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381519AbiBUROW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 12:14:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381516AbiBUROV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 12:14:21 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490CE2611E
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 09:13:58 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 83DA718202B;
        Mon, 21 Feb 2022 12:13:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=DmDpAXcTIlyZ
        BRPK+5sazLh4ttnrlleB4Agt2XGfEPM=; b=dy+rLtcU8Aoy8mFgYFC+n43N8dDY
        SZkNOQBXb3DSk7H2+fod2UfbXUEIpfSvvI9ZWXG44+bH/Qx1cVL7P4yRR2sLCn9x
        Myqohu0wJiDum7SleSI1GS/svfDsO24TCQcOjWeIVK5EpbieaHG+5HTkwhDH2FcB
        O4xNNiuH5Td5bjo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7DD6418202A;
        Mon, 21 Feb 2022 12:13:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EA6C4182028;
        Mon, 21 Feb 2022 12:13:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Erlend Aasland <Erlend-A@innova.no>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] branch: delete now accepts '-' as branch name
References: <pull.1217.git.git.1645020495014.gitgitgadget@gmail.com>
        <xmqqbkz6vjkj.fsf@gitster.g>
        <00720bfb-c7b7-aaf2-e846-19b08d7b9cf4@sunshineco.com>
        <400A4D37-74EA-4F3B-BA3B-99FFDAE3CB3C@innova.no>
        <CAPig+cR0Ks2bnTRqs3uF4M+3q+n9X6pApBQ9HQTUq=zK5TpuXQ@mail.gmail.com>
        <xmqqiltd9vyg.fsf@gitster.g>
        <220221.86pmngb22e.gmgdl@evledraar.gmail.com>
Date:   Mon, 21 Feb 2022 09:13:53 -0800
In-Reply-To: <220221.86pmngb22e.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 21 Feb 2022 17:34:01 +0100")
Message-ID: <xmqqwnhota5q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A609C2AA-9339-11EC-980E-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> Continuing the "thinking aloud" a bit, I _think_ this tells us these
>> things:
>>
>>  * @{-1} has way too many letters to type to be liked by users, who
>>    won't learn or remember what they do not appreciate (and do not
>>    blame them---it is a bad notation).
>>
>>  * @{-<n>} may have been a generalized way that satisfied geeky mind
>>    while being implemented, but the users only need the "last one"
>>    and no such generalization.
>>
>> If it is too late for a more easy-to-type-and-pleasant-to-eyes
>> notation, perhaps "@-", that does not have downsides of "-" or
>> "@{-1}", I have to wonder.
>
> I too find the syntax really annoying to type.
>
> I wonder if we couldn't say that:
> ...

We could, but I do not think I like any of it, except for adding
"@-".  We learned that we do not need @{-4} generalization and
people only want "the last one" with nothing else.  It is repeating
the same mistake without learning any from the lesson to take any
random string that follows @ as if it is inside @{}, I am afraid.

P.S. It seems it is holiday around here and I hear it is at GitHub,
too, so I expect the day to be slow and my presence may be sporadic.



