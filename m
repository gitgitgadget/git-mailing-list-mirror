Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B84C001DC
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 19:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjGMTir (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 15:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbjGMTiq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 15:38:46 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1782269D
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 12:38:45 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 33C0A1AAE36;
        Thu, 13 Jul 2023 15:38:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UkG9THhk9w2jOorBof0q146PwfM8O3hL1Jit5L
        bj0Bw=; b=nS9qkgWZdHRqd+ODtovYfU09MLrfyOwACnWUtatKP0X89HlIbUJ+UV
        6fpi+kqpPW3n3suEgK6vMq1qbnfAI/uCDyUiSy+ay4FQXARJm+A+Us9CJKc457cY
        yZbLNgYO8IzePIGAOpOwZnfI9SRr4h3X6rxAJ6b/x3FTY8Gprt1m8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2AD861AAE35;
        Thu, 13 Jul 2023 15:38:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 949581AAE34;
        Thu, 13 Jul 2023 15:38:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     pvutov@imap.cc
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/1] docs: highlight that .gitmodules does not
 support !command
References: <d775437e-7fa3-189b-a1c3-4fd358dd9768@imap.cc>
        <20230713193342.1053968-1-pvutov@imap.cc>
Date:   Thu, 13 Jul 2023 12:38:43 -0700
In-Reply-To: <20230713193342.1053968-1-pvutov@imap.cc> (pvutov@imap.cc's
        message of "Thu, 13 Jul 2023 21:33:42 +0200")
Message-ID: <xmqqcz0vppoc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E0E8BD8A-21B4-11EE-931F-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

pvutov@imap.cc writes:

> From: Petar Vutov <pvutov@imap.cc>
>
> Bugfix for fc01a5d2 (submodule update documentation: don't repeat
> ourselves, 2016-12-27).
>
> The `custom command` and `none` entries are described as sharing the
> same limitations, but one is allowed in .gitmodules and the other is
> not. Instead, describe their limitations separately and in slightly
> more detail.

Sounds sensible.

>
> Signed-off-by: Petar Vutov <pvutov@imap.cc>
> ---
>
> Changes from v1:
> Don't delete the documentation for `!command`. Instead, highlight
> the differences in the limitations of `none` and `!command`.
>
> Changes from v2:
> Improve phrasing.
> Add the bugfix blurb in the commit message.
>
>  Documentation/git-submodule.txt | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 4d3ab6b9f9..69ee2cd6b0 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -160,16 +160,19 @@ checked out in the submodule.
>  	merge;; the commit recorded in the superproject will be merged
>  	    into the current branch in the submodule.
>  
> -The following 'update' procedures are only available via the
> -`submodule.<name>.update` configuration variable:
> -
>  	custom command;; arbitrary shell command that takes a single
>  	    argument (the sha1 of the commit recorded in the
>  	    superproject) is executed. When `submodule.<name>.update`
>  	    is set to '!command', the remainder after the exclamation mark
>  	    is the custom command.
> ++
> +Custom commands are only allowed in the `submodule.<name>.update`
> +git-config variable. They cannot be used in the .gitmodules file.
>  
>  	none;; the submodule is not updated.
> ++
> +The `none` update procedure is allowed in the .gitmodules file
> +or the `submodule.<name>.update` git-config variable.

But the usual ones like "merge" are also allowed in both places.
Does this still need to be said?

I wonder if it makes more sense to swap the order of these two
entries, showing "none" without any additional text first, and
then describe "custom command" with the note, exactly like you
did above.



