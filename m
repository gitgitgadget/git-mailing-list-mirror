Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD9FC4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 22:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8658360720
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 22:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbhHQWOE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 18:14:04 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52868 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235578AbhHQWOD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 18:14:03 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D1153158083;
        Tue, 17 Aug 2021 18:13:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=07knAVlMvRQHulKJ/Rz709YyqDLbdBficfMPrS
        ygR5I=; b=ZTvKzvR/erP8NnLHcxdAix6ONRCbuD7BDSOE2mU7eYdaqtZb70I7AQ
        uxEIA1F6AtdAYBkE+h4SqRlwfbnSI8KmnrQNoYUQtXgxoyVPEs+sSWjpj/4ZCiSH
        jEdZhVLCLTLzmHrWih0UVkoMS52rKdQrei1yryFlEE3pjYrV6iiiQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C8A62158082;
        Tue, 17 Aug 2021 18:13:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 139A3158081;
        Tue, 17 Aug 2021 18:13:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        ak@linux.intel.com, Jeff Hostetler <git@jeffhostetler.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] make: add install-strip target
References: <20210817110728.55842-1-bagasdotme@gmail.com>
        <nycvar.QRO.7.76.6.2108172327290.55@tvgsbejvaqbjf.bet>
Date:   Tue, 17 Aug 2021 15:13:25 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2108172327290.55@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 17 Aug 2021 23:28:37 +0200 (CEST)")
Message-ID: <xmqq8s0z7m9m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 589A64F4-FFA8-11EB-9890-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Would those `all` and `strip` targets interfere with one another if `make
> -j2` was called? If not, wouldn't it be sufficient to let `install-strip`
> depend on `strip` alone?

Good question.

I would have expected that this will *not* be a new target, but some
sort of make variable (e.g. "make INSTALL_STRIP=yes install").
