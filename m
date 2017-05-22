Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 497372023D
	for <e@80x24.org>; Mon, 22 May 2017 19:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761954AbdEVTxv (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 15:53:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:56215 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761948AbdEVTxs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 15:53:48 -0400
Received: (qmail 21129 invoked by uid 109); 22 May 2017 19:53:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 May 2017 19:53:37 +0000
Received: (qmail 24157 invoked by uid 111); 22 May 2017 19:54:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 May 2017 15:54:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 May 2017 15:53:35 -0400
Date:   Mon, 22 May 2017 15:53:35 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     DOAN Tran Cong Danh <congdanhqx@gmail.com>, git@vger.kernel.org,
        animi.vulpis@gmail.com, gitster@pobox.com, git@grubix.eu,
        pclouds@gmail.com, karthik.188@gmail.com
Subject: Re: [PATCH v3] ref-filter: trim end whitespace in subject
Message-ID: <20170522195334.eoj4u4nxupyl6dho@sigill.intra.peff.net>
References: <20170522145753.83810-1-congdanhqx@gmail.com>
 <20170522171014.33384-1-congdanhqx@gmail.com>
 <777c63ed-c1e3-8efd-48cd-91ac2a841631@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <777c63ed-c1e3-8efd-48cd-91ac2a841631@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 22, 2017 at 09:47:59PM +0200, Johannes Sixt wrote:

> Am 22.05.2017 um 19:10 schrieb DOAN Tran Cong Danh:
> > diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
> > index 5778c0afe..fa4441868 100755
> > --- a/t/t3203-branch-output.sh
> > +++ b/t/t3203-branch-output.sh
> > @@ -13,7 +13,8 @@ test_expect_success 'make commits' '
> >   test_expect_success 'make branches' '
> >   	git branch branch-one &&
> > -	git branch branch-two HEAD^
> > +	git branch branch-two $(printf "%s\r\n" one " " line3_long line4 |
> > +	     git commit-tree HEAD:)
> >   '
> >   test_expect_success 'make remote branches' '
> > 
> 
> This updated test shows nothing, I am afraid: If I apply only this change
> without the rest of the patch, then all test in t3203 still pass. And I do
> not see how the code change could make any difference at all. What am I
> missing?

It does for me here on Linux; I wonder if the CRs are being eaten by the
shell expansion.

-Peff
