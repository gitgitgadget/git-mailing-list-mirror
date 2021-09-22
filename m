Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED01EC433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 23:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D267E611C4
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 23:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238438AbhIVXaV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 19:30:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55762 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbhIVXaT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 19:30:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B69FFFB60;
        Wed, 22 Sep 2021 19:28:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WxBZzX5gwSPUZdbgdo5J1Q1VoUdaTNCK1/1DoT
        /ycRE=; b=dXkMdQCr6PS4vvFS+yfD4/tYc2vKqCvvH2uZ5K69Jn4WN7BQ2GL234
        q4uV+o/VGr06HYbcJUK9K96/dN9z/q6pB/CCf6UADzN8HNm/RecqK5f93tNZeeCU
        0sL8opWdjTs9ExyXT3T0E4FgzBx1nIDvuwIBs6LUabYCliQZN9uUw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5F4CBFFB5F;
        Wed, 22 Sep 2021 19:28:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BD131FFB5E;
        Wed, 22 Sep 2021 19:28:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH 0/3] Makefile: make "sparse" and "hdr-check" non-.PHONY
References: <cover-0.3-00000000000-20210921T224944Z-avarab@gmail.com>
        <YUqQzn5vFDpbF5dM@coredump.intra.peff.net>
        <c13b050c-abb9-c669-b92c-930f2b43ce10@ramsayjones.plus.com>
        <YUttpgkU6eCOxMj/@coredump.intra.peff.net>
        <82c3d9fc-32ff-c38a-cb44-873af1fb83d1@ramsayjones.plus.com>
Date:   Wed, 22 Sep 2021 16:28:46 -0700
In-Reply-To: <82c3d9fc-32ff-c38a-cb44-873af1fb83d1@ramsayjones.plus.com>
        (Ramsay Jones's message of "Wed, 22 Sep 2021 20:17:16 +0100")
Message-ID: <xmqqsfxw42c1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D6036B14-1BFC-11EC-84E1-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>>> At the heart of my unease is dependencies (or rather the lack) for
>>> the 'synthetic object files' *.hco and *.sp. (Also, the addition
>>> of even more 'shrapnel' to the build directories - I wrote a patch
>>> to remove the useless *.hcc files just after commit b503a2d515e was
>>> included, but didn't get around to submitting it).
>> 
>> I don't consider them shrapnel if they're holding useful results. :)
>
> Heh, yes I am a bit of a curmudgeon! :D

We do not necessarily have to have these files immediately next to
the corresponding source file.

For example, we could give .shrapnel/ hierarchy to *.hco and *.sp
files, so that for revision.c and compat/bswap.h, we'd create
.shrapnel/revision.sp and .shrapnel/compat/bswap.hco files that will
not be so cluttering ;-)


