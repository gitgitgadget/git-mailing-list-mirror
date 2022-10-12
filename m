Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F76CC4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 20:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJLUyM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 16:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiJLUyK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 16:54:10 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0F410B786
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 13:54:10 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 73A51155E9E;
        Wed, 12 Oct 2022 16:54:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=engibWb6xKhfRpK8JI7uUd7ht9xaxL+K5oHpSs
        pQt3Y=; b=O5NdKxMaH/+M+mUSjGpS0e8kMr4Qk2XsP5+g4jMLvah6qzsHPDKQUU
        3V8aXEbnv2P8xYRjQr9gi5N9BQcYePhHuFW/hTSCQ4jgfQWOyVNNDQfclLxhQd3N
        JPmiNzdUnFDUYkdqYHC4A6lrfV9bv/U53RLIMW8bxRBdbRrhXipbQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 68B8C155E9D;
        Wed, 12 Oct 2022 16:54:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C1CA155E9C;
        Wed, 12 Oct 2022 16:54:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>
Subject: Re: [PATCH 0/2] [2.38 regression] config: respect includes in
 protected config
References: <pull.1360.git.git.1665603814.gitgitgadget@gmail.com>
Date:   Wed, 12 Oct 2022 13:54:06 -0700
In-Reply-To: <pull.1360.git.git.1665603814.gitgitgadget@gmail.com> (Glen Choo
        via GitGitGadget's message of "Wed, 12 Oct 2022 19:43:32 +0000")
Message-ID: <xmqqmta0kbkh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03E7E8F0-4A70-11ED-89F7-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Here's a fix for the regression reported in [1]. I'm quite confident that
> the test suite is extensive enough to catch any unintended behavioral
> changes, but I'd appreciate a second opinion.

This hooks onto safe.directory that dates back to 2.30.4 or so, but
the topic gc/bare-repo-discovery appears only in 2.38 so we do not
have to backport anything beyond the current maintenance track.
Whew ;-)

> Cc: Derrick Stolee derrickstolee@github.com, Taylor Blau me@ttaylorr.com,
> Johannes Schindelin Johannes.Schindelin@gmx.de, Junio C Hamano
> gitster@pobox.com
>
> [1]
> https://lore.kernel.org/git/CAPWNY8W_Tr-WoD-GXBddD5Y8w5Y4w+gDNYQdOAJ1uBwVHuRrsQ@mail.gmail.com
>
> Glen Choo (2):
>   t0033, t0035: test for included config
>   config: respect includes in protected config
>
>  config.c                        | 30 ++++++++----------------------
>  t/t0033-safe-directory.sh       |  9 +++++++++
>  t/t0035-safe-bare-repository.sh |  9 +++++++++
>  3 files changed, 26 insertions(+), 22 deletions(-)
>
>
> base-commit: 3dcec76d9df911ed8321007b1d197c1a206dc164
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1360%2Fchooglen%2Fprotected-config%2Frespect-includes-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1360/chooglen/protected-config/respect-includes-v1
> Pull-Request: https://github.com/git/git/pull/1360
