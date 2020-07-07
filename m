Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72033C433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 04:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34D0720722
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 04:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QA3I6RSn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgGGEkM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 00:40:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54918 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgGGEkM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 00:40:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BF2E569A2B;
        Tue,  7 Jul 2020 00:40:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VnYsrvhK7HIO+LFibT2NdMMI1oY=; b=QA3I6R
        SnMqyiJdbMiwLSWGVzKWiSqDWEj0Oq9DA/RW43U4m9mn8U589TQSGDC+0V1fhLCK
        maMvMGLQyXSo5+kWw1sReExdrmL6bc2++rVFC48aGdLM4Augl8oGbJkxLmg8rngN
        V6QKfzN0BXr6uzX0SAMM+JIRlTAHeRscN1pTM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DGMF1vg8lDWCzCmDzhDL2mJUjMAuY4PD
        k95WR0GzXVR8ELqvtbrHo1BqtmeHdNHO4UbeWg6u0eEGDvNi8gKlbNDo7sQYwu2v
        UboCwjNCAGZJPWIWeS465dZ1yNt1VksFNVGxIv9F4wms/JZ5kfrO8EwbnhQ4lqAm
        x/B0CGZw9JY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9890B69A2A;
        Tue,  7 Jul 2020 00:40:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C605969A28;
        Tue,  7 Jul 2020 00:40:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 0/4] Preliminary fixes for reftable support
References: <pull.669.git.1593518738.gitgitgadget@gmail.com>
Date:   Mon, 06 Jul 2020 21:40:07 -0700
In-Reply-To: <pull.669.git.1593518738.gitgitgadget@gmail.com> (Han-Wen
        Nienhuys via GitGitGadget's message of "Tue, 30 Jun 2020 12:05:34
        +0000")
Message-ID: <xmqqmu4c6iqg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EFCA8EFE-C00B-11EA-BA40-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> These are assorted small fixes split out from the reftable topic.
>
> Han-Wen Nienhuys (4):
>   lib-t6000.sh: write tag using git-update-ref
>   t3432: use git-reflog to inspect the reflog for HEAD
>   checkout: add '\n' to reflog message
>   Treat BISECT_HEAD as a pseudo ref
>
>  builtin/bisect--helper.c       | 3 +--
>  builtin/checkout.c             | 5 +++--
>  git-bisect.sh                  | 4 ++--
>  t/lib-t6000.sh                 | 5 ++---
>  t/t3432-rebase-fast-forward.sh | 7 ++++---
>  5 files changed, 12 insertions(+), 12 deletions(-)

Thanks for splitting these out, and sorry for not being able to get
to them earlier.

Will queue.

