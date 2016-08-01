Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D99E1F855
	for <e@80x24.org>; Mon,  1 Aug 2016 22:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842AbcHAWfY (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 18:35:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64177 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752778AbcHAWfR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 18:35:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 10B763291A;
	Mon,  1 Aug 2016 18:30:06 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9V6IyFbGlyyvPNJ44UzttBjNed0=; b=l6X+R0
	rasWJo0rbD4tfwj4ZzHfI1E848SATqqTSojFYRoeOKqHiqpqAQTtTUYxZVbIDK8L
	5tN267dU29wkQsEJKFNQnpeiUPfMAT7k04h250b9QGKeEmT+EMvyIvUNRqfHlXIb
	uqnXl4pglqTiAjMo8m/JhuszpQxC25USs+8rM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rc1U3IDmoLFjHHJ0xw6LyVwotmO3LcnT
	0j+9wuM9Vk4vsBziBDpjwhtro+CwWai/f9PNFazD/Gn1BMcgNkwKWvFV3rfslGGV
	MZeHOmaHMd5c6mz5wfHrhG33nTyEe54jyYipg/xtq1rXAXE0Z1iXgxef9dipm2uf
	YiaSqV8CVHs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0714332919;
	Mon,  1 Aug 2016 18:30:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6166332917;
	Mon,  1 Aug 2016 18:30:05 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Christian Couder <christian.couder@gmail.com>
Cc:	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v9 00/41] libify apply and use lib in am, part 2
References: <20160730172509.22939-1-chriscool@tuxfamily.org>
	<CAP8UFD2CDCOHJ8ONq12F2Phceu2yE=5i1sSxtnse+gXrn9aSEw@mail.gmail.com>
Date:	Mon, 01 Aug 2016 15:30:02 -0700
In-Reply-To: <CAP8UFD2CDCOHJ8ONq12F2Phceu2yE=5i1sSxtnse+gXrn9aSEw@mail.gmail.com>
	(Christian Couder's message of "Sat, 30 Jul 2016 21:50:52 +0200")
Message-ID: <xmqqa8gwgm1h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7EC73206-5837-11E6-A6EF-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Sat, Jul 30, 2016 at 7:24 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>>
>> I will send a diff between this version and the previous one, as a
>> reply to this email.
>
> Here is the diff:

The "verbosity" bits, and also deduplication of parse_options, are
both welcome changes.

Will replace.

Thanks.
