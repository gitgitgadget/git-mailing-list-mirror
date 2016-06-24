Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AE591FEAA
	for <e@80x24.org>; Fri, 24 Jun 2016 22:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbcFXWlw (ORCPT <rfc822;e@80x24.org>);
	Fri, 24 Jun 2016 18:41:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51086 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751019AbcFXWlw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2016 18:41:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 98A9526D08;
	Fri, 24 Jun 2016 18:41:50 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1Kidl4kbdSBo6HghTHH7HUcYRDM=; b=F7g69c
	zB2Jsn17EAGIrEsAhukLeGlnDxjtYtOW8nRCUtuTCpQzVwlieHK7mjMYqya1tgKc
	dxa9JSubdIXEw+n2mlN9OX29f1m3/hecAnJHrPhZaGXmD0ebZQjtCmQhcIKHbZZL
	s2t2wAmbxWSS8j543sg4aN/sky0GKmNDaVgc4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DjY1/rgZbOb5hATbERwdi4lS3HoyaoEE
	75NBnr88hziCIi1imiCjatNTyj8CN7AGXA6aIXJs9NKOhvkjs9kzuHAcslNXRTso
	7pgEr9TJA36GVwljAahiO6XbA0U55glfLjzv1T+331w4SP0KGnJ4Y/ArLkRC1LNC
	qz6AnNO1X4Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 922A326D06;
	Fri, 24 Jun 2016 18:41:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1C2C626D04;
	Fri, 24 Jun 2016 18:41:50 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	"Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH v3 1/4] t5000: test tar files that overflow ustar headers
References: <20160623231512.GA27683@sigill.intra.peff.net>
	<20160623232041.GA3668@sigill.intra.peff.net>
	<xmqq1t3mh0vg.fsf@gitster.mtv.corp.google.com>
	<20160624190744.GA32118@sigill.intra.peff.net>
	<20160624205858.GA23315@sigill.intra.peff.net>
Date:	Fri, 24 Jun 2016 15:41:47 -0700
In-Reply-To: <20160624205858.GA23315@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 24 Jun 2016 16:58:58 -0400")
Message-ID: <xmqqk2hedxas.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D715A616-3A5C-11E6-831A-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The difference in time between the two is measurable on my system, but
> it's only a few milliseconds (for 4096 bytes). So maybe it's not worth
> worrying about (though as a general technique, it does make me worry
> that it's easy to get wrong in a way that will fail racily).

Yeah, GNU dd has iflag=fullblock, but if we assume GNU, we can
safely assume "head -c", so I do not think of a way to do this
portably enough.

