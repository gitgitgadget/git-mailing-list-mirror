Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10E3C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A942C23403
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 20:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbhAGUNI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 15:13:08 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52403 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbhAGUNI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 15:13:08 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 52FBFAA8D1;
        Thu,  7 Jan 2021 15:12:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EbQP4PcA5b0pXhczMZBI38Xi90k=; b=kbd5X+
        L2hHICVJI4dbsyW+fpSpc/ishotRekYvifHHENcVGkASguvpqCO4BP1xPQKn2DGo
        tUDN1UQk1t9PjnfEwIgyLLlbCdHK1wGIEnxf26HYuaf3UwsW2wQ+SMZORtQMeZsv
        LL8/fJs4HDRLJpIXwLZDDH4eFuOXButp1ZkOI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YYtxquOA0xShsMygIZmN+I8nKsEM39F6
        tGRWhvsKrM/U5H0qh4SsxJViTWVZFcD7WqckM1/RrXHDbZXQRgcxEbNq3ERExZ+S
        Na9J+SUtBSO3ph5NyAHANjU+yZYcfRnQl8/VxWKoMdB35beH7sEC/gEDbeqkSfKH
        zcWV0u8cCiM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4ADE0AA8D0;
        Thu,  7 Jan 2021 15:12:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CA278AA8CF;
        Thu,  7 Jan 2021 15:12:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 6/9] index-format: update preamble to cached tree
 extension
References: <pull.829.git.1609356413.gitgitgadget@gmail.com>
        <pull.829.v2.git.1609729758.gitgitgadget@gmail.com>
        <75b51483d3c7088d0cfae36544966672374c50f9.1609729758.git.gitgitgadget@gmail.com>
        <xmqqble1o5sc.fsf@gitster.c.googlers.com>
        <5a1a51c1-7ada-6f66-a6d0-2fc01303d334@gmail.com>
Date:   Thu, 07 Jan 2021 12:12:26 -0800
In-Reply-To: <5a1a51c1-7ada-6f66-a6d0-2fc01303d334@gmail.com> (Derrick
        Stolee's message of "Thu, 7 Jan 2021 06:51:03 -0500")
Message-ID: <xmqqv9c8ld5h.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A9729F82-5124-11EB-AE9B-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> We later found out that we rather often compare the index against
>> the tree of HEAD (think: "git status"), and diff-lib.c::diff_cache()
>> does take advantage of the fact that an entire directory can be
>> skipped if the tree object taken from the HEAD side exactly matches
>> the tree recorded for the subdirectory in the cache tree extension.
>
> I need to read more about this. traverse_by_cache_tree() seems to
> be a good place to start. Thanks.

Ah, that one I forgot about.

What I had in mind was a different optimization that is far more
aggressive in unpack-trees.c::unpack_callback(); look for a comment
that begins with "Everything under the name matches".  The block
allows us to skip an entire subdirectory hierarchy.

