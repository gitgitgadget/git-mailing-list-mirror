Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD884C2B9F4
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 06:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87F0A610CC
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 06:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbhFSGTY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Jun 2021 02:19:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50923 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbhFSGTX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jun 2021 02:19:23 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C3EFCB211;
        Sat, 19 Jun 2021 02:17:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hl+jYzQiTwJfjyIWQb4n8wcGRqkPu+SO30GGrC
        efh5k=; b=A61zmI13MwsMd6AQArf8yrj9OY/NQMuPP/K/cEXDivfdPPYYlAGHiw
        +3X+d/OSJKDapiMTWf9Con5rVOxWH4HfBCE2pJX27BJQVjRk6P73qjnEG3r4PDOf
        i3xyRsYlH8cl4HuHWx4lCOWiqFnNWoLO3M3g3XTJmYmhGesMS/so4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 82CFECB210;
        Sat, 19 Jun 2021 02:17:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0B329CB20F;
        Sat, 19 Jun 2021 02:17:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Git List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 0/4] t: new helper test_line_count_cmd
References: <20210615172038.28917-1-congdanhqx@gmail.com>
        <20210619013035.26313-1-congdanhqx@gmail.com>
        <CAPig+cR7tUXB4=j3fGHN07=tPJ-skGb_6M7SExTq5eAH7FSwOQ@mail.gmail.com>
Date:   Sat, 19 Jun 2021 15:17:11 +0900
In-Reply-To: <CAPig+cR7tUXB4=j3fGHN07=tPJ-skGb_6M7SExTq5eAH7FSwOQ@mail.gmail.com>
        (Eric Sunshine's message of "Sat, 19 Jun 2021 01:50:29 -0400")
Message-ID: <xmqqfsxel6oo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FC0AAE3A-D0C5-11EB-A26D-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Since you've dropped the `--out` and `--err` options entirely, I
> wonder if now would be a good time to shorten the function name, as
> well, in order to further reduce the noise level. Since it now only
> tests stdout (and doesn't deal with stderr), a name even shorter than
> what I tried for the last version might be even better. So, for
> instance, the name test_out_count() might not be too bad:
>
>     test_out_count = 0 git ls-files -o &&

"Test out" to me sound like trying something out and the part "out"
in the name no longer hints it is about "output"; you may have
shortened the name too much to be meaningful, I am afraid.

Is the helper used to check with anything but equality?  Otherwise
you can lose "= " to make it shorter.

Having said all that, as an external interface, I wonder

	test_line_count -e = 0 git-ls-files -o

would work better.  It usually takes <op> <num> <file>, but when
$1 is a magic "-e", we shift it out and it becomes <op> <num> <cmd>...
