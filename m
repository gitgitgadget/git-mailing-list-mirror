From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 53/67] drop strcpy in favor of raw sha1_to_hex
Date: Fri, 18 Sep 2015 15:29:28 -0400
Message-ID: <20150918192928.GF11068@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915160605.GA29753@sigill.intra.peff.net>
 <CAPig+cRaPu0_WdLwE_O3UddP5LEvqqB7gOkyg5ne9YkXu_JJ9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Sep 18 21:29:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zd1Lj-0003ZA-DH
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 21:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752409AbbIRT3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 15:29:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:33340 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751422AbbIRT3b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 15:29:31 -0400
Received: (qmail 20441 invoked by uid 102); 18 Sep 2015 19:29:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 18 Sep 2015 14:29:31 -0500
Received: (qmail 11103 invoked by uid 107); 18 Sep 2015 19:29:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 18 Sep 2015 15:29:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Sep 2015 15:29:28 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cRaPu0_WdLwE_O3UddP5LEvqqB7gOkyg5ne9YkXu_JJ9w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278221>

On Fri, Sep 18, 2015 at 03:24:37PM -0400, Eric Sunshine wrote:

> >                 fprintf(stderr, "updating '%s'", ref->name);
> >                 if (strcmp(ref->name, ref->peer_ref->name))
> >                         fprintf(stderr, " using '%s'", ref->peer_ref->name);
> > -               fprintf(stderr, "\n  from %s\n  to   %s\n", old_hex, new_hex);
> > +               fprintf(stderr, "\n  from %s\n  to   %s\n",
> > +                       sha1_to_hex(ref->old_sha1), sha1_to_hex(ref->new_sha1));
> 
> Would it make sense for the commit message can mention that when this
> code was written originally, it was not safe to call sha1_to_hex()
> twice like this within a single expression, but became safe as of
> dcb3450 (sha1_to_hex() usage cleanup, 2006-05-03)?

Sure. I suspected that was the case (there were several spots like this
in http-push.c), but didn't actually dig.

-Peff
