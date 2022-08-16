Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7747EC25B0E
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 15:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbiHPPKc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 11:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiHPPKX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 11:10:23 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1197531DF2
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 08:10:21 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 142C1130EF3;
        Tue, 16 Aug 2022 11:10:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZNiCmguworwBjXLVNJ5I/zfDxpN/QtWm9oifeg
        VZI1E=; b=OYG3xRda/JRdG2RBsCss/1OnN4AjQ8LkZ8OPIQCZgODF35+YHTnQqA
        PBcdUiaF2su05FXoYotjb5brQeVdgd6StJJGWhq3eCJ3F7WD7XV2bKDaVV6qvMMm
        miM3XNPkjEyv62vzZQPgOeeCy73V3ePYjZGw5iBpEihb9C5VK/hWs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0BFC9130EF2;
        Tue, 16 Aug 2022 11:10:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 67CAC130EF1;
        Tue, 16 Aug 2022 11:10:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/5] add -p: avoid ambiguous signed/unsigned comparison
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
        <4d24a4345ba66031d2ccf7ce472ed93ace82e9d6.1660143750.git.gitgitgadget@gmail.com>
        <xmqq7d3gm1bl.fsf@gitster.g>
        <r1461365-9np6-n988-0288-9ps4o944qqp4@tzk.qr>
Date:   Tue, 16 Aug 2022 08:10:19 -0700
In-Reply-To: <r1461365-9np6-n988-0288-9ps4o944qqp4@tzk.qr> (Johannes
        Schindelin's message of "Tue, 16 Aug 2022 11:56:02 +0200 (CEST)")
Message-ID: <xmqqr11gxm04.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8B56B5C8-1D75-11ED-874B-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The scope of this patch series is to fix running the tests in Visual
> Studio when building using CMake.

That's only the perspective of who cares about VS+CMake.  From my
point of view who wants a healthy Git overall, the priority is
different.  "add -p" fix is wider than the context of VS, and I do
not discount the need that we need to fix it before we can call
VS+CMake issue fixed (and I do not mean to say it is unnecessary to
fix VS+CMake).  It's just this one can proceed with help by those
who do not care about or have no environment to help with VS+CMake
because it is more generic, and I do not think you mind to make the
rest of the narrower VS+CMake topic _depend_ on it.

> Pulling out this patch would break that patch series because it would
> leave that breakage in place.

We deal with topic that depends on another topic all the time, and I
do not think there is anything that makes VS+CMake topic so special
that it cannot be dependent on another topic.  It's just the matter
of splitting this out and make it [1/1], and make the remainder to
[1-4/4] and mark them rely on add-p fix when you send the latter
out, isn't it?  Puzzled...

Thanks.

