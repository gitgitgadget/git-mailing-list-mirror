Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 877C21FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 17:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753593AbcGSR1F (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 13:27:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50684 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753324AbcGSR1D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 13:27:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E001E2B383;
	Tue, 19 Jul 2016 13:27:01 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=maeONyhkoy3X309AUj7aSYwashk=; b=WyIxOC
	Kv5tXnZ2x/pObTCy/9hLlTx7o2/kHMRhS+1bnLKxdqrhFfoZUmMBQF3vYhB2oesh
	lcKSkUVPIstbvu0DJ13PJUrhEoin5jRO0UroEFLuJ9tV2PvVeGKPQZoOQID525PM
	lgbFOzmsosnQNG7NifKqDdQuwdRdkV8jzqp1c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RVxzAEGfz7yvgoPzHyfaxOCLjzoIStJr
	oQHdGtMrFT/+RvTRFbUSZi6PwW6Zk4vhGpL0G4bVHb0KiJfwaPSKjW8cEKKSqlj9
	R1PzRgX3nxB6blechR3j8gE3jU6apntMtKfs/qV5LBX/Uli6/1/brUs4psGnWQgB
	r6jVgMVslrc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D6D1F2B381;
	Tue, 19 Jul 2016 13:27:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 55F082B37B;
	Tue, 19 Jul 2016 13:27:01 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>,
	=?utf-8?Q?Ren?= =?utf-8?Q?=C3=A9?= Scharfe <l.s.r@web.de>,
	git@vger.kernel.org
Subject: Re: [PATCH] test-lib: stricter unzip(1) check
References: <20160718064431.GA10819@starla>
	<20160718130405.GA19751@sigill.intra.peff.net>
	<alpine.DEB.2.20.1607181536540.3472@virtualbox>
	<xmqqtwfmkduk.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607191327260.3472@virtualbox>
Date:	Tue, 19 Jul 2016 10:26:59 -0700
In-Reply-To: <alpine.DEB.2.20.1607191327260.3472@virtualbox> (Johannes
	Schindelin's message of "Tue, 19 Jul 2016 13:27:30 +0200 (CEST)")
Message-ID: <xmqqfur5h730.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 00D4CC16-4DD6-11E6-82B9-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 18 Jul 2016, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > Hrm. That sounds a little magical, and fragile, to me. What if the next
>> > person's unzip returns 0 and *still* cannot handle -a?
>> 
>> That is a very sensible line of thought.
>> 
>> > I'd rather do something like
>> 
>> ... but the patch presented as an alternative does not seem to
>> follow that line of thought.
>
> Right. I tried to see whether I could come up with a test, but did not
> immediately succeed. The patch I presented was the best I could do...

Ah, OK, it makes sense.
