From: Jeff King <peff@peff.net>
Subject: Re: [RFD/PATCH] add: ignore only ignored files
Date: Thu, 20 Nov 2014 13:20:13 -0500
Message-ID: <20141120182012.GD2559@peff.net>
References: <3f78d6c1e35c87049daaac6cb1257ea8310a90bb.1416408015.git.git@drmicha.warpmail.net>
 <20141119191502.GC9908@peff.net>
 <xmqqbno2rhlz.fsf@gitster.dls.corp.google.com>
 <546DB778.2000000@drmicha.warpmail.net>
 <20141120155621.GA30273@peff.net>
 <xmqqegsx4whi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 19:20:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrWL9-0005gJ-7N
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 19:20:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757084AbaKTSUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 13:20:16 -0500
Received: from cloud.peff.net ([50.56.180.127]:42891 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751406AbaKTSUP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 13:20:15 -0500
Received: (qmail 20102 invoked by uid 102); 20 Nov 2014 18:20:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Nov 2014 12:20:15 -0600
Received: (qmail 14607 invoked by uid 107); 20 Nov 2014 18:20:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Nov 2014 13:20:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Nov 2014 13:20:13 -0500
Content-Disposition: inline
In-Reply-To: <xmqqegsx4whi.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 20, 2014 at 09:23:21AM -0800, Junio C Hamano wrote:

> > diff --git a/builtin/add.c b/builtin/add.c
> > index ae6d3e2..1074e32 100644
> > --- a/builtin/add.c
> > +++ b/builtin/add.c
> > @@ -284,7 +284,7 @@ static int add_files(struct dir_struct *dir, int flags)
> >  		for (i = 0; i < dir->ignored_nr; i++)
> >  			fprintf(stderr, "%s\n", dir->ignored[i]->name);
> >  		fprintf(stderr, _("Use -f if you really want to add them.\n"));
> > -		die(_("no files added"));
> > +		exit_status = 1;
> >  	}
> >  
> >  	for (i = 0; i < dir->nr; i++)
> >
> > It needs a tweak to t3700.35, which expects the "fatal:" line on stderr.
> > But other than that, it passes all tests. So it must be good, right? :)
> 
> ;-)
> 
> It indeed is a behaviour change, but I do not expect it would be too
> heavy a change to require us a transition period or major version
> bump.  But because that is just my expectation, which is not what
> real world users would expect, so I'd prefer to cook such a change
> for at least a cycle and a half in 'next'.

Oh, definitely. Showing the patch at all was my not-so-subtle attempt to
convince Michael to take over the topic so I did not have to worry about
such things. :)

-Peff
