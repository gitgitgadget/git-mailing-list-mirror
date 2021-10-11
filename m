Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A72C433EF
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 04:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC28260F38
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 04:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbhJKEhA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 00:37:00 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55214 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhJKEg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 00:36:59 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 853E51577C5;
        Mon, 11 Oct 2021 00:34:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2F2Z7xF0c5C6fQVM8xn0gyL+2FGYhaMWyxOn6Q
        a5nUA=; b=PAec5Mmhygl1qIumgnYFjf5mtvSN4bDUM7MHj82A5LIWKlKvzzQYKF
        +9AwKr1eIIipvXcJ+PPkz80oI7WERyY25PuDxY7owz5RXJZiaATB4xNGkfHtRNc8
        aiD0fImZy/1hNXLi4WsRRsc6U6CEnhsJhgMuG16F56PLrx24h8MZs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7E09B1577C4;
        Mon, 11 Oct 2021 00:34:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E48D71577C2;
        Mon, 11 Oct 2021 00:34:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] test-lib.sh: try to re-chmod & retry on failed trash
 removal
References: <patch-1.1-d7e88a77fef-20211009T133043Z-avarab@gmail.com>
        <xmqqee8seded.fsf@gitster.g>
Date:   Sun, 10 Oct 2021 21:34:55 -0700
In-Reply-To: <xmqqee8seded.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        10 Oct 2021 15:14:02 -0700")
Message-ID: <xmqqa6jgdvrk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96522FCE-2A4C-11EC-BDC6-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +		chmod -R u+w "$dir" 2>/dev/null
>
> If a test lost searchable bit from directories, "u+wx" may be
> necessary to clean fully, no?

Sorry, but I was stupid.

If we were to worry about losing the searchable bit, then I should
considered the possibility that we may also lose the readable bit,
too.

