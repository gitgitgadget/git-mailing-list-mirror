Return-Path: <SRS0=xqrk=6B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE801C3815B
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 18:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 943602224F
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 18:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sAjosQQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730671AbgDQSYI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Apr 2020 14:24:08 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62900 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730256AbgDQSYH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Apr 2020 14:24:07 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ACB00BD28F;
        Fri, 17 Apr 2020 14:24:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HBwuqeJw+/PQF6mlzk9/cW5AUb0=; b=sAjosQ
        QRN3miVKAYaPRjdg0St7VznJ4aI7Y8A9YX4kvTMdBNsINW/LR0lKYqpTEejorX/x
        AmYnWeMmXjbBvWXnZvnw7CgJy3ebJOieHyZy3/KyVOOxseenFniINLZkk0nqlWHV
        Ef371XTnYB9juw8i7hq4REoHSvKCT6jZu+wrc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XiKObua18h9QBPNEUNwxaxrvEGSieGCB
        ySzy4kJ9hEs3G1RqLFwwbjQGgSRge1vDfJ5NJL4yYNca3J5GAhqCW1iTX8KCI4rF
        DPVCDFYqwzR4qP2TGNvvQrSzfFsCQQDKucLYXo25Y2Jz1fZ8pDMIVhP5+ciT5OJ5
        zm1HQ3a2i3s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A3E88BD28E;
        Fri, 17 Apr 2020 14:24:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E983ABD28D;
        Fri, 17 Apr 2020 14:24:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Terry via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Terry <tmoschou@gmail.com>
Subject: Re: [PATCH] complete: zsh: add missing sub cmd completion candidates
References: <pull.613.git.1587107464322.gitgitgadget@gmail.com>
Date:   Fri, 17 Apr 2020 11:24:01 -0700
In-Reply-To: <pull.613.git.1587107464322.gitgitgadget@gmail.com> (Terry via
        GitGitGadget's message of "Fri, 17 Apr 2020 07:11:04 +0000")
Message-ID: <xmqqsgh2ug1q.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D5E3304-80D8-11EA-9A79-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Terry via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
> index eef4eff53df..ce47e86b60c 100644
> --- a/contrib/completion/git-completion.zsh
> +++ b/contrib/completion/git-completion.zsh
> @@ -150,9 +150,11 @@ __git_zsh_cmd_common ()
>  	push:'update remote refs along with associated objects'
>  	rebase:'forward-port local commits to the updated upstream head'
>  	reset:'reset current HEAD to the specified state'
> +	restore:'restore working tree files'
>  	rm:'remove files from the working tree and from the index'
>  	show:'show various types of objects'
>  	status:'show the working tree status'
> +	switch:'switch branches'
>  	tag:'create, list, delete or verify a tag object signed with GPG')
>  	_describe -t common-commands 'common commands' list && _ret=0
>  }

This is not a new issue, but it makes me wonder if we can initialize
this list just once by running "git help" and picking up pieces from
it.  That way, we won't have to maintain this hardcoded list at all,
no?

And if it is cumbersome to parse "git help" output, I do not think
it is a worse solution than having to maintain the above list
manually to add a new "--list-common-commands-for-zsh-completion"
option to "git help" to produce something more easily parseable.

In any case, the patch is probably an improvement to make the list
closer to what "git help" considers "common commands", but in the
longer term, it may not be making it any better for maintainability.

Thanks.
