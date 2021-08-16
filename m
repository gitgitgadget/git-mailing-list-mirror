Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F63FC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 18:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1676660F39
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 18:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhHPSxU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 14:53:20 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56680 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbhHPSxT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 14:53:19 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3A18A14E90D;
        Mon, 16 Aug 2021 14:52:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PHMQahRb4oKcHeuFGw9xM9DGiJo3/F+MC56k0i
        3K3xY=; b=jMvj2glxLdL6gFJghj1YVczCyf1m4vjR5LBZudbipZixu+VfsAQJoi
        lgsi4bPmx76OWLgI6DmQZhwDB59J86u2XSLyoK1D1/3sDDCupp/f4VtKnBHHdWc4
        XdmSE2YvJ2HYB8Sb6wUwwyFcRkVxbKEtVXG/XiAdZZPPVmZXJkc1k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 337AE14E90C;
        Mon, 16 Aug 2021 14:52:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6D4BB14E908;
        Mon, 16 Aug 2021 14:52:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Ben Goldberg <ben@benaaron.dev>, git@vger.kernel.org
Subject: Re: send-email issue
References: <24a88faf-5339-8449-80c4-f6085bd1e098@benaaron.dev>
        <b4b1dda4-6bf7-f4b1-88c5-9d579a7c56d3@benaaron.dev>
        <20210813180056.ctzivmakj4bj5apa@nitro.local>
        <xmqq35rbtx84.fsf@gitster.g>
        <20210816131143.6ifcbpxp6ilo2nv5@nitro.local>
        <YRqQJTyBW6j6b2pW@coredump.intra.peff.net>
        <xmqq4kbps58l.fsf@gitster.g>
        <YRqY4Tw4YxbepuFg@coredump.intra.peff.net>
Date:   Mon, 16 Aug 2021 11:52:42 -0700
In-Reply-To: <YRqY4Tw4YxbepuFg@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 16 Aug 2021 12:57:05 -0400")
Message-ID: <xmqqzgthql1h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 24374244-FEC3-11EB-8572-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This is certainly unfortunate, but IMHO is not a hard requirement for
> adding new values. This is no different than a case where we add a new
> config option, but old versions of Git quietly ignore it.
>
> In other words, I would suggest to tighten this as the values are added,
> but not worry about having a "spreading" period.

I would have agreed with you even in April if this knob were not
about security.  Thinking that the user is asking for an encrypted
connection and silently getting an unencrypted connection is not
such a good thing, and advertising "we now improved the distinction
between smtps and starttls easier to express" to users would not
work well in that context.

