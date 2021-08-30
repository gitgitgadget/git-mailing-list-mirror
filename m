Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457FCC4320A
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B3F660E98
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbhH3VEF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 17:04:05 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56232 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhH3VED (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 17:04:03 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C93FB14F027;
        Mon, 30 Aug 2021 17:03:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0GTMvptkGRZhvAIqWVaZ3UfC0AE2KvXjPEhy+u
        Rwj5w=; b=AfNCvamViGE90mWk1pznEBEcd1YEjfNKbr0G0gCcagRDV9AlRhO3Vc
        v3++K7Dtgev5+kytNffQQo1hLcObkUWaggjAd5ZCcBY7EwcAEncQxkvqEMk/xA87
        2EKHqDwDMXmEtJJmlR76XlNEr4na/oNHJA+DEpS70MiBddAX4FLus=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C1F5914F023;
        Mon, 30 Aug 2021 17:03:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EDDE914F01F;
        Mon, 30 Aug 2021 17:03:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 3/4] refs: drop force_create argument of create_reflog API
References: <pull.1067.git.git.1630334929.gitgitgadget@gmail.com>
        <048e2d17077f89049221e6e4a16b7e4143bc244c.1630334929.git.gitgitgadget@gmail.com>
Date:   Mon, 30 Aug 2021 14:03:05 -0700
In-Reply-To: <048e2d17077f89049221e6e4a16b7e4143bc244c.1630334929.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Mon, 30 Aug 2021
        14:48:47 +0000")
Message-ID: <xmqqh7f63at2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AC96C55C-09D5-11EC-A704-9BA3EF469F85-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> There is only one caller, builtin/checkout.c, and it hardcodes
> force_create=1.

This dates back to abd0cd3a (refs: new public ref function:
safe_create_reflog, 2015-07-21) and it seems that we never acquired
the second caller to this helper.

Makes sense.
