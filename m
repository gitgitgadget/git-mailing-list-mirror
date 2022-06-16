Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F8EC43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 20:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbiFPULN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 16:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiFPULM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 16:11:12 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B783C4476A
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 13:11:10 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 62D6C12A6CA;
        Thu, 16 Jun 2022 16:11:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hU64GV1Ba/XTPPhP3OS1uOxs2WDZh6kH0TiTvz
        5W+xQ=; b=Cnght4xIzwo9JZdllmir5TmSWKx8dBJbZHyJiZr3g+Vuvt0OTDykLX
        4zFLjpDwdSKiXJIIKN2TgDgdjqEvj6NqFmMqcdslfdgNgWDJkHrxqn5pL4Yu5E1J
        Uqf1sJnKCK3jNA1yIo0Ao39ZKtVUl9iePtvQlvgqGaYQ1kfdbVmeA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B5D2712A6C9;
        Thu, 16 Jun 2022 16:11:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EA95212A6C7;
        Thu, 16 Jun 2022 16:11:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 11/11] bug_fl(): add missing `va_end()` call
References: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
        <d674aefa78bdb6d255e40af2f308abf8a87a593a.1655336146.git.gitgitgadget@gmail.com>
        <Yqq3O5hykBecoVKQ@coredump.intra.peff.net>
        <xmqq8rpxw6ch.fsf@gitster.g>
        <220616.86o7yswyek.gmgdl@evledraar.gmail.com>
        <xmqqk09gtriq.fsf@gitster.g>
        <YquCaE+Vw9P/fybU@coredump.intra.peff.net>
Date:   Thu, 16 Jun 2022 13:11:03 -0700
In-Reply-To: <YquCaE+Vw9P/fybU@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 16 Jun 2022 15:20:08 -0400")
Message-ID: <xmqqr13os71k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74255BC4-EDB0-11EC-ACEE-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Being the curious sort, I ran it in a debugger. And indeed, "cp" is
> filled with uninitialized garbage. The reason it works is that the test
> calls bug() with a format string that does not contain any placeholders.
> And thus our eventual call to vsnprintf() does not ever look at "cp" at
> all!

;-)  Thanks.
