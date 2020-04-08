Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A51C2D0F4
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 21:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B3D2078E
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 21:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iHj2Wg3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgDHVgA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 17:36:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58876 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgDHVgA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 17:36:00 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 94F2960925;
        Wed,  8 Apr 2020 17:35:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/cNnBM5ZCy2CqInqQYOzLvrv5ek=; b=iHj2Wg
        3orUBPyNkYxASHiwtPEXusFh8rpMhkgAPTMvN7IqwhnD6pnSPTJ2LxqED6/t6Ukd
        pSHW8VGPw+Ris+/yjc4jTt3pCaDzuDlUgX85Xc5PBCNRwFMwSE8ToGQ42AmK8AiO
        mI9kNYRKqSGE8licJ+Nm2a4fGRIZrpUD9hfz4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CO4q3g4i72qM8TcNMEJ8t2Y9j25ndC9+
        tD94qdnamKmIqC95Zgh1bi25dqfs187VdVh9BUIF2r//jcpuE7JW3eFs9hwVP+di
        pIbnM0UIINMUqWfXzpXUjvn/Q7KwmpRsPOUPfhdZXoSocYsgaQq4A5/aiWCBeVP8
        j6FfJzN14ZM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8BE0E60922;
        Wed,  8 Apr 2020 17:35:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E9D8B60920;
        Wed,  8 Apr 2020 17:35:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] revision: --include-diversions adds helpful merges
References: <pull.599.git.1586308923544.gitgitgadget@gmail.com>
        <xmqqv9mapxw9.fsf@gitster.c.googlers.com>
        <5f1c6868-303c-ccc1-553e-e54d0fa8e24f@gmail.com>
        <74562b04-b1ce-cad4-da18-4af030a3dc29@gmail.com>
        <xmqqzhbloj4u.fsf@gitster.c.googlers.com>
        <20200408200526.GA2270445@coredump.intra.peff.net>
        <9eab6c60-3c99-d6ac-9206-02ce37f7a479@gmail.com>
Date:   Wed, 08 Apr 2020 14:35:58 -0700
In-Reply-To: <9eab6c60-3c99-d6ac-9206-02ce37f7a479@gmail.com> (Derrick
        Stolee's message of "Wed, 8 Apr 2020 16:22:21 -0400")
Message-ID: <xmqqv9m9oe2p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EFBA4696-79E0-11EA-AB14-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Then I suppose we should focus on naming merge commits with this property:
>
>   A merge commit that is not TREESAME to its first parent (but is TREESAME
>   to a later parent).
>
> The part in parentheses may be optional, because a merge commit that is
> not TREESAME to any parent will be included by every history mode.

A merge that is TREESAME to its first parent does not introduce
anything new to the mainline (as far as the paths that match the
pathspec are concerned).  We are trying to find names to call merges
that are not those no-op merges.  Hmph...

> In my latest attempt at documentation, I called these merges "diverters"
> yet still used "--include-diversions". Here are a few other words that we
> could use:
>
>  * diverters or diversions
>  * redirects
>  * switches (think railroad switch). Synonym: exchange
>  * detours

...none of the above tells me that they are not no-op (in other
words, they do something meaningful), so I must be coming from
a direction different from you are.  What redirects from what other
thing, for example?


