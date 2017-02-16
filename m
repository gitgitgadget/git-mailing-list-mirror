Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83DB41FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 19:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932916AbdBPTCE (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 14:02:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:56581 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932379AbdBPTCD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 14:02:03 -0500
Received: (qmail 15261 invoked by uid 109); 16 Feb 2017 19:02:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Feb 2017 19:02:02 +0000
Received: (qmail 26035 invoked by uid 111); 16 Feb 2017 19:02:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Feb 2017 14:02:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Feb 2017 14:02:00 -0500
Date:   Thu, 16 Feb 2017 14:02:00 -0500
From:   Jeff King <peff@peff.net>
To:     Fabrizio Cucci <fabrizio.cucci@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Back quote typo in error messages (?)
Message-ID: <20170216190200.h362e52uxqlkduar@sigill.intra.peff.net>
References: <CAOxYW4z=bABqhmHWCc9rizykMcGBjDvqLEuqpJ6DtPve5442Fw@mail.gmail.com>
 <20170215212157.qgscyglgzrd5cplf@sigill.intra.peff.net>
 <CAOxYW4xqk4j6Uu86jq2Vi9Bpgihxfr2Tw-DQLc+7YTZiPmDtiA@mail.gmail.com>
 <20170215215633.deyxp76j7o3ceoq3@sigill.intra.peff.net>
 <CAOxYW4x93cjMJoXYzSXCwqYVEstSLLcxzad_BPdvxfasrkxapw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOxYW4x93cjMJoXYzSXCwqYVEstSLLcxzad_BPdvxfasrkxapw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2017 at 06:41:26PM +0000, Fabrizio Cucci wrote:

> On 15 February 2017 at 21:56, Jeff King <peff@peff.net> wrote:
> > Grep for "``" in Git's documentation directory, and you will see many
> > examples (asciidoc only accepts the double-quote form, not singles).
> >
> > You can also try:
> >
> >   echo "this is \`\`quoted'' text" >foo.txt
> >   asciidoc foo.txt
> >
> > and then open "foo.html" in your browser.
> 
> We are probably going a bit OT here :) but AFAIK there is no such
> thing as non-symmetric start/end quotes in AsciiDoc.
> 
> Even enclosing something in curved quotes is done as follows:
> 
> '`single curved quotes`'
> 
> "`double curved quotes`"
> 
> (http://asciidoctor.org/docs/asciidoc-syntax-quick-reference/)

Try the "Quoted Text" section of the original asciidoc user manual:

  http://www.methods.co.nz/asciidoc/userguide.html#X51

Asciidoctor has introduced some new syntax (almost certainly because the
original asymmetric formulations have a bunch of ambiguous corner
cases). By default, it disables the asymmetric versions, but they work
in "compat" mode (and the newer ones do not).

Git's documentation is all written for the original asciidoc. If you
build it with asciidoctor, it must be done in compat mode. This is the
default when asciidoctor sees a two-line (i.e., underlined) section
title, which all of our manpages have.

More details at:

  http://asciidoctor.org/docs/migration/#migration-cheatsheet

Yes, we are off-topic,. but I think it is worth clarifying Git's
asciidoc compatibility expectations. :)

-Peff
