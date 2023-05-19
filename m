Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B183C77B7A
	for <git@archiver.kernel.org>; Fri, 19 May 2023 09:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjESJJW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 May 2023 05:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjESJJU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2023 05:09:20 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9231AC
        for <git@vger.kernel.org>; Fri, 19 May 2023 02:09:19 -0700 (PDT)
Received: (qmail 12468 invoked by uid 109); 19 May 2023 09:09:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 May 2023 09:09:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 339 invoked by uid 111); 19 May 2023 09:09:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 May 2023 05:09:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 May 2023 05:09:17 -0400
From:   Jeff King <peff@peff.net>
To:     M Hickford <mirth.hickford@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Which macOS versions does Git support?
Message-ID: <20230519090917.GB3515410@coredump.intra.peff.net>
References: <CAGJzqsnS3SnoW__aPQ+13s+-b3a+makCjWxR=z6mjgBBnuKjLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGJzqsnS3SnoW__aPQ+13s+-b3a+makCjWxR=z6mjgBBnuKjLg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 19, 2023 at 08:00:00AM +0100, M Hickford wrote:

> Hi. Does anyone know which macOS versions are supported by Git?

I don't think we have any formal decision here (or for any other
platform; it is usually a cost/benefit for individual features we may
want to depend on).

> Motivation: I spotted that git-credential-osxkeychain.c uses a
> deprecated API. SecKeychainAddInternetPassword was deprecated in
> 2014's macOS 10.10 [1].  Replacement SecItemAdd was introduced in
> 2009's macOS 10.6 [2].

+cc Taylor, who I know was looking into this recently.

I'd guess that anything older than 2009 is probably not worth worrying
about.

> Further motivation: If I understand the documentation correctly, the
> new SecItemAdd API has better support for storing attributes alongside
> secrets, which might be handy for storing Git credential's new
> password_expiry_utc attribute (d208bfd, credential: new attribute
> password_expiry_utc, 2023-02-18).

Yeah, that would be a nice bonus (in addition to avoiding a deprecated
interface).

-Peff
