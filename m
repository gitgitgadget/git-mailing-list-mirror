Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F7E220989
	for <e@80x24.org>; Mon, 10 Oct 2016 18:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbcJJSVo (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 14:21:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:55199 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751691AbcJJSVn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 14:21:43 -0400
Received: (qmail 7247 invoked by uid 109); 10 Oct 2016 18:21:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Oct 2016 18:21:31 +0000
Received: (qmail 375 invoked by uid 111); 10 Oct 2016 18:21:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Oct 2016 14:21:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Oct 2016 14:21:29 -0400
Date:   Mon, 10 Oct 2016 14:21:29 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] git.c: support "!!" aliases that do not move cwd
Message-ID: <20161010182129.fta7j7m3lxcgsn2d@sigill.intra.peff.net>
References: <xmqq60p5l3om.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1610071319520.35196@virtualbox>
 <CACsJy8ASc7Fxm5XDHFiX9E+bQ8s1MtmEHfc7bZY4C-_GEQr0og@mail.gmail.com>
 <0347de20-72a7-b384-389f-4b2ad5789973@kdbg.org>
 <20161007175052.sxyk7y2ytjh36phr@sigill.intra.peff.net>
 <alpine.DEB.2.20.1610081034430.35196@virtualbox>
 <20161009060149.voqjoiltqi6jub7g@sigill.intra.peff.net>
 <CACsJy8BpYYJmBm32YsQyuP58uhLE+sn8WdhiHyY6xzcqPVjMVQ@mail.gmail.com>
 <20161009205854.byq2wqgemtmwudfb@sigill.intra.peff.net>
 <xmqqzimcf5wl.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzimcf5wl.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2016 at 10:52:26AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Having separate exec/shell boolean options just punts the overlap from
> > the command key to those keys. If you have two mutually exclusive
> > options, I think the best thing is a single option, like:
> >
> >   type = <shell | exec | whatever>
> >
> > and then it is obvious that a second appearance of "type" overrides an
> > earlier one, by our usual "last one wins" convention. As opposed to:
> >
> >   shell = true
> >   exec = true
> >
> > where you have to understand the meaning of each option to know that
> > "exec" overrides "shell".
> 
> Good.  
> 
> Duy's "do we want to chdir or stay?" would be an orthogonal axis to
> "what does the command line look like?" and "how is the command line
> run?" so it adds one member to the "alias.<string>.*" family of
> variables, I guess.

Yeah, exactly. There may be other orthogonal axes to add, too, but I do
not have any in mind myself. My main motive in switching to the
"alias.$cmd.key" syntax is that it fixes the ancient mistake of putting
arbitrary content into the key (just like pager.*, as we've discussed
elsewhere).

-Peff
