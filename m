Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF36C433F5
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 23:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44C4A60C4B
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 23:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbhJLXJf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 19:09:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:38188 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229588AbhJLXJe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 19:09:34 -0400
Received: (qmail 1936 invoked by uid 109); 12 Oct 2021 23:07:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Oct 2021 23:07:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19911 invoked by uid 111); 12 Oct 2021 23:07:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Oct 2021 19:07:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Oct 2021 19:07:31 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] config: make git_config_include() static
Message-ID: <YWYVM8dzC/w8t7vk@coredump.intra.peff.net>
References: <cover.1634077795.git.jonathantanmy@google.com>
 <179df6d6adfe460de7413e1fb1dff6bce185ae0e.1634077795.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <179df6d6adfe460de7413e1fb1dff6bce185ae0e.1634077795.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 12, 2021 at 03:57:22PM -0700, Jonathan Tan wrote:

> It is not used from outside the file in which it is declared.

Makes sense. We used to use it from builtin/config.c, but that went away
in e895589883 (git-config: use git_config_with_options, 2012-10-23).

> diff --git a/config.h b/config.h
> index 147f5e0490..b11b0be09a 100644
> --- a/config.h
> +++ b/config.h
> @@ -126,6 +126,8 @@ int git_default_config(const char *, const char *, void *);
>  /**
>   * Read a specific file in git-config format.
>   * This function takes the same callback and data parameters as `git_config`.
> + *
> + * Unlike git_config(), this function does not respect includes.
>   */

Breaking out the relevant caller-facing parts of the documentation like
this is a nice touch.

And the rest of the patch looks good to me.

-Peff
