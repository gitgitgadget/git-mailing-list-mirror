Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E75C433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 22:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiANWSQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 17:18:16 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56313 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiANWSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 17:18:16 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 49FCB167F3E;
        Fri, 14 Jan 2022 17:18:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0ZGzw00W+Lac
        9byqorxyNy9ohKMVj/zzp9AlwM1uPFI=; b=r3h63Hk44zE0puo1BqUvCc7tb4lm
        kWBRpWCEIgkRwuV7YM3VsTqkHl+4rFT7Bt4VGq5Cz6zT0JRCkiQBPAItvC7RrOlA
        t6uGMXaj1S0FXaVnzTb4p4OpGv/X11CU6n8L4nOTUrK5VldvmA5L/dpzwXCe2te9
        1+MdZpO9qTk/WHs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 42FAC167F3D;
        Fri, 14 Jan 2022 17:18:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 99675167F38;
        Fri, 14 Jan 2022 17:18:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jan 2022, #03; Thu, 13)
References: <xmqq35lrf8g4.fsf@gitster.g> <xmqqk0f3dk5o.fsf@gitster.g>
        <CABPp-BFGxKBzi5RYDuiJv6Vz7yyGYTOdJC9cL_EkPGNJ5BksYQ@mail.gmail.com>
        <xmqqmtjyaylt.fsf@gitster.g>
        <CABPp-BGOqK0YJXna3PqnFmTcW_KxzAGbqjpUvRjgAxAwYzG4bw@mail.gmail.com>
        <xmqqfspq9dqn.fsf@gitster.g>
Date:   Fri, 14 Jan 2022 14:18:12 -0800
In-Reply-To: <xmqqfspq9dqn.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        14 Jan 2022 14:03:28 -0800")
Message-ID: <xmqq7db29d23.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DD5B1CBA-7587-11EC-96D3-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Elijah Newren <newren@gmail.com> writes:
>
>> In contrast, if we leave the leak-checker failing and the failing job
>> spreads to next and master,...

In any case, I think =C3=86var identified an offending topic, so I kicked
it out from 'seen'.  If it makes the leak-checker job pass, that
would be a much better outcome than anything else we have been
discussing on this thread so far, and we'd hopefully set a good
precedent to follow.  (1) if your change adds a new leak, you'll not
hit 'next', (2) as an exception, if new test added by you use a tool
that wasn't used in it, and if the test is known to be leaky, it is
OK to mark the test leak-checker-unclean.

Let's see how well the rest of the topics do.
