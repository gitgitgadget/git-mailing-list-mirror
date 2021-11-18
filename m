Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B74C433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 21:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17A92611EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 21:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhKRVdv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 16:33:51 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54784 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbhKRVdu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 16:33:50 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E5923167850;
        Thu, 18 Nov 2021 16:30:49 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Myr0Z3SqfsW/TBga90tK/PNR2BcG5QgJxv5Odc
        wZzWg=; b=Fi+R14+le8okLBq0uw61VQFjDRM1lKDqHAGw2Pa+BupFZVUrf5LaYy
        vJ55ea/YiQcfnfyAeR1xglZAoCMlVrMHAUyUrqBcUIQUpurztY6aWpCRXcXBh8OW
        e8Ub5m1ZffRJVykdNHVRAISNZZpoO7Wwo2+DJfXDVtN8Ew9TOF3/Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DE2C716784F;
        Thu, 18 Nov 2021 16:30:49 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4B7E816784D;
        Thu, 18 Nov 2021 16:30:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, sluongng@gmail.com,
        matthias.baumgarten@aixigo.com, sunshine@sunshineco.com,
        avarab@gmail.com, johannes.schindelin@gmx.de
Subject: Re: [PATCH] pull: don't say that merge is "the default strategy"
References: <20211118154317.639118-1-alexhenrie24@gmail.com>
Date:   Thu, 18 Nov 2021 13:30:45 -0800
In-Reply-To: <20211118154317.639118-1-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Thu, 18 Nov 2021 08:43:17 -0700")
Message-ID: <xmqqk0h5w3qy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CB463DDC-48B6-11EC-B77C-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> Git no longer has a default strategy for reconciling divergent branches,
> because there's no way for Git to know which strategy is appropriate in
> any particular situation.

A very good observation, and the patch makes sense.

> The initially proposed version of commit
> 031e2f7ae195069d00d21cde906fce5b0318dbdd, "pull: abort by default when
> fast-forwarding is not possible", dropped this phrase from the message.
> It appears that leaving it in the message in the final version of the
> patch was accidental.

Hmph, the one before later iterations v$N, i.e.
 
https://lore.kernel.org/git/dca0455898a838b46546a29ee79f0a8b112fbff5.1626536508.git.gitgitgadget@gmail.com/ 

seems to keep "the default" label from the beginning.

I am tempted to drop this latter last paragraph, which looks more
like a guess than anything else, and does not add much value to
future readers of the "git log".

>
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  builtin/pull.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 127798ba84..590f15bf9b 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -970,7 +970,7 @@ static void show_advice_pull_non_ff(void)
>  		 "You can do so by running one of the following commands sometime before\n"
>  		 "your next pull:\n"
>  		 "\n"
> -		 "  git config pull.rebase false  # merge (the default strategy)\n"
> +		 "  git config pull.rebase false  # merge\n"
>  		 "  git config pull.rebase true   # rebase\n"
>  		 "  git config pull.ff only       # fast-forward only\n"
>  		 "\n"
