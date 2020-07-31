Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1443BC433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 17:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E27D122B3F
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 17:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gHZROyhJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387635AbgGaRRO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 13:17:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62198 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387688AbgGaRRM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 13:17:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1284D6A69A;
        Fri, 31 Jul 2020 13:17:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YBvKvwlynV7q+dl39Xrnx31gcHo=; b=gHZROy
        hJX9+C2yPSSACAp7wc4W8YTYvUBuhDa62qWpxBdenFfA2mBQ58a3YUjLQAw7TIZz
        Z/bAA4kpK38tVET7qkRi4yvYylT6hfubMTRCVcfLGZuHLcVmoxuMaJhJtMq5tbjX
        zj0hRegrYxTgNQ6ajGZ11Qw+h6AIoqyhzb/+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LLWQ0TMeRg/bFgoQRYEEr6Xbp5Unxwme
        fFv5fFAjJAhBGdzdiOaRSAlgbPCzG+lgl+KJaDJa/ojKDWVGpHniFlIAGH8UTrMM
        rcgc3e3kqxQoCZrdwzvWDA3JMDJl1mnGRFv4+hrTBcQ/i/sikHZf50y1d7brbXkB
        XKxJfWJcOCs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 09D3B6A699;
        Fri, 31 Jul 2020 13:17:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 41F6B6A692;
        Fri, 31 Jul 2020 13:17:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] refs: add \t to reflog in the files backend
References: <pull.688.git.1596195370757.gitgitgadget@gmail.com>
Date:   Fri, 31 Jul 2020 10:17:07 -0700
In-Reply-To: <pull.688.git.1596195370757.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Fri, 31 Jul 2020 11:36:10
        +0000")
Message-ID: <xmqqd04b4nak.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9CE2D9E-D351-11EA-A5B1-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> commit 523fa69c3 (Jul 10, 2020) "reflog: cleanse messages in the
> refs.c layer" centralized reflog normalizaton.  However, the
> normalizaton added a leading "\t" to the message. This is an artifact
> of the reflog storage format in the files backend, so it should be
> added there.

I agree with you that it makes sense to move the logic to add "\t"
before the log message from generic layer to the backend.  Thanks
for spotting and correcting.

Will queue.
