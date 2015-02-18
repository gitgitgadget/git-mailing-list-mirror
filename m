From: Jeff King <peff@peff.net>
Subject: Re: Interested in helping open source friends on HP-UX?
Date: Wed, 18 Feb 2015 13:25:47 -0500
Message-ID: <20150218182547.GA6346@peff.net>
References: <xmqq4mt2fx2m.fsf@gitster.dls.corp.google.com>
 <20150218170007.784be6aa@pc09.procura.nl>
 <54E4CFDC.40401@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Feb 18 19:25:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YO9Jr-0002xY-Ec
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 19:25:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbbBRSZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 13:25:50 -0500
Received: from cloud.peff.net ([50.56.180.127]:50575 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932066AbbBRSZt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 13:25:49 -0500
Received: (qmail 2491 invoked by uid 102); 18 Feb 2015 18:25:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Feb 2015 12:25:49 -0600
Received: (qmail 19434 invoked by uid 107); 18 Feb 2015 18:25:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Feb 2015 13:25:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Feb 2015 13:25:47 -0500
Content-Disposition: inline
In-Reply-To: <54E4CFDC.40401@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264036>

On Wed, Feb 18, 2015 at 06:46:04PM +0100, Michael J Gruber wrote:

> >> H. Merijn Brand runs a few HP-UX boxes to help perl5 and other open
> >> source communities, wants help porting more recent Git on these
> >> boxes, running HP-UX 10.20, 11.00, and 11.23, and looking for a
> >> volunteer.  Please contact him directly if you are interested.
> > 
> > No-one. Disappointing :(
> 
> Well, how can we help if we don't even know the limitations of that
> platform?

I'm not sure, but I think the original call for help may have been "I
will give you shell access to these boxes if you want to play around".

> > t/t7001-mv.t
> > ------------
> > cp uses -P flag, which is unknown to HP's (non-GNU) version of cp
> > 
> > Changing the two occurrences from
> > 
> > 		cp -R -P -p ../.git/modules/sub .git &&
> > to
> > 		rsync -aHl ../.git/modules/sub/ .git/ &&
> > 
> > make the tests pass (on those systems that have a working rsync)
> 
> "rsync -r -l -o -p -t" would be the proper equivalent. -aH does more for
> my rsync. I don't know what HP-UX rsync understands, though.

It seems like we could use

  (cd src && tar cf - .) | (cd dst && tar xf -)

here as a more portable alternative. I don't think we can rely on rsync
being everywhere.

-Peff
