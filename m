Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD4DC83F14
	for <git@archiver.kernel.org>; Wed, 30 Aug 2023 22:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343886AbjH3W4p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Aug 2023 18:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237098AbjH3W4o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2023 18:56:44 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517A110CE
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 15:56:17 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 132F31A03B9;
        Wed, 30 Aug 2023 18:55:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=adKSbhieMNKFhaKIaHibSgUK3w0a5oJxm91JBj
        QKN9g=; b=Bt7XTVyvMo6TJ+J0dLKHyS8Ih+tsneDUCcttN7Z/LsUEScXQTOGASA
        nYWSnna5v7fPi3qBwrEQYX+AoS4v4dGN738uo8rWwzGxzYnEp+hhsnr35tgLGSCX
        IvxbaLjc38F2js87FpNDQBTa3NHndr4xmc1SxE54/kj6Jeu7xw8JY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0BC091A03B8;
        Wed, 30 Aug 2023 18:55:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 72C771A03B2;
        Wed, 30 Aug 2023 18:55:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] replacing ci/config/allow-ref with a repo variable
References: <20230830194919.GA1709446@coredump.intra.peff.net>
Date:   Wed, 30 Aug 2023 15:55:48 -0700
In-Reply-To: <20230830194919.GA1709446@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 30 Aug 2023 15:49:19 -0400")
Message-ID: <xmqq5y4w87ij.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5CE731F2-4788-11EE-8B0D-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This is a more efficient way to do the same thing that
> ci/config/allow-ref does (which didn't exist back then).

Very nice.

> After that, the only useful thing left in the "config" job would be the
> "skip-if-redundant" step. I'm not sure if it will be possible to get the
> same behavior there without spinning up a VM.
>
>   [1/2]: ci: allow branch selection through "vars"
>   [2/2]: ci: deprecate ci/config/allow-ref script
>
>  .github/workflows/main.yml | 10 +++++++---
>  ci/config/README           | 14 ++++++++++++++
>  ci/config/allow-ref.sample | 27 ---------------------------
>  3 files changed, 21 insertions(+), 30 deletions(-)
>  create mode 100644 ci/config/README
>  delete mode 100755 ci/config/allow-ref.sample
