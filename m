From: Jeff King <peff@peff.net>
Subject: Re: [BUG] having 'plink' anywhere in the GIT_SSH environment
 variables sets putty = true
Date: Wed, 22 Apr 2015 17:29:04 -0400
Message-ID: <20150422212904.GA32043@peff.net>
References: <2A6FFC1D-5479-4DCA-A5E5-FF92DE0AA552@gmail.com>
 <6c2a6b53e8e6e019b145dddc67a9d2ca@www.dscho.org>
 <F1AB6016-DA88-446C-84E9-1BD42436843D@gmail.com>
 <20150422202910.GB26917@peff.net>
 <20150422211915.GB827497@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Sharp <jakanapes@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 22 23:30:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl2EL-0002rO-6r
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 23:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754056AbbDVV3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 17:29:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:48877 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753419AbbDVV3H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 17:29:07 -0400
Received: (qmail 21376 invoked by uid 102); 22 Apr 2015 21:29:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Apr 2015 16:29:07 -0500
Received: (qmail 14363 invoked by uid 107); 22 Apr 2015 21:29:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Apr 2015 17:29:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Apr 2015 17:29:04 -0400
Content-Disposition: inline
In-Reply-To: <20150422211915.GB827497@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267642>

On Wed, Apr 22, 2015 at 09:19:15PM +0000, brian m. carlson wrote:

> > Note that I don't think just switching the strcasestr to look for
> > "plink.exe" is right. For one thing, it just punts on the problem (it
> > can still happen, it's just less likely to trigger). But for another,
> > you can have plink (without ".exe") on Linux systems.
> 
> Perhaps it would be worthwhile to check instead if the text "plink" is
> the beginning of string or is preceded by a path separator.  That would
> give us a bit more confidence that the user is looking for plink, but
> would still allow people to use "plink-0.63" if they like.

Yeah, I think that is a reasonable approach. Note that it needs to
handle the "tortoiseplink" case from below, too (you can still use your
strategy, you just need to look for either string).

-Peff
