Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3627020248
	for <e@80x24.org>; Tue, 12 Mar 2019 10:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfCLKwC (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 06:52:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:47032 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725894AbfCLKwB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 06:52:01 -0400
Received: (qmail 25639 invoked by uid 109); 12 Mar 2019 10:52:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 12 Mar 2019 10:52:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31456 invoked by uid 111); 12 Mar 2019 10:52:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 12 Mar 2019 06:52:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Mar 2019 06:51:59 -0400
Date:   Tue, 12 Mar 2019 06:51:59 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Duy Nguyen <pclouds@gmail.com>,
        Jeffrey Walton <noloader@gmail.com>,
        Todd Zullinger <tmz@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: disabling sha1dc unaligned access, was Re: One failed self test
 on Fedora 29
Message-ID: <20190312105159.GB2023@sigill.intra.peff.net>
References: <CAH8yC8k_Zyi89uxTWTrjN65UAAc1L+jLho+P7O7UyvE-LvZuzA@mail.gmail.com>
 <20190308174343.GX31362@zaya.teonanacatl.net>
 <CAH8yC8mg3vjPoof5SDemQ_YiL+7e1ak535U2nFnPbaWJ8xSWOA@mail.gmail.com>
 <CAH8yC8kn=EmEm_UPrnpwaofv97S42Se6FC+hWcm0EHCX-4rewQ@mail.gmail.com>
 <xmqq1s3emapy.fsf@gitster-ct.c.googlers.com>
 <20190311033755.GB7087@sigill.intra.peff.net>
 <CACsJy8CdqbOKu7SHMt_Pz1EtRz08HGpwWHUHoZbUiow_pPh=+A@mail.gmail.com>
 <8cf2fa6c-d742-a2a6-cde7-66cef87b04e8@virtuell-zuhause.de>
 <20190311182328.GB16865@sigill.intra.peff.net>
 <xmqqa7i0h7r6.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa7i0h7r6.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 12, 2019 at 04:27:57PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The problem to me is not that the steps that a developer has to do, but
> > rather that we are dependent on the upstream project to make a simple
> > fix (which they may not agree to do, or may take a long time to do).
> 
> Yeah.  In practice, I think the recommended way to work for a
> depending project like us is to keep a fork in a separate repository
> we control of the submodule project, and allow our fork to be
> slightly ahead of the upstream while feeding our change to them.

Reading Thomas's email again, that might actually have been what he was
recommending. If so, sorry for the confusion. And I agree that's a valid
solution.

That said, I do wonder at some point if there's a huge value in using a
submodule at that point. I think there is if the dependent project is
large (and if it's optional, and some people might not need it). But in
this case, it is not a big deal to just carry the sha1dc code in-tree.

-Peff
