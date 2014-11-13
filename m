From: Jeff King <peff@peff.net>
Subject: Re: Bug: git log showing nothing when using --since and --until
 flags with specific dates
Date: Thu, 13 Nov 2014 04:36:06 -0500
Message-ID: <20141113093606.GC8329@peff.net>
References: <CAPLyDLo+-SebLvHxVKT7RAiER2c8HdeZQUg7_DGrpER1h-BPQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Colin Smith <colin.webdev@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 10:36:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xoqp7-0000LP-A6
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 10:36:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbaKMJgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 04:36:10 -0500
Received: from cloud.peff.net ([50.56.180.127]:39797 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932127AbaKMJgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 04:36:09 -0500
Received: (qmail 19082 invoked by uid 102); 13 Nov 2014 09:36:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Nov 2014 03:36:08 -0600
Received: (qmail 22159 invoked by uid 107); 13 Nov 2014 09:36:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Nov 2014 04:36:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Nov 2014 04:36:06 -0500
Content-Disposition: inline
In-Reply-To: <CAPLyDLo+-SebLvHxVKT7RAiER2c8HdeZQUg7_DGrpER1h-BPQA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 13, 2014 at 11:27:06AM +1100, Colin Smith wrote:

> Apologies if this has already been raised or PEBCAK, but I've noticed
> a bug where git log with certain date ranges breaks things. It appears
> to be any --since date with a --until date in the future between
> 2014-12-01 and 2014-12-09. Dates from 2014-12-10 appear to work, and
> so does the date 2015-12-01.

Ugh. Approxidate strikes again:

  for i in 2014-11-01 2013-12-01 2014-12-01; do
    ./test-date approxidate $i
  done

produces:

  2014-11-01 -> 2014-11-01 09:35:19 +0000
  2013-12-01 -> 2013-12-01 09:35:19 +0000
  2014-12-01 -> 2014-01-12 09:35:19 +0000

The first two are right, but the fourth one is not.  It's probably
something simple and stupid.

-Peff
