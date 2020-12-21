Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7626C433DB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 22:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65B5422D2A
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 22:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgLUWZh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 17:25:37 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56183 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgLUWZh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 17:25:37 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 02CFDF9BE6;
        Mon, 21 Dec 2020 17:24:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8O6VaOArTxG+r1Wa0CJAFiIMUy8=; b=ZjlaUQ
        jPv1/9G4TkW9wdHMsZc5lEz2iDrxWPNLMTaW8QYtRoyjjB8WmigrDJJGjekjWhPu
        Uu/Z2MbIPH07PeZco0NZKCQWrAMZAhUEGth+Ua5md/pZuoFXYEy/ZhZGKYPqrk/u
        UxXSEkfoPyc4okMxPetWLi0gzucZ05dCBsrfM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nVwuzrK/l89h1zcDfR3mNKH1G2JY3zBA
        q7rDl4wtojXEsKHOcLnndgC8HhZ7moer7wNqWX0qTUB/nhqWVLxX/iKaXDwolbjd
        PxaiCrgvzxg+rP7hrYwvqK+keajgCXb0ixmB0U/idlm17FB6kj252/umAPjDQ8IO
        wZTz3DW2v0o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EF731F9BE5;
        Mon, 21 Dec 2020 17:24:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3F65BF9BE0;
        Mon, 21 Dec 2020 17:24:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 3/3] git: catch an attempt to run "git-foo"
References: <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com>
        <20200826011718.3186597-1-gitster@pobox.com>
        <20200826011718.3186597-4-gitster@pobox.com>
        <nycvar.QRO.7.76.6.2008280412030.56@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.2012201623490.56@tvgsbejvaqbjf.bet>
Date:   Mon, 21 Dec 2020 14:24:49 -0800
In-Reply-To: <nycvar.QRO.7.76.6.2012201623490.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sun, 20 Dec 2020 16:25:15 +0100 (CET)")
Message-ID: <xmqqblemlrv2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 57AC9668-43DB-11EB-83E5-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I need this on top, to make it work on Windows:
>> ...
> How about this instead (to fix that part of the CI failures of `seen`)?

Ah, I didn't knew the backburnered stuff was breaking 'seen'.
Thanks for helping to cleanse 'seen'; I do not actually mind
dropping the offending topic at this point in the cycle, though.

> -- snipsnap --
> From e8ce19db04657b6ef1c73989695c97a773a9c001 Mon Sep 17 00:00:00 2001
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Fri, 28 Aug 2020 14:50:25 +0200
> Subject: [PATCH] fixup??? git: catch an attempt to run "git-foo"
>
> This is needed to handle the case where `argv[0]` contains the full path
> (which is the case on Windows) and the suffix `.exe` (which is also the
> case on Windows).
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  git.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/git.c b/git.c
> index 7544d2187306..c924c53ea76f 100644
> --- a/git.c
> +++ b/git.c
> @@ -854,6 +854,7 @@ int cmd_main(int argc, const char **argv)
>  	const char *cmd;
>  	int done_help = 0;
>
> +	strip_extension(argv);
>  	cmd = argv[0];

Hph, would this make strip_extension() at the beginning of
handle_builtin() redundant and unneeded, I wonder?

Yes, I know stripping .exe twice would be fine most of the time, so
I'll queue the patch on top just to make 'seen' pass the tests, but
it is just as easy to discard jc/war-on-dashed-git topic, so...

>  	if (!cmd)
>  		cmd = "git-help";
> @@ -875,12 +876,11 @@ int cmd_main(int argc, const char **argv)
>  	 * So we just directly call the builtin handler, and die if
>  	 * that one cannot handle it.
>  	 */
> -	if (skip_prefix(cmd, "git-", &cmd)) {
> -		warn_on_dashed_git(argv[0]);
> +	if (skip_prefix(cmd, "git-", &argv[0])) {
> +		warn_on_dashed_git(cmd);
>
> -		argv[0] = cmd;
>  		handle_builtin(argc, argv);
> -		die(_("cannot handle %s as a builtin"), cmd);
> +		die(_("cannot handle %s as a builtin"), argv[0]);
>  	}
>
>  	/* Look for flags.. */
> --
> 2.30.0.rc0.windows.1
