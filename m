Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59220C433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 17:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238433AbiCGR2i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 12:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239259AbiCGR2g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 12:28:36 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D57712778
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 09:27:40 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8440D12C342;
        Mon,  7 Mar 2022 12:27:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3UDVtwnkeViAtcUz11E3b927idGxOn3KKIwyzO
        n2xYc=; b=FO5c4Kvz20X+VL365Cbxd900gLd2O+ZLMBXqpmIz2GjYabehVydYcY
        WeeqGcZOmb5TcewwsPqYzMtnZ+LtPtGuey6FsmpbTOlhCfwq1c3lWdlIo+5dGMjs
        64rj8Qlrpn9VFSsl6pk60roYVmZ9cI4ZdyPLqOYM88g7tUSVZ/MCM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 775DE12C341;
        Mon,  7 Mar 2022 12:27:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D44B512C33F;
        Mon,  7 Mar 2022 12:27:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robert Coup <robert@coup.net.nz>
Cc:     Robert Coup via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 4/7] fetch: add --refetch option
References: <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
        <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
        <a503b98f33328133f9a89ad7eba986b73535c461.1646406275.git.gitgitgadget@gmail.com>
        <xmqqa6e51kms.fsf@gitster.g>
        <CACf-nVfEt8xWgg-d8JmtSD09Mvp=YvshN=cfMQ=304--h5Rjcg@mail.gmail.com>
Date:   Mon, 07 Mar 2022 09:27:37 -0800
In-Reply-To: <CACf-nVfEt8xWgg-d8JmtSD09Mvp=YvshN=cfMQ=304--h5Rjcg@mail.gmail.com>
        (Robert Coup's message of "Mon, 7 Mar 2022 11:31:11 +0000")
Message-ID: <xmqq4k49u0za.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E2EA2FE0-9E3B-11EC-A02E-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Coup <robert@coup.net.nz> writes:

> Ah, I literally copied the unshallow one since it seemed boolean-ish
> and that's what I wanted. I'll look into it.

You may (or may not --- I didn't look) find options that need to be
OPT_BOOL() other than "unshallow" one.

While it would be excellent to add a separate "preliminary clean-up"
step before you add OPT_BOOL("refetch") to fix them to use
OPT_BOOL() instead of OPT_SET_INT(), that will add extra review
cycles to the series by extending the scope of it.

It is OK to leave them, in addition to the new one you are adding,
to use the old and a bit incorrect pattern, as long as you leave a
prominent note that we need to clean them up later.

Thanks.
