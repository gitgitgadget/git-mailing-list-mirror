Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C400C433F5
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 20:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AC69610A8
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 20:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhKCUHY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 16:07:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50552 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbhKCUHV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 16:07:21 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E103E4BD1;
        Wed,  3 Nov 2021 16:04:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gAsp4RyQyjRC6JHSMJgcJ96e7oD9oaBZc/MwP3
        lPpDY=; b=AtjiewhiF0xY83oby6zPAW8RbwyXhq1KpP7ub9l7Su9votzRRpY3Ff
        FOKjSAZ875XmlG1UsTeKnCoQyL3h0pSTyPnMBVZdfsEwqvOF2bN3tqz0MzDD+Rnl
        9iiGlXhl9w2X8HhswwW6IptBr3Gm10jNdnFA80B6xUSB3XCi//bbI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 05435E4BD0;
        Wed,  3 Nov 2021 16:04:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5EF90E4BC7;
        Wed,  3 Nov 2021 16:04:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] var: add GIT_DEFAULT_BRANCH variable
References: <xmqqa6il6qxu.fsf@gitster.g>
        <20211103185331.599463-1-thomas@t-8ch.de>
        <CAPig+cR0PL-XtfC8v4-u1Taq6yOLO=2HSHsNBnzvzLCyM-whZA@mail.gmail.com>
Date:   Wed, 03 Nov 2021 13:04:42 -0700
In-Reply-To: <CAPig+cR0PL-XtfC8v4-u1Taq6yOLO=2HSHsNBnzvzLCyM-whZA@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 3 Nov 2021 15:57:27 -0400")
Message-ID: <xmqq5yt96m5h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4924EB7C-3CE1-11EC-9049-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> earlier in the thread (i.e. create a dummy repo and ask it for its
> default branch)? Something like this (untested):
>
>     (
>         sane_unset GIT_TEST_... &&
>         git init defbranch &&
>         git -C defbranch symbolic-ref --short HEAD >expect &&
>         git var GIT_DEFAULT_BRANCH >actual &&
>         test_cmp expect actual
>     )

So, the idea is to "observe" what the init command actually does,
and see if that matches the behaviour of the var command?

Sounds like a good way to ensure correctness to me.

Thanks.
