Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB91C433EF
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 22:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245602AbiCNW2E (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 18:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245636AbiCNW17 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 18:27:59 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D863D4B9
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 15:26:49 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B49091127FE;
        Mon, 14 Mar 2022 18:26:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O0bF4+ZV2/Eh6LC+Lnv/63mqNnMpcyBQNHZhgY
        FfQ3M=; b=Qh+1cGtw1rYR5JqX8E9pG5l5gib5ckslnAbiuBSgh5sADEijCWg4s8
        /01oA3yA3zL2mSnU8PVFowVzRPSjTNvToTD9NkY74YHKv7dwASOoxy/MPyKaw5jr
        CzSPCsdwJ9syxjIzzFSot/Ey8AaoVE06M0noMzEzExP8lKn3CChqg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A93A01127FD;
        Mon, 14 Mar 2022 18:26:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0BF4B1127FC;
        Mon, 14 Mar 2022 18:26:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 2/2] repack: add config to skip updating server info
References: <659d5528df56f6b9aece6b1f3c4e2e5a4ae04e1e.1646996936.git.ps@pks.im>
        <cover.1647243508.git.ps@pks.im>
        <f8639116d2d384a6d285c75830c52d8a8230ae6b.1647243509.git.ps@pks.im>
Date:   Mon, 14 Mar 2022 22:26:47 +0000
In-Reply-To: <f8639116d2d384a6d285c75830c52d8a8230ae6b.1647243509.git.ps@pks.im>
        (Patrick Steinhardt's message of "Mon, 14 Mar 2022 08:42:51 +0100")
Message-ID: <xmqq5yognpaw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D6597E02-A3E5-11EC-869A-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> By default, git-repack(1) will update server info that is required by
> the dumb HTTP transport. This can be skipped by passing the `-n` flag,
> but what we're noticably missing is a config option to permanently
> disable updating this information.
>
> Add a new option "repack.updateServerInfo" which can be used to disable
> the logic. Most hosting providers have turned off the dumb HTTP protocol
> anyway, and on the client-side it woudln't typically be useful either.
> Giving a persistent way to disable this feature thus makes quite some
> sense to avoid wasting compute cycles and storage.

Makes sense.  Perhaps we can leave a NEEDSWORK comment somewhere to
flip the default to false in two years or so.

Will queue.

Thanks.
