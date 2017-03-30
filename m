Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8373F1FAFB
	for <e@80x24.org>; Thu, 30 Mar 2017 06:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754977AbdC3G1e (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 02:27:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:54011 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754762AbdC3G1d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 02:27:33 -0400
Received: (qmail 12049 invoked by uid 109); 30 Mar 2017 06:27:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Mar 2017 06:27:32 +0000
Received: (qmail 29254 invoked by uid 111); 30 Mar 2017 06:27:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Mar 2017 02:27:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Mar 2017 02:27:30 -0400
Date:   Thu, 30 Mar 2017 02:27:30 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/18] snprintf cleanups
Message-ID: <20170330062730.ycsok7skrjy5c6en@sigill.intra.peff.net>
References: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
 <xmqq60itc9pv.fsf@gitster.mtv.corp.google.com>
 <20170329034105.bfgh4tutgrmjp2lc@sigill.intra.peff.net>
 <xmqqr31gax0y.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr31gax0y.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 29, 2017 at 09:05:33AM -0700, Junio C Hamano wrote:

> > I think there are two things going on in your example.
> >
> > One is that obviously patch_id_addf() removes the spaces from the
> > result. But we could do that now by keeping the big strbuf_addf(), and
> > then just walking the result and feeding non-spaces.
> >
> > The second is that your addf means we are back to formatting everything
> > into a buffer again....
> 
> You are right to point out that I was blinded by the ugliness of
> words stuck together without spaces in between, which was inherited
> from the original code, and failed to see the sole point of this
> series, which is to remove truncation without adding unnecessary
> allocation and freeing.
> 
> Thanks for straighten my thinking out.  I think the seeming
> ugliness, if it ever becomes a real problem, should be handled
> outside this series after the dust settles.

Yeah, the no-spaces thing should almost certainly wait.

There is still the minor question of whether skipping the strbuf
entirely is nicer, even if you still have to feed it strings without
spaces (i.e., what I posted in my initial reply).

I'm OK either with the series I posted, or wrapping up the alternative
in a commit message.

-Peff
