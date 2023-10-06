Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C74E92FD0
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 00:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjJFAy0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 20:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjJFAxm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 20:53:42 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B671997
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 17:51:42 -0700 (PDT)
Received: (qmail 30054 invoked by uid 109); 6 Oct 2023 00:51:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Oct 2023 00:51:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30817 invoked by uid 111); 6 Oct 2023 00:51:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Oct 2023 20:51:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Oct 2023 20:51:32 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] revision: clear decoration structs during
 release_revisions()
Message-ID: <20231006005132.GA992085@coredump.intra.peff.net>
References: <20231005212802.GA982892@coredump.intra.peff.net>
 <20231005213014.GB986467@coredump.intra.peff.net>
 <xmqq34yoekt5.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq34yoekt5.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 05, 2023 at 04:00:54PM -0700, Junio C Hamano wrote:

> Wow, nested maze of callbacks make my head spin ;-) but they all
> look reasonable.  Thanks.

Yeah, I don't love those one-liner callbacks just to handle the cast.

The other alternative is to write some kind of for_each_decoration()
macro, but I think it ends up in the usual macro hell (requiring the
caller to provide iterator variables, hanging half-open braces, and so
on). It might be worth it if iterating could be used in other places,
but I don't think it is.

So I tried to choose the lesser of two evils. :)

-Peff
