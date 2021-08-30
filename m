Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC148C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 23:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9192E60FC0
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 23:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbhH3X7Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 19:59:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65090 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbhH3X7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 19:59:25 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7AD43E7D84;
        Mon, 30 Aug 2021 19:58:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=v3iQk8ytl1VR
        btYqUb1oUyH/Am8K+wu4ITPz8Q8kpqo=; b=K1fblDnWYJjILxhwp6RklXEggVEk
        QyrKE/F7iWfiwdKV/o1tP8d0inRaz5d9bXewhkFLY5fMbQm36sWHEk6n5bo1o7CA
        dpnccHLdwEFXSuodvnrOM7OvRjhcmPzPJr/JpqlAa4v0LHannmFZgGX6Ns9wsdzM
        bLrZ8WIquzKep9A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7347DE7D83;
        Mon, 30 Aug 2021 19:58:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F0EF5E7D7E;
        Mon, 30 Aug 2021 19:58:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 0/7] commit-graph: usage fixes
References: <cover-0.6-00000000000-20210720T113707Z-avarab@gmail.com>
        <cover-v4-0.7-00000000000-20210823T122854Z-avarab@gmail.com>
        <YS1vz16wOyj2GPHP@nand.local>
Date:   Mon, 30 Aug 2021 16:58:29 -0700
In-Reply-To: <YS1vz16wOyj2GPHP@nand.local> (Taylor Blau's message of "Mon, 30
        Aug 2021 19:54:55 -0400")
Message-ID: <xmqqpmtuzdqy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2CCBBEAE-09EE-11EC-A522-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Mon, Aug 23, 2021 at 02:30:14PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>> A re-roll of v3 which should fix all outstanding issues &
>> feedback. Thanks SZEDER & Taylor:
>> https://lore.kernel.org/git/cover-0.6-00000000000-20210720T113707Z-ava=
rab@gmail.com/
>>
>> I dropped this myself because per
>> https://lore.kernel.org/git/87im14unfd.fsf@evledraar.gmail.com/ I was
>> under the impression that Taylor was intending to pick up these
>> patches as part of some more generale usage() fixes of his (which also
>> touched multi-pack-index.c), but his recent changes to fix
>> multi-pack-index.c didn't pick this up, so here it is as a re-roll ins=
tead.
>
> Thanks, and sorry for totally dropping this on the floor even though I
> said that I would pick it up. Since it had been a while, I re-read
> through the patches and they all look good to me.
>
>     Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks.

