Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392A1EB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 20:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjFUU5d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 16:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjFUU50 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 16:57:26 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD261BD4
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 13:56:53 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 59EF019E7DC;
        Wed, 21 Jun 2023 16:56:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HrNvfUQM+gpesMySsLnbBaoB9KFtU+DS3FhlOC
        H1G8U=; b=M1zVp0GynFO4ApLRqFdyWWSiVlekEHKjvgiUQ2uDsI+mUB3pHJpReQ
        RBdJoUpo0ZpcRJXyeWbbdJXZ2mvvXH5oP06DovTHBnC3Nob2iF4eHb8JsmilXzZN
        QrCnkN7EJSBUU+8gXXKLX6nJjmkJ/tanilyaxC8PX47O8YXcopQCo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 52C0E19E7DB;
        Wed, 21 Jun 2023 16:56:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B257E19E7DA;
        Wed, 21 Jun 2023 16:56:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 0/3] revision: refactor ref_excludes to ref_visibility
References: <pull.1515.git.git.1687376112.gitgitgadget@gmail.com>
Date:   Wed, 21 Jun 2023 13:56:13 -0700
In-Reply-To: <pull.1515.git.git.1687376112.gitgitgadget@gmail.com> (John Cai
        via GitGitGadget's message of "Wed, 21 Jun 2023 19:35:09 +0000")
Message-ID: <xmqqy1kcfsb6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0F82A7E6-1076-11EE-9C1E-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The ref_excludes API is used to tell which refs should be excluded. However,
> there are times when we would want to add refs to explicitly include as
> well. 4fe42f326e (pack-refs: teach pack-refs --include option, 2023-05-12)
> taught pack-refs how to include certain refs, but did it in a more manual
> way by keeping the ref patterns in a separate string list. Instead, we can
> easily extend the ref_excludes API to include refs as well, since this use
> case fits into the API nicely.

Hmph, how would this interact with the other topic in flight that
touch the ref exclusion logic tb/refs-exclusion-and-packed-refs?

Thanks.
