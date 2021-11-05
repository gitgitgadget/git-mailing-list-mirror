Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F19C433EF
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 22:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F4316120A
	for <git@archiver.kernel.org>; Fri,  5 Nov 2021 22:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbhKEWsF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 18:48:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62544 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbhKEWsE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 18:48:04 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C91CE8380;
        Fri,  5 Nov 2021 18:45:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rvsfrwoZAujB
        Wl9IwOogBzvezyKLoKmgt60tfxOnugg=; b=Ghp+v5mwndkNz9Sa5fn1bCom5dEJ
        PUGnB/KIG5FEyH4VvH2NLKuNulmR9e3+5GFZK1pDtFq9L+6c7W4d4uCe1HtYrYPB
        DfxFTBb9izwTESq+1rQA7iW5EDH7Kj6QFLF7bsSKia3czIWvgx7ndG5xlgx9HFQB
        xb0O1Mgwnd6DGKU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 23967E837F;
        Fri,  5 Nov 2021 18:45:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 889C0E837E;
        Fri,  5 Nov 2021 18:45:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 01/10] command-list.txt: sort with "LC_ALL=C sort"
References: <cover-v2-00.10-00000000000-20211022T193027Z-avarab@gmail.com>
        <cover-v3-00.10-00000000000-20211105T135058Z-avarab@gmail.com>
        <patch-v3-01.10-c385e84c04c-20211105T135058Z-avarab@gmail.com>
Date:   Fri, 05 Nov 2021 15:45:17 -0700
In-Reply-To: <patch-v3-01.10-c385e84c04c-20211105T135058Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 5 Nov
 2021 15:07:59
        +0100")
Message-ID: <xmqqbl2yw7b6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0CFA25CC-3E8A-11EC-BCB7-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> In a subsequent commit I'll change generate-cmdlist.sh to use C sort
> order, and without this change we'd be led to believe that that change
> caused a meaningful change in the output,

What I found misleading in this sentence (which hasn't changed after
I pointed it out in the previous iterations) is that
command-list.txt is an input file, and if the sort order used in the
script that reads this to produce some other file as its output
changes, nobody will be "led to believe" anything.  Not unless/until
which output file to look at and compare between revisions.

Is this talking about the order of entries in command-list.h file?

Also, if the script sorts the input, whether it is in C locale or
other locale, it would not matter how the input originally is
sorted, as the input does not have duplicated entries to make sort
stability matter, no?
