From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 28/32] config: read ref storage config on startup
Date: Mon, 29 Feb 2016 17:13:15 -0500
Message-ID: <20160229221315.GF25342@sigill.intra.peff.net>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
 <1456354744-8022-29-git-send-email-dturner@twopensource.com>
 <20160227035634.GA10829@sigill.intra.peff.net>
 <20160227041416.GA11604@sigill.intra.peff.net>
 <1456783069.18017.66.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 23:13:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaW4B-00054m-Py
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 23:13:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754182AbcB2WNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 17:13:19 -0500
Received: from cloud.peff.net ([50.56.180.127]:51828 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754165AbcB2WNS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 17:13:18 -0500
Received: (qmail 12279 invoked by uid 102); 29 Feb 2016 22:13:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 17:13:17 -0500
Received: (qmail 31859 invoked by uid 107); 29 Feb 2016 22:13:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 17:13:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Feb 2016 17:13:15 -0500
Content-Disposition: inline
In-Reply-To: <1456783069.18017.66.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287922>

On Mon, Feb 29, 2016 at 04:57:49PM -0500, David Turner wrote:

> > By the way, I notice that the default value for the_refs_backend is
> > "&refs_be_files". It might be safer to make this NULL (or some
> > &refs_be_null that fills the vtable, but just returns an error for
> > each
> > call).
> 
> In 'refs: register ref storage backends', I do make this change.  I
> don't do it earlier because we don't have this config stuff in place
> yet.

Ah, OK. I was that we did register the files backend as a normal one,
but I missed the assignment to NULL (I do wonder if we want a
refs_be_null to smoke out problem cases with a die("BUG") rather than
segfaulting, but in theory nobody should be doing that).

-Peff
