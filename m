Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE88C433EF
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 16:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C13286120E
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 16:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236563AbhIVQRB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 12:17:01 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62401 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236611AbhIVQQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 12:16:57 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D7BAE8013;
        Wed, 22 Sep 2021 12:15:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8ZkYbgXBUB/P
        zJYajk7bWL2p3nI7XZ1c/jnws+8v/Kg=; b=CLVKul7D4Q5cTxc8gC5GNaYFFqp8
        ArZ5FQJww1x5hEsRNY02BLjKxLHRFk9J/H4UCSlJx4Rs2qXJIVccmnzEzVQ5SKIU
        dkHAXNq8JNFdM9Ae9+CAO0XRu24k8Kisdsc8n7djGwPWJCa0euf4ec5F2/1T3YKR
        UW9LdOWjgn/gMLg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 94D5FE8012;
        Wed, 22 Sep 2021 12:15:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F31A9E8011;
        Wed, 22 Sep 2021 12:15:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Carlo Arenas <carenas@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: cb/pedantic-build-for-developers, POSIX-but-not-C99 and
 -Wno-pedantic-ms-format
References: <xmqq1r5iaj9j.fsf@gitster.g> <87lf3q9u6b.fsf@evledraar.gmail.com>
        <CAPUEspiBP+4Ac4O5ZRTK0N+8PhHeewksrhL=x8TcswrvnS1JOw@mail.gmail.com>
        <b0eba1c6-5468-df31-db6f-701bcd24adff@web.de>
Date:   Wed, 22 Sep 2021 09:15:24 -0700
In-Reply-To: <b0eba1c6-5468-df31-db6f-701bcd24adff@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 21 Sep 2021 12:30:00 +0200")
Message-ID: <xmqqee9g8u3n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4BBF67E6-1BC0-11EC-9F6C-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> The lack of warnings about the use of that extension in po/ means
> translated formats are not checked by the compiler at all, right?
> According to the gettext documentation [2] msgfmt takes care of that
> when building the translation files, though.

It is not even seen by the compiler at compilation time, right?  _()
at runtime is merely a function call to map its parameter string to
another string using what is in .mo (compiled from po/).
