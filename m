Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD832C433E3
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 18:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C15A20792
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 18:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgGWS0t (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 14:26:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:36450 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbgGWS0t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 14:26:49 -0400
Received: (qmail 16339 invoked by uid 109); 23 Jul 2020 18:26:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Jul 2020 18:26:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14430 invoked by uid 111); 23 Jul 2020 18:26:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Jul 2020 14:26:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Jul 2020 14:26:48 -0400
From:   Jeff King <peff@peff.net>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        "B. Stebler" <bono.stebler@gmail.com>, git@vger.kernel.org
Subject: Re: Improving merge of tricky conflicts
Message-ID: <20200723182648.GC3975154@coredump.intra.peff.net>
References: <a0418859-c62e-c207-a1b0-1b1aaf178527@gmail.com>
 <4df975f0-e4b1-afa1-cac1-f38e6d31a0d8@kdbg.org>
 <874kpzmhis.fsf@osv.gnss.ru>
 <xmqqwo2v45hq.fsf@gitster.c.googlers.com>
 <87tuxzl00h.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87tuxzl00h.fsf@osv.gnss.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 23, 2020 at 12:20:46AM +0300, Sergey Organov wrote:

> >> Is there 'git merge' command-line option for that? I failed to find one.
> >
> > There isn't, unless you count
> >
> >     $ git -c merge.conflictstyle=diff3 merge side-branch
> >
> > as a "command line option" (which may technically is).
> 
> Yeah, I thought of maybe making an alias for that, so apparently I do
> count it as command line option, thanks!

You can also do it after "git merge" aborts with conflicts by running:

  git checkout --conflict=diff3 my-file

but do note that it will check out from the index, overwriting any
resolution you've already done in that file.

-Peff
