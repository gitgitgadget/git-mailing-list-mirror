Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34341C433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 06:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbiGLGyx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 02:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiGLGyw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 02:54:52 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181448AEC2
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 23:54:48 -0700 (PDT)
Received: (qmail 10419 invoked by uid 109); 12 Jul 2022 06:54:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Jul 2022 06:54:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27645 invoked by uid 111); 12 Jul 2022 06:54:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Jul 2022 02:54:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Jul 2022 02:54:47 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v6 11/27] revisions API users: add "goto cleanup" for
 release_revisions()
Message-ID: <Ys0at7pMPUrrmEaB@coredump.intra.peff.net>
References: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
 <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
 <patch-v6-11.27-e93791b6242-20220413T195935Z-avarab@gmail.com>
 <YsxmrRCSpze1csHz@coredump.intra.peff.net>
 <220711.86tu7n5ryf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220711.86tu7n5ryf.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 11, 2022 at 10:12:18PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > I was also somewhat confused by the double-assignment of "result" in the
> > cleanup label. But I think that is because diff_result_code() is
> > massaging the current value of "result" into the right thing. But in
> > that case, should the "-1" from earlier be passed to diff_result_code()?
> > I think probably not (and certainly it was not before your patch). Which
> > would imply that the label should go after that, like:
> [...]
> 
> Urgh, yes that's the obviously correct fix to bring it back to the
> previous behavior, it's indeed just a misplaced "cleanup" label, sorry
> about that.

Thanks, I'll work it up into a real patch. Which I should have just done
in the first place; I just hadn't convinced myself I understood
everything until I finished writing the other email. :)

-Peff
