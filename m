Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C05C1F855
	for <e@80x24.org>; Wed, 27 Jul 2016 22:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163588AbcG0Wg0 (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 18:36:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57814 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1163457AbcG0WgY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 18:36:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4EA7530AA3;
	Wed, 27 Jul 2016 18:36:23 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KiEHoGMG/RxJbuU64E3CdIulHG4=; b=Si6cn0
	1B/c3zTTRfaBujr4jDtlmHLTHjPVbWlS67aUStOoKaNp+m8SrocZMW/WcnLgOH8S
	hRl4j/oaMPSQ8aMZqd3JEB6wkoXo61Je3kn9whFc/g70Qv7CNfgGyZBzW1apMO9v
	mb+qK53fTEf1mfcDBUgKkXLKL540gbFUnglOE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iaG1qIirJ8Fm91QoPk0nHSgi3MRLdA7I
	8sfjzVWjroAgY27QGK3rbchgC3WVkb/GIMOpwD4OLJPwBrFVADNeUg6ngV8AJNmp
	zFwqv8iB8wfvUyUFoNcWB5XKAMfIDFsoZEeXY68kHN4TKMcxzfBvCNo689sb/xuT
	Jzy2pLg3YfU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 46BC530AA2;
	Wed, 27 Jul 2016 18:36:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BD0BD30AA1;
	Wed, 27 Jul 2016 18:36:22 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v5 13/16] merge-recursive: write the commit title in one go
References: <cover.1469187652.git.johannes.schindelin@gmx.de>
	<cover.1469547160.git.johannes.schindelin@gmx.de>
	<882273dd0067de30fe4b672050457708d56f317e.1469547160.git.johannes.schindelin@gmx.de>
Date:	Wed, 27 Jul 2016 15:36:20 -0700
In-Reply-To: <882273dd0067de30fe4b672050457708d56f317e.1469547160.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Tue, 26 Jul 2016 18:06:38 +0200
	(CEST)")
Message-ID: <xmqqzip2u2sb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8BA4475C-544A-11E6-8157-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Let's make sure that the same holds true when outputting the commit
> title: previously, we used several printf() statements to stdout and
> speculated that stdout's buffer is large enough to hold the entire
> commit title.

s/speculate/assume/; other than that looks very sensible.
