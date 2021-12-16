Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7776BC433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 03:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbhLPDMn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 22:12:43 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64682 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbhLPDMm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 22:12:42 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 33474173B5E;
        Wed, 15 Dec 2021 22:12:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=h27isQOqEe5s99pS8CTXVI1xB4r++yi09IY6yh
        mgr4k=; b=LJb66FUN3kSWLQjOkcsoAPAC6ERMnTt3WRja+KExkawsnV0p7E5QzR
        RRWIuuaY5UFBtGsYorv6drHQTFeICzuubeZxNJO9iw3YZqn2vIWV/Fm5qfew+gPJ
        jzm0uX2fBHgBxU3DOCzVPG6qSMuLDHq1Y3jg6BA8Lal/L/skmjTT8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2A7E7173B5D;
        Wed, 15 Dec 2021 22:12:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 86D4A173B5C;
        Wed, 15 Dec 2021 22:12:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "kashav madan via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, kashav madan <kshvmdn@gmail.com>
Subject: Re: [PATCH v2] help: make auto-correction prompt more consistent
In-Reply-To: <pull.1166.v2.git.git.1639609138813.gitgitgadget@gmail.com>
        (kashav madan via GitGitGadget's message of "Wed, 15 Dec 2021 22:58:58
        +0000")
References: <pull.1166.git.git.1639604468498.gitgitgadget@gmail.com>
        <pull.1166.v2.git.git.1639609138813.gitgitgadget@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Wed, 15 Dec 2021 19:12:37 -0800
Message-ID: <xmqq35mtz1i2.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0614D14A-5E1E-11EC-BFDA-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"kashav madan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Kashav Madan <kshvmdn@gmail.com>
>
> There are three callsites of git_prompt() that ask the user for "yes/no"
> confirmation, but the one in help.c, used for auto-correction, is
> formatted differently from the others. This updates that format string
> to make the prompt look more consistent.

Looks much better.  

The last sentence should be phrased as if we were giving an order to
the codebase to "become like so", to match the style, in which our
log messages are typically written (look for "imperative-mood" in
Documentation/SubmittingPatches).

Thanks.

> diff --git a/help.c b/help.c
> index 973e47cdc30..71444906ddf 100644
> --- a/help.c
> +++ b/help.c
> @@ -643,7 +643,7 @@ const char *help_unknown_cmd(const char *cmd)
>  		else if (autocorrect == AUTOCORRECT_PROMPT) {
>  			char *answer;
>  			struct strbuf msg = STRBUF_INIT;
> -			strbuf_addf(&msg, _("Run '%s' instead? (y/N)"), assumed);
> +			strbuf_addf(&msg, _("Run '%s' instead [y/N]? "), assumed);
>  			answer = git_prompt(msg.buf, PROMPT_ECHO);
>  			strbuf_release(&msg);
>  			if (!(starts_with(answer, "y") ||
>
> base-commit: e773545c7fe7eca21b134847f4fc2cbc9547fa14
