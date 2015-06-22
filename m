From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add list-all-objects command
Date: Mon, 22 Jun 2015 19:50:01 -0400
Message-ID: <20150622235001.GB13709@peff.net>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org>
 <1434914431-7745-1-git-send-email-charles@hashpling.org>
 <1434914431-7745-2-git-send-email-charles@hashpling.org>
 <20150622083822.GB12259@peff.net>
 <20150622103321.GB12584@peff.net>
 <xmqqk2uvfm5p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Charles Bailey <charles@hashpling.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 01:50:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7BTs-0005BL-B4
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 01:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbbFVXuT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 19:50:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:50313 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753650AbbFVXuE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 19:50:04 -0400
Received: (qmail 18712 invoked by uid 102); 22 Jun 2015 23:50:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Jun 2015 18:50:03 -0500
Received: (qmail 14843 invoked by uid 107); 22 Jun 2015 23:50:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Jun 2015 19:50:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Jun 2015 19:50:01 -0400
Content-Disposition: inline
In-Reply-To: <xmqqk2uvfm5p.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272436>

On Mon, Jun 22, 2015 at 02:50:10PM -0700, Junio C Hamano wrote:

> > We may want to take patch 1 separately for the maint-track, as it is
> > really a bug-fix (albeit one that I do not think actually affects anyone
> > in practice right now).
> 
> Hmph, add_unseen_recent_objects_to_traversal() is the only existing
> user, and before d3038d22 (prune: keep objects reachable from recent
> objects, 2014-10-15) added that function, for-each-packed-object
> existed but had no callers.

I think that is because it was added by d3038d22^. :)

> And the objects not beeing seen by that function (due to lack of
> "open") would matter only for pruning purposes, which would mean
> you have to be calling into the codepath when running a full repack,
> so you would have opened all the packs that matter anyway (if you
> have a "old cruft archive" pack that contains only objects that
> are unreachable, you may not have opened that pack, though, and you
> may prune the thing away prematurely).

Exactly, that matches my analysis.

> So, I think I can agree that this would unlikely affect anybody in
> practice.

Yep. I am OK if we do not even worry about it for "maint", then.

-Peff
