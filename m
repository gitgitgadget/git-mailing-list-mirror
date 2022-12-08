Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245D2C63708
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 06:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiLHGdy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 01:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiLHGdx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 01:33:53 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A6F2719
        for <git@vger.kernel.org>; Wed,  7 Dec 2022 22:33:48 -0800 (PST)
Received: (qmail 22726 invoked by uid 109); 8 Dec 2022 06:33:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Dec 2022 06:33:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9544 invoked by uid 111); 8 Dec 2022 06:33:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Dec 2022 01:33:48 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Dec 2022 01:33:46 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH v2 2/3] object-file: emit corruption errors when detected
Message-ID: <Y5GFSqKG1org13lc@coredump.intra.peff.net>
References: <221207.86pmcva2s8.gmgdl@evledraar.gmail.com>
 <20221207232623.1439026-1-jonathantanmy@google.com>
 <221208.86edta93e5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221208.86edta93e5.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 08, 2022 at 12:50:27AM +0100, Ævar Arnfjörð Bjarmason wrote:

> I have a mild preference for my latest suggestion as the ownership of
> all the variables seems cleanest in that iteration. I.e. we don't need
> to xstrdup(), and the "fd" is always contained within
> map_loose_object_1().
> 
> We still have the "sometimes a path, sometimes I make a path from an
> oid" semantics though, but that seems unavoidable.

Of the two warts, I think "this function consume the fd" is less weird
than the two path variables (one sometimes-in and one sometimes-out).
If the fd thing is too ugly, we could have the function _not_ consume
the fd, but I think that probably makes the callers worse.

At any rate, we can wait and see what Jonathan comes up with.

(As an aside, thank you Jonathan for dealing with some of this
long-standing ugliness; it is not directly related to your goal, but I
think it's adjacent enough to merit doing it as part of the series).

-Peff
