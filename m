Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F735EB64DD
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 15:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbjHKPCs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 11:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbjHKPCq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 11:02:46 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0082910FE
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 08:02:45 -0700 (PDT)
Received: (qmail 15949 invoked by uid 109); 11 Aug 2023 15:02:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Aug 2023 15:02:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26297 invoked by uid 111); 11 Aug 2023 15:02:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Aug 2023 11:02:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Aug 2023 11:02:44 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/4] commit-graph: fsck zero/non-zero generation number
 fixes
Message-ID: <20230811150244.GD2303200@coredump.intra.peff.net>
References: <ZNUiEXF5CP6WMk9A@nand.local>
 <cover.1691699851.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1691699851.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2023 at 04:37:32PM -0400, Taylor Blau wrote:

> This series expands on a patch that Peff sent earlier in this thread to
> remove a section of unreachable code that was noticed by Coverity in the
> `verify_one_commit_graph()` function.
> 
> The first couple of patches addresses the main issue, which is that we
> couldn't verify ancient commit-graphs written with zero'd generation
> numbers. The third patch adds additional tests to ensure our coverage in
> this area is complete, and the final patch is a cleanup.

Thanks for untangling (and explaining!) some of the history here. I
think this series is a definite improvement, including that final
cleanup. But I also think that the "two bits" approach mentioned by
Junio would be better still.  IMHO the intent of the code would be more
clear, and it would avoid the flip-flopping error case.

-Peff
