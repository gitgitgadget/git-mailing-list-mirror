Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16A2B208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 16:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbdHRQal (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 12:30:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63607 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751614AbdHRQak (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 12:30:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F0A193473;
        Fri, 18 Aug 2017 12:30:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=f/f54Qdet7Mg
        b5xj5HcvM/8pB0Y=; b=WZei95KaI0KQ2ujKQsBqvMxVZjKRauKOr1fyIa5DnClH
        4ECC+uwENi276Qv4Maxkgomnrbt2rJr5ogG0uYPAYJaq5XeX5lvmHEGKwNoffYdS
        DuDS6roimH2iCOLMITtuUz7gytogE7GGan6Hsw1ECPXjZy355Dwmu/cJcIIO6Co=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=NHC5Eg
        FPhH+yeEM8s5gobcaZCX4iNLoe7eTEV02i87iSfMmYBSByOGnT6ZPdvtKiTfq90A
        lwRCNVzuSikmFzWBx31OTJfA/KsCHXT29Qlh6oquePCm1PeJ9Fw5vACeNTNe2wNg
        drybDerPZzK7dlNvh8HgG2Z9ndfUKtBwCQIyA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 38AB993471;
        Fri, 18 Aug 2017 12:30:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 81B7E9346E;
        Fri, 18 Aug 2017 12:30:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] builtin/branch: stop supporting the use of --set-upstream option
References: <xmqqy3qluck4.fsf@gitster.mtv.corp.google.com>
        <20170817025425.6647-1-kaarticsivaraam91196@gmail.com>
        <20170817025425.6647-2-kaarticsivaraam91196@gmail.com>
        <CAN0heSquaXk421sR6Ry59C+er8n26nC93=3KG1wD0xNXZkuiGw@mail.gmail.com>
        <xmqqshgqezox.fsf@gitster.mtv.corp.google.com>
        <42219b51-8232-e1ee-9c48-f67ccdcbb4c8@gmail.com>
Date:   Fri, 18 Aug 2017 09:30:37 -0700
In-Reply-To: <42219b51-8232-e1ee-9c48-f67ccdcbb4c8@gmail.com> (Kaartic
        Sivaraam's message of "Fri, 18 Aug 2017 08:11:37 +0530")
Message-ID: <xmqqr2w8dej6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 91AE4A30-8432-11E7-976D-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> On Friday 18 August 2017 01:25 AM, Junio C Hamano wrote:
>> Martin =C3=85gren <martin.agren@gmail.com> writes:
>>
>>> On 17 August 2017 at 04:54, Kaartic Sivaraam
>>> <kaarticsivaraam91196@gmail.com> wrote:
>>>> Helped-by: Martin =C3=85gren <martin.agren@gmail.com>,  Junio C Hama=
no <gitster@pobox.com>
>>>> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
>>> I didn't expect a "Helped-by", all I did was to give some random
>>> comments. :-) I'm not so sure about the comma-separation, that seems =
to
>>> be a first in the project.
>> I didn't either ;-)
>>
>> The line looks odd so I'll remove it while queuing.
>>
>> Thanks for noticing.
> I should have been better with my wordings :) How about converting that
> line into two 'Suggestions-by:' or 'Reviewed-by:' ?

I personally do not think either is needed for those small things we
saw in the discussion.

Unless Martin feels strongly about it, that is.

Thanks.
