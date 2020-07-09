Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751BCC433DF
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 02:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E2A820738
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 02:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="akwHvJCS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgGIC5B (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 22:57:01 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55858 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgGIC5B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 22:57:01 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3EFE4EAF2D;
        Wed,  8 Jul 2020 22:56:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=c1VrLvGMR5MzLmj20IAV45MjRq4=; b=akwHvJ
        CSu/j6jW2T3m/4eBriF3eDAPngEoEM43IrKDfC8nXCjO+Olx+OHqD3Qgvnm2lA/Y
        PaQgQq+mqs5uhNfbGT3cCvxhdPybnGIbYQRxof0y9cQfKrwlfRWVZ6CztMQUZn4F
        o7BvYxoZj/zBrHLNKnfzkhG2ybikiflggT+Fg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WR54V6k0uDZJ7Su0Vf6NQanYiMhjpDMQ
        zpgoPYErdku2ENaSTIhZqSO4wAjuE7T9ny245LjHbiqTSXCymjlslQiysjEuVXHd
        hotBiV4DK/H6SOol8pDxdzOiklRHRtAtZvk/PCdQNooP3FAiT1lM4IHBe8aEm6Yi
        u3rCR3Jd8xc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 38C67EAF2C;
        Wed,  8 Jul 2020 22:56:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2E943EAF29;
        Wed,  8 Jul 2020 22:56:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "sunlin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sunlin <sunlin7@yahoo.com>,
        Lin Sun <lin.sun@zoom.us>
Subject: Re: [PATCH v13] Support auto-merge for meld to follow the vim-diff behavior
References: <pull.781.v12.git.git.1594178716840.gitgitgadget@gmail.com>
        <pull.781.v13.git.git.1594254906647.gitgitgadget@gmail.com>
Date:   Wed, 08 Jul 2020 19:56:53 -0700
In-Reply-To: <pull.781.v13.git.git.1594254906647.gitgitgadget@gmail.com>
        (sunlin via GitGitGadget's message of "Thu, 09 Jul 2020 00:35:06
        +0000")
Message-ID: <xmqqh7uhz98q.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D8EC0372-C18F-11EA-95FD-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"sunlin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +			case "$meld_help_msg" in
> +			*"--output="*|*'[OPTION...]'*)

This may be personal preference, but I think the way you spelled
this line with SP on both sides of '|' was much easier to read.

> +	# Check whether we should use 'meld --auto-merge ...'
> +	if test -z "$meld_use_auto_merge_option"
>  	then
> +		meld_use_auto_merge_option=$(git config mergetool.meld.useAutoMerge)
> +		case "$meld_use_auto_merge_option" in
> +		true|false)
> +			: use well formatted boolean value
> +			;;

OK.

> +		auto)
> +			# testing the "--auto-merge" option only if config is "auto"
> +			init_meld_help_msg
> +
> +			case "$meld_help_msg" in
> +			*"--auto-merge"*|*'[OPTION...]'*)
> +				meld_use_auto_merge_option=true
> +				;;
> +			*)
> +				meld_use_auto_merge_option=false
> +				;;
> +			esac
> +			;;

OK.

> +		*)

This is the case where we saw "", "True", "treu", etc. from the
string "git config --get".

> +			if meld_use_auto_merge_option=$(\
> +				 git config --bool mergetool.meld.useAutoMerge)

You do not need that backslash, do you?

Perhaps

			if meld_use_auto_merge_option=$(
				 git config --bool mergetool.meld.useAutoMerge
			)	
			then

if you really want to spread them into multiple lines.

> +			then
> +				: use normalized boolean value

Sure, we got a valid boolean.

> +			else
> +				meld_use_auto_merge_option=false

Why? Shoudln't we loudly complain to let the user know of a misspelt
value in the configuration?

> +			fi
> +			;;
> +		esac
>  	fi
>  }
>
> base-commit: 07d8ea56f2ecb64b75b92264770c0a664231ce17
