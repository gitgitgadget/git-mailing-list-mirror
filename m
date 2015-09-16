From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 52/67] use sha1_to_hex_to() instead of strcpy
Date: Wed, 16 Sep 2015 17:54:29 -0400
Message-ID: <20150916215429.GA23667@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915160535.GZ29753@sigill.intra.peff.net>
 <xmqq1tdyowxa.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 23:54:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcKf4-0003Lu-9c
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 23:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752349AbbIPVyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 17:54:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:60420 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751830AbbIPVyi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 17:54:38 -0400
Received: (qmail 30248 invoked by uid 102); 16 Sep 2015 21:54:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 16:54:37 -0500
Received: (qmail 24260 invoked by uid 107); 16 Sep 2015 21:54:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 17:54:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Sep 2015 17:54:29 -0400
Content-Disposition: inline
In-Reply-To: <xmqq1tdyowxa.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278074>

On Wed, Sep 16, 2015 at 02:51:13PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > diff --git a/builtin/merge-index.c b/builtin/merge-index.c
> > index 1d66111..4ed0a83 100644
> > --- a/builtin/merge-index.c
> > +++ b/builtin/merge-index.c
> > @@ -9,7 +9,7 @@ static int merge_entry(int pos, const char *path)
> >  {
> >  	int found;
> >  	const char *arguments[] = { pgm, "", "", "", path, "", "", "", NULL };
> > -	char hexbuf[4][60];
> > +	char hexbuf[4][GIT_SHA1_HEXSZ + 1];
> >  	char ownbuf[4][60];
> 
> So you saved 19*4 = 76 bytes at runtime?
> 
> Looks good ;-).

I think we can save even more in ownbuf, which holds only octal
modes. That was out of scope for this patch, though. :)

-Peff
