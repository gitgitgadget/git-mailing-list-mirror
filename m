Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BB5C433F5
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 06:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236098AbiCNGQV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 02:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbiCNGQU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 02:16:20 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3052C65B
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 23:15:11 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7371F173AF3;
        Mon, 14 Mar 2022 02:15:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=N2+dNi4DcB2UXlS8UGmkcPRCEoWgin0uI2T75L
        BxrMw=; b=Wv8Dzri0pMR7TrgwoLZlieOdPC6MuStbzz/iyE2VC0WQx2lFhKbcxG
        zmVX59oTEVIr6ygOd2+O3OR98Q5lkoMUL1y7bO9rEO/My0pdGchYps0h0+QMkJvr
        VSg6fR/xEkwCX4+i2/BQ5cb6yYPvh/3qi1F381LL6HPlq9uMpWz74=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6033A173AF2;
        Mon, 14 Mar 2022 02:15:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CD005173AF1;
        Mon, 14 Mar 2022 02:15:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 09/16] t7527: fix && chaining in matrix_try()
References: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
        <903643c449821f24d80c999b50031945c79a0a7e.1647033303.git.gitgitgadget@gmail.com>
Date:   Mon, 14 Mar 2022 06:15:06 +0000
In-Reply-To: <903643c449821f24d80c999b50031945c79a0a7e.1647033303.git.gitgitgadget@gmail.com>
        (Jeff Hostetler via GitGitGadget's message of "Fri, 11 Mar 2022
        21:14:56 +0000")
Message-ID: <xmqq1qz5t5zp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 18B71026-A35E-11EC-9937-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> fixup! t7527: test status with untracked-cache and fsmonitor--daemon
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  t/t7527-builtin-fsmonitor.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
> index 026382a0d86..f60e211dbab 100755
> --- a/t/t7527-builtin-fsmonitor.sh
> +++ b/t/t7527-builtin-fsmonitor.sh
> @@ -536,9 +536,9 @@ matrix_clean_up_repo () {
>  }
>  
>  matrix_try () {
> -	uc=$1
> -	fsm=$2
> -	fn=$3
> +	uc=$1 &&
> +	fsm=$2 &&
> +	fn=$3 &&

After seeing up to this step, I am reasonably well convinced that
what we want is to kick the jh/builtin-fsmonitor-part2 topic back to
'seen', and you send instead of part2.5 an updated part2, with
range-diff since the last round and this final iteration.  A change
like the above will be seen in the range-diff in the cover letter
and most of them, like the above, will become trivial improvements,
and then the result can hopefully be placed back in 'next' reasonably
fast.

Opinions?
