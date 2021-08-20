Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1ADBC4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 20:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C35CD61179
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 20:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238208AbhHTURx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 16:17:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57155 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhHTURw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 16:17:52 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E524ADA68E;
        Fri, 20 Aug 2021 16:17:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9l4US17568HTdXJ/OmJ2NlKvA029gBReGltmnm
        sIsn0=; b=UEpDmJ12S4+yQvUvFrX3EWEV9W0uj1w7DXZecddyR9rmhcoXp4KHwz
        E6meXuvucqn8K45FFFPvdz4rb6PA4he99T17hjgjD1d9AaCiJddCHE4/+M78cFD1
        SLgCF1r9kc4Wfjc8BDN3aLkj5y+FpY8nFzsghRTiHQIDl6eSYSM24=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DD9FDDA68D;
        Fri, 20 Aug 2021 16:17:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 653AEDA68C;
        Fri, 20 Aug 2021 16:17:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thiago Perrotta <tbperrotta@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] send-email: print newline for
 --git-completion-helper
References: <20210820004604.9948-1-tbperrotta@gmail.com>
        <20210820004604.9948-2-tbperrotta@gmail.com>
Date:   Fri, 20 Aug 2021 13:17:12 -0700
In-Reply-To: <20210820004604.9948-2-tbperrotta@gmail.com> (Thiago Perrotta's
        message of "Thu, 19 Aug 2021 20:46:02 -0400")
Message-ID: <xmqqmtpbub07.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B35CF5E-01F3-11EC-89C4-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thiago Perrotta <tbperrotta@gmail.com> writes:

> Rationale: Currently all git built-in commands print a newline upon upon git
> <cmd> --git-completion-helper. Therefore git-send-email should follow suit for
> consistency.

"upon upon".

You do not need to start with "Rationale", because one of the things
you need to have in any proposed log message is a justification for
the change.  You also do not need "Currently" in our log message, as
the convention here is to state the status quo in the present tense,
point out what's wrong there (or leave it unsaid and implied by the
description of the current state, if it is obvious), state the
approach to correct what's wrong, and finally give an order to the
codebase to "become like so".

	Unlike other Git subcommands, "git send-email" leaves its
	output an incomplete line when "--git-completion-helper" is
	asked.  Be consistent by terminating the message with LF
	here.

or something like that.

I do not know which style is preferred among

 (1)	print something;
	print "\n";

 (2)	print something, "\n";

 (3)	print something . "\n";

but other than that, the goal and the implementation both sound
sensible (the second one is what I'd be writing if I were doing this
change myself, FWIW).

Thanks.

> Signed-off-by: Thiago Perrotta <tbperrotta@gmail.com>
> ---
>  git-send-email.perl | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index e65d969d0b..e991bf333d 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -115,6 +115,7 @@ sub usage {
>  
>  sub completion_helper {
>      print Git::command('format-patch', '--git-completion-helper');
> +    print "\n";
>      exit(0);
>  }
