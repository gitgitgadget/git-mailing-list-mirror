Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC2FC43461
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 21:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 912AA20731
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 21:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rb2WBiMr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgIOVdd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 17:33:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50705 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbgIOVdB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 17:33:01 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 30DC87EFF7;
        Tue, 15 Sep 2020 17:32:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=feHZdBV8+FiLGnhz69y9CA8c+6o=; b=rb2WBi
        MrUjZi3LV7YMse2qI5x1luHhr9ap9Rb9lG8RopWlXx6HnqpGv3Lmgp+iC76OXAjC
        7W21UL4dGAUD/s/oHl+JCbo4mizqSz7KWzSEQA/zAexne7ad/GE/RgI0JUQKYeVu
        W2YL9uksIYqfzHHOJUdHCPeXymATeH6HIJGu0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ld/3+Hq9wgcsJ9QWIv90B4r+W4rdydMt
        n7FGbVh76mY9dTc7lONcw96mmcb1Y9MCv2VNByRvN+eNHLsA8yaGR4xbsqw0Omcr
        +tWidaEohRrugYKz/mH3S2MqXfVaoxIzeQUJ0OaDpCKUa4rde3CdjpSgNuoapy25
        Yk6Uk8MYxZg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 289647EFF6;
        Tue, 15 Sep 2020 17:32:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A8A7C7EFF5;
        Tue, 15 Sep 2020 17:32:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Alex Riesen <alexander.riesen@cetitec.com>, git@vger.kernel.org,
        Eric Wong <normalperson@yhbt.net>
Subject: Re: sub-fetches discard --ipv4|6 option
References: <20200914121906.GD4705@pflmari>
        <20200914194951.GA2819729@coredump.intra.peff.net>
        <20200915115025.GA18984@pflmari>
        <20200915130506.GA2839276@coredump.intra.peff.net>
        <20200915140613.GB18984@pflmari>
        <20200915152730.GA2853972@coredump.intra.peff.net>
        <xmqq4kny2461.fsf@gitster.c.googlers.com>
        <20200915212338.GA2868700@coredump.intra.peff.net>
Date:   Tue, 15 Sep 2020 14:32:50 -0700
In-Reply-To: <20200915212338.GA2868700@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 15 Sep 2020 17:23:38 -0400")
Message-ID: <xmqqa6xqzpx9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 019A231C-F79B-11EA-8E62-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So I think the best you could do is:
>
>   1. Keep two separate option lists, "parent" and "child". The parent
>      list has "--all" in it. The child list has stuff like "--ipv6".
>
>   2. Parse using the parent list with PARSE_OPT_KEEP_UNKNOWN. That lets
>      you decide whether we're in a mode that is spawning child fetch
>      processes.

Hmph, I vaguely recall discussion about cascading options[] list but
do not find anything that may be involved in an implementation like
that in <parse-options.h>.  I agree that neither of the above is so
attractive.

> I guess parse-options could provide a MAYBE_PASSTHRU flag. On the first
> parse_options() call, it would skip over any such options, leaving them
> in argv. On the second, the caller would tell it to actually parse them.

Or calling it USR1, which is a good way to make it crystal clear
that parse_options() API does not do anything to it.  The code like
"builtin/fetch.c" can locally give it a more meaningful name with
"#define PARSE_OPT_RECURSIVE PARSE_OPT_USR1". if recursive is the
appropriate name for the bit in the context of the options[] array.

I agree that _F() convention that can be used across different types
would be a good thing to have in the longer term, by the way.

Thanks.



