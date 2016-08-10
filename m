Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F8C01FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 18:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932855AbcHJSKY (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 14:10:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52252 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932417AbcHJSKW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 14:10:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E2BEA3216A;
	Wed, 10 Aug 2016 13:34:04 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p2gU82b25+j26u5AY0Hp/315HZ0=; b=WDUDpY
	48lveAFXRxpreXMB3uQWS12hwacLvLSPbUpJGs0d6ns4WK5xPm2KFhu44hFAg2Td
	bOKJfDhyOVgECcHnt26SmThydnX6Lwu0QjHbtHFu7/zHikkDJ4Tg6oifj9K9+vwL
	0/YdM3nKA4w8rBNA4NIBbelZbMSS2atZPHLO0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WW/7sD3eR8Zwjf4lWXgd27iwWaXqs5o3
	8hMhsywtobANa8rNF+sw3480eHwr1ab4KCkoGUtSyu4DoD7rstEs2yqJMk2Mi75D
	0vwmHfNdZYT6eUNcBwDJmfKGpyrslfYu9R+atYeAPF18u/tzTngvfVpH2vfyMQhR
	8OyoW20tIRQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D9D7B32168;
	Wed, 10 Aug 2016 13:34:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5DAB032167;
	Wed, 10 Aug 2016 13:34:04 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Christian Couder <christian.couder@gmail.com>
Cc:	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v10 33/40] environment: add set_index_file()
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
	<20160808210337.5038-34-chriscool@tuxfamily.org>
	<xmqq60raewod.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD2ZAdUjQnO-4qnum2_AK84SfBN2_yO=py+Jj+pkV8pk-w@mail.gmail.com>
Date:	Wed, 10 Aug 2016 10:34:02 -0700
In-Reply-To: <CAP8UFD2ZAdUjQnO-4qnum2_AK84SfBN2_yO=py+Jj+pkV8pk-w@mail.gmail.com>
	(Christian Couder's message of "Wed, 10 Aug 2016 18:52:38 +0200")
Message-ID: <xmqqlh045y0l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A21A48E8-5F20-11E6-BA06-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>> Isn't the mention on NO_THE_INDEX_COMPATIBILITY_MACROS in the added
>> comments (there are two) pure red-herring?
>
> Yeah, true.
>
> So do you want me to refactor the code to use
> hold_lock_file_for_update() instead of hold_locked_index() and to
> avoid the set_index_file() hack?

I somehow thought that we already agreed to accept the technical
debt, taking your "it is too much work" assessment at the face
value.  If you now think it is feasible within the scope of the
series, of course we'd prefer it done "right" ;-)

> Or would the set_index_file() hack be ok with a commit message like
> the following:
>
> ---
> Introduce set_index_file() to be able to temporarily change the
> index file.
>
> Yeah, this is a short cut and this new function should not be used
> by other code.
>
> It adds a small technical debt, that could perhaps be avoided with a
> refactoring and by using hold_lock_file_for_update() instead of
> hold_locked_index() to pass the filename where the index should be
> written.

Is the problematic hold_locked_index() something you do yourself, or
buried deep inside the callchain of a helper function you use?  I am
sensing that it is the latter (otherwise you wouldn't be doing the
hack or at least will trivially fixing it up in a later "now we did
a faithful conversion from the previous code using GIT_INDEX_FILE
enviornment variable in an earlier step. Let's clean it up by being
in full control of what file we read from and write to" step in the
series).

Do you also have an issue on the reading side (i.e. you write it out
to temporary file and then later re-read the in-core cache from that
temporary file, for example)?  Or is a single "write to a temporary
index" the only thing you need to work around?  

The "Yeah, this is a short cut ..." admission of guilt is much much
less interesting than showing later people a way forward when they
help us by cleaning up the mess we decided to leave behind for
expediency.  I am not seeing that "here are the callchains that need
to be proper refactored, if we want to avoid this hack" yet; but
that is what would help them.

Thanks.

