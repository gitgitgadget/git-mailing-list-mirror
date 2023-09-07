Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEE5EC8758
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 20:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjIGUHS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 16:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjIGUHR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 16:07:17 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1DD1BCC
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 13:07:13 -0700 (PDT)
Received: (qmail 27647 invoked by uid 109); 7 Sep 2023 09:00:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Sep 2023 09:00:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24805 invoked by uid 111); 7 Sep 2023 09:00:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Sep 2023 05:00:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Sep 2023 05:00:31 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/8] repack: refactor pack snapshot-ing logic
Message-ID: <20230907090031.GH1260718@coredump.intra.peff.net>
References: <cover.1693946195.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1693946195.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 05, 2023 at 04:36:37PM -0400, Taylor Blau wrote:

> This series refactors some of the 'git repack' internals to keep track
> of existing packs in a set of string lists stored in a single structure,
> instead of passing around multiple string lists to different functions
> throughout the various paths.
> 
> The result is that the interface around pack deletion, marking packs as
> redundant, and handling the set of pre-existing packs (both kept and
> non-kept) is significantly cleaner without introducing any functional
> changes.
> 
> I didn't mean to produce so much churn when I started writing these
> patches, which began as a simple effort to rename a couple of variables
> for more consistency.

These all look pretty reasonable to me. I wasn't quite sure about patch
7 and left some comments there, but all of the options are kind of ugly.
Since it's limited to that one file, it may not be worth spending too
much time or brain-power on trying to polish it further.

-Peff
