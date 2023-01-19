Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD715C004D4
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 08:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjASIUO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 03:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjASIUN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 03:20:13 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F622470AA
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 00:20:10 -0800 (PST)
Received: (qmail 9562 invoked by uid 109); 19 Jan 2023 08:20:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 19 Jan 2023 08:20:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30319 invoked by uid 111); 19 Jan 2023 08:20:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 19 Jan 2023 03:20:13 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 19 Jan 2023 03:20:08 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] hash-object: fix descriptor leak with --literally
Message-ID: <Y8j9OP6EeGN6nBDg@coredump.intra.peff.net>
References: <Y8ijpJqtkDTi792i@coredump.intra.peff.net>
 <xmqqtu0n2g67.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtu0n2g67.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2023 at 10:26:40PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > In hash_object(), we open a descriptor for each file to hash (whether we
> > got the filename from the command line or --stdin-paths), but never
> > close it. For the traditional code path which feeds the result to
> > index_fd(), this is OK; it closes the descriptor for us.
> >
> > But 5ba9a93b39 (hash-object: add --literally option, 2014-09-11) a
> > second code path which does not close the descriptor.
> 
> A sentence without verb?  "5ba9 (hash-...) added a second code path,
> which does not close the descriptor." or something?

Yes, the missing word was "added". Thanks.

-Peff
