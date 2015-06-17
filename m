From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] notes: Use get_sha1_committish instead of read_ref in
 init_notes()
Date: Wed, 17 Jun 2015 12:35:36 -0400
Message-ID: <20150617163536.GA22689@peff.net>
References: <1434503731-26414-1-git-send-email-mh@glandium.org>
 <20150617032231.GA24505@peff.net>
 <20150617090246.GC30948@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Jun 17 18:35:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5GJY-0006uQ-5U
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 18:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757854AbbFQQfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 12:35:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:47479 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755661AbbFQQfj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 12:35:39 -0400
Received: (qmail 17828 invoked by uid 102); 17 Jun 2015 16:35:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Jun 2015 11:35:38 -0500
Received: (qmail 27073 invoked by uid 107); 17 Jun 2015 16:35:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Jun 2015 12:35:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Jun 2015 12:35:36 -0400
Content-Disposition: inline
In-Reply-To: <20150617090246.GC30948@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271865>

On Wed, Jun 17, 2015 at 06:02:46PM +0900, Mike Hommey wrote:

> > In a sense that is weirdly broken already:
> > 
> >   $ git log --notes=:/foo >/dev/null
> >   warning: notes ref refs/notes/:/foo is invalid
> > 
> > but I wonder if we should be making expand_notes_ref a little more
> > careful as part of the same topic.
> 
> Interestingly, now that I look, there's also this:
> https://github.com/git/git/blob/master/notes-cache.c#L40
> 
> that doesn't use expand_notes_ref, but it's apparently only used in
> userdiff_get_textconv, and I'm not sure why.

notes-cache.c predates expand_notes_ref. I don't think it's a big deal.
The implementation of notes-cache is an internal detail (the user
interacts with it by setting diff.*.cacheTextConv, and then git handles
the cache).

-Peff
