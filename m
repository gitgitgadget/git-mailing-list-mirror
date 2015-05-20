From: Jeff King <peff@peff.net>
Subject: Re: identical hashes on two branches, but holes in git log
Date: Wed, 20 May 2015 12:18:15 -0400
Message-ID: <20150520161815.GA12521@peff.net>
References: <20150519132958.GA21130@frolo.macqel>
 <20150519233925.GA22748@peff.net>
 <20150520131359.GA7043@frolo.macqel>
 <20150520132534.GI10518@serenity.lan>
 <20150520141238.GA13990@frolo.macqel>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Philippe De Muyter <phdm@macq.eu>
X-From: git-owner@vger.kernel.org Wed May 20 18:18:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv6hM-0001Hg-M4
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 18:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755275AbbETQSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 12:18:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:33194 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754189AbbETQSS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 12:18:18 -0400
Received: (qmail 24801 invoked by uid 102); 20 May 2015 16:18:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 May 2015 11:18:18 -0500
Received: (qmail 24219 invoked by uid 107); 20 May 2015 16:18:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 May 2015 12:18:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 May 2015 12:18:15 -0400
Content-Disposition: inline
In-Reply-To: <20150520141238.GA13990@frolo.macqel>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269469>

On Wed, May 20, 2015 at 04:12:38PM +0200, Philippe De Muyter wrote:

> After reading the man page of 'git log', should --topo-order not be the
> default log order ?

The problem with --topo-order is that it has to traverse all of the
commits before starting output. So:

  $ time git log | head -1
  commit 64fb1d0e975e92e012802d371e417266d6531676

  real    0m0.038s
  user    0m0.032s
  sys     0m0.008s

  $ time git log --topo-order | head -1
  commit 64fb1d0e975e92e012802d371e417266d6531676

  real    0m4.247s
  user    0m4.140s
  sys     0m0.108s

-Peff
