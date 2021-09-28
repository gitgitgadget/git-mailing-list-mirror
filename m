Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD23C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 17:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4300A6120D
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 17:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242123AbhI1SAc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 14:00:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:56808 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236453AbhI1SAa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 14:00:30 -0400
Received: (qmail 10561 invoked by uid 109); 28 Sep 2021 17:58:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Sep 2021 17:58:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1771 invoked by uid 111); 28 Sep 2021 17:58:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Sep 2021 13:58:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Sep 2021 13:58:49 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/5] refs: remove long-dead code
Message-ID: <YVNX2QrdR7XZFfqA@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20210928T130032Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-0.5-00000000000-20210928T130032Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 28, 2021 at 03:02:19PM +0200, Ævar Arnfjörð Bjarmason wrote:

> This removes dead code in the refs backend, mainly in the
> ref-cache. By line count this is mostly a straightforward follow-up to
> 9939b33d6a3 (packed-backend: rip out some now-unused code, 2017-09-08)
> and 9dd389f3d8d (packed_ref_store: get rid of the `ref_cache`
> entirely, 2017-09-25).

Thanks, all five look good to me.

Reading through I was surprised the loose backend didn't use
add_ref_entry(), but that's because it uses add_entry_to_dir() more
directly. And that also explains why the "incomplete" parameter in the
final patch was always 1: in the loose world, we are always reading as
incrementally as possible.

So patches 2-4 are really just fallout from switching the packed-refs
reading away from ref-cache. Makes sense.

-Peff
