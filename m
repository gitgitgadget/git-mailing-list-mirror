Return-Path: <SRS0=d2Ax=EG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB15C388F9
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 22:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 848D320719
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 22:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bCPN36ul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbgJaWpl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Oct 2020 18:45:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54198 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgJaWpl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Oct 2020 18:45:41 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E4D4F91625;
        Sat, 31 Oct 2020 18:45:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=y3x4bM7e12R0o4+bARbbdfgz7L0=; b=bCPN36
        ulQYfkRGRSEtPe0C+G90UflloiKXJoFJnhezjasp4/eXNt9Bhz0jrHhI3fIeUFne
        73bl/CTmnG6l0HfC8LirVnDWaSMAi5P9S1onYO0kwVwozfOvGWxGMvpfjWy3DYYK
        r2UnSdErvTBQ6pwuiid7qmfcMmWOjh3WgfsWo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=f5l4DrNezwt2Uufl9n+/diCO5D251WUL
        tLfW9CQNYsXThvWa7ooTxnALOqOct5+mXBBVkOjgwIjnWLTobL16MBGBDYHsA2JB
        uHpZp9RSd8HmIZPoF1SXRVAVm60WSv+aQ6n1P0fg0G/0pAXugsRYfNLlt4DTztRg
        D7gnoL0oQy4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D30BD91624;
        Sat, 31 Oct 2020 18:45:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4081891623;
        Sat, 31 Oct 2020 18:45:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Sibo Dong via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Sibo Dong <sibo.dong@outlook.com>
Subject: Re: [PATCH] git-prompt.sh: make `option` a local variable
References: <pull.775.git.1604182187195.gitgitgadget@gmail.com>
Date:   Sat, 31 Oct 2020 15:45:37 -0700
In-Reply-To: <pull.775.git.1604182187195.gitgitgadget@gmail.com> (Sibo Dong
        via GitGitGadget's message of "Sat, 31 Oct 2020 22:09:46 +0000")
Message-ID: <xmqqmu02xbe6.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CBE14490-1BCA-11EB-9195-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Sibo Dong via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Sibo Dong <sibo.dong@outlook.com>
>
> Other variables like `key` and `value` are local to this completion
> script, so I think the same should be done with `option`.
>
> Signed-off-by: Sibo Dong <sibo.dong@outlook.com>
> ---
>     git-prompt.sh: make option a local variable
>     
>     This is very trivial, but variables like key and value are local to 
>     git-prompt.sh, so I think the same should be done with option.

That explains why we might consider localizing option; another thing
to consider is if it is safe to just blindly localize it.

Here is how I would explain and justify the change, if I were
writing it:

    git-prompt.sh: localize `option` in __git_ps1_show_upstream

    The variable 'option' is used in __git_ps1_show_upstream()
    without being localized.

    This clobbers the variable the user may be using for other
    purposes, which is bad.  Luckily, $option is not used to carry
    information around in the script as a global variable.  The use
    of it in this script has very limited scope (namely, only inside
    this function), so just declare that it is "local".


following the usual pattern:

 - start with the observation on the codebase before your change,
 - explain what the problem is with the current state,
 - outline the solution and explain why it is the right thing to do, and
 - order the codebase to "be like so".


> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
> index 16260bab73..5116016d39 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -137,6 +137,7 @@ __git_ps1_show_upstream ()
>  	done <<< "$output"
>  
>  	# parse configuration values
> +	local option
>  	for option in ${GIT_PS1_SHOWUPSTREAM}; do
>  		case "$option" in
>  		git|svn) upstream="$option" ;;

Looks OK to me.
