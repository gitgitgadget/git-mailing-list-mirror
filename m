From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] refs: speed up is_refname_available
Date: Thu, 11 Sep 2014 14:31:43 -0400
Message-ID: <20140911183143.GB18382@peff.net>
References: <20140910101730.GA12399@peff.net>
 <xmqqy4tqdr1r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 20:31:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XS99q-0006eI-1U
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 20:31:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752812AbaIKSbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 14:31:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:47118 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752661AbaIKSbp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 14:31:45 -0400
Received: (qmail 5085 invoked by uid 102); 11 Sep 2014 18:31:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Sep 2014 13:31:45 -0500
Received: (qmail 28655 invoked by uid 107); 11 Sep 2014 18:32:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Sep 2014 14:32:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Sep 2014 14:31:43 -0400
Content-Disposition: inline
In-Reply-To: <xmqqy4tqdr1r.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256861>

On Thu, Sep 11, 2014 at 10:07:28AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > This has a fairly straightforward conflict with the ref-transaction
> > stuff in pu. The "oldrefname" parameter to is_refname_available became a
> > list of items;
> 
> Hmph, the trouble I had while reading the conflicts was about the
> new "we skip these when repacking", not "oldrefname".
> 
> Will check your suggested resolution later today.  Thanks.

I didn't see any conflict related to repacking. If I am reading
54e696fc433 correctly, the single "oldrefname" became a list "skip" in
the name_conflict_* code. My series dropped name_conflict_*, but gave a
similar adaptation to the replacement.

The "skip while repacking" code is repack_without_refs, but I don't
think I touched anything that conflicted there.

-Peff
