Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573B5C07E95
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 01:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 349F661380
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 01:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237244AbhGNBHy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 21:07:54 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55572 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237180AbhGNBHy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 21:07:54 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F23C7157477;
        Tue, 13 Jul 2021 21:05:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6l1GFK4VSGPdak4t7OuohN+u5vthwH37jOKI3f
        xd0uU=; b=voMrRctuN9qgLQG5qECDlN1sa5hXYEOa143nmawdVqH8iTttbRRoYl
        GHZ6wfHKs1ZmIO0EpdlGtjfWsjsIyDo3ytnG/yMzmFDm/zkSlUhPxO76Xujbcsc2
        lZIn7waKQRTb1qDT9XUjyaAQyagaY4RF/mT/BJydRPP9hxqnkh5DM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EAFE9157476;
        Tue, 13 Jul 2021 21:05:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6BE1F157474;
        Tue, 13 Jul 2021 21:05:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     randall.becker@nexbridge.ca
Cc:     git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [Patch 2/3] Documentation/config.txt: add worktree includeIf
 conditionals.
References: <20210712223139.24409-1-randall.becker@nexbridge.ca>
        <20210712223139.24409-3-randall.becker@nexbridge.ca>
Date:   Tue, 13 Jul 2021 18:04:59 -0700
In-Reply-To: <20210712223139.24409-3-randall.becker@nexbridge.ca> (randall
        becker's message of "Mon, 12 Jul 2021 18:31:38 -0400")
Message-ID: <xmqqr1g1zow4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 840ECDFC-E43F-11EB-8F31-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

randall.becker@nexbridge.ca writes:

> From: "Randall S. Becker" <rsbecker@nexbridge.com>
>
> Documentation of the worktree and worktree/i conditionals is add based on
> gitdir rules except that the trailing / form of the path is not supported.
>
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
>  Documentation/config.txt | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index bf82766a6a..7e951937ae 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -143,7 +143,16 @@ refer to linkgit:gitignore[5] for details. For convenience:
>  
>  `gitdir/i`::
>  	This is the same as `gitdir` except that matching is done
> -	case-insensitively (e.g. on case-insensitive file systems)
> +	case-insensitively (e.g. on case-insensitive file systems).
> +
> +`worktree`::
> +	This is similar to `gitdir` except that matching is done with
> +	the path of a worktree instead of the main repository. Unlike
> +	`gitdir`, the trailing / form of the worktree path is not supported.

It is not immediately obvious what "the trailing / form" means.

Does it refer to the 4th item in the 4-bullet list in the
description just above the patch context (I am trying to make a
guess here)?

The problem I perceive in this description is that there is no
phrase "trailing" in the vicinity of what readers have read so far;
readers who are not exactly familiar with the system may need a bit
more assurance that they guessed correctly.

    Unlike `gitdir`, `**` will not be automatically added to a
    pattern that ends with `/`

would be easier to give that assurance, albeit more verbosely.

Assuming that I guessed correctly, is this a deliberate design
decision not to "automatically add ** after a pattern that ends with
a slash", and if so why?  I would have thought that "in the
worktrees that I create inside /var/tmp/, please enable these
configuration variables" would be a fairly natural thing to ask, and
I do not immediately see a reason why we want to apply different
syntax rules between "gitdir" and "worktree".

Thanks.
