Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 212DC20196
	for <e@80x24.org>; Thu, 14 Jul 2016 20:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbcGNUH4 (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 16:07:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58551 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751160AbcGNUHz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 16:07:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 666162A7F0;
	Thu, 14 Jul 2016 16:07:54 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WfWeY30+UjuktSMSfbU0qk8fk7M=; b=hEXhl9
	g62AJ7KCjEP80wEpm1lbK4eQhaDwfp43l6unN/cniAULeP/G3efjuawBDTPBZnx8
	t3Dd6uIdVDJ96n/3gQUSW9jOzf3mZCpXcMKyZB1wq7mKleF0TPFPEvfKrMbPqKTS
	F3/bHp2V4iilBGVMLk9VMyXw38eUoZLxKbWFU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SXoTARjKlt7+a4MGj9VrNBmmHGgBUxMi
	r5JAgMaYQl5pBPkdAPvoCpH4Xr5o+VaQj0/F82o+AfW5/gO8nkxbkhfY8U0qtVpN
	dKVt5noQcSHoLRmEiZPWl0XVDQyrA7KGSggcSxJ115LAbgX73y4NvAo52eo1IZaB
	/ljElMMM9v4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E5B82A7EE;
	Thu, 14 Jul 2016 16:07:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D9C7B2A7ED;
	Thu, 14 Jul 2016 16:07:53 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Dan Wang <dwwang@google.com>, Eric Wong <e@80x24.org>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/4] receive-pack: implement advertising and receiving push options
References: <20160714173920.22001-1-sbeller@google.com>
	<20160714173920.22001-3-sbeller@google.com>
	<xmqqk2goqd4l.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZgJ_6fxZ19Hx6zd6KoTAd_+oMjb4fj1twY2ZGUHP7wHA@mail.gmail.com>
	<xmqqfurcqbrw.fsf@gitster.mtv.corp.google.com>
	<20160714194522.GA17798@sigill.intra.peff.net>
Date:	Thu, 14 Jul 2016 13:07:51 -0700
In-Reply-To: <20160714194522.GA17798@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 14 Jul 2016 15:45:22 -0400")
Message-ID: <xmqqk2gooueg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A62A500E-49FE-11E6-A00C-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> packet_read() does NUL-terminate for you. It gets the extra bytes
> because it doesn't store the 4-byte size in the output (whereas the
> client does not ever send anything over LARGE_PACKET_MAX, _including_
> those bytes, so we always have room to store its result in our
> LARGE_PACKET_MAX buffer, plus the NUL, with 3 bytes to spare).

Good; then the loop will further be simplified ;-)

Thanks.
