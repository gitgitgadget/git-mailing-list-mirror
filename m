Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C6631F621
	for <e@80x24.org>; Wed, 27 Jul 2016 19:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757508AbcG0Tto (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 15:49:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52045 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753189AbcG0Tto (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 15:49:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D15953025E;
	Wed, 27 Jul 2016 15:49:42 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zfEK3Hxn6FS3PzmxYrPgU1uS2JE=; b=CWx0Si
	V9CwjxcHm5A5MHjalB4Hk42SXnwtA4Yc9PrUO8W2KOvvJuehPKMlTy/aFCcJv9Zj
	m1RyWixcHhvGm7WO/g3VnP/tNh6id2Fg325/IYs9SwztVkPsfCdiBCio4JI22Qod
	PAYfwSPD5dvBg+ZDCn3sFF3mnbVsGSG4xXpmM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TFbEwRr6mL8MupJQiUDuB6xwcYcAeEVj
	pbhq3mRzY6eHAbZouPhhracwsokhhHJCDUt1Nzg7y+J8apw/Bx/+IJCRmc3vJLc4
	ZOEkf9qNXYPgOUwWWgY8paymsNVky3wohfG05alkBbIcF7ObCt3jBZTtt/FIQqT3
	V+Ba9FrRpng=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C97C83025D;
	Wed, 27 Jul 2016 15:49:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 564BB3025B;
	Wed, 27 Jul 2016 15:49:42 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	git@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v3 5/6] date: document and test "raw-local" mode
References: <20160722195105.GA19542@sigill.intra.peff.net>
	<20160722195144.GE19648@sigill.intra.peff.net>
	<579343C9.1040902@gmail.com>
	<20160726184746.GA678@sigill.intra.peff.net>
	<5798AA7C.6050107@gmail.com>
	<20160727134441.GB14928@sigill.intra.peff.net>
Date:	Wed, 27 Jul 2016 12:49:40 -0700
In-Reply-To: <20160727134441.GB14928@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 27 Jul 2016 09:44:41 -0400")
Message-ID: <xmqq37mux3mz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 42E3A056-5433-11E6-B384-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> +e.g. ``2 hours ago''. The `-local` option has no effect for
> +`--date=relative`.

Good.

> @@ -746,7 +746,10 @@ format, often found in email messages.
>  +
>  `--date=short` shows only the date, but not the time, in `YYYY-MM-DD` format.
>  +
> -`--date=raw` shows the date in the internal raw Git format `%s %z` format.
> +`--date=raw` shows the date in the internal raw Git format `%s %z`
> +format. Note that the `-local` option does not affect the
> +seconds-since-epoch value (which is always measured in UTC), but does
> +switch the accompanying timezone value.

Not your fault, but "internal raw Git format X format" sounds a bit
clunky.

	shows the date in `%s %z` format (seconds since 1970-01-01
	00:00:00 UTC, space, timezone as sign and four digits)
        
or something like that?  I suspect %s is not a POSIX-kosher strftime
conversion specifier, so from that point of view, perhaps making the
text the authoritative description and demote the format string as a
comment to help those who know strfmt, i.e.

	shows the date as seconds since 1970-01-01 00:00:00 UTC,
	space, timezone as sign and four digits (i.e. as if the
	timestamp were formatted with `strftime("%s %z")`).

perhaps?

