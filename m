Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA5DC20248
	for <e@80x24.org>; Tue, 12 Mar 2019 21:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfCLVTK (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 17:19:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:47820 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726329AbfCLVTK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 17:19:10 -0400
Received: (qmail 2990 invoked by uid 109); 12 Mar 2019 21:19:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 12 Mar 2019 21:19:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3977 invoked by uid 111); 12 Mar 2019 21:19:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 12 Mar 2019 17:19:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Mar 2019 17:19:08 -0400
Date:   Tue, 12 Mar 2019 17:19:08 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeffrey Walton <noloader@gmail.com>,
        Todd Zullinger <tmz@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] Makefile: fix unaligned loads in sha1dc with UBSan
Message-ID: <20190312211908.GA24509@sigill.intra.peff.net>
References: <CAH8yC8k_Zyi89uxTWTrjN65UAAc1L+jLho+P7O7UyvE-LvZuzA@mail.gmail.com>
 <20190308174343.GX31362@zaya.teonanacatl.net>
 <CAH8yC8mg3vjPoof5SDemQ_YiL+7e1ak535U2nFnPbaWJ8xSWOA@mail.gmail.com>
 <CAH8yC8kn=EmEm_UPrnpwaofv97S42Se6FC+hWcm0EHCX-4rewQ@mail.gmail.com>
 <xmqq1s3emapy.fsf@gitster-ct.c.googlers.com>
 <20190311033755.GB7087@sigill.intra.peff.net>
 <20190312210626.GA5157@sigill.intra.peff.net>
 <87va0nbxmj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87va0nbxmj.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 12, 2019 at 10:17:56PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > Here's a commit which updates Git to use the new feature. I've tested it
> > with both the in-tree and submodule builds like:
> >
> >   make DC_SHA1_SUBMODULE=Yes SANITIZE=undefined && (cd t && ./t0001-*)
> >   make DC_SHA1_SUBMODULE=    SANITIZE=undefined && (cd t && ./t0001-*)
> >
> > both of which fail without this patch and succeed without it.
> 
> FWIW I've reproduced this testing and found the same thing. Looks good
> to me.

Er, that second "without" should be "with", but hopefully you figured
that out during your testing. :)

-Peff
