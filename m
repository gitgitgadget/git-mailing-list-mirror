Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8504FC433F5
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 08:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 571C8608FB
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 08:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbhILIYG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 04:24:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61485 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbhILIYF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 04:24:05 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 68A7BF1E62;
        Sun, 12 Sep 2021 04:22:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=QxkCOgAiI2eLKh6osZ9Cwd7ZcvqqFbZlq2hG0oy6Hj0=; b=BNZh
        8KdbGrfuKGTqne9PhQ4Z6s7/3ARa8kRYhn1jO4w8oqn5hp8ynO+NMf5p1JBfV1sO
        jd0LnALGzL1uBczjP9mxDmqxpGtpHONEGx0O5MFOpuiSmczz0f/cS8Caky4imEKi
        qNeoKKMOwyHCxQThBQnMjDeVv0LvTu8AhpGB99M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F44FF1E61;
        Sun, 12 Sep 2021 04:22:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E5501F1E60;
        Sun, 12 Sep 2021 04:22:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] notes: don't indent empty lines
References: <20210830072118.91921-1-sunshine@sunshineco.com>
        <20210830072118.91921-4-sunshine@sunshineco.com>
        <xmqqwno2505w.fsf@gitster.g>
        <CAPig+cQ6FA0rUnkkTDRUD5vAD3cDXW9vtR1oX0pUJK5eJB9CHg@mail.gmail.com>
        <xmqqeeaa4y0v.fsf@gitster.g>
        <CAPig+cQdXp0c+JYthvy+bbr6vLR7nq4pQY3w+CADUtzr+Ang4A@mail.gmail.com>
        <CAPig+cTFbnrPPSZbzihJ9gdGV2c4poXWyNjhK3mnr5_uRwpxbg@mail.gmail.com>
        <xmqqwnnos2jz.fsf@gitster.g>
        <CAPig+cQdAuLkZ0pDK6XOfm_WXCJAOm8Tr19oK14n-Tf7DcfW=w@mail.gmail.com>
        <878s03c1of.fsf@evledraar.gmail.com>
        <CAPig+cQ+qVNBJqHmQgk6D1fbYHHJpAxhfwyBOgevi9Hvs6JYkw@mail.gmail.com>
        <87wnnn8kba.fsf@evledraar.gmail.com>
        <CAPig+cTRo_bLrCyhWC5on-HHco=H=3Mc6Xfi4gRP0xVE+Xk=BA@mail.gmail.com>
Date:   Sun, 12 Sep 2021 01:22:50 -0700
Message-ID: <xmqqmtoikxt1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9EAEE948-13A2-11EC-A201-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> I'm not a fan of the trailing whitespace either, however, Junio does
> have the concern that there may be some tooling somewhere which relies
> upon the "indented blank lines" (even if such tooling would not be
> robust).

Note that such a "concern" is always relative.  If the upside were
so great, perhaps risking possible breakage may be warranted.  FWIW,
I am not a big fan of trailing whitespaces that human writers leave
in what they write, either.

Because the patch text will be full of lines with trailing
whitespaces anyway due to a blank lines in the patch context,
however, it does not sound so great an upside to tweak how the
paragraphs taken from the notes are inserted.

Thanks.
