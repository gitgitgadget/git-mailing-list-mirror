Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9BAC433C1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 02:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D027861927
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 02:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhC2CGj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 22:06:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62504 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbhC2CGU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 22:06:20 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 12C25BF96C;
        Sun, 28 Mar 2021 22:06:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4nwdgX7Vwd2h
        coPIdL0wvLkHXIQ=; b=FSWdt8MdSHbG8Fn2thmglcBmjrPffoKWr6N9XP3jhy1N
        xrVYg/7MQFyv7gAlnhF0h+nvwpFggOS5v3r553aK+bdG0hUjev636lZgSMlLWdgD
        5S7qQetaJzU60uiUN6E9ydOQ0oCcXSVmfFgLI9owY/FZiU4/1f6qPDKdLyH+cMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=SNmeXl
        nnTmsAqUPh4I46rM3JaDAk8HBHpBiAJSjMmckSyohju9gZjWMpLTGY1FxaarX9Y0
        hgQXI38gdBEa71SyCeYM/eE22Fat3dU5A3n71yTdUIqUoXMh3Q24jTHNEh/js5tm
        3E2hYDr4U7QQaRJznDbwsq542X7ixwFZwobaI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B861BF96B;
        Sun, 28 Mar 2021 22:06:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 723BCBF96A;
        Sun, 28 Mar 2021 22:06:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v6 00/19] fsck: API improvements
In-Reply-To: <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 28 Mar
 2021 15:15:32
        +0200")
References: <20210317182054.5986-1-avarab@gmail.com>
        <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
Date:   Sun, 28 Mar 2021 19:06:17 -0700
Message-ID: <xmqq5z1alnmu.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5A22682E-9033-11EB-80DB-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> To recap on the goals in v1[1] this series gets rid of the need to
> have the rececently added "print_dangling_gitmodules" function in
> favor of a better fsck API to get at that information.

Read the whole series afresh, as well as "git diff @{1}" after
replacing to see what changed since the previous round.  Didn't find
anything iffy.

Unless somebody finds improvement opportunities in the coming couple
of days, let's declare it is good enough and merge to 'next',
polishing incrementally if needed.

Thanks.
