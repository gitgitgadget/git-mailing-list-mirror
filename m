Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE80C433E9
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 21:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FD4C64E6C
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 21:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbhBHV0A (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 16:26:00 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54511 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236046AbhBHVZE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 16:25:04 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7B2CC11CB72;
        Mon,  8 Feb 2021 16:24:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/hQAf7ep6It4nkwJDYWvy2WKnXU=; b=VPo+Ki
        1CqbzUyoGSAjur12qncTNKQh/PQIiUZh2i+PX55k+TxLWnxaW8tG5ZgKHFucWT3b
        Vkz0W8cZE62cEyiWGKssx/ole/o07r2j6CeoK6k3PoqVjTEmT+hqUghVFcarxCJC
        I83MMbdcviOHFrlK/jk/ac6lgytJ7jlUzaVck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tFKtRj2JQxcP0YgKKP021e/8iOgySWW+
        NKjVjkdWYwXiK0k6URMhkDAJHqNQq/ceMm2Za9q2WAVlNGey+hfZ/Tg0cW2MoAhh
        +NY8oe3sekm1Ik46vpYwOBwxGlaBDKSQsxBGFmPka6vE0V7+yaBbShFiYGLibcmH
        bsz3r5CRfO8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7470911CB71;
        Mon,  8 Feb 2021 16:24:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BD37011CB70;
        Mon,  8 Feb 2021 16:24:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com,
        christian.couder@gmail.com, phillip.wood123@gmail.com,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 03/11] rebase -i: clarify and fix 'fixup -c'
 rebase-todo help
References: <20210207181439.1178-1-charvi077@gmail.com>
        <20210208192528.21399-4-charvi077@gmail.com>
Date:   Mon, 08 Feb 2021 13:24:16 -0800
In-Reply-To: <20210208192528.21399-4-charvi077@gmail.com> (Charvi Mendiratta's
        message of "Tue, 9 Feb 2021 00:55:21 +0530")
Message-ID: <xmqq5z325k3j.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0030E214-6A54-11EB-AA37-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charvi Mendiratta <charvi077@gmail.com> writes:

> When `-c` says "edit the commit message" it's not clear what will be
> edited. The original's commit message or the replacement's message or a
> combination of the two. Word it such that it states more precisely what
> exactly will be edited. While at it, also drop the jarring period and
> capitalization, neither of which is otherwise present in the message.

>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
> ---
>  rebase-interactive.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/rebase-interactive.c b/rebase-interactive.c
> index c3bd02adee..e85994beb6 100644
> --- a/rebase-interactive.c
> +++ b/rebase-interactive.c
> @@ -45,8 +45,8 @@ void append_todo_help(int command_count,
>  "e, edit <commit> = use commit, but stop for amending\n"
>  "s, squash <commit> = use commit, but meld into previous commit\n"
>  "f, fixup [-C | -c] <commit> = like \"squash\", but discard this\n"
> -"                   commit's log message. Use -C to replace with this\n"
> -"                   commit message or -c to edit the commit message\n"
> +"                   commit's log message; use -C to replace with this\n"
> +"                   commit message or -c to edit this commit message\n"

The goal is good, but I am not sure if this "the commit" -> "this commit"
is an effective enough way to fix the issue.  Here is my attempt but
I do not think it is not 10x better to be worth replacing yours X-<.

    use only the log message of the "fixup" commit, discarding the
    message from the previous commit.  While "-C" uses the message
    as-is, "-c" lets the user further edit it.

>  "x, exec <command> = run command (the rest of the line) using shell\n"
>  "b, break = stop here (continue rebase later with 'git rebase --continue')\n"
>  "d, drop <commit> = remove commit\n"
> @@ -55,7 +55,7 @@ void append_todo_help(int command_count,
>  "m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]\n"
>  ".       create a merge commit using the original merge commit's\n"
>  ".       message (or the oneline, if no original merge commit was\n"
> -".       specified). Use -c <commit> to reword the commit message.\n"
> +".       specified); use -c <commit> to reword the commit message\n"

This hunk fixes the formatting by dropping the full-stop.  Unlike
the description of "fixup -C/-c", I find it very easy to understand.

Thanks.
