Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2DAC433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 23:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbiFVXqg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 19:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbiFVXqg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 19:46:36 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5208542A3D
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 16:46:35 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BA2FA1AC05D;
        Wed, 22 Jun 2022 19:46:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Wbjv8pqmmPZxhVZ0GzQ3EGc4e0Uxk0TSZUeDFn
        Ux2fw=; b=wq6QVEwZ9BsXrUSvcbvT0G6pZy0kY2fN8JeO75VzdKKQHg7VCWyFWn
        lil2KN1V+1OV/5zYa04Ra5zj2tEtcUifaaLPCS+LxAZqywIj0hw4j8q6JwQ3fPhu
        1VhfI4HYuhgEk+l3RpxmLRqBRIArOK9rcl97K2jbEuUcOMgISfFJQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B1BE91AC05C;
        Wed, 22 Jun 2022 19:46:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5E98C1AC05A;
        Wed, 22 Jun 2022 19:46:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] revisions.txt: escape "..." to avoid asciidoc
 horizontal ellipsis
References: <YrOmsA04FZae89be@coredump.intra.peff.net>
Date:   Wed, 22 Jun 2022 16:46:30 -0700
In-Reply-To: <YrOmsA04FZae89be@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 22 Jun 2022 19:33:04 -0400")
Message-ID: <xmqqfsjw2re1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8ABFDC0E-F285-11EC-B3EC-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Note that this produces an empty doc-diff of the manpages. Curiously,
> asciidoc produces the same ellipsis entity in the XML file, but docbook
> then converts it back into three literal dots for the roff output! So
> the roff manpages have been correct all along (which may be a reason
> nobody noticed this until now).

Hilarious.

I just checked with "man -l -Tps" and it does seem to throw literal
three dots in the PostScript.

> Reported-by: Arthur Milchior
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This was originally reported via https://github.com/git/git-scm.com/issues/1700,
> hence no email address for the reporter. I'm not sure if that makes it
> too useless to keep, but I mostly wanted to give credit.

I wonder if it is the same person as
<pull.1280.git.git.1655927444821.gitgitgadget@gmail.com>

Anyway, thanks, both ;-)

>
>  Documentation/revisions.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> index f5f17b65a1..cef8c3c66f 100644
> --- a/Documentation/revisions.txt
> +++ b/Documentation/revisions.txt
> @@ -283,7 +283,7 @@ The '..' (two-dot) Range Notation::
>   for commits that are reachable from r2 excluding those that are reachable
>   from r1 by '{caret}r1 r2' and it can be written as 'r1..r2'.
>  
> -The '...' (three-dot) Symmetric Difference Notation::
> +The '\...' (three-dot) Symmetric Difference Notation::
>   A similar notation 'r1\...r2' is called symmetric difference
>   of 'r1' and 'r2' and is defined as
>   'r1 r2 --not $(git merge-base --all r1 r2)'.
