Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58546FA373D
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 07:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiKAHcK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 03:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKAHcJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 03:32:09 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC7515704
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 00:32:08 -0700 (PDT)
Received: (qmail 4771 invoked by uid 109); 1 Nov 2022 07:32:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Nov 2022 07:32:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20292 invoked by uid 111); 1 Nov 2022 07:32:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Nov 2022 03:32:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Nov 2022 03:32:06 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] t5516: move plaintext-password tests from t5601 and
 t5516
Message-ID: <Y2DLdsM2CYY3Z2Sc@coredump.intra.peff.net>
References: <Y2CDrZNgNZ+flJBK@coredump.intra.peff.net>
 <Y2CD4g9z2yVFA06l@coredump.intra.peff.net>
 <221101.865yfz5pjp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221101.865yfz5pjp.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 01, 2022 at 04:18:32AM +0100, Ævar Arnfjörð Bjarmason wrote:

> Did you consider just using git://; on the WIP branch I linked to where
> I fixed these tests quite a bit already I left them in their own file in
> anticipation of having to test that (but didn't finish that yet). I.e.:

No, I didn't really consider that. Mostly because I was trying to stick
with the original intent of 6dcbdc0d66 that created them.

If we toss that out, then in theory that widens the options. And in some
ways it's nice to use git://, because it has fewer dependencies and so
is run on more platforms. But it strikes me as a pretty unrealistic
test, just because credentials in git:// URLs make no sense and are not
something anybody would do.

As you note, since the error comes from remote.c, it would still
trigger. But it's a bit more "white box" testing than I think makes
sense here. I prefer the original tests' method of trying to create
plausible real-world scenarios and seeing how they behave (and I think
my patch even improves that, since having an actual server on the other
end is the usual case).

-Peff
