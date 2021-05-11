Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5708C43460
	for <git@archiver.kernel.org>; Tue, 11 May 2021 21:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B81046191D
	for <git@archiver.kernel.org>; Tue, 11 May 2021 21:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhEKVcP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 17:32:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61805 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhEKVcP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 17:32:15 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F3520C6647;
        Tue, 11 May 2021 17:31:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=idEHf87YeCtW
        3Rd6fjWSdJpQt2B6PD0vVhujwgeUj+0=; b=n+jEeAypyqAmh3P82KAsLoNZrBdP
        ntam5m1+7YvZk/xG99FGKTYldFZROwKJ5H6lYREiMMhqVlUR/erlS52hzgvAzTX1
        CZ0goIgda2DczYpDRH7eNJ7qtN6KFLoKSOY5MNj8eHKc/5T6hLhHv4fT4yFVLiY8
        g4CFsjX2VkeiZUk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E603EC6645;
        Tue, 11 May 2021 17:31:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1FA01C6644;
        Tue, 11 May 2021 17:31:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] tr2: log parent process name
References: <20210507002908.1495061-1-emilyshaffer@google.com>
        <87im3qu4gy.fsf@evledraar.gmail.com>
Date:   Wed, 12 May 2021 06:31:05 +0900
In-Reply-To: <87im3qu4gy.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 10 May 2021 14:29:15 +0200")
Message-ID: <xmqq8s4lkleu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 31A3FFE0-B2A0-11EB-8FBE-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, May 06 2021, Emily Shaffer wrote:
>
>> It can be useful to tell who invoked Git - was it invoked manually by =
a
>> user via CLI or script? By an IDE? Knowing where the Git invocation ca=
me
>> from can help with debugging to isolate where the problem came from.
>
> Aside from the portability concerns others have raised, I don't really
> see why you'd need this.
>
> We already have the nest-level as part of the SID, so isn't it
> sufficient (and portable) at the top-level to log what isatty says + se=
t
> the initial SID "root" in the IDE (which presumably knows about git).
>
> Wouldn't this log passwords in cases of e.g.:
>
>     some-script --git-password secret # invokes "git"

Both valid and excellent points, I would think.
