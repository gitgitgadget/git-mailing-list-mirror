Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E54BC4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 15:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F9A960F46
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 15:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbhHKPYI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 11:24:08 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47932 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232990AbhHKPYE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 11:24:04 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17BFN5Xb021892
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Aug 2021 11:23:06 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8AA7115C37C1; Wed, 11 Aug 2021 11:23:05 -0400 (EDT)
Date:   Wed, 11 Aug 2021 11:23:05 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     "lilinchao@oschina.cn" <lilinchao@oschina.cn>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [QUESTION]Is it possible that git would support two-factor
 authentication?
Message-ID: <YRPrWSj2TbshKTor@mit.edu>
References: <66e42438fa9311ebaeb60026b95c99cc@oschina.cn>
 <20210811135055.tqdblurgk3vw5lgm@nitro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210811135055.tqdblurgk3vw5lgm@nitro.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 11, 2021 at 09:50:55AM -0400, Konstantin Ryabitsev wrote:
> On Wed, Aug 11, 2021 at 07:00:50PM +0800, lilinchao@oschina.cn wrote:
> > Many websites support two-factor authentication(2FA) to log in,
> > like Github, I wander if we can support it in application layer.
> > When client clone something, they need  input username and
> > password, it is like a website login process. For security, we can
> > enable  2FA during this process.
> 
> As you well know, "cloning" a repository can be done via any number of
> mechanisms:
> 
> 1. locally from another repository on disk
> 2. locally, from a git bundle file
> 3. remotely, using the anonymous git:// protocol
> 4. remotely, using ssh or http(s) protocols
> 
> 2-factor authentication does not make sense in the first three cases (you
> already have access to all the objects with 1 and 2, and the git:// protocol
> is public and anonymous by design). For the ssh/https scheme, 2fa is already
> supported by the underlying protocol, so it does not make sense for git to
> implement it again on the application level.

It might be helpful to be explicit about what *kind* of two-factor
authentication you are interested in.  There are multiple different
kinds of 2FA systems, including ssh keys stored on a hardware token
such as a smartcard or a Yuibikey, U2F Fido systems using a security
key, TOTP or HOTP otp systems, etc.

Each of these systems have different tradeoffs in terms of ease of use
from the user perspective (both from the point of view of initial
setup and day-to-day use after getting set up), security against MITM
attacks, and ease of integration/deployment from the system
administrator's perspective.

Cheers,

						- Ted
