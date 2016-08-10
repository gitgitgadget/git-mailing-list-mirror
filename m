Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13E661FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 18:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938606AbcHJSmj (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 14:42:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55507 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933565AbcHJSmh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 14:42:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ABBCD32CEC;
	Wed, 10 Aug 2016 14:42:35 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iWEVR7+Nw0WUkiHwYJI37wOWLcA=; b=rn6H4E
	Z6qDCargk+QjzzaqTnUt/ImIlc6OeTiu7vK4+jXm5F6k1fYRxc938GyAv5uszV5H
	QdiAMVvdzuLqNLcRgPp3vRmtYgXx/qlg4m/flVil66Lbvok2blyHhEtkUFNAFvnA
	Ev8QjKfq3ZisqJk/8/Oaqk8BIdT3bF1ay+wsc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TpW2y8A2sr5L6++JFyQpsUD7Np1LiFYK
	vTljqBZWwpBwyd623OHNTcuuJFX6cblqy7Pt8sCzLJmcaXySICQVxdCFWZohs0Qr
	39ruJZgRKpqAyzJKgF97H9wxmIqkXQojshJJDcwUB198ASL+A/vzK4/yJxAtPzqY
	F+5nxLTJS3M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A327532CEB;
	Wed, 10 Aug 2016 14:42:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2749D32CEA;
	Wed, 10 Aug 2016 14:42:35 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Jeff King <peff@peff.net>, git@vger.kernel.org, jnareb@gmail.com,
	mlbright@gmail.com, e@80x24.org, Johannes.Schindelin@gmx.de,
	ben@wijen.net
Subject: Re: [PATCH v5 05/15] pkt-line: add packet_write_gently_fmt()
References: <20160803164225.46355-1-larsxschneider@gmail.com/>
	<20160810130411.12419-1-larsxschneider@gmail.com>
	<20160810130411.12419-6-larsxschneider@gmail.com>
	<20160810134346.6nmf2sudwh56nq76@sigill.intra.peff.net>
	<xmqqpopg5yqf.fsf@gitster.mtv.corp.google.com>
	<2B2AC073-95AD-42E9-AD3A-23E8E13C66DE@gmail.com>
Date:	Wed, 10 Aug 2016 11:42:33 -0700
In-Reply-To: <2B2AC073-95AD-42E9-AD3A-23E8E13C66DE@gmail.com> (Lars
	Schneider's message of "Wed, 10 Aug 2016 19:53:22 +0200")
Message-ID: <xmqqvaz84g9y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3451C052-5F2A-11E6-BD5E-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>>> Similarly, I'd think this could share code with the non-gentle form
>>> (which should be able to just call this and die() if returns an error).
>>> Though sometimes the va_list transformation makes that awkward.
>> 
>> Yes.
>
> Peff just posted that he tried the shared code idea but the result
> ended up ugly.

OK.
