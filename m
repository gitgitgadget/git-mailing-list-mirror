Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2163AC433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 20:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5DDF6121E
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 20:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhDGUmj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 16:42:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65329 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhDGUmf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 16:42:35 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CE02FC2563;
        Wed,  7 Apr 2021 16:42:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+mDuvZMqaRVhqPBwpVukx7t9yH0=; b=t9Fsl2
        v3x/Etr8tURiVG46P6QTMpoBbzrAmFAi5xBPhZpQWu9J43t1b4rzwE8/Dhk8saAZ
        m7B2Nh97heGkQdZdG/HvfGvGGvp6PQgeB8gFjvs5+5ak0LVEHH47GDGNypgVtyuP
        +ufqhM5/NLm24Hmfx/cAuFXwCz3vn7vVGpY70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vwmPd8TZ6big4xwWEC2qykISYgkUHAe9
        3Z3DRIGu9RM6tKs7zNTShcWhIRSJ2XKSNpjwMXcGE9Xa5bJmM8cS7i3VhD8ED+oU
        W4J3HzOCJaAPW3kMUyv28dye7kMi1pAxODfsOTV1NQARIvxFnC0bk7uAnnG5WaIu
        DPMA/7n3GLI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C5B9BC2562;
        Wed,  7 Apr 2021 16:42:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 54F33C2561;
        Wed,  7 Apr 2021 16:42:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ama bamo <pythoncontrol@gmail.com>
Cc:     Santiago Torres Arias <santiago@nyu.edu>, git@vger.kernel.org
Subject: Re: exporting git commands in parsable format for constructing
 language-specific API for git CLI
References: <CAJxd1DPcCD96NSqzXvh3cgA93d1nCNFQbFWduTCqfx1zi_1o=w@mail.gmail.com>
        <YGEMMyAYVlzgv79G@meme-cluster>
        <CAJxd1DNB=OGgNkLHg=2TpQxgWKp1dTcg5vvFXG7+2MS0KyXjJA@mail.gmail.com>
Date:   Wed, 07 Apr 2021 13:42:23 -0700
In-Reply-To: <CAJxd1DNB=OGgNkLHg=2TpQxgWKp1dTcg5vvFXG7+2MS0KyXjJA@mail.gmail.com>
        (ama bamo's message of "Wed, 7 Apr 2021 20:18:31 +0200")
Message-ID: <xmqq4kghzv0w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C2079486-97E1-11EB-9695-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ama bamo <pythoncontrol@gmail.com> writes:

> By following the definition of CLI and API; the CLI is human readable
> while the API is machine readable. If we were able to expose CLI
> in a machine-readable format then would it be an API?

Both input and output for Porcelain commands are subject to change
to improve the end user experience for humans, which may break
scripts that hardcodes the assumption of either the input or the
output at one version of Git.

So no, I wouldn't call that an API.
