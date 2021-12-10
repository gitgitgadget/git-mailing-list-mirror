Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E44AC433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 09:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239270AbhLJJcm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 04:32:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:48566 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236575AbhLJJck (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 04:32:40 -0500
Received: (qmail 18071 invoked by uid 109); 10 Dec 2021 09:29:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Dec 2021 09:29:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28459 invoked by uid 111); 10 Dec 2021 09:29:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Dec 2021 04:29:08 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Dec 2021 04:29:05 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH 12/19] tests: fix broken &&-chains in `{...}` groups
Message-ID: <YbMd4cuRs9aiPWbX@coredump.intra.peff.net>
References: <20211209051115.52629-1-sunshine@sunshineco.com>
 <20211209051115.52629-13-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211209051115.52629-13-sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 09, 2021 at 12:11:08AM -0500, Eric Sunshine wrote:

> The top-level &&-chain checker built into t/test-lib.sh causes tests to
> magically exit with code 117 if the &&-chain is broken. However, it has
> the shortcoming that the magic does not work within `{...}` groups,
> `(...)` subshells, `$(...)` substitutions, or within bodies of compound
> statements, such as `if`, `for`, `while`, `case`, etc. `chainlint.sed`
> partly fills in the gap by catching broken &&-chains in `(...)`
> subshells, but bugs can still lurk behind broken &&-chains in the other
> cases.
> 
> Fix broken &&-chains in `{...}` groups in order to reduce the number of
> possible lurking bugs.

Seems good. This is mostly stuff we don't expect to fail (mostly
"echo"), so I doubt they're important on their own. But getting a clean
state for the linter _is_ important.

-Peff
