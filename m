Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5001C2018A
	for <e@80x24.org>; Thu, 23 Jun 2016 16:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860AbcFWQrE (ORCPT <rfc822;e@80x24.org>);
	Thu, 23 Jun 2016 12:47:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51500 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751660AbcFWQrD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2016 12:47:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6863F243B9;
	Thu, 23 Jun 2016 12:47:01 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GYfXrlhcqqBXppiCjDYrAr90tQ4=; b=mTqn7T
	BH+Sw5uxCULzkALNL8xZgARGiyu+jUv8+esCiZlsTb9w3u0PQ7Mg9wR6BL1fPLbV
	uo3r8Mdd8+oy/T/Ka3WEfKxHclEwLvWpolNBfWHoubdWXQQocmJQk/iU2PrlU1/W
	K1UrEbMEdRZDa7B48T8F7LBz3cAnRqsb7wjv0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l75prN4/ZgQYPlXOJ9ksfnZ/6Sy8kPh5
	ZPZGWkZIB7lvjm/NwckBL4y8VgJGPAOBzwMGj8x1SMsegNn9Yvb0CAm4Ws267ExO
	4bCh++/1dvBYCaYV6fylSjL63kTau8HTEtV6bJ3kuHSRathLH/NHnjRgf+V6A2tt
	Sxzwra+NKYk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3847E243B5;
	Thu, 23 Jun 2016 12:47:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1C2CC243AC;
	Thu, 23 Jun 2016 12:47:00 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Simon Courtois <scourtois@cubyx.fr>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] color: support "italic" attribute
References: <20160623130828.GA25209@sigill.intra.peff.net>
	<20160623131028.GB12653@sigill.intra.peff.net>
Date:	Thu, 23 Jun 2016 09:46:57 -0700
In-Reply-To: <20160623131028.GB12653@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 23 Jun 2016 09:10:28 -0400")
Message-ID: <xmqq7fdfkg3i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1AD73E42-3962-11E6-BEE6-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We already support bold, underline, and similar attributes.
> Let's add italic to the mix.  According to the Wikipedia
> page on ANSI colors, this attribute is "not widely
> supported", but it does seem to work on my xterm.
>
> We don't have to bump the maximum color size because we were
> already over-allocating it (but we do adjust the comment
> appropriately).
>
> Requested-by: Simon Courtois <scourtois@cubyx.fr>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/config.txt | 2 +-
>  color.c                  | 8 ++++----
>  color.h                  | 3 ++-
>  t/t4026-color.sh         | 4 ++--
>  4 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 58673cf..4b97d8d 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -154,7 +154,7 @@ color::
>         colors (at most two) and attributes (at most one), separated

This is describing the format accepted by color_parse_mem(), whose
main loop has /* [fg [bg]] [attr]... */ comment in front?

Is "at most one" still correct, or it was already stale before this
patch?

