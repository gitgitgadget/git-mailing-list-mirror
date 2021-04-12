Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717B2C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 20:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 376E56121F
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 20:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238734AbhDLUvW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 16:51:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57817 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236988AbhDLUvV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 16:51:21 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9BD42C702D;
        Mon, 12 Apr 2021 16:51:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RftJ3O/DbJm/DGLgmZgVD/v3Xcc=; b=X07mvh
        Q920bulQz35lOC1KaCu0evqzSzPzLtARVFa315Ip7aLzFzJEkGQZ3dmH22KwqF6I
        KHpPEFLRZ+/81IJVKQZd80v0moo61HEQHB50h5jOs/EdyySOjZWayVOnU6pAG7tB
        3rA93D06hjP6YST9VzITywWzszJgJZaEdv7yg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lauKptHWT3X6LBfBtCkJjHQUzLqoyALW
        LIyvaaLmCez+5uHDW6H3v858r0dM0XsYZRI0RuXRGhkivEV1WBzSc+ONDe+07COd
        /s0E4CQigF+BJbhrhhDa5pMBdr5OKmo4jqvBeXX98UAwkCk3UNY13KtLkBks8M2g
        U6vtVrqsjpE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 92916C702C;
        Mon, 12 Apr 2021 16:51:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 95618C7029;
        Mon, 12 Apr 2021 16:51:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v9 2/2] [GSOC] trailer: add new .cmd config option
References: <pull.913.v8.git.1617975462.gitgitgadget@gmail.com>
        <pull.913.v9.git.1618245568.gitgitgadget@gmail.com>
        <7f645ec95f48a206311973ee45578ba14ac58b7f.1618245568.git.gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 13:51:00 -0700
In-Reply-To: <7f645ec95f48a206311973ee45578ba14ac58b7f.1618245568.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Mon, 12 Apr 2021 16:39:27
        +0000")
Message-ID: <xmqqsg3vb51n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CA7EDB22-9BD0-11EB-A76A-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +For consistency, the $1 is also passed, this time with the empty string,
> +in the command when the command is first called to add a trailer with
> +the specified <token>.

I guess the same question as 1/2 applies to this part.  I am not
sure what "consistency" the behaviour of calling the configured
command with no argument is trying to achieve.  To me, .cmd doing
this may be for consistency with .command but I am not sure why
the consistency is even desiable.

> +$ cat ~/bin/gcount
> +#!/bin/sh
> +test -n "$1" && git shortlog -s --author="$1" HEAD || true
> +$ git config trailer.cnt.key "Commit-count: "
> +$ git config trailer.cnt.ifExists "replace"
> +$ git config trailer.cnt.cmd "~/bin/gcount"
> +$ git interpret-trailers --trailer="cnt:Junio" <<EOF
> +> subject
> +> 
> +> message
> +> 
> +> EOF
> +subject
> +
> +message
> +
> +Commit-count: 22484     Junio C Hamano
> +------------

This and the other (omitted) example demonstrates how the initial
"empty" invocation is useless by using "replace".  Which also means
that you cannot add more than one trailer of the same <key> with the
mechanism (since the older ones are replaced with the latest).

The code change and the test change are consistent with the design,
though.

Thanks.
