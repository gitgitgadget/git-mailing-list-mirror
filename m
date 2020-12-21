Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878F0C433DB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 00:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B27F21D7F
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 00:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgLUAmH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Dec 2020 19:42:07 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61139 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgLUAmG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Dec 2020 19:42:06 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B798A9239;
        Sun, 20 Dec 2020 19:41:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=C9rDsVIq6thx
        y4+l8I5rmvmKZ3Q=; b=KwmUc/WDK4Zlrr/xEz+3wBspxQvmDatJHLu5YvSCSswx
        PII1/IG4sYfUEYytL6irtnOoygcN/FfnXdUaKyrfOv8DbnRtAsTLXnqiFLplS0sp
        9j71lgdJ/JJaaSkuJMRQdGGi6f8284jMPMMqrvmV/7xexJEnVESdKy3IhK5QIDk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=WPQ3UN
        zwYiwm/u476L0vvO/Nmd1Bgbl/Iho6rCwH27gYQPMeg+xCSSqx7AUH/IxNveeJVk
        vMNcBn/oAS5NRIjsyEapLEr9btebXbeYCImLJFIiPZrJsS/qO50iN+wgieyfmslQ
        TJioprY5cBo4KYMWQRfsrXQVPnCdXhSm0l1tU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 62DBDA9238;
        Sun, 20 Dec 2020 19:41:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E2F80A9237;
        Sun, 20 Dec 2020 19:41:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Git List <git@vger.kernel.org>,
        pudinha <rogi@skylittlesystem.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [BUG] Regression in 'git mergetool --tool-help'
References: <CADtb9DyozjgAsdFYL8fFBEWmq7iz4=prZYVUdH9W-J5CKVS4OA@mail.gmail.com>
        <CAMP44s15CJVGRg5Qxcgqq8xVkDhpVyxND67-iQZF9uZ_PRstEQ@mail.gmail.com>
        <xmqqczz6qs0p.fsf@gitster.c.googlers.com>
        <5fddeda8a5a92_1de0de2088a@natae.notmuch>
        <xmqqsg81pvm8.fsf@gitster.c.googlers.com>
        <c4f2330f-715b-1745-5ad7-5477f4e833db@gmail.com>
        <568f42a0-f630-64ca-9f77-183dcaa56d1e@kdbg.org>
        <a9e6f3aa-e88e-6cc2-fb16-c26bdd3bf4d3@web.de>
        <2e7485b6-86d9-4de2-a823-dd84fc7386b0@gmail.com>
Date:   Sun, 20 Dec 2020 16:41:23 -0800
In-Reply-To: <2e7485b6-86d9-4de2-a823-dd84fc7386b0@gmail.com> (Philippe
        Blain's message of "Sun, 20 Dec 2020 18:47:29 -0500")
Message-ID: <xmqqpn34m1n0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4079E52E-4325-11EB-B99C-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Thanks Ren=C3=A9 and Johannes for two additional suggestions; both work=
 correctly.
> Junio, I retried yours and verified my quoting and I confirm it does no=
t work.
>
> I think I prefer Ren=C3=A9's suggestion.
>
> Thanks all,

I see what was wrong with my variant.

We force IFS to be LF and nothing else upfront, which defeats the
attempt to split $variants at SP and turn them into "one token per
line" with "printf '%s\n' $variants | ..."

In any case, I find Ren=C3=A9's variant easier to follow, too. =20

Thanks, all.
