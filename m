Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 10969 invoked by uid 107); 4 Oct 2009 13:35:06 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sun, 04 Oct 2009 09:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755931AbZJDNaQ (ORCPT <rfc822;peff@peff.net>);
	Sun, 4 Oct 2009 09:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754141AbZJDNaP
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Oct 2009 09:30:15 -0400
Received: from peff.net ([208.65.91.99]:51581 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754112AbZJDNaO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2009 09:30:14 -0400
Received: (qmail 10946 invoked by uid 107); 4 Oct 2009 13:33:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 04 Oct 2009 09:33:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 04 Oct 2009 09:29:36 -0400
Date:	Sun, 4 Oct 2009 09:29:36 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
Subject: Re: Interim maintainer tree
Message-ID: <20091004132936.GA13804@sigill.intra.peff.net>
References: <20090925160504.GW14660@spearce.org>
 <7viqevu1zt.fsf@alter.siamese.dyndns.org>
 <20091004064129.GB7076@coredump.intra.peff.net>
 <7viqevpjr3.fsf@alter.siamese.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7viqevpjr3.fsf@alter.siamese.dyndns.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Oct 04, 2009 at 02:54:08AM -0700, Junio C Hamano wrote:

> >   - silence gcc warning:
> >     http://article.gmane.org/gmane.comp.version-control.git/129485
> >     The warning is overly cautious, I think, but it is a dubious enough
> >     construct that it is probably worth fixing.
> 
> I cannot reach gmane now, but if this is about -Wextra, I'd rather not
> touch it before the release.  "comparison between signed and unsigned"
> tends to be excessive and IMNSHO it is crazy to use -Wextra and -Werror 
> together.

Actually, I mislabeled this. It is about a glibc run-time complaint not
a gcc warning, which is more worrisome. It is triggered by an argv list
where we pass (argv - 1) to something expecting only to index it
starting from '1'. I'm not sure yet if it is glibc being picky or if we
violate that assumption somewhere. I'll post a followup in the thread.

-Peff
