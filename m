Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D15C433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 19:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiJQTS2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 15:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiJQTS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 15:18:27 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D7376540
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 12:18:26 -0700 (PDT)
Received: (qmail 27753 invoked by uid 109); 17 Oct 2022 19:18:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 Oct 2022 19:18:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10030 invoked by uid 111); 17 Oct 2022 19:18:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Oct 2022 15:18:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Oct 2022 15:18:24 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 00/11] cocci: make "incremental" possible + a
 ccache-like tool
Message-ID: <Y02qgLP12p0c+XWB@coredump.intra.peff.net>
References: <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com>
 <cover-v3-00.11-00000000000-20221014T152552Z-avarab@gmail.com>
 <Y02V0E0JRSNa4Sb9@coredump.intra.peff.net>
 <221017.86czaqjnhy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221017.86czaqjnhy.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 17, 2022 at 08:36:46PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Maybe we don't do any of the things that could trigger problems in our
> > spatch rules. But it's not clear to me what we're risking. Do you have a
> > link for further discussion?
> 
> I think 10/11's commit message should answer your question:
> https://lore.kernel.org/git/patch-v3-10.11-52177ea2a68-20221014T152553Z-avarab@gmail.com/
> 
> The tl;dr is that it's not safe in the general case, as noted in the
> post you & the more recent one I linked to in 10/11.

Thanks. Holy cow, the coccinelle list is hard to use compared to
lore/public-inbox. The direct link to the thread in question is:

  https://sympa.inria.fr/sympa/arc/cocci/2022-09/msg00001.html

(you'll need to click a javascript button to see it, though).

> So, with this series doing:
> 
> 	perl -pi -e 's/swap/preincrement/g' contrib/coccinelle/swap.cocci
> 
> Will error it if you run it with "SPATCH_CONCAT_COCCI=Y", but not with
> "SPATCH_CONCAT_COCCI=", as the rule names conflict in the ALL.cocci.
> 
> But as 10/11 notes we can just avoid this by not picking conflicting
> names, which doesn't seem like an undue burden.

Yeah, that seems OK, then. In fact, I'd be fine with guidance in the
README saying "don't bother with a name if you don't need it".

-Peff
