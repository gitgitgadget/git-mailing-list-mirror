Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 136CD2021E
	for <e@80x24.org>; Thu, 10 Nov 2016 00:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754111AbcKJAXj (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Nov 2016 19:23:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:40975 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752325AbcKJAXi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2016 19:23:38 -0500
Received: (qmail 31659 invoked by uid 109); 10 Nov 2016 00:23:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Nov 2016 00:23:38 +0000
Received: (qmail 943 invoked by uid 111); 10 Nov 2016 00:24:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 09 Nov 2016 19:24:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Nov 2016 19:23:35 -0500
Date:   Wed, 9 Nov 2016 19:23:35 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/5] attr: do not respect symlinks for in-tree
 .gitattributes
Message-ID: <20161110002335.z2z2stjtzgspikxe@sigill.intra.peff.net>
References: <20161102130432.d3zprdul4sqgcfwu@sigill.intra.peff.net>
 <20161102130848.qpigt4hxpoyfjf7x@sigill.intra.peff.net>
 <CACsJy8AO2KtpxFu=wRjW1DoCA9bfpF1VoJUn__2ib-ML0XT66w@mail.gmail.com>
 <20161107211010.xo3243egggdgscou@sigill.intra.peff.net>
 <20161107211522.vzl4zpsu5cpembgc@sigill.intra.peff.net>
 <CACsJy8BoEXDjwe=ZX5ZOC_mvaMjYrB3i7wcMmiOP3mm5-rwC5Q@mail.gmail.com>
 <xmqqmvh88dlu.fsf@gitster.mtv.corp.google.com>
 <20161109231720.luuhezzziuhx4r75@sigill.intra.peff.net>
 <xmqqoa1o6vca.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqoa1o6vca.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 09, 2016 at 04:18:29PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Wed, Nov 09, 2016 at 02:58:37PM -0800, Junio C Hamano wrote:
> >
> > I'm slightly confused. Did you mean "supporting any in-tree symlink to
> > an out-of-tree destination" in your first sentence?
> 
> I was trying to say that these "control files used solely by git"
> have no business being a symbolic link pointing at anywhere, even
> inside the same tree; actually, especially if it is inside the same
> tree.

OK. That is what my patch does (modulo .gitmodules, which I did not
think of). But I think that is the opposite of Duy's opinion, as his
review seemed to object to that.

As you know my ulterior motive is dealing with malicious out-of-tree
symlinks, and I would be happy to deal with that directly. That still
leaves symlinked ".gitmodules" etc in a funny state (they work in the
filesystem but not in the index), but since nobody is _complaining_,
it's a bug we could leave for another day.

So I dunno.

-Peff
