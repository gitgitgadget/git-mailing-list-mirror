Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAA1C433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 20:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24D1960E09
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 20:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237808AbhIVU76 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 16:59:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57484 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237786AbhIVU75 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 16:59:57 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 186EBFEDAF;
        Wed, 22 Sep 2021 16:58:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yYg94Jo14BnOlItbZDn0BTIG0pDfmCbggNpwHq
        GtXOg=; b=S7GlDEB7pkSFoU6evjzgI/v6vy4shutIvx7arjZJoG1Mjc1BBfcufn
        BouZ3y0ePnNoIWHEBRLa8FR0DhHxsT5GbytmKGgkGBWfVQOfACVxAyH0lBsCLvbk
        lDYVKDxWj5PnuxOCoEM062U5gfhzWDE4ciF1m2uD5InkSp1kkPI2Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0FC27FEDAE;
        Wed, 22 Sep 2021 16:58:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 73B59FEDAD;
        Wed, 22 Sep 2021 16:58:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
        wolf@oriole.systems
Subject: Re: [PATCH] rev-parse: fix mismatch quoting of separator in the
 message
References: <20210922111744.675326-1-bagasdotme@gmail.com>
        <YUtqp+1Mwl2v0kuh@nand.local> <xmqqzgs45s15.fsf@gitster.g>
        <YUuHP41V9m7cIEBL@nand.local> <87bl4k7532.fsf@evledraar.gmail.com>
        <YUuNOcqClVjQamYh@nand.local>
Date:   Wed, 22 Sep 2021 13:58:25 -0700
In-Reply-To: <YUuNOcqClVjQamYh@nand.local> (Taylor Blau's message of "Wed, 22
        Sep 2021 16:08:25 -0400")
Message-ID: <xmqqfstw5nv2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D4E705E8-1BE7-11EC-94B0-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> I agree. But for what it's worth, I think we should:
>
>   - accept patches, such as this one, which move things in a positive
>     direction
>
>   - not spend a ton of time or reviewer bandwidth on conversions
>     throughout the tree
>
> In other words, I'm happy to see patches like this, or little clean-ups
> along the way in related areas, but I would be unhappy to see a massive
> patch to change all instances from one to the other.

Oh, absolutely.  But let's not accept a small patch that swaps one
bad style `--' to another bad one `--`, which does not improve
anything.

