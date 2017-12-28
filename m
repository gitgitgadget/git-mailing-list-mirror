Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A11C1F406
	for <e@80x24.org>; Thu, 28 Dec 2017 18:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754617AbdL1SgS (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 13:36:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53813 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754347AbdL1SgO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 13:36:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B0E67C9FA9;
        Thu, 28 Dec 2017 13:36:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=QIgPt5LpnFPD
        uvRmynlE4Yllbb4=; b=jAqBpuuOAt5raNpD7cjhADo0P9hOfX0aXiiv4vuOcRls
        sJZFz9gP3/JlHeOyMIr2LoY/QcOcZ9xh4E5g5YzqUUl1go4wpSjb5Rr6IK3uQalG
        NrsDm18VsmBWnzhoGATY7QYU3X4ZoVThwKK6XgZlD8GrbX57eRHkK3LTS6EmRaI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Zhm9F4
        Obewa3sCDxpTpIgNff89rUYC3Vhtrz7uSOv0nVPf30GIgykG8tt99qUjJzUf8swX
        +2fKcjGK/3mgSjpY6XtSsyQF0RBUbe5wU4lyKzlr/+OqGFV59Ht7UQZzSRP6ngb5
        timDxHDo5c0ZNgEvRWtkyAd80ATm/4c+TAJGA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A7C5CC9FA8;
        Thu, 28 Dec 2017 13:36:13 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 216A9C9FA7;
        Thu, 28 Dec 2017 13:36:13 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Dan Jacques <dnj@google.com>,
        Alex Riesen <alexander.riesen@cetitec.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Casey <drafnel@gmail.com>, Petr Baudis <pasky@ucw.cz>,
        Gerrit Pape <pape@smarden.org>,
        "martin f . krafft" <madduck@madduck.net>, Eric Wong <e@80x24.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        "Randall S . Becker" <rsbecker@nexbridge.com>,
        Michael J Gruber <git@grubix.eu>,
        Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v6] Makefile: replace perl/Makefile.PL with simple make rules
References: <20171220174147.GG3693@zaya.teonanacatl.net>
        <20171220182419.16865-1-avarab@gmail.com>
        <xmqqefnmshsm.fsf@gitster.mtv.corp.google.com>
        <87lghnrerd.fsf@evledraar.gmail.com>
Date:   Thu, 28 Dec 2017 10:36:12 -0800
In-Reply-To: <87lghnrerd.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 27 Dec 2017 23:24:06 +0100")
Message-ID: <xmqqwp16lmxv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FB38CFA6-EBFD-11E7-9369-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> Here is the difference as I see between what we already have and
>> this update, and a proposed summary.
>> ...
>
> When I read this back on the 22nd I missed that you were waiting on my
> feedback on this. Just saw What's Cooking now. Yes, LGTM:

Thanks!
