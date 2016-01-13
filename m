From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] lock_ref_sha1_basic: always fill old_oid while
 holding lock
Date: Wed, 13 Jan 2016 06:38:38 -0500
Message-ID: <20160113113837.GA9360@sigill.intra.peff.net>
References: <20160112214318.GA2527@sigill.intra.peff.net>
 <20160112214439.GB2841@sigill.intra.peff.net>
 <CAPig+cRHNa8b8TdoRFsYvBBOcHbJF1VCKNgmt4SYkQsMAsJjqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 12:38:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJJlG-0005Ac-QB
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 12:38:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755593AbcAMLim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 06:38:42 -0500
Received: from cloud.peff.net ([50.56.180.127]:52832 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754573AbcAMLil (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 06:38:41 -0500
Received: (qmail 22741 invoked by uid 102); 13 Jan 2016 11:38:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Jan 2016 06:38:41 -0500
Received: (qmail 27129 invoked by uid 107); 13 Jan 2016 11:38:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 13 Jan 2016 06:38:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jan 2016 06:38:38 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cRHNa8b8TdoRFsYvBBOcHbJF1VCKNgmt4SYkQsMAsJjqA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283900>

On Tue, Jan 12, 2016 at 08:25:45PM -0500, Eric Sunshine wrote:

> On Tue, Jan 12, 2016 at 4:44 PM, Jeff King <peff@peff.net> wrote:
> > Our basic strategy for taking a ref lock is:
> > [...]
> > If these run simultaneously, we'll see a lot of lock
> > contention, but each of the writes will succeed some of the
> > time. The reflog may record movements between any of the
> > three refs, but we would expect it to provide a consistent
> > log: the "from" field of each log entry should be the same
> > as the "two" field of the previous one.
> 
> s/two/to/

Whoops. Was tweaking my scripts "one" and "two" to test the race while I
wrote up the commit message. :)

-Peff
