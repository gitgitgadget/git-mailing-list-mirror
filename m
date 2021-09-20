Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80584C433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 20:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D8A2611ED
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 20:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhITUB5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 16:01:57 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59310 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345230AbhITT7y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 15:59:54 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AB301148D18;
        Mon, 20 Sep 2021 15:58:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DXXdmEMS/p/TqIuQ0wqvey+g82amSejzsSiHYN
        49+RA=; b=qN/iGfkZH3glGn2fqZNj+x9g0gmRZXVLiJtLmYjq48MDAJVFyiEKA/
        bXrP1pTA4OszBetXA7y7C3wWHkpZDhLDUf0UqbSSI/M68+ZiPOv3PfkdDF6apitx
        ivkp061a+WGzpCEeFg7d5N7HksU2CAfDUbmdAHKnSLtGYXUqgSHoY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A2CDA148D17;
        Mon, 20 Sep 2021 15:58:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 14FCE148D14;
        Mon, 20 Sep 2021 15:58:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Cc:     avarab@gmail.com, christian.couder@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, jrnieder@gmail.com,
        kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: Re: [PATCH v2 5/8] submodule: move core cmd_update() logic to C
References: <20210907115932.36068-1-raykar.ath@gmail.com>
        <20210916103241.62376-1-raykar.ath@gmail.com>
        <20210916103241.62376-6-raykar.ath@gmail.com>
Date:   Mon, 20 Sep 2021 12:58:23 -0700
In-Reply-To: <20210916103241.62376-6-raykar.ath@gmail.com> (Atharva Raykar's
        message of "Thu, 16 Sep 2021 16:02:38 +0530")
Message-ID: <xmqqa6k7aujk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1D7AD948-1A4D-11EC-B8E6-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atharva Raykar <raykar.ath@gmail.com> writes:

> This patch completes the conversion past the flag parsing of
> `submodule update` by introducing a helper subcommand called
> `submodule--helper update`. The behaviour of `submodule update` should
> remain the same after this patch.
> ...
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Shourya Shukla <periperidip@gmail.com>
> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
> ---

This seems to overlap with Emily's 242655f2 (submodule: record
superproject gitdir during 'update', 2021-08-19) that came in
<20210819200953.2105230-5-emilyshaffer@google.com>.

Should I expect there probably needs a few more iterations for this
topic?  Depending, the "a submodule knows which superproject it is
part of" topic may have to be done in C on top of this topic.

I'll eject the 'es/superproject-aware-submodules' topic for now,
just to get today's integration going.

Thanks.

