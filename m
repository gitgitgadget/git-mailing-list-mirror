Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07D431F462
	for <e@80x24.org>; Tue, 11 Jun 2019 20:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391985AbfFKUgX (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 16:36:23 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53735 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391832AbfFKUgX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 16:36:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BADB868E64;
        Tue, 11 Jun 2019 16:36:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=xtQLRqjYppxU
        +txPDS5Lg5ScsOc=; b=X9K8zapTHZ5D4fyapcVfBy9uSrphPwxXbqGxrPRqEEbi
        IPkpKAet664kgAmKKk+62z9tRXQHcTtToodz0wRjY1Z0pJn5tJA3BudFZo/fDx1v
        v6qnQHyxlPy5Sbx/Vij7Hk7dALtErPE1w25haMoerQd48lzWB1q8TkENlsk1uLk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Fo+r1j
        V1HATWL4oH2SvMe+aCzAvjT6eX5qcqm8WQ6Tv+g9mCZTYGukKTa9BTtN4fF6ik1I
        6jPu1hNAJCZFAmBxRlj57Ygi7CAZakGPB+q0IA5fGPouzj81voF5FY/ooXaxUwiV
        3PBT9V7/1vcxyr34vC93/Oly7xZB0WhF4Yuzw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B2F4F68E63;
        Tue, 11 Jun 2019 16:36:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DE43368E5F;
        Tue, 11 Jun 2019 16:36:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] rebase: fix garbled progress display with '-x'
References: <20190430142556.20921-1-szeder.dev@gmail.com>
        <20190611130320.18499-1-szeder.dev@gmail.com>
        <20190611130320.18499-4-szeder.dev@gmail.com>
Date:   Tue, 11 Jun 2019 13:36:16 -0700
In-Reply-To: <20190611130320.18499-4-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Tue, 11 Jun 2019 15:03:19 +0200")
Message-ID: <xmqq36kflv0f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 91188102-8C88-11E9-B29C-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> -Rebasing (1/4)QRebasing (2/4)QRebasing (3/4)QRebasing (4/4)QSuccessful=
ly rebased and updated refs/heads/missing-commit.
> +Rebasing (1/4)QRebasing (2/4)QRebasing (3/4)QRebasing (4/4)QQ         =
                                                                       QS=
uccessfully rebased and updated refs/heads/missing-commit.
>  EOF

Yuck, ... but I do not see how else/better this test can be written
myself, which makes it a double-yuck X-<

Are we forcing out test to operate under dumb terminal mode and with
a known number of columns?
