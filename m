Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B171DC433F5
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 06:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236296AbiCNGB3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 02:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236313AbiCNGBX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 02:01:23 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5433FDB9
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 23:00:11 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 66CC9173827;
        Mon, 14 Mar 2022 02:00:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kze9BkNHhJf1HVPqVVdKRknzhbzsDM4maY1W5r
        AqQrc=; b=GQDjnT6LoaBZDhPj37w9Ddn+xvfxHIaiDc/lqI9cNafF4Skll78X+o
        GhxX8C8asJ1qClPlATD7tiz3WjeVMwxtldhxqu5kZl1TLfotjlEqr6cBXPg59QZk
        mpQxAJp0M1uDd5/OsgmMQn2tKh4aZ87LeBOmx+ec2UyBpmkt+xwNY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 600A8173826;
        Mon, 14 Mar 2022 02:00:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D0D66173820;
        Mon, 14 Mar 2022 02:00:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 01/16] t/test-lib: avoid using git on LHS of pipe
References: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
        <6750cc17bc439c14e752606fbb7271086a802eaf.1647033303.git.gitgitgadget@gmail.com>
Date:   Mon, 14 Mar 2022 06:00:07 +0000
In-Reply-To: <6750cc17bc439c14e752606fbb7271086a802eaf.1647033303.git.gitgitgadget@gmail.com>
        (Jeff Hostetler via GitGitGadget's message of "Fri, 11 Mar 2022
        21:14:48 +0000")
Message-ID: <xmqqa6dtt6oo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 00E089C0-A35C-11EC-8345-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> fixup! help: include fsmonitor--daemon feature flag in version info

Do you want me to kick part-2 out of 'next' so that these can be
squashed into the original commits that need fixing?  If not, you
would want to have a real commit log message instead.

The patch text looks good, even though I had to see if 'output' may
clobber or collide with names used in tests that want the
prerequisite.

> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  t/test-lib.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 46cd596e7f5..5d819c1bc11 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1803,5 +1803,6 @@ GIT_TEST_MAINT_SCHEDULER="none:exit 1"
>  # Does this platform support `git fsmonitor--daemon`
>  #
>  test_lazy_prereq FSMONITOR_DAEMON '
> -	git version --build-options | grep "feature:" | grep "fsmonitor--daemon"
> +	git version --build-options >output &&
> +	grep "feature: fsmonitor--daemon" output
>  '
