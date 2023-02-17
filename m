Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42341C636D6
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 20:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjBQU0i (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 15:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjBQU0f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 15:26:35 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB3460A76
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 12:26:06 -0800 (PST)
Received: (qmail 14764 invoked by uid 109); 17 Feb 2023 20:25:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Feb 2023 20:25:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23080 invoked by uid 111); 17 Feb 2023 20:25:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Feb 2023 15:25:31 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 17 Feb 2023 15:25:31 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Raul E Rangel <rrangel@chromium.org>, git@vger.kernel.org
Subject: Re: Feature request: Add --mtime option to git archive
Message-ID: <Y+/iu7j+NsS/3sAX@coredump.intra.peff.net>
References: <Y+6G9n6cWRT9EKyl@google.com>
 <Y+6akicTFG9n0eZy@coredump.intra.peff.net>
 <xmqq5yc1p7yn.fsf@gitster.g>
 <Y+7PcqpYhF5ZuApG@coredump.intra.peff.net>
 <xmqqpma9m4i1.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpma9m4i1.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2023 at 06:04:38PM -0800, Junio C Hamano wrote:

> > I do wonder if people would complain (both with the patch above and with
> > brian's proposal) that the resulting tarballs extract everything with a
> > date in 1970. That's not functionally a problem, but it looks kind of
> > weird in "ls -l".
> 
> And owned by root:root ;-)

Yeah, though I think it's pretty standard these days to use
--no-same-owner or equivalent (and it's the default for non-root users).
And ditto for modes. I wondered if there was an equivalent for
timestamps. It looks like "-m" works (it just sets everything to the
current timestamp at time of extraction), but I don't know how portable
that is (and POSIX is no help with tar, as usual).

-Peff
