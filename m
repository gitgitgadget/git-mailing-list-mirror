Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D648CE92FC8
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 21:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjJEVpk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 17:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjJEVpj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 17:45:39 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC5C9E
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 14:45:38 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D7C5B1AE1D3;
        Thu,  5 Oct 2023 17:45:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=YXJJAG/luvbzizq581/xv6X1L66QndqVaDqKOs
        GwV/M=; b=TXaCjKQg0LRTfhvpCj4uhDCIr3U9dSTFKJLAEoVySU0RDUl7bHdOaT
        yUBBD1IKJX7agHd9Bfui6V24IzQAB6jv1rzELhTRetnHWDlPPsWupgg3qRnipju0
        okHwsz4WXphseSZ/lDD0Owgvbt4f8d/W+EqTqvCq+QtZiR47UvAz0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CFBF71AE1D2;
        Thu,  5 Oct 2023 17:45:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 412541AE1D1;
        Thu,  5 Oct 2023 17:45:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 3/3] completion: complete '--dd'
In-Reply-To: <20231004214558.210339-4-sorganov@gmail.com> (Sergey Organov's
        message of "Thu, 5 Oct 2023 00:45:58 +0300")
References: <20230909125446.142715-1-sorganov@gmail.com>
        <20231004214558.210339-1-sorganov@gmail.com>
        <20231004214558.210339-4-sorganov@gmail.com>
Date:   Thu, 05 Oct 2023 14:45:36 -0700
Message-ID: <xmqqlecgeoan.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 851B534A-63C8-11EE-AD9C-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> '--dd' only makes sense for 'git log' and 'git show', so add it to
> __git_log_show_options which is referenced in the completion for these
> two commands.
>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 133ec92bfae7..ca4fa39f3ff8 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2042,7 +2042,7 @@ __git_log_shortlog_options="
>  "
>  # Options accepted by log and show
>  __git_log_show_options="
> -	--diff-merges --diff-merges= --no-diff-merges --remerge-diff
> +	--diff-merges --diff-merges= --no-diff-merges --dd --remerge-diff
>  "
>  
>  __git_diff_merges_opts="off none on first-parent 1 separate m combined c dense-combined cc remerge r"

Quite straight-forward.  I am kind of surprised that we do not have
to list "--cc" here.  Perhaps it is so short and common that people
do not need completion help?

But that is not a new problem caused by this series, so it is OK.

Unless "--cc" gets completed without being listed here, using some
automation like the "--git-completion-helper" option, in which case
we may want to see if we can remove all of the above and complete
them the same way as "--cc" gets completed.  I didn't check.

Thanks.

