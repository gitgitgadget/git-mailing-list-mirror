Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCB7C432BE
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 01:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F481606A5
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 01:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbhH1Bvu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 21:51:50 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62936 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbhH1Bvu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 21:51:50 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6225113843B;
        Fri, 27 Aug 2021 21:51:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/sDJRyIZ3LAX
        wW6P91mrGvZepxQCzqbWEYdFUhDvzjY=; b=pikBSXZaIWonbUwiYmDlnuh2Gtjm
        dgKBZOpgAB3vQMzOWGu/20adVrgXnhZmSKkQVlFnQVZiTSx4Uaysm+97OKBa8R1N
        ociM5lodvzXZTtNDGr6LKixfcqIA3vQpoXmUOK3hKtG+q+s3E4IGAUFXobCKEwv/
        l7GjbUsOMbdDfQw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 59D4213843A;
        Fri, 27 Aug 2021 21:51:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A44BD138437;
        Fri, 27 Aug 2021 21:50:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 4/5] index-pack: add --progress-title option
References: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com>
        <cover-v3-0.5-00000000000-20210826T140414Z-avarab@gmail.com>
        <patch-v3-4.5-e44d825e5df-20210826T140414Z-avarab@gmail.com>
Date:   Fri, 27 Aug 2021 18:50:56 -0700
In-Reply-To: <patch-v3-4.5-e44d825e5df-20210826T140414Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 26 Aug
 2021 16:05:50
        +0200")
Message-ID: <xmqqsfyu8hhb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 637CC536-07A2-11EC-B824-9BA3EF469F85-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Since the option is internal-only the inconsistency shouldn't
> matter.

OK.

> I'm copying the pattern to handle it as-is from the handling
> of the existing "-o" option in the same function, see 9cf6d3357aa (Add
> git-index-pack utility, 2005-10-12) for its addition.

That is apples-to-oranges comparison, as the original is not even a
long option so it won't be -o=3Dfilename anyway.  So the "i+1" (as
opposed to "i + 1") loses justification.  Since the option is
implementation detail, having to spell its value separately is OK,
though.

> Eventually we'd like to migrate all of this this to parse_options(),
> which would make these differences in behavior go away.

Perhaps, but if it does not matter now, it shouldn't be worth
code-churn later, either.

Thanks.

