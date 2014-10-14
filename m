From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] fsck: do not canonicalize modes in trees we are
 checking
Date: Tue, 14 Oct 2014 04:21:21 -0400
Message-ID: <20141014082120.GA16686@peff.net>
References: <20140923154751.GA19319@peff.net>
 <20140923162343.GA20379@debian>
 <20140923163008.GA21591@peff.net>
 <543B02A7.9040807@optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Edward Thomson <ethomson@edwardthomson.com>, git@vger.kernel.org
To: Ben Aveling <bena.001@optusnet.com.au>
X-From: git-owner@vger.kernel.org Tue Oct 14 15:48:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xe2SQ-0007Ba-Go
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 15:48:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbaJNNsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 09:48:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:58316 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755288AbaJNNsE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 09:48:04 -0400
Received: (qmail 11890 invoked by uid 102); 14 Oct 2014 13:48:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Oct 2014 08:48:03 -0500
Received: (qmail 8544 invoked by uid 107); 14 Oct 2014 08:21:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Oct 2014 04:21:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Oct 2014 04:21:21 -0400
Content-Disposition: inline
In-Reply-To: <543B02A7.9040807@optusnet.com.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 13, 2014 at 09:37:27AM +1100, Ben Aveling wrote:

> A question about fsck - is there a reason it doesn't have an option to
> delete bad objects?

If the objects are reachable, then deleting them would create other big
problems (i.e., we would be breaking the object graph!).

If they are not, then it is probably safest for them to go away via the
normal means (repack/prune via "git gc").  Deleting via fsck would mean
replicating the reachability and deletion code found elsewhere.

-Peff
