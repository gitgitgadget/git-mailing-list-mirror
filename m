Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96173C4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 17:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83A8B6101B
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 17:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbhG1RIp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 13:08:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51629 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbhG1RIj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 13:08:39 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D903AD8C90;
        Wed, 28 Jul 2021 13:08:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rblwt92zb4vpHEE5/KslX7bn2f7Jb/sy75JH2V
        Wj9+s=; b=dpH56UcuwLBdsbnH5mNgGYw8Wo+mkG0qeCEa5KQlJkFoAEWGZK7jpo
        OB+oktodBtKkBNhwh3wkO9sCGr08R/wvXH1vYPr9IJKH5H23Q1MTtcog0dWo+L5z
        KpdWjCpzXWglvdzC101f6MzljhLR+0FBKjaankSXIO/o+iUwcl/Vw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D08E2D8C8F;
        Wed, 28 Jul 2021 13:08:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4C286D8C8D;
        Wed, 28 Jul 2021 13:08:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 4/5] Use a better name for the function interpolating
 paths
References: <pull.66.v2.git.1625155388.gitgitgadget@gmail.com>
        <pull.66.v3.git.1627164413.gitgitgadget@gmail.com>
        <19fd9c3c803a300b586c76736301a7379c4c6226.1627164413.git.gitgitgadget@gmail.com>
        <xmqqh7gghgtd.fsf@gitster.g>
        <99332fdf-24af-8938-2f55-b6e25ca12aad@gigacodes.de>
        <xmqqfsvzcqmo.fsf@gitster.g> <xmqq8s1rcn0t.fsf@gitster.g>
        <xmqq4kcfclw8.fsf@gitster.g> <xmqqczr3at7n.fsf@gitster.g>
        <6fdc3b2f-6135-d540-1868-080a423af0e8@gigacodes.de>
Date:   Wed, 28 Jul 2021 10:08:35 -0700
In-Reply-To: <6fdc3b2f-6135-d540-1868-080a423af0e8@gigacodes.de> (Fabian
        Stelzer's message of "Wed, 28 Jul 2021 10:18:59 +0200")
Message-ID: <xmqqzgu69xik.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7230E1E6-EFC6-11EB-90D6-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> ok, funny issue. in the ssh test setup i generated a few ssh keys for
> testing and (wanting to be clever) concatenated them with a prefixed 
> principal into an allowedSigners file using find & awk.
>
> Turns out the directory entries in /dev/shm are the other way around.

Good finding.  Yes, relying on the order "find" discovers filesystem
entities is asking for trouble.

> I'll change the test setup code to do this statically for each
> key. Not such a good idea to rely on the file order in the dir anyway.

Thanks.
