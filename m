From: Jeff King <peff@peff.net>
Subject: Re: memrchr() implementation
Date: Thu, 28 Jul 2011 22:40:31 -0600
Message-ID: <20110729044031.GA17481@sigill.intra.peff.net>
References: <CALUzUxqNGsThcWem4mj=M3EcFF_N5GpARB+x0qx+Q1Gs76Gzig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 29 06:40:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmesJ-0005Tp-M8
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 06:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752452Ab1G2Eke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jul 2011 00:40:34 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48635
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751256Ab1G2Eke (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 00:40:34 -0400
Received: (qmail 19855 invoked by uid 107); 29 Jul 2011 04:41:05 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Jul 2011 00:41:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Jul 2011 22:40:31 -0600
Content-Disposition: inline
In-Reply-To: <CALUzUxqNGsThcWem4mj=M3EcFF_N5GpARB+x0qx+Q1Gs76Gzig@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178124>

On Fri, Jul 29, 2011 at 12:33:01PM +0800, Tay Ray Chuan wrote:

> I'm writing a patch that requires the use of memrchr(). [1] As far as
> I know, memrchr() is non-standard.

Yep.

> So what's the best way to get git to use memrchr()?
> 
> I was thinking of getting git to use glibc's implementation if glibc
> is present, if not, use a naive implementation included in git's code
> base [2].

Yeah, that's our usual strategy; see how strchrnul is implemented for an
example.

Since you are doing this for speed and not ease-of-use, I assume you are
benchmarking stock git versus glibc's optimized memrchr. I'd be curious
to see a comparison to your naive implementation, too, just to
double-check that your attempt at speeding up doesn't make things worse
on non-glibc platforms.

-Peff
