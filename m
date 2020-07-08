Return-Path: <SRS0=LMRs=AT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2203C433E0
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 23:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D0C220708
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 23:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BPfpNUXY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgGHXLc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 19:11:32 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55299 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgGHXLc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 19:11:32 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 32157DFB1C;
        Wed,  8 Jul 2020 19:11:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Jl/IF+HpqR88zWyY/SheMcVGNgk=; b=BPfpNU
        XYvzMUwVMe868NZJw26i+Q7SptZWDStpb4vtb8QxTqzcgzsPCNVm2AU+gEHxAfUU
        Vipv3MIpyupDDyWEyL1RoXWlncrNH8K75Wst+tiuwsDzfkVmB8n7RSFGBE+e2fll
        jlPMsjusXjEqGNWQfzbM9uwLiBlS0f394qJ8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tRqYk1P/CaHCEKwYPQ9KPLwF4i56zGdg
        XOwJFcGCAADBXqt48sZG/slcwDPmNiTnxGoxsH8Wq3ZXHnUshPlasDF6vBGBDave
        XAXQrQgBz+FR7iSycpFLUkRF6EMQ24IrqcCeBQVf1KE7JnQLKn4dH3+FcLVrgZGz
        ubsCQzWw9tY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2A391DFB1B;
        Wed,  8 Jul 2020 19:11:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 73CBCDFB19;
        Wed,  8 Jul 2020 19:11:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: mr/bisect-in-c-2, was Re: What's cooking in git.git (Jul 2020, #01; Mon, 6)
References: <xmqqh7uj7tqn.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2007081630180.50@tvgsbejvaqbjf.bet>
        <xmqq36622eru.fsf@gitster.c.googlers.com>
Date:   Wed, 08 Jul 2020 16:11:25 -0700
In-Reply-To: <xmqq36622eru.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 08 Jul 2020 08:43:49 -0700")
Message-ID: <xmqqy2ntzjoi.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 59C64144-C170-11EA-A786-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>>>  Rewrite of the remainder of "git bisect" script in C continues.
>>>
>>>  Expecting a response to reviews.
>>>  cf. <nycvar.QRO.7.76.6.2005230007260.56@tvgsbejvaqbjf.bet>
>>
>> Maybe you could change this to
>>
>>    Needs more reviews.
>>    cf. <20200701133504.18360-1-mirucam@gmail.com>
>>
>> ?
>
> Thanks, absolutely.

Actually, the state was before that.  It would have been "Reroll exists"
with the same reference.

In any case, the latest one broke build of 'seen' and I had to
exclude it from the day's integration.  Now it should be listed
as "Needs more work" or something.



