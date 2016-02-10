From: Jeff King <peff@peff.net>
Subject: Re: git show doesn't work on file names with square brackets
Date: Wed, 10 Feb 2016 16:12:06 -0500
Message-ID: <20160210211206.GA5755@sigill.intra.peff.net>
References: <CACsJy8ChZzYWXePSwF6D8vPZMuz3dQe1=jtw6rSG7M1oC+RiNw@mail.gmail.com>
 <32B9BD70-F06C-49C4-B672-24173E69B99F@jetbrains.com>
 <CACsJy8AMEgk8UXF==VmvLXsL4R67u0+U4MiUGPtO6HX0Y30oXg@mail.gmail.com>
 <20160208141552.GC27054@sigill.intra.peff.net>
 <20160208150709.GA13664@sigill.intra.peff.net>
 <xmqqpow7807l.fsf@gitster.mtv.corp.google.com>
 <20160208195230.GA30693@sigill.intra.peff.net>
 <xmqqziv939ir.fsf@gitster.mtv.corp.google.com>
 <20160210161548.GC19867@sigill.intra.peff.net>
 <xmqqpow4zcwd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 22:12:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTc3b-0000l9-BG
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 22:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbcBJVMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 16:12:10 -0500
Received: from cloud.peff.net ([50.56.180.127]:39982 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750799AbcBJVMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 16:12:09 -0500
Received: (qmail 15915 invoked by uid 102); 10 Feb 2016 21:12:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Feb 2016 16:12:08 -0500
Received: (qmail 31653 invoked by uid 107); 10 Feb 2016 21:12:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Feb 2016 16:12:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Feb 2016 16:12:06 -0500
Content-Disposition: inline
In-Reply-To: <xmqqpow4zcwd.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285928>

On Wed, Feb 10, 2016 at 09:35:46AM -0800, Junio C Hamano wrote:

> > IOW, something like this implements the "permissive" thing I wrote above
> > (i.e., be inclusive when seeing if something could plausibly be a
> > filename, but exclusive when complaining that it _could_ be one):
> 
> Yup, I think that is probably a better first step.

Thanks. And thank you for the discussion. I read your response last
night and almost just said "OK, let's just scrap my patches, this isn't
worth the trouble". But after reading it again this morning, I think it
forced me to look at the problem in a new way. And while I did scrap my
original patches here, I think the result is accomplishing the same
thing in a much saner way.

Here's what I came up with.

  [1/3]: checkout: reorder check_filename conditional
  [2/3]: check_filename: tighten dwim-wildcard ambiguity
  [3/3]: get_sha1: don't die() on bogus search strings

The first is a minor preparatory cleanup, the second is the meat we've
been discussing, and the third is a bonus, though it has some tradeoffs.

-Peff
