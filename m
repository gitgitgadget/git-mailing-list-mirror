Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51431C4321E
	for <git@archiver.kernel.org>; Thu,  5 May 2022 17:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382236AbiEERFm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 13:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356896AbiEERFh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 13:05:37 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DDB5C84C
        for <git@vger.kernel.org>; Thu,  5 May 2022 10:01:56 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9B9D0179910;
        Thu,  5 May 2022 13:01:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xRW9KbP0te1tsjTtSvnjzx1CQvMXvfOV6dcNgx
        y13XM=; b=qXgt4pnqyXdB6pJecbfTFZnBkj7h5n+ue0zKoGPtYKHzHrk1YIGK/o
        vROzDqqAzSg8UCidfq2Pxxelqfsp3xUKEkN5oVz4PnBnTBfiMpPTREfvQTnbr0Ra
        LXxQFzrg1sdDsD3PociCi/e7g1+RF298kwq0kcIXb2R4UFVwOIXZU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 93A3F17990F;
        Thu,  5 May 2022 13:01:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1AC0717990E;
        Thu,  5 May 2022 13:01:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com, me@ttaylorr.com
Subject: Re: [PATCH v4 3/8] object-store: add function to free object_info
 contents
References: <20220328191112.3092139-1-calvinwan@google.com>
        <20220502170904.2770649-1-calvinwan@google.com>
        <20220502170904.2770649-4-calvinwan@google.com>
        <xmqqzgjztt7s.fsf@gitster.g> <xmqqv8ukkf6o.fsf@gitster.g>
        <CAFySSZB72GTaJRvoGXgfkBE3w6+pYz9QVpGgEcsxy_8EDG-xpg@mail.gmail.com>
Date:   Thu, 05 May 2022 10:01:50 -0700
In-Reply-To: <CAFySSZB72GTaJRvoGXgfkBE3w6+pYz9QVpGgEcsxy_8EDG-xpg@mail.gmail.com>
        (Calvin Wan's message of "Thu, 5 May 2022 09:47:05 -0700")
Message-ID: <xmqqee17gbgh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0F576624-CC95-11EC-B018-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> Apologies for the mistakes. Getting a script from Josh Steadmon to
> make sure these things never happen again :)

Don't fret, mistakes happen.  The static-analysis job is quite picky
and catch these for us.

Sample runs are found here:

https://github.com/git/git/runs/6299058086?check_suite_focus=true
https://github.com/git/git/runs/6295167966?check_suite_focus=true

