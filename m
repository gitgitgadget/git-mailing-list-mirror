Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C0EC433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 18:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3C11610F8
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 18:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345796AbhIGSYD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 14:24:03 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60797 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245718AbhIGSYC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 14:24:02 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A255315F5C5;
        Tue,  7 Sep 2021 14:22:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=9pJN6aApbji6
        lCHK2gJC/Fn3t/C/7ZOBZbIs31YAzqo=; b=TJhVMvtSExkq3gsRO/sS9Ypf4G7D
        3B8tmS+BpTEONZqWV5n3HG6uigagkF52RwhCSYMQoleG2StC0o61f7Q1UeU7oGCC
        pFTjjieEuKhYJennAx5sCyamWvstcrNtOX0SQyhBHv2hJcB1qZGDOYnwxK8O4v72
        pWWgw4dOVeQEUxU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 99D9715F5C4;
        Tue,  7 Sep 2021 14:22:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BDD4715F5C0;
        Tue,  7 Sep 2021 14:22:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Andrzej Hunt <andrzej@ahunt.org>,
        =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr>,
        Derrick Stolee <dstolee@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 0/3] add a test mode for SANITIZE=leak, run it in CI
References: <cover-v3-0.8-00000000000-20210831T132546Z-avarab@gmail.com>
        <cover-v4-0.3-00000000000-20210907T151855Z-avarab@gmail.com>
        <YTeW+MpIVNCcd2nF@coredump.intra.peff.net>
Date:   Tue, 07 Sep 2021 11:22:50 -0700
In-Reply-To: <YTeW+MpIVNCcd2nF@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 7 Sep 2021 12:44:40 -0400")
Message-ID: <xmqqtuiwb5z9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9CCA9B38-1008-11EC-B875-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Sep 07, 2021 at 05:33:28PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>
> OK, I think we should proceed with this series/approach, then. The
> question of friction when CI fails is an open one, but we won't know
> until we have more data. So let's see what happens. :)
>
> The patches themselves look fine to me, though I had a few nits on the
> third commit message.

Thank you all.

Let's see a copy-edited v5 and we can go from there.


