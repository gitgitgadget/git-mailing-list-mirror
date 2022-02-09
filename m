Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EAAC433FE
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 18:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240198AbiBISlh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 13:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240286AbiBISkc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 13:40:32 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8352EC0401EF
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 10:40:08 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9795110F06C;
        Wed,  9 Feb 2022 13:40:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mRFAOeCiIy5gi+72CBo5rbciRwoH8QTL6Ktqez
        1kiZg=; b=hy7lzQ8DvxQE0ZLO5vstAVUXlksRtT0ZcjyHIagT5bKFbXLJI2K0Zc
        mVzpLiCxaLSSSglB14VpALQcZOlE4hYZbV6g7AGrCZZo/GEEhp0CaJWfAswq0K6i
        Sfrvum0lmdgyN5nMyUBD1riI2ov0yhJABAogXOkaF9pCo1B1LRths=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7648610F06B;
        Wed,  9 Feb 2022 13:40:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5EFDF10F06A;
        Wed,  9 Feb 2022 13:40:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Sean Allred <allred.sean@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v6 1/6] Documentation: add extensions.worktreeConfig
 details
References: <pull.1101.v5.git.1643641259.gitgitgadget@gmail.com>
        <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com>
        <0260ff6cac0c76c6d66187d77defef1edd4c6fb5.1644269583.git.gitgitgadget@gmail.com>
        <xmqqo83hatm1.fsf@gitster.g>
        <11bf1541-c46a-fcf5-f8d4-0d144b942d59@gmail.com>
        <xmqqmtj09cuz.fsf@gitster.g>
        <CABPp-BHKr3xPStXE6HXUBB0KR=6Y1-CSjDc1DTDdd63uYvK7uQ@mail.gmail.com>
Date:   Wed, 09 Feb 2022 10:40:03 -0800
In-Reply-To: <CABPp-BHKr3xPStXE6HXUBB0KR=6Y1-CSjDc1DTDdd63uYvK7uQ@mail.gmail.com>
        (Elijah Newren's message of "Wed, 9 Feb 2022 09:51:46 -0800")
Message-ID: <xmqqv8xn7ukc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B2E92B8E-89D7-11EC-98F2-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> But testing just now, I think the pseudorefs are already per-worktree.
> I just did a merge in a secondary worktree, and then observed from the
> primary worktree that a .git/worktrees/<id>/MERGE_HEAD was created,
> not a .git/MERGE_HEAD.  (Maybe the glossary could just spell out that
> these are under $GIT_DIR and _not_ $GIT_COMMON_DIR to avoid potential
> confusion?)

I actually think the longer-term direction is to describe that these
are always per-worktree, without referring to $GIT_DIR or giving any
hints that these may be represented as a file in the filesystem.
That would leave the door open for the reftable backend to take them
over as well as the normal refs.
