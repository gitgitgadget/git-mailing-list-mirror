Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14145C4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 19:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE7FD60F11
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 19:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhHLTOR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 15:14:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56158 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbhHLTOL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 15:14:11 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B0833D612B;
        Thu, 12 Aug 2021 15:13:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eEdttUOEsHFJhnazuz/lUlSNM9YVFwOXuHluRS
        S+3M4=; b=lBJN/bwZ9yMC1xzmacDBR9sft2j8x82UCiUsPC7/zOyFrXu/3wivda
        Re6/HTFO0x2jmq5zsYPZ9mOB0THTHJdBnf/Ns8iqW706ploL9rACpa86maRQr/qJ
        elnC2E4STIcR8uNPXcgIU5dspkXRaendOEYcN822rUi17+vdPXNQI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A7204D612A;
        Thu, 12 Aug 2021 15:13:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 25F75D6128;
        Thu, 12 Aug 2021 15:13:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        phillip.wood123@gmail.com
Subject: Re: [PATCH v2] sequencer: advise if skipping cherry-picked commit
References: <4d83766ab3425a5f4b361df2ac505d07fefd7899.1628109852.git.steadmon@google.com>
        <496da0b17476011b4ef4dde31593afc7572246eb.1628623058.git.steadmon@google.com>
        <c185a396-c498-b2ef-1c86-cec7d5751f3d@gmail.com>
Date:   Thu, 12 Aug 2021 12:13:44 -0700
In-Reply-To: <c185a396-c498-b2ef-1c86-cec7d5751f3d@gmail.com> (Philippe
        Blain's message of "Thu, 12 Aug 2021 13:45:58 -0400")
Message-ID: <xmqqtuju328n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A01891C-FBA1-11EB-97C0-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Since your proposed changes are in sequencer.c, this will only affect
> the default "merge" rebase backend, and not the older 'apply' backend. I think
> it might be worth mentioning this in the commit message.

It shouldn't be too hard to teach "format-patch --cherry-pick" to
report when commits are actually dropped.  There isn't necessarily a
need to give help to users what to do to apply the same change
twice, but even for those who _know_ how to do so, they need to know
if commits are dropped in the first place.  And such a notice is useful
for any user of the --cherry-pick feature of format-patch, not just
as an implementation detail of "git rebase".



