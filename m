Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD96EE020A
	for <git@archiver.kernel.org>; Wed, 13 Sep 2023 19:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbjIMToT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Sep 2023 15:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbjIMToO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2023 15:44:14 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5421C19B6
        for <git@vger.kernel.org>; Wed, 13 Sep 2023 12:44:10 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CC02D1C3B7;
        Wed, 13 Sep 2023 15:44:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=qCbOE8MBHWJX5hDmhW4GYEfKUIa5fGPsTS6O1Y
        +RkZQ=; b=dxTIR8KVNBt2uEtDfBPl0y8HYQwJ6hTKfbVC/qCYzxtGnH/8My6MdP
        K4fkDV+tz56m0txzccyvUnhK4lNdppU1pqzg9q3dEwqh5yU7sAE4SfR+JmfLPoh9
        innvuST5Q/PHtIHmQmOr0s/xuxboYiXrKvfFWy+X5MJ6lWNC9gQro=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C4B2C1C3B6;
        Wed, 13 Sep 2023 15:44:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5DAD61C3B5;
        Wed, 13 Sep 2023 15:44:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 0/8] repack: refactor pack snapshot-ing logic
In-Reply-To: <cover.1694632644.git.me@ttaylorr.com> (Taylor Blau's message of
        "Wed, 13 Sep 2023 15:17:32 -0400")
References: <cover.1693946195.git.me@ttaylorr.com>
        <cover.1694632644.git.me@ttaylorr.com>
Date:   Wed, 13 Sep 2023 12:44:04 -0700
Message-ID: <xmqqa5tpluyj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E65051FE-526D-11EE-96E4-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Here is a small reroll of my series to clean up some of the internals of
> 'git repack' used to track the set of existing packs.
>
> Much is unchanged from the last round, save for some additional clean-up
> on how we handle the '->util' field for each pack's string_list_item in
> response to very helpful review from those CC'd.

The change to [7/8] was as expected and looking good.  Let's see if
we see additional reviews from others, plan to declare victory and
merge it to 'next' by early next week at the latest, if not sooner.

Christian, your cc/repack-sift-filtered-objects-to-separate-pack
topic will have to interact with this topic when merged to 'seen',
so it would be good for you to give a review on these patches (if
only to understand the new world order) and optionally make a trial
merge between the two to see how well they work together and what
adjustment will be needed when you eventually rebase your topic on
top.  Actual rebasing can wait until this topic graduates, but trial
merge is something you can immediately do in the meantime to prepare
for the future.

Thanks.
