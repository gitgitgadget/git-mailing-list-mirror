Return-Path: <SRS0=aK8K=3V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941C1C33C9E
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 11:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64948206E6
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 11:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgBALQh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Feb 2020 06:16:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:50330 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726265AbgBALQh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Feb 2020 06:16:37 -0500
Received: (qmail 21119 invoked by uid 109); 1 Feb 2020 11:16:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 01 Feb 2020 11:16:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8070 invoked by uid 111); 1 Feb 2020 11:24:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 01 Feb 2020 06:24:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 1 Feb 2020 06:16:36 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?Q?=C3=89tienne?= Servais <etienne.servais@voucoux.fr>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: add documentation for git log --no-follow
Message-ID: <20200201111636.GC1864948@coredump.intra.peff.net>
References: <85e71c97-9e0a-863e-179f-a6e1f14365ce@voucoux.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85e71c97-9e0a-863e-179f-a6e1f14365ce@voucoux.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 01, 2020 at 12:24:31AM +0100, Étienne Servais wrote:

> This feature was added by commit
> 076c98372e (log: add "log.follow" configuration variable, 2015-07-07)
> but remained undocumented.

That commit just touched the code; it was originally added by aebbcf5797
(diff: accept --no-follow option, 2012-09-21). But I think the general
intent of your patch is still valid.

> Signed-off-by: Étienne Servais <etienne.servais@voucoux.fr>
> ---
> This is my first patch to git \o/
> Sent with thunderbird with help of format-patch'doc (So, it works!).

Yeah, everything looks good there (no whitespace damage, etc).

> I couldn't figure if I shall merge the --no-follow doc with the follow
> as is done for --no-decorate and --decorate just after.

I think it would make more sense to just put it with --follow, like:

  [--no-]follow::

which matches how --use-mailmap is defined, for instance.

> @@ -205,7 +208,8 @@ log.follow::
>  	If `true`, `git log` will act as if the `--follow` option was used when
>  	a single <path> is given.  This has the same limitations as `--follow`,
>  	i.e. it cannot be used to follow multiple files and does not work well
> -	on non-linear history.
> +	on non-linear history. This setting can be disabled by the `--no-follow`
> +	option.

I'm on the fence on this hunk. There are a number of config options that
can be canceled or overridden by command-line options. It's a normal
pattern for the "--no" variant to do so. So while it often doesn't hurt
to give a pointer in the right direction, I don't know that we'd want to
start doing so in every such case.

-Peff
