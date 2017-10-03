Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2242720281
	for <e@80x24.org>; Tue,  3 Oct 2017 06:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750846AbdJCGV7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 02:21:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57803 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750720AbdJCGV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 02:21:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 06C6FA91CB;
        Tue,  3 Oct 2017 02:21:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=qnewr3UsZlrr
        pjt7HhluP8XDf6s=; b=mBLw149RyfwoIZ+DkuPaMnUzbU6+Le2dViLk5DhcFOc+
        7TOSTzXrzUSyia0bXAscP6iWE/si6LupkxmTSJImz0FXXUI2x19F7Wh2nRaOTSd8
        uE9fUfE8qj6usfW0cBNga7wPxaqK2c7ngHX5Us05b0u/V5pgchPGHQutQZjGxgk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Dn4BiJ
        toa8s0gJ/Nyg9iZS8B5fQBjecGE/JClE1T195M6NZl3X4uSRRwYHTqHEFDCmtw8p
        +OdBcRz2/vw4UDlKRukbNknTkJavQchb8DNGfXiuo/BPlDULdU2gh7/3OJ+6yLGe
        R1UcVwm8SCfaqCp/I8GF8k11FArCrsM4SXVkw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F2DA6A91CA;
        Tue,  3 Oct 2017 02:21:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CF67DA91C6;
        Tue,  3 Oct 2017 02:21:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Paul Tan <pyokagan@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4g?= =?utf-8?B?VGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>
Subject: Re: [PATCH 00/11] various lockfile-leaks and -fixes
References: <cover.1506862824.git.martin.agren@gmail.com>
        <20171002062252.didw7guppl4nvxry@sigill.intra.peff.net>
        <xmqqbmlqoydg.fsf@gitster.mtv.corp.google.com>
        <CAN0heSqsZXoiVs9s7sZ-d_X4ghU4ciG_=8ppY+w0XG535tt2EA@mail.gmail.com>
Date:   Tue, 03 Oct 2017 15:21:53 +0900
In-Reply-To: <CAN0heSqsZXoiVs9s7sZ-d_X4ghU4ciG_=8ppY+w0XG535tt2EA@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Mon, 2 Oct 2017 12:19:55
 +0200")
Message-ID: <xmqqy3osiwe6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 26E944A8-A803-11E7-AD2D-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> On 2 October 2017 at 08:30, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> Thanks, both.  Let's merge this to 'next' soonish.
>
> Thanks both of you for your comments. Based on them, I have made the
> following notes:
> ...
> Especially 9-11 make me feel like wanting to re-roll this, for future
> readers if nothing else. I expect to be able to do so in the middle of
> this week (I don't know how this interferes with Junio's definition of
> "soonish").

OK, then I'll hold off and expect such a reroll.

Thanks.
