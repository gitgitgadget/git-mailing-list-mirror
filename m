Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D5EC0015E
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 18:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjGYSRk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 14:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGYSRj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 14:17:39 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6440B1BF8
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 11:17:38 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F22033173F;
        Tue, 25 Jul 2023 14:17:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jRZDfS9PlYHtqreszSeMzNCbHHehdw+gE4NaBD
        11iME=; b=JKONqfOmNlDJA3wAecRZHWpYwPrgUETXWcTP7avs2gZwcAipMoD4FF
        juiOZjOsnCZpdOXZ3NvSnQJEea5pbryf2GhRp7ocKLU6Xmf/vGV+UCbyuzGv37Cx
        eptwl7/shnsxkccOvTVtGhkk/Dr+VU5eIVEO3lMfzVjzYRa39q7jI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EAC5F3173E;
        Tue, 25 Jul 2023 14:17:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7F1013173D;
        Tue, 25 Jul 2023 14:17:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Petar Vutov <pvutov@imap.cc>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/1] docs: highlight that .gitmodules does not
 support !command
References: <d775437e-7fa3-189b-a1c3-4fd358dd9768@imap.cc>
        <20230713193342.1053968-1-pvutov@imap.cc>
        <a8bde495-57fc-6a70-e325-6e2a52f40552@imap.cc>
        <xmqqwmz3oacg.fsf@gitster.g>
        <9de918bc-6913-0486-02dd-5b4028a7fe1b@imap.cc>
        <xmqqa5vzo7jy.fsf@gitster.g> <xmqqv8enmr21.fsf@gitster.g>
        <0d29ac42-4e8f-71b6-b85f-00de182e2957@imap.cc>
Date:   Tue, 25 Jul 2023 11:17:33 -0700
In-Reply-To: <0d29ac42-4e8f-71b6-b85f-00de182e2957@imap.cc> (Petar Vutov's
        message of "Sat, 15 Jul 2023 00:03:31 +0200")
Message-ID: <xmqq8rb3n9du.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8711167E-2B17-11EE-B2A9-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Petar Vutov <pvutov@imap.cc> writes:

> I applied your patch and then made some additions, which I'll append
> at the end of this message. Summary:
>
> * Added your rewrite from yesterday. I like that it's more precise
>   than the current docs, but I struggle with the complexity of the
>   first sentence. I wanted to make it easier to follow by splitting it
>   in two somehow. Instead I ended up with an introductory sentence
>   summarizing the functionality with small words.
>
> * In gitmodules.txt, moved the security disclaimer so people are more
>   likely to see it before they follow the link to git-submodule.txt.
>
> * Explicitly called out `none` and `custom command` as being unusable
>   on the command line (and in .gitmodules). I expect that you won't
>   want that .gitmodules mention anymore, but I left it in for now, up
>  to you.
>
> The diff below is based on top of your patch from yesterday, since I
> assume that you don't want to look at a mishmash of both patches.

Sorry for a very slow response; I seem to have missed this one.

The end result looks good.  Care to wrap it up into a single patch
(iow, make a "mishmash of both patches") with a good log message so
we can move the topic forward?

Thanks.

> diff --git a/Documentation/git-submodule.txt
> b/Documentation/git-submodule.txt
> index 5248840b18..695730609a 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -165,13 +165,18 @@ checked out in the submodule.
>  	merge;; the commit recorded in the superproject will be merged
>  	    into the current branch in the submodule.
>
> -	custom command;; arbitrary shell command that takes a single
> -	    argument (the sha1 of the commit recorded in the
> -	    superproject) is executed. When `submodule.<name>.update`
> -	    is set to '!command', the remainder after the exclamation mark
> -	    is the custom command.
> -
> -	none;; the submodule is not updated.
> +The following update procedures have additional limitations:
> +
> +	custom command;; mechanism for running arbitrary commands with the
> +	    commit ID as an argument. Specifically, if the
> +	    `submodule.<name>.update` configuration variable is set to
> +	    `!custom command`, the object name of the commit recorded in the
> +	    superproject for the submodule is appended to the `custom command`
> +	    string and executed. Note that this mechanism is not supported in
> +	    the `.gitmodules` file or on the command line.
> +
> +	none;; the submodule is not updated. This update procedure is not
> +	    allowed on the command line.
>
>  If the submodule is not yet initialized, and you just want to use the
>  setting as stored in `.gitmodules`, you can automatically initialize the
> diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
> index dcee09b500..d9bec8b187 100644
> --- a/Documentation/gitmodules.txt
> +++ b/Documentation/gitmodules.txt
> @@ -43,9 +43,9 @@ submodule.<name>.update::
>  	command in the superproject. This is only used by `git
>  	submodule init` to initialize the configuration variable of
>  	the same name. Allowed values here are 'checkout', 'rebase',
> -	'merge' or 'none'. See description of 'update' command in
> -	linkgit:git-submodule[1] for their meaning. For security
> -	reasons, the '!command' form is not accepted here.
> +	'merge' or 'none', but not '!command' (for security reasons).
> +	See the description of the 'update' command in
> +	linkgit:git-submodule[1] for more details.
>
>  submodule.<name>.branch::
>  	A remote branch name for tracking updates in the upstream submodule.
