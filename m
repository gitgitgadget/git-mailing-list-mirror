Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECA9C433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 21:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17C5D207D8
	for <git@archiver.kernel.org>; Wed, 27 May 2020 21:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gOzoMh8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgE0VvE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 17:51:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59569 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgE0VvD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 17:51:03 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 76A65500E2;
        Wed, 27 May 2020 17:51:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4uXPDGer2tZReD+0zVsZcJlWkEk=; b=gOzoMh
        8Gdn02YsSSF3Cgrt8TtMNu42sjksE69kXZuVygtGfJ5OJFRYXJI2S7dgcjVUrF3M
        mHN2pDr+pGrjOfIsDDdb/mYTl8I7rP1DD0t0zART88i+b50KuUHBsypywVBfPqel
        2NmFDLQ5Bfl10KDg7gsB1Rtt3/Ym/YLqPDNSw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rio9/JGvacCbRRwTFJWZp72C+wY7dAHK
        YDyIZopYkRtWVkgBqQu2WEFBvYSwNbaLiUPkj6LbT1zTUreNJilqLayw3CQ9aLLq
        On4akkXQZmQ1yhNf5fUY/p5g6SBgA10f3QNbcBLI9n0VR/OIdNOOBG0Fqk2LG7Ah
        z8aSx7esKXo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6EDE8500DF;
        Wed, 27 May 2020 17:51:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E7BD2500DE;
        Wed, 27 May 2020 17:51:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Merlin =?utf-8?Q?B=C3=BCge?= <toni@bluenox07.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] checkout -p: handle new files correctly
References: <pull.646.git.1590613746507.gitgitgadget@gmail.com>
Date:   Wed, 27 May 2020 14:51:01 -0700
In-Reply-To: <pull.646.git.1590613746507.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Wed, 27 May 2020 21:09:06
        +0000")
Message-ID: <xmqqwo4xjbcq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28309DC8-A064-11EA-9B2E-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> This also fixes the problem where added _empty_ files could not be
> staged via `git checkout -p`.

Nice.  Will queue.

>     For ease of backporting, this patch is based on js/add-p-leftover-bits.

Yup, I agree that it would be a sensible fork point.
