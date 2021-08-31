Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F84C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 21:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F52860698
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 21:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241300AbhHaVHl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 17:07:41 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60385 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbhHaVHk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 17:07:40 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BB5241575C6;
        Tue, 31 Aug 2021 17:06:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gfyJffMOzZ5PGDe/ta9Fx0MomU5RkXOGo59F+l
        VxPUg=; b=u02vdmI0KjT/7q02RYMBpairfYqCL52Arh55LCRx3q2yRm+dxck6D2
        7OMejGEyHO3fq6H2GIUWbL24RThe9Z+wiixKuoBbmQiihWwu1mhAeGMTMjuaTjJL
        OgWyxDDeEBrDJdgU1xQFzVuU/hTF7CI5MKqIyI4KNnzeejw/tdAbE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B348C1575C5;
        Tue, 31 Aug 2021 17:06:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 791C81575C3;
        Tue, 31 Aug 2021 17:06:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/7] merge-ort: mark a few more conflict messages as
 omittable
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
        <df6e2774f1a5560a598dd8b46131bc6b0a261d4a.1630376800.git.gitgitgadget@gmail.com>
Date:   Tue, 31 Aug 2021 14:06:39 -0700
In-Reply-To: <df6e2774f1a5560a598dd8b46131bc6b0a261d4a.1630376800.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Tue, 31 Aug 2021
        02:26:34 +0000")
Message-ID: <xmqqzgsxs4rk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 56DDF4B2-0A9F-11EC-8390-9BA3EF469F85-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> path_msg() has the ability to mark messages as omittable when recording
> conflict messages in an in-tree file.  This conflict message file will
> then be shown by diffing the merge-created tree to the actual merge
> commit that is created.  While all the messages touched in this commit
> are very useful when trying to create a merge initially, early use with
> the --remerge-diff feature (the only user of this omittable conflict
> message capability), suggests that the particular messages marked in
> this commit are just noise when trying to see what changes users made to
> create a merge commit.  Mark them as omittable.

Sorry for asking something that may be obvious, but if you recreate
an automated and potentially conflicting merge in-core, in order to
then compare the recorded merge result, is there *any* message that
is worth showing while doing the first step, and where in the output
do users see them?

