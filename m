Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EE851F4B6
	for <e@80x24.org>; Mon,  8 Jul 2019 20:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404826AbfGHUCZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Jul 2019 16:02:25 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51071 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404790AbfGHUCZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jul 2019 16:02:25 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1F4136AEA2;
        Mon,  8 Jul 2019 16:02:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6k9s2AxSlOsnBqYJvS8Ol/cgv1E=; b=AXiOBR
        YtqpvycUX6S5maEOraQR0QVk6sPLnOdqh2OE0GgDCDLjhgcSjYdEcG1u5UwAE5mH
        bqGf1IOo4FR2KP9HnA7EOW01s8q4dwFh3qnUXldFf6dkd2D35jF5AAEjZc/4T7kr
        IW1X7Ad1+wJbYSN9U2PGVVi3ggqElBjRnh9Qk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ACoFYUkuOeNJbKkih7e6ArTTggF2oKpt
        XTynep/Qc/cz/PX3hmJ7kKrJt7Tl+LM/QJT4TU1esh++A2Yv6/RjbeFy0mrIcBqW
        cuK38cYi9qNStamfVFCpO9pHmtd4qVCHeV1n1YWRH+0+ntZ7esicvwE4q0w9Tgap
        WNl1Ja9Nj7U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1718E6AEA1;
        Mon,  8 Jul 2019 16:02:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 457E56AEA0;
        Mon,  8 Jul 2019 16:02:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v1] merge - rename a shadowed variable in cmd_merge
References: <20190705203227.23451-1-eantoranz@gmail.com>
Date:   Mon, 08 Jul 2019 13:02:15 -0700
In-Reply-To: <20190705203227.23451-1-eantoranz@gmail.com> (Edmundo Carmona
        Antoranz's message of "Fri, 5 Jul 2019 14:32:27 -0600")
Message-ID: <xmqqlfx8xpko.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49584774-A1BB-11E9-979F-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Edmundo Carmona Antoranz <eantoranz@gmail.com> writes:

> variable ret used in cmd_merge introduced in d5a35c114ab was already
> a local variable used inside a for loop inside the function.

Strictly speaking, there was a local variable 'ret' inside for loop,
which is unrelated to the variable introduced by the said commit.
The only resemblance was that they happen to share the same name.
So "was already a local variable" is not quite right, and made my
reading hiccup.

> for-local variable is being renamed to ret_try_merge to avoid shadow.

Is this really a problem that needs to be changed?  What compiler
is having trouble with the code?

I am reasonably negative on this change.  But as you seem to be a
new contributor, let me grab this opportunity to comment on other
aspects of the patch.

> ---

Missing sign-off.

In the proposed commit log message body, write full sentences just
like normal English, e.g. a sentence begins with a capital letter,
etc.

The usual pattern used in our log messages is first to give an
observation of the current state and state what the problem is,
and then write orders you give to the codebase to be like so to fix
the problem, e.g.

	The commit d5a35c11 ("Copy resolve_ref() return value for
	longer use", 2011-11-13) introduced a variable 'ret' to
	cmd_merge() to keep the final return value from the
	function.  There however was an unrelated variable that is
	local to a for loop that shared the same name.  Because the
	statements inside of the loop do not have enough information
	to decide the final outcome of the function, there is no
	need for the outer 'ret' to be visible to them, which is
	a perfectly good reason to use the "shadowing" technique.

	Rename the local variable used inside the for loop to avoid
	warnings when compiled with -Wshadow; this will expose the
	outer 'ret' to the statements in the loop, allowing them to
	mistakenly making an assignment to it, though.

is how I would describe this change.  As you can see, this trades
"make -Wshadow less noisy" with "make it easier to make mistakes"
and I am not sure if it is a good trade-off.

> diff --git a/builtin/merge.c b/builtin/merge.c
> index 6e99aead46..972b6c376a 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1587,7 +1587,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  		oidclr(&stash);

Interesting.

All assignments to ret up to this point are all followed by "goto
done" to jump over the "for" loop we are looking at this patch.
So we know that when the control reaches at this point, ret has its
initial value 0.

So an alternative approach would be to just ...

>  	for (i = 0; i < use_strategies_nr; i++) {
> -		int ret;
> +		int ret_try_merge;

... drop this local variable declaration and let it contaminate the
outer 'ret', and then after the loop is done, assign 0 to ret.  That
would squelch "-Wshallow" and at the same time makes sure that the
loop won't corrupt the "proposed final outcome" stored in 'ret'.

Quite honestly, I think the easiest "solution" would be not to use
"-Wshadow" in your compilation.  Thsi file has a handful other
instances of variable shadowing, and most of them do not look
confusing or problematic.
