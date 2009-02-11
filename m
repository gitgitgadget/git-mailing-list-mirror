From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fast-export: ensure we traverse commits in topological
	order
Date: Wed, 11 Feb 2009 12:53:54 -0500
Message-ID: <20090211175354.GB19749@coredump.intra.peff.net>
References: <1234332233-10017-1-git-send-email-newren@gmail.com> <1234332233-10017-2-git-send-email-newren@gmail.com> <alpine.DEB.1.00.0902111125410.10279@pacific.mpi-cbg.de> <e2b179460902110248m8055b3amdebcfc550438cff2@mail.gmail.com> <20090211135640.GA19600@coredump.intra.peff.net> <51419b2c0902110723y75d0c4a4r34cf92cf371313ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Ralphson <mike.ralphson@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 18:56:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXJIy-0003JS-U3
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 18:55:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756096AbZBKRx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 12:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755483AbZBKRx5
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 12:53:57 -0500
Received: from peff.net ([208.65.91.99]:33800 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945AbZBKRx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 12:53:57 -0500
Received: (qmail 31797 invoked by uid 107); 11 Feb 2009 17:54:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 11 Feb 2009 12:54:13 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Feb 2009 12:53:54 -0500
Content-Disposition: inline
In-Reply-To: <51419b2c0902110723y75d0c4a4r34cf92cf371313ea@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109458>

On Wed, Feb 11, 2009 at 08:23:22AM -0700, Elijah Newren wrote:

> I'm a little surprised why my numbers were so much lower than yours,
> though.  I don't think of my hard drive and CPU as being all that
> quick -- is this a difference in packing, by chance, with your
> repository not having recently been repacked?

I don't think the hard drive matters much at all; the CPU is pegged the
whole time. I'm not fully packed, but almost so. I suspect it is a
combination of:

  1. I compile git with "-g" and no optimizations to make debugging
     easier.

  2. My system sucks. It is a 1.8GHz dual Athlon from around 2003.
     fast-export should be pretty memory intensive, which I'm sure is
     saturating my totally rocking 266MHz FSB.

Just for fun, I tried:

  - fully repacking; no change

  - compiling with -O2; shaved off about 2s. Not too surprising;
    previous profiling has shown that git spends a lot of time in zlib,
    and I am dynamically linking against an optimized version.

So I think it is mainly (2) above, assuming your machine sucks a lot
less than mine.

-Peff
