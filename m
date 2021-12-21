Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52ACC433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 23:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbhLUXUs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 18:20:48 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54093 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbhLUXUq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 18:20:46 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A789C1593AE;
        Tue, 21 Dec 2021 18:20:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3QAe0BvbOZRLz5HSzy8dQ1wPdmhMD+S1YSe8mX
        96C+M=; b=sza5tM2CIR29Y89OHdAir5myMo0g1nTo+j5C3DpIlV6b3UABKWlX92
        SE7i3HYN6LtGFwT+QUlaaaG6FMww7GeVNeNT80P0BJzhFyAXQ7/6AgIVt+hdrsku
        r0ZKzcTSWVDyvMytjvMsJbcHBIv3nyriiekGQGp9HZJg9OA2yXLJ4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A0C031593AD;
        Tue, 21 Dec 2021 18:20:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DE5F51593AC;
        Tue, 21 Dec 2021 18:20:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Neeraj Singh <nksingh85@gmail.com>
Subject: Re: [PATCH 0/9] Add a new --remerge-diff capability to show & log
References: <pull.1103.git.1640109948.gitgitgadget@gmail.com>
Date:   Tue, 21 Dec 2021 15:20:40 -0800
In-Reply-To: <pull.1103.git.1640109948.gitgitgadget@gmail.com> (Elijah Newren
        via GitGitGadget's message of "Tue, 21 Dec 2021 18:05:39 +0000")
Message-ID: <xmqqsfulo88n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D98635C-62B4-11EC-927D-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Here are some patches to add a --remerge-diff capability to show & log,
> which works by comparing merge commits to an automatic remerge (note that
> the automatic remerge tree can contain files with conflict markers).
>
> Changes since original submission[1]:
>
>  * Rebased on top of the version of ns/tmp-objdir that Neeraj submitted
>    (Neeraj's patches were based on v2.34, but ns/tmp-objdir got applied on
>    an old commit and does not even build because of that).

Oh, that's bad.  I wish people do not rebase their updates on top of
newer 'master' only for the sake of it, once an older version is
queued.

>  * Modify ll-merge API to return a status, instead of printing "Cannot merge
>    binary files" on stdout[2] (as suggested by Peff)

I wondered if we want to do the same for other error messages to
give callers greater control, but this change by itself already
looks quite good.

>  * Make conflict messages and other such warnings into diff headers of the
>    subsequent remerge-diff rather than appearing in the diff as file content
>    of some funny looking filenames (as suggested by Peff[3] and Junio[4])

OK.

>  * Sergey ack'ed the diff-merges.c portion of the patches, but that wasn't
>    limited to one patch so not sure where to record that ack.

On that single patch?

