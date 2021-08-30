Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6CAC432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 16:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8B4660E97
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 16:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237710AbhH3QnC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 12:43:02 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56410 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237049AbhH3QnC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 12:43:02 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 538311666A9;
        Mon, 30 Aug 2021 12:42:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZQG7tXaOU4/C
        8M+Z2dyAL0H1unELYaW/CAL1qoR6LsA=; b=RN1Hcq+20AcPtzTt2/3eQLcPo76Q
        tLaWU1ar6KZvTxyUHpSDSWSqSpBbFp2wWddzSwofvvQYwIIWVys5Buu/Nbs3rZWU
        K8tZKFQOxHl1yB0F8sFaD2aDpVZssRf0cSjxqLVYYw0PfShy9LBLc1AwCNTiYV+i
        +vyHjwv78BG+EgM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4C0691666A8;
        Mon, 30 Aug 2021 12:42:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 969CF1666A7;
        Mon, 30 Aug 2021 12:42:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>, Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Mickey Endito <mickey.endito.2323@protonmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] t5582: remove spurious 'cd "$D"' line
References: <tV8xl8isDPhmGxCNmN06tTwhJTve0PsrkakKwLMcFQJybDZO2SGHHbDLZFrcLp1Yda1_KRygSm7-lVDSZSaG-antdalcPnhSqYqcK5Fpifk=@protonmail.com>
        <xmqq8s0rpwiw.fsf@gitster.g> <20210824185942.GE2257957@szeder.dev>
        <YSWeeEgzCCT/3kxR@coredump.intra.peff.net>
        <xmqqsfyxjyfe.fsf@gitster.g> <20210828094726.GG2257957@szeder.dev>
Date:   Mon, 30 Aug 2021 09:42:03 -0700
In-Reply-To: <20210828094726.GG2257957@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message
        of "Sat, 28 Aug 2021 11:47:26 +0200")
Message-ID: <xmqqilzm6g10.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 35B1794C-09B1-11EC-8719-FA11AF6C5138-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Wed, Aug 25, 2021 at 09:12:37AM -0700, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>>=20
>> > Hmm. I think that one is different, in that the "cd" is not redundan=
t,
>> > but wrong. But it turns out not to matter to the test. ;)
>>=20
>> Funny.=20
>>=20
>> We are lucky because 'cd ""' stays in the same repository as the
>> current one and not to a random place,
>
> Actually, the results of 'cd ""' are unspecified, though most shells
> do as you said.  Do we want something like this?

I doubt it, as the root issue is not "cd" but "$D" and other
variables that we use before setting.

I wonder how close our test suite is for being "set -u" clean.
Running our tests under "set -u" may not be a bad endpoint, but
only if we can get there without too much pain.

Thanks.

