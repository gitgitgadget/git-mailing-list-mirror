Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 736311F62B
	for <e@80x24.org>; Wed, 27 Jul 2016 20:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757999AbcG0ULj (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 16:11:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59859 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757321AbcG0ULi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 16:11:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8EC6D30292;
	Wed, 27 Jul 2016 16:11:37 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ca9hHYSLR1S0XIXYCw8xrMawIRs=; b=SDbkd6
	3sdIEWrXziNm02YTh0MFwcr8HsWHL11fQVjHySDNwzA5hIAp4v2+WrvC4bp6/ii7
	k7zktim0YwcqQHWi3jH1yFuoxLdutNFFv8T2a0NW6p7jOI2ydBYgd7aTcWIyRC9y
	kB+ZRkVFGaM0Sj9sfgvXamhdgGhe19+w0G3IA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ieqXRV5NfN3doa+yeeSMJSUs1hohkPcB
	/+4d4C0GI4QjVOaLu1sBH/7narbRPcUNMsDyT2dJj/ThfgS/2p0jyMVRE/vNzTfm
	wUwXCLh/KfrV2ajX2k5lxVqdRxklD6x9NCkVVEC9QOYWRBk2Ac/xODMwlI9yduzV
	ZPLX2NkspQE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8450E30291;
	Wed, 27 Jul 2016 16:11:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BF63F30290;
	Wed, 27 Jul 2016 16:11:36 -0400 (EDT)
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
	<xmqq37mux3mz.fsf@gitster.mtv.corp.google.com>
	<20160727195703.GA8141@sigill.intra.peff.net>
Date:	Wed, 27 Jul 2016 13:11:34 -0700
In-Reply-To: <20160727195703.GA8141@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 27 Jul 2016 15:57:03 -0400")
Message-ID: <xmqqtwfavo21.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52637F3A-5436-11E6-AE44-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The second option you've shown here is much better, and I think this is
> worth fixing (and it should be in a new patch, and can go on top of the
> others).
>
> I'm not sure if it's worth calling out more clearly what the timezone
> means, since the epoch seconds are in UTC, as you noted here. The
> follow-on sentence explains what "-local" does, but not what it means in
> the non-local variant.

Hmm, that is another thing we can incrementally improve, I guess.

Here is 7/6 I've tentatively queued.  Note that I minimized the
reflowing of the paragraph you did in 5/6 so the patch may not apply
cleanly to your tree.

-- >8 --
Subject: [PATCH] date: clarify --date=raw description

"... in the internal raw Git format `%s %z` format." was clunky in
repeating "format" twice, and would not have helped those who do not
know that these are strftime(3) conversion specifiers.

Explain them with words, and demote the mention of `%s %z` to a
hint to help those who know them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/rev-list-options.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index fd86ed1..d55e3ae 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -746,7 +746,9 @@ format, often found in email messages.
 +
 `--date=short` shows only the date, but not the time, in `YYYY-MM-DD` format.
 +
-`--date=raw` shows the date in the internal raw Git format `%s %z` format.
+`--date=raw` shows the date as seconds since 1970-01-01 00:00:00 UTC,
+space, timezone as sign and four digits (i.e. as if the timestamp were
+formatted with `strftime("%s %z")`).
 Note that the `-local` option does not affect the seconds-since-epoch
 value (which is always measured in UTC), but does switch the accompanying
 timezone value.
-- 
2.9.2-654-g4c312ab

