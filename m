Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FE1C433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 20:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDD1F61106
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 20:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346136AbhIGUQq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 16:16:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51723 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346321AbhIGUQp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 16:16:45 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A05CFDF8B8;
        Tue,  7 Sep 2021 16:15:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7j2zwMHh6B77
        9W0YJWAgCLwjikmQAxmEkb04Gs9s4c4=; b=GnOQ44/fXDZ2Vn1pDxbHU5MlEbas
        Fz3Vrf7cMqDVKb73KLTy75ZZFap2AWjQTnCnR+endkjTVlg9fEFyGxMCXtD3AKcE
        K/2efEa389Uxc23ORxT1MmMeIhGO90iiyK5eezzJywycfaxamjwRAC5PuFIY/QoC
        P7d8400HDpuxBWk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 961D6DF8B7;
        Tue,  7 Sep 2021 16:15:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 15CA3DF8B5;
        Tue,  7 Sep 2021 16:15:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, lilinchao@oschina.cn,
        Elijah Newren <newren@gmail.com>, jerry@skydio.com
Subject: Re: [PATCH v2] apply: resolve trivial merge without hitting
 ll-merge with "--3way"
References: <xmqqczr26i9f.fsf@gitster.g>
        <20210905190657.2906699-1-gitster@pobox.com>
        <87pmtlnyu7.fsf@evledraar.gmail.com>
Date:   Tue, 07 Sep 2021 13:15:37 -0700
In-Reply-To: <87pmtlnyu7.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 06 Sep 2021 23:59:42 +0200")
Message-ID: <xmqqy2889m6u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5DD414EE-1018-11EC-B3DB-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Partly this is cleaning up a mess after an existing test, but here
> there's no reason we can't use test_when_finished() for all the new
> tests to make them clean up after themselves:

I do not mind if somebody wants to send in a janitorial patch after
the dust settles, but adding "test_when_finished reset --hard" after
each "refs --hard" at the beginning of each test is not something I
would expect to see.  Such a patch should first choose between "each
test cleans after itself" and "expect previous ones may have left a
mess, so each test clears the slate sufficiently before it starts"
and then stick to the approach, not mixture of both, I would think.

Thanks.
