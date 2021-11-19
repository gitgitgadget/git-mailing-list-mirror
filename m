Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71120C433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 14:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E7C4613A3
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 14:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbhKSOnI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 09:43:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:34866 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232249AbhKSOnH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 09:43:07 -0500
Received: (qmail 8276 invoked by uid 109); 19 Nov 2021 14:40:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Nov 2021 14:40:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13079 invoked by uid 111); 19 Nov 2021 14:40:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Nov 2021 09:40:05 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Nov 2021 09:40:04 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] strbuf: remove unused istarts_with() function
Message-ID: <YZe3RCFsXomGHv3G@coredump.intra.peff.net>
References: <cover-0.6-00000000000-20211119T124420Z-avarab@gmail.com>
 <patch-5.6-642eec3d77c-20211119T124420Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-5.6-642eec3d77c-20211119T124420Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 19, 2021 at 01:46:25PM +0100, Ævar Arnfjörð Bjarmason wrote:

> This function was added in 66b8af3e124 (strbuf: add a case insensitive
> starts_with(), 2018-03-09) for use with code added in
> 2f0c4a362c5 (utf8: teach same_encoding() alternative UTF encoding
> names, 2018-04-15).
> 
> That use got rewritten in ed283588330 (convert: use skip_iprefix() in
> validate_encoding(), 2019-11-08) to use skip_iprefix() instead.
> 
> It's arguably slightly odd to have a skip_prefix() and iskip_prefix(),
> but not both variants when it comes to starts_with(), but this is easy
> enough to resurrect should we ever need it, so let's drop it for now.

I have a custom patch that uses istarts_with(), but it's not something
that will ever go upstream. I'll probably just switch it to do:

  skip_iprefix(..., &dummy);

which is equivalent. Not really an objection, but just mentioning that
unused functions may have ripple effects for topics in flight.

-Peff
