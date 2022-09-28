Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDD0C04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 17:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbiI1Rel (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 13:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbiI1Rej (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 13:34:39 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DEEBB1
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 10:34:34 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B251415472A;
        Wed, 28 Sep 2022 13:34:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Kmo8lMtPldtXzdN1Qq/v7Dic6lIWoVXjlEes8d
        +3x5E=; b=e+MPYeWDTHzW2sUyMhu1wab9fQjW3NsMxtiX5lXXghbERvJ7oj+Fqj
        KopJUrt5AEq1J5tZsiCP/79fHElTOCJNSs00F/iy56IsBfc06vmKSqLJPNgbnS54
        d33LflGFnPfRzIje+7yiwmrxXDbuRDmIjgk8TWLdJNgXCvJ2zMu/4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A7CD5154729;
        Wed, 28 Sep 2022 13:34:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1D7A4154728;
        Wed, 28 Sep 2022 13:34:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, derrickstolee@github.com,
        Phillip Wood <phillip.wood123@gmail.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2] read-cache: avoid misaligned reads in index v4
References: <pull.1366.git.1663962236069.gitgitgadget@gmail.com>
        <pull.1366.v2.git.1664385541084.gitgitgadget@gmail.com>
Date:   Wed, 28 Sep 2022 10:34:32 -0700
In-Reply-To: <pull.1366.v2.git.1664385541084.gitgitgadget@gmail.com> (Victoria
        Dye via GitGitGadget's message of "Wed, 28 Sep 2022 17:19:00 +0000")
Message-ID: <xmqqleq3v1w7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D082C1E6-3F53-11ED-864D-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	/*
> +	 * NEEDSWORK: using 'offsetof()' is cumbersome and should be replaced
> +	 * with something more akin to 'load_bitmap_entries_v1()'s use of
> +	 * 'read_be16'/'read_be32'. For consistency with the corresponding
> +	 * ondisk entry write function ('copy_cache_entry_to_ondisk()'), this
> +	 * should be done at the same time as removing references to
> +	 * 'ondisk_cache_entry' there.
> +	 */

Sounds sensible.  Will replace and merge down to 'next'--- it will
most likely be part of the first batch in the next cycle.

Thanks, all.

