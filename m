Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBC1C1F858
	for <e@80x24.org>; Thu, 28 Jul 2016 14:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758741AbcG1O7w (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 10:59:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58921 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754576AbcG1O7v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 10:59:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CB8742E7E3;
	Thu, 28 Jul 2016 10:59:49 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=S+8/hfg5qV364+2xGr3VVubpLE4=; b=N+rLnx
	N/CbLgrGhmSgslt6nAh6JpZ2MOM1MIrZp2Afw5YQFEh4EIEIGsURcu66YDNQQutL
	VD2isOHJwwVPw63W8Fi1a7ZF5jIlXo+3UUVUrRBUmWPMbi8nDb0v1RJrtgR2Sxo/
	mFeZCUFQpH1zi6KH6vMVg5dfDymUvQ8LZq7HI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ANkSLjKCZ3lpDxF5YivXzognw6ATJs4M
	ix+vq6e3t2a8mipoYgMXAj9n4C/g3v25Jv9aq9KRNtPeMKMzG3h8H51u9iqaUmt6
	oqzpk1wkadWGR/qtn0O+9ceLNWuIgwtYtzyi3SDbxOrFqY74DCpnPi3tsNP2lMq4
	hBFPfAVMaZE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C416F2E7E2;
	Thu, 28 Jul 2016 10:59:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3DE9F2E7E0;
	Thu, 28 Jul 2016 10:59:49 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Heiko Voigt <hvoigt@hvoigt.net>
Cc:	Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 1/2] fix passing a name for config from submodules
References: <578E7A07.8080006@web.de> <20160720082515.GA823@book.hvoigt.net>
	<57911AFF.7030107@web.de> <20160725143706.GA4872@sandbox>
	<xmqq60rt933m.fsf@gitster.mtv.corp.google.com>
	<20160726094913.GA3347@book.hvoigt.net>
	<CAGZ79kaOf3NRAXh+krM=onwswSjAF3yy_zpa1d+9CFOBNke6-w@mail.gmail.com>
	<20160728111636.GA7760@sandbox>
Date:	Thu, 28 Jul 2016 07:59:46 -0700
In-Reply-To: <20160728111636.GA7760@sandbox> (Heiko Voigt's message of "Thu,
	28 Jul 2016 13:17:11 +0200")
Message-ID: <xmqqeg6du7tp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EE34DC04-54D3-11E6-AB1C-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Heiko Voigt <hvoigt@hvoigt.net> writes:

>> Apparently we put the subject first and then the date. I always did it
>> the other way
>> round, to there is no strict coding guide line,...

Please don't say "this is not spelled out in the guidelines, so I
can do whatever I like, *EVEN* *THOUGH* I know that is different
from what most others do".

Without the "follow the best-current-practice and be consistent",
which I think is in an early part of the guideline document (and if
not, it should be spelled out as the most important rule), the
guidelines document will become too long that nobody would read.

>> understanding for a) how long are we in the "broken" state already as well as
>> b) what was the rationale for introducing it.
>
> Ah ok did not know about this format. Will change that.

In other words,

    In commit 959b5455 we implemented the initial version of ...

would become something like:

    959b5455 (submodule: implement a config API for lookup of
    .gitmodules values, 2015-08-17) implemented the initial version
    of ...

Thanks.
