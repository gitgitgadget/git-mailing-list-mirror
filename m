From: Jeff King <peff@peff.net>
Subject: Re: Unresolved issues #2 (shallow clone again)
Date: Mon, 8 May 2006 00:24:29 -0400
Message-ID: <20060508042429.GA20249@coredump.intra.peff.net>
References: <87mzdx7mh9.wl%cworth@cworth.org> <7v1wv92u7o.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605050806370.3622@g5.osdl.org> <e3fqb9$hed$1@sea.gmane.org> <Pine.LNX.4.64.0605050848230.3622@g5.osdl.org> <46a038f90605052323o29f8bfadr7426f97d8dfc2319@mail.gmail.com> <7vbqubvdbr.fsf@assigned-by-dhcp.cox.net> <46a038f90605062308x53995076k7bf45f0aebcae0c6@mail.gmail.com> <20060507075631.GA24423@coredump.intra.peff.net> <Pine.LNX.4.64.0605070802590.16343@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 08 06:24:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcxIZ-0003SR-BS
	for gcvg-git@gmane.org; Mon, 08 May 2006 06:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbWEHEYc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 00:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWEHEYc
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 00:24:32 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:7385 "EHLO
	peff.net") by vger.kernel.org with ESMTP id S932286AbWEHEYb (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 May 2006 00:24:31 -0400
Received: (qmail 74261 invoked from network); 8 May 2006 04:24:29 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 0 with SMTP; 8 May 2006 04:24:29 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon,  8 May 2006 00:24:29 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060508003338.GB17138@thunk.org> <Pine.LNX.4.64.0605070802590.16343@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19759>

On Sun, May 07, 2006 at 08:27:02AM -0700, Linus Torvalds wrote:

> factor for a lot of things for many "common" filesystem setups. You 
> probably didn't even account for the size of inodes in your "du" setup.

My numbers came from git-count-objects, which uses the st_blocks sum for
all objects. The actual du numbers showing space wasted by block
boundaries are:
  du -c ??: 1429216
  du -c --apparent-size ??: 792277
So it's about 45% wasted space.

On Sun, May 07, 2006 at 08:33:38PM -0400, Theodore Tso wrote:

> If there are 233338 objects, then the average wasted space due to
> internal fragmentation is 233338 * 2k, or 466676 kilobytes, or only
> 36% of the wasted space.  Most of the savings is probably coming from
> the compression and delta packing.

As Linus indicated, that assumes a uniform distribution of file sizes
(and my numbers above show that it is, in fact, somewhat higher). FYI,
the mean and median of usage of the final 4K block in the linux-2.6
repository are 1309 and 912 bytes, respectively.

-Peff
