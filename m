From: Jeff King <peff@peff.net>
Subject: Re: Git configure/make does not honor ARFLAGS
Date: Mon, 14 Sep 2015 00:30:16 -0400
Message-ID: <20150914043016.GA10167@sigill.intra.peff.net>
References: <CAH8yC8kV77h8cRA9Qo_1FYe9sv0zgsE7yKxaX+OtpRfj9+7wog@mail.gmail.com>
 <20150913101727.GB26562@sigill.intra.peff.net>
 <CAPig+cQV-kaDDdBH+QZXsSjDHjP2CUYDXp3WKSBtgguVmLvofg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeffrey Walton <noloader@gmail.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 06:30:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbLPM-0007fS-DO
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 06:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbbINEaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 00:30:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:58569 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750832AbbINEaT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 00:30:19 -0400
Received: (qmail 21555 invoked by uid 102); 14 Sep 2015 04:30:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 13 Sep 2015 23:30:19 -0500
Received: (qmail 23254 invoked by uid 107); 14 Sep 2015 04:30:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 14 Sep 2015 00:30:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Sep 2015 00:30:16 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cQV-kaDDdBH+QZXsSjDHjP2CUYDXp3WKSBtgguVmLvofg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277803>

On Sun, Sep 13, 2015 at 01:11:46PM -0400, Eric Sunshine wrote:

> > Hrm. Your "$(AR)" is not really "ar" then, is it? It has been a long
> > time since I played with libtool, but what is the reason that you are
> > calling libtool and not "ar" in the first place. Is it that you do not
> > have "ar" at all, and libtool performs some other procedure? If so, is
> > there a more ar-compatible wrapper that can be used?
> 
> This isn't GNU's libtool. It's Apple's libtool, an entirely different
> beast, which is an 'ar' replacement and is needed when linking
> Universal binaries containing code for more than one architecture,
> such as 'ppc' and 'i386', so the same executable can run on multiple
> architectures. This tool dates all the way back to at least NextStep
> 3.1 when NeXT ported NextStep to Intel hardware (i486) from NeXT
> computers (m68k). The name "Universal" is an Apple invention, but back
> in the NeXT days, they were called Multi-Architecture Binaries (MAB)
> or, colloquially, just FAT (for "fat"); there was a corresponding
> "lipo" command (short for "liposuction") to "thin" out "fat" binaries.
> NeXT's libtool predates GNU's libtool by a few years: May 1993 vs.
> July 1997, respectively. When an attempt is made to use 'ar' on
> Universal object files, it errors out saying that it can't be used
> with such files and recommends 'libtool' instead.

Ah, OK. Today I learned something. :)

Jeffrey, can you produce a tested patch which works for you?

-Peff
