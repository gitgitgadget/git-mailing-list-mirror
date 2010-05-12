From: Jeff King <peff@peff.net>
Subject: Re: Re: git log -M -- filename is not working?
Date: Wed, 12 May 2010 09:03:39 -0400
Message-ID: <20100512130339.GA19072@coredump.intra.peff.net>
References: <z2r76c5b8581005071131q15524cb8td6711dbb9142b28e@mail.gmail.com>
 <19428.24021.324557.517627@winooski.ccs.neu.edu>
 <20100508044434.GC14998@coredump.intra.peff.net>
 <19428.62170.654092.308682@winooski.ccs.neu.edu>
 <20100508053025.GG14998@coredump.intra.peff.net>
 <7v39y3c5p1.fsf@alter.siamese.dyndns.org>
 <19429.3589.823244.270582@winooski.ccs.neu.edu>
 <20100512113855.GB23847@coredump.intra.peff.net>
 <19434.39095.448649.313537@winooski.ccs.neu.edu>
 <20100512124948.GA11761@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Eugene Sajine <euguess@gmail.com>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>, git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Wed May 12 15:04:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCBbN-0000tV-Ox
	for gcvg-git-2@lo.gmane.org; Wed, 12 May 2010 15:03:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375Ab0ELNDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 May 2010 09:03:42 -0400
Received: from peff.net ([208.65.91.99]:36234 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750766Ab0ELNDl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 May 2010 09:03:41 -0400
Received: (qmail 3391 invoked by uid 107); 12 May 2010 13:03:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 12 May 2010 09:03:39 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 May 2010 09:03:39 -0400
Content-Disposition: inline
In-Reply-To: <20100512124948.GA11761@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146944>

On Wed, May 12, 2010 at 08:49:48AM -0400, Jeff King wrote:

> Anyway, here is the patch. My testing so far has been very simple, so
> please try it on a few repos and let me know if it does what you expect
> in all cases. Note that is based on "next", as it has Bo's
> find_copies_harder patch.

By the way, here are some basic speed tests in git.git:

  $ time git log builtin >/dev/null
  real    0m0.486s
  user    0m0.468s
  sys     0m0.016s

  $ time git log --follow builtin >/dev/null
  real    0m23.518s
  user    0m23.469s
  sys     0m0.040s

So it's _way_ slower, but still snappy enough with the first few commits
not to be awful. However, I haven't done any profiling, so it may be
that we can improve that by limiting the rename-detection diff only to
interesting paths.

-Peff
