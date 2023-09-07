Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732AEEC8758
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 20:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236912AbjIGUUm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 16:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjIGUUi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 16:20:38 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44219A1
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 13:20:31 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6F9971BD984;
        Thu,  7 Sep 2023 16:20:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=cMp4dvUZUQ+hEzd+1jFwpUZR36wAZCIrbIjzSK
        oP5ds=; b=k0USXb5u1uVi0QvXhItYe4U6QLiHrSFlZ35Qsx42NoY0i5suq8GyLo
        u3ukOwCTiQyddh38slNdYYVu9VwPt05CgbixIEjszdMt30EQ3LV9x4ScbozkwQT1
        De8ONbLDlBhmPb2MIwCYFGpeNhtnabne/zagmEmomSznCv5rm+/Lg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 65E501BD983;
        Thu,  7 Sep 2023 16:20:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BD80A1BD982;
        Thu,  7 Sep 2023 16:20:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ZheNing Hu <adlternative@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] completion: commit: complete configured trailer tokens
In-Reply-To: <pull.1583.git.1694108551683.gitgitgadget@gmail.com> (Philippe
        Blain via GitGitGadget's message of "Thu, 07 Sep 2023 17:42:31 +0000")
References: <pull.1583.git.1694108551683.gitgitgadget@gmail.com>
Date:   Thu, 07 Sep 2023 13:20:28 -0700
Message-ID: <xmqqpm2tka5v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FD3D29F2-4DBB-11EE-BD99-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> Since 2daae3d1d1 (commit: add --trailer option, 2021-03-23), 'git
> commit' can add trailers to commit messages. To make that feature more
> pleasant to use at the command line, update the Bash completion code to
> offer configured trailer tokens.
>
> Add a __git_trailer_tokens function to list the configured trailers
> tokens, and use it in _git_commit to suggest the configured tokens,
> suffixing the completion words with ':' so that the user only has to add
> the trailer value.

Nice attention to the details.

I do not use custom trailers myself, but I can see how this will be
useful.  The choice of the source of the information (i.e. the
configuration variables trailer.*.key) sounds sensible, too.

Will queue.  Thanks.

> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>     completion: commit: complete configured trailer tokens
>     
>     Since 2daae3d1d1 (commit: add --trailer option, 2021-03-23), 'git
>     commit' can add trailers to commit messages. To make that feature more
>     pleasant to use at the command line, update the Bash completion code to
>     offer configured trailer tokens.
>     
>     Add a __git_trailer_tokens function to list the configured trailers
>     tokens, and use it in _git_commit to suggest the configured tokens,
>     suffixing the completion words with ':' so that the user only has to add
>     the trailer value.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1583%2Fphil-blain%2Fcompletion-commit-trailers-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1583/phil-blain/completion-commit-trailers-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1583
>
>  contrib/completion/git-completion.bash | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 133ec92bfae..b5eb75aadc5 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1677,6 +1677,11 @@ _git_clone ()
>  
>  __git_untracked_file_modes="all no normal"
>  
> +__git_trailer_tokens ()
> +{
> +	git config --name-only --get-regexp trailer.\*.key | awk -F. '{print $2}'
> +}
> +
>  _git_commit ()
>  {
>  	case "$prev" in
> @@ -1701,6 +1706,10 @@ _git_commit ()
>  		__gitcomp "$__git_untracked_file_modes" "" "${cur##--untracked-files=}"
>  		return
>  		;;
> +	--trailer=*)
> +		__gitcomp_nl "$(__git_trailer_tokens)" "" "${cur##--trailer=}" ":"
> +		return
> +		;;
>  	--*)
>  		__gitcomp_builtin commit
>  		return
>
> base-commit: 1fc548b2d6a3596f3e1c1f8b1930d8dbd1e30bf3
