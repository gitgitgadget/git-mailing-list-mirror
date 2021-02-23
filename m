Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FEEC433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 19:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94B8B64DF3
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 19:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbhBWTVp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 14:21:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55051 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbhBWTUP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 14:20:15 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D3EB995099;
        Tue, 23 Feb 2021 14:19:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9TbWsH6YEy43jgsBSmiBbWqrgbE=; b=aKqUez
        XUzXqC/MOOb7r2e0m4XhzClpZmG35T9+lO3QKigWJAEa8Rq6gNT/qxVypaaQS+TE
        /ZYlK884LFLzxXXxZ6O5HiWGKgpO8oUPIJkzEUAmvLlctULia8I2j5oCww/7YagJ
        b4OkmbsiCwe/WbSme7EemQ72vAobXMyd4o9nQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kIHZ5exyBdwzywbtOCRZpiRsLtVVqiEw
        58bgt6SBnvXQHxkBZ9oX2X8vle+BUakTXKsKxiIeY6ejqd4hk+R1O0lTsS+075mG
        KQaNCUNigeahPEuQHIdK2smDnf1PGRENC/mIbIQzpj7dat/7Nk+tFCl8K/O7RPcn
        ZQU65TjaWEs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C4F7895098;
        Tue, 23 Feb 2021 14:19:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BA0B195097;
        Tue, 23 Feb 2021 14:19:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 6/6] Makefile: build "$(FUZZ_OBJS)" in CI, not under
 "all"
References: <20210201111715.10200-1-avarab@gmail.com>
        <20210223114132.24345-7-avarab@gmail.com>
        <YDVJZnmTiBYZ4iPM@coredump.intra.peff.net>
Date:   Tue, 23 Feb 2021 11:19:25 -0800
In-Reply-To: <YDVJZnmTiBYZ4iPM@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 23 Feb 2021 13:28:54 -0500")
Message-ID: <xmqq35xm383m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0ACC0780-760C-11EB-9DD9-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If you do a refactor, you are still on the hook for breaking the fuzz
> objects because CI will fail (and you have to investigate it, and fix it
> for CI to remain a useful tool). But instead of finding out about the
> problem quickly as you're working, instead you push up what you think is
> a finished result, and then from minutes to hours later you get a
> notification telling you that oops, you missed a spot. I find that the
> shorter the error-fix-compile cycle is, the less time I waste waiting or
> context-switching.

Thanks for writing this down so clearly.
