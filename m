Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E06E4203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 16:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756030AbcG0QY6 (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 12:24:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62604 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754200AbcG0QY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 12:24:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EB14A2E347;
	Wed, 27 Jul 2016 12:24:55 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H7wYeGMGDfRocnFcgBgRWiUxkkQ=; b=INIyII
	s+wH06qP5WW3chy8RCA4449SwK+NxcbsbHZpQ5dFtL1UCKFG34sUT6yXTCYMked3
	RDDyFEs090DmMvqsIGtwi4IYyogdVOm52x9cDY1jVies1eskqk47gYCJQF8kS/kS
	CfLtpEqf3y3fsE+TJ+oaiDSBhz0WG28GGrQmE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HkGZJXnuaaRhCaVgVe2UdZvzXl79gBv1
	7ramQMwIgXjJGSLhpgOaX5qpbNT4taniYz/D0N5Hz1S/uhEJXFdfYENWctI+CFVJ
	lAwbnZ28peSq6WCMuszNVeDYdhCDx9jT+b4i7IqkUJixZ1ddYTvQ56/7AbcqpWpb
	C8cbD8NoUrc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DF2C42E346;
	Wed, 27 Jul 2016 12:24:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4D7242E33F;
	Wed, 27 Jul 2016 12:24:55 -0400 (EDT)
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
Subject: Re: [PATCH v8 00/41] libify apply and use lib in am, part 2
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
	<xmqqzip4xfmz.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD0tcPnqBcxC5-4tnGMT4W5b7L=C_riwpTvDfeMUjQzpjA@mail.gmail.com>
Date:	Wed, 27 Jul 2016 09:24:53 -0700
In-Reply-To: <CAP8UFD0tcPnqBcxC5-4tnGMT4W5b7L=C_riwpTvDfeMUjQzpjA@mail.gmail.com>
	(Christian Couder's message of "Wed, 27 Jul 2016 08:15:07 +0200")
Message-ID: <xmqqa8h3xd4a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A7494C5C-5416-11E6-BCB8-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>> I finally found time to get back to finish reviewing this.
>
> Great, thanks!

No, thank _you_ for working on this.

>> The early part up to and including "apply: make some parsing
>> functions static again" looked good and we could treat them as a
>> continuation of the earlier cc/apply-introduce-state topic, which
>> has been merged to the 'master' already.
>
> Ok, is it ok for you to just pick up this early part, or do you prefer
> me to resend it (maybe with the last patch on top of it)?

Either would be fine for _me_, but as the original thread is now
about a month old, a final reroll to give people the last chance to
comment on them would not hurt.
