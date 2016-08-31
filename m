Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB70A1F859
	for <e@80x24.org>; Wed, 31 Aug 2016 22:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754059AbcHaWPh (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 18:15:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62550 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753126AbcHaWPg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 18:15:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 007023B4EE;
        Wed, 31 Aug 2016 18:15:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YO8y1hOyej3037JjWtCk1cNzwuM=; b=ZDR6vG
        jQIWakBLiHSU6OWrmC1iN6dkAaND6cX/FQd911jixDAzVHd3Jxgn4OicNiBpVt+b
        Uut12rkrP+SnAAJUq27GKjkN3LGmU+Zuqkj+Um9nWlo2denzJfCYxMzSu62CcPEd
        VY1XsKtnSFmRqbrIo5ZJT6cB+UoO3Hu5QHXqM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c696IMTsjv3Nkz/b8YW24/12Tdqx9hY5
        yqxTbegHeahbzf6OvaJ+89GnQ9yFgsea3+j5h4mPAgbyVtOUDI/OqgRKdLy2jLqS
        zfBdGRtsyfZfs0bS0ruNtbncdcIT2tTNOmrJd0wTP+DVi2OA+OrffjztLWrvdS4v
        bgDH8NTmKWc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EC8223B4ED;
        Wed, 31 Aug 2016 18:15:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7657E3B4EC;
        Wed, 31 Aug 2016 18:15:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v13 00/14] libify apply and use lib in am, part 3
References: <20160827184547.4365-1-chriscool@tuxfamily.org>
        <xmqq7fazbdmk.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD20GY0h8n-7oJp8zhjHPUeKSkcEkNrOMuyGBrtS8JE6Jg@mail.gmail.com>
Date:   Wed, 31 Aug 2016 15:15:32 -0700
In-Reply-To: <CAP8UFD20GY0h8n-7oJp8zhjHPUeKSkcEkNrOMuyGBrtS8JE6Jg@mail.gmail.com>
        (Christian Couder's message of "Tue, 30 Aug 2016 12:19:51 +0200")
Message-ID: <xmqq1t14zit7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 70101734-6FC8-11E6-8A9B-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Mon, Aug 29, 2016 at 9:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>>> Highlevel view of the patches in the series
>>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> This is "part 3" of the full patch series. I am resending only the
>>> last 14 patches of the full series as "part 3", because I don't want
>>> to resend the first 27 patches of v10 nearly as is.
>>
>> Just to make sure, you are sending the first 11 of these 14 exactly
>> as-is, right?  I didn't spot anything different other than 12 and 13
>> that replaced the "alternate index" step from the previous round.
>
> Yeah, the first 11 of the 14 patches have no change compared to v12.
> I didn't want to create a "part 4" as that could be confusing, and
> sending the first 11 patches gives them another chance to be reviewed
> again.

Hmph.

But most likely, you made sure that those who _could_ review the
first 11 are miniscule minority by omitting the earlier steps before
these 14 patches -- unless they are familiar with them, the first 11
patches are not much use to them.  And those who are familiar have
already seen the first 11, too.  That was why I wondered who the
target audience was when seeing only the last 14, among which 11 of
them were identical to the previous.

