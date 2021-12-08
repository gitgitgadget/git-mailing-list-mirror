Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6981C433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 04:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244192AbhLHERS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 23:17:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54321 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbhLHERR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 23:17:17 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7BC3410D51F;
        Tue,  7 Dec 2021 23:13:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nUCys+EWHpuq8pqUFWXsYvNqBSE3zhXvnvKibo
        Qxa0g=; b=rABuEvkdueJV5py2ZbX5C5pT8DzUWG+iiKzpjJRhYBIhS5lHkEt+50
        rGJilubvTbou9br1DsWnBTp2HMxSQyP8KgVRjZujtxiJxO2WZVsoXV5wWVQHi/dl
        aANfDRPqQmmhptVaHBc7ckKCNgVdsuRK6UO9uKT5QMY0Ie5pBdgFs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7307F10D51E;
        Tue,  7 Dec 2021 23:13:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DA73610D51D;
        Tue,  7 Dec 2021 23:13:44 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 10/10] reftable: make reftable_record a tagged union
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
        <8deccc3a1dff7e4f7d613fa63d2781fd1f11f841.1638899124.git.gitgitgadget@gmail.com>
        <xmqqlf0w5bbc.fsf@gitster.g>
        <YbAVOtYXA1Hf9EtJ@coredump.intra.peff.net>
Date:   Tue, 07 Dec 2021 20:13:43 -0800
In-Reply-To: <YbAVOtYXA1Hf9EtJ@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 7 Dec 2021 21:15:22 -0500")
Message-ID: <xmqq4k7j68eg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C163064-57DD-11EC-88C1-E10CCAD8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> error: ISO C99 doesn't support unnamed structs/unions [-Werror=pedantic]
>
> Hmm. It's interesting that the regular DEVELOPER=1 doesn't catch this.
> It's because we don't specify -std there, and newer gcc defaults to
> gnu17 (unnamed unions appeared in c11, I think). I wonder if it would be
> helpful to teach config.mak.dev to pass -std=c99.

FWIW, I use -std=gnu99 as our Makefile suggests.
